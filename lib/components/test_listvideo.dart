
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


class ListVideoViolation2 extends StatefulWidget {
  const ListVideoViolation2({Key? key}) : super(key: key);

  @override
  _ListVideoViolation2State createState() => _ListVideoViolation2State();
}

class _ListVideoViolation2State extends State<ListVideoViolation2> {
  TextEditingController controller = TextEditingController();
  String namesearch = '';
  late Future<ListResult> futureFiles;
  Map<int, double> downloadProgress = {};

  List<String> ListID = [];
  List<String> _searchResult = [];
  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {
      });
      return;
    }

    ListID.forEach((userDetail) {
      if (userDetail.contains(text) || userDetail.contains(text))
        _searchResult.add(userDetail);
    });


    setState(() {});@override
    void initState() {
      super.initState();

      futureFiles = FirebaseStorage.instance.ref('/Video').listAll();
      //futureFiles = Firebase.initializeApp.ref('/file').listAll();
    }
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
    double  heightR,widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Card(
          child: TextField(
            //controller: controller,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search...',

            ),
            onChanged: (val){
              setState(() {
                namesearch = val;
              });
            },


          ),
        ),
        //title: const Text('List Video'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        //future: futureFiles,
        stream: (namesearch != '' && namesearch != null)
            ?FirebaseFirestore.instance
            .collection('violation')
        .where("string_search", arrayContains: namesearch)
            //.where('video_name', isEqualTo: namesearch)
        //.where('violation', isEqualTo: namesearch)
        //.where('local', isEqualTo: namesearch)
        //.where('licenseplate', isEqualTo: namesearch)
            .snapshots()
            : FirebaseFirestore.instance.collection("violation").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final files = snapshot.data!.docs;

            return ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                DocumentSnapshot data = snapshot.data!.docs[index];

                final file = files[index];
                //print(data.data());
                double? progress = downloadProgress[index];

                if(data['video_name'].toString().startsWith(namesearch.toLowerCase())){
                  return ListTile(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.deepPurpleAccent, //<-- SEE HERE
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    title: Text('${data['video_name']}'),
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
                      onPressed: () {downloadFile(index, data['video_name']);},
                    ),
                  );
                }


                // return Padding(
                //   padding:  EdgeInsets.all(8.0*heightR),
                //   child:  Card(
                //     child:  ListTile(
                //       leading:  Icon(Icons.search),
                //       title:  TextField(
                //         controller: controller,
                //         decoration: new InputDecoration(
                //             hintText: 'Search', border: InputBorder.none),
                //         onChanged: onSearchTextChanged,
                //       ),
                //       trailing: new IconButton(icon: new Icon(Icons.cancel), onPressed: () {
                //         controller.clear();
                //         onSearchTextChanged('');
                //       },),
                //     ),
                //   ),
                // );

                return ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.deepPurpleAccent, //<-- SEE HERE
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  title: Text('${data['video_name']}'),
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
                    onPressed: () {downloadFile(index, data['']);},
                  ),
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