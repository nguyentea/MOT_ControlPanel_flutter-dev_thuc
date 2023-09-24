

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttercontrolpanel/components/side_menu.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fluttercontrolpanel/components/viewVideo.dart';


class ListVideoViolation extends StatefulWidget {
  const ListVideoViolation({Key? key}) : super(key: key);

  @override
  _ListVideoViolationState createState() => _ListVideoViolationState();
}

class _ListVideoViolationState extends State<ListVideoViolation> {
  late Future<ListResult> futureFiles;
  Map<int, double> downloadProgress = {};
  Map<int, String> videoUrlList = {};

  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseStorage.instance.ref('/VideoViolation').listAll();
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

  _loadFirebaseImageUrl(index, ref) async {

    var url = await ref.getDownloadURL() as String;
    setState(() {
      videoUrlList[index] = url;
    });
    // print("url: ${videoUrlList}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.deepPurpleAccent,
        leading: Icon(Icons.video_library),
        title: const Text('Video vi phạm'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => SideMenu(currentIndex: 2, currentIndex_listcamera: 0, currentIndex_listProfile: 0,
                    currentIndext_listSearch: 1, currentIndex_violationList: 0),
              )
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
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
                _loadFirebaseImageUrl(index, file);
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          ViewVideo(videoUrl: videoUrlList[index]!)
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      ListTile(
                        shape: Border(
                          bottom: BorderSide(
                            color: Colors.blueGrey.shade100, //<-- SEE HERE
                          ),
                          // borderRadius: BorderRadius.circular(20.0),
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
                  )
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
