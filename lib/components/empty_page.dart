
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:fluttercontrolpanel/firebase_options.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';


class ListVideoViolation extends StatefulWidget {
  const ListVideoViolation({Key? key}) : super(key: key);

  @override
  _ListVideoViolationState createState() => _ListVideoViolationState();
}

class _ListVideoViolationState extends State<ListVideoViolation> {
  late Future<ListResult> futureFiles;
  Map<int, double> downloadProgress = {};

  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseStorage.instance.ref('/Video').listAll();
    //futureFiles = Firebase.initializeApp.ref('/file').listAll();
  }
  Future downloadFile(int index, Reference ref) async {

    final url = await ref.getDownloadURL();

    //final Directory directory = await getApplicationDocumentsDirectory();
    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/${ref.name}';
    print('Video downloaded to $path');


    await Dio().download(
      url,
      path,
      onReceiveProgress: (receied, total) {
        double progress = receied / total;
        setState(() {
          downloadProgress[index] = progress;
        });
      },
    );

    if (url.contains('.mp4')) {
      await GallerySaver.saveVideo(path, toDcim: true);
    } else if (url.contains('ipg')) {
      await GallerySaver.saveImage(path, toDcim: true);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Download: ${ref.name}")),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text('List Video'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          )
        ],
        centerTitle: true,
      ),
      body: FutureBuilder<ListResult>(
        future: futureFiles,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final files = snapshot.data!.items;
            return ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                final file = files[index];
                double? progress = downloadProgress[index];


                return Column(
                  children: [
                    SizedBox(height: 10,),
                    ListTile(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.deepPurpleAccent, //<-- SEE HERE
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      title: Text('${file.name}'),
                      subtitle: progress != null
                          ? LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.black26,
                      )
                          : null,
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.download,
                          color: Colors.black,
                        ),
                        onPressed: () {downloadFile(index,file);},
                      ),
                    ),
                  ],
                );

              },

            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error occurred'),);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );

  }
}
//class GetUserName extends StatelessWidget {
//   final String documentId;
//
//   GetUserName(this.documentId);
//
//   @override
//   Widget build(BuildContext context) {
//     CollectionReference users = FirebaseFirestore.instance.collection('violation');
//     var Id = documentId.split('.');
//     return FutureBuilder<DocumentSnapshot>(
//       future: users.doc(Id[0]).get(),
//       builder:
//           (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//
//         if (snapshot.hasError) {
//
//           return Text("Something went wrong");
//         }
//
//         if (snapshot.connectionState == ConnectionState.done) {
//           Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
//           return Text("${snapshot.data!['time'].toDate()} ${data['violation']} ${data['licenseplate']} ${data['local']}");
//         }
//         return Text("loading");
//       },
//
//     );
//   }
// }