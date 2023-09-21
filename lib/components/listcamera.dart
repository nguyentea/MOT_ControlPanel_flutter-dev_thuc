
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttercontrolpanel/components/preview_camera.dart';
import 'package:fluttercontrolpanel/components/side_menu.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';




class ListCamera extends StatelessWidget {

  final Stream<QuerySnapshot> cam =
  FirebaseFirestore.instance.collection('cameraIp').snapshots();


  // Widget show_camera(String link){
  //   //print(link);
  //   bool _isPlay = true;
  //   final VlcPlayerController _vlcPlayerController = VlcPlayerController.network(
  //       link,
  //       options: VlcPlayerOptions(),
  //       hwAcc: HwAcc.full,
  //       autoPlay: true
  //   );
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Video'),
  //     ),
  //     body: Center(
  //         child: Container(
  //           child: Column(
  //             children: [
  //               VlcPlayer(
  //                 controller: _vlcPlayerController,
  //                 aspectRatio: 16 / 9, // Tùy chỉnh tỷ lệ khung hình
  //                 placeholder: Center(child: CircularProgressIndicator()),
  //               ),
  //               TextButton(
  //                   onPressed: (){
  //                     if(_isPlay){
  //                       _isPlay =   false;
  //                       // setState(() {
  //                       //   _isPlay =   false;
  //                       // });
  //                       _vlcPlayerController.pause();
  //                     }else{
  //                       _isPlay = true;
  //                       // setState(() {
  //                       //   _isPlay = true;
  //                       // });
  //                       _vlcPlayerController.play();
  //                     }
  //                   },
  //                   child: _isPlay ?Icon(Icons.pause,size: 28,color: Colors.black,)  : Icon(Icons.play_arrow,size: 28,color: Colors.black,)
  //               )
  //             ],
  //           ),
  //         )
  //     ),
  //   );
  // }
  //
  // _show(){
  //   return StreamBuilder<QuerySnapshot>(
  //       stream: cam,
  //       builder: (
  //           context,
  //           AsyncSnapshot<QuerySnapshot> snapshot,
  //           ) {
  //         if (snapshot.hasError) {
  //           return Text('Something went wrong.');
  //         }
  //         return ListView(
  //             scrollDirection: Axis.vertical,
  //             shrinkWrap: true,
  //             children: snapshot.data!.docs
  //                 .map((DocumentSnapshot document) {
  //               Map<String, dynamic> data = document.data()! as Map<String,
  //                   dynamic>;
  //               //print(document.id);
  //               return ListTile(
  //                 title: Text('${data['namecam']}'),
  //                 trailing: PopupMenuButton(
  //                   icon: const Icon(
  //                     Icons.more_vert,
  //                     color: Colors.black,
  //                   ),
  //                   onSelected: (result) {
  //                     if (result == 0) {
  //                       Navigator.push(
  //                         context,
  //                         MaterialPageRoute(builder: (context) =>
  //                             ViewCamera(link: data['Ipcamera'])
  //                             //SideMenu(currentIndex: 1, currentIndex_listcamera: 2, currentIndext_listSearch: 0, currentIndex_listProfile: 0,)),
  //                       ),
  //                       );
  //                     }
  //                     if (result == 1) {
  //                       CollectionReference camdl = FirebaseFirestore.instance.collection('cameraIp');
  //                       camdl.doc(document.id).delete();
  //                       AwesomeDialog(
  //                         context: context,
  //                         animType: AnimType.leftSlide,
  //                         headerAnimationLoop: false,
  //                         dialogType: DialogType.error,
  //                         showCloseIcon: true,
  //                         title: 'Đã xóa Camera',
  //                         btnOkOnPress: () {
  //                         },
  //                         btnOkIcon: Icons.check_circle,
  //                         onDismissCallback: (type) {
  //                         },
  //                       ).show();
  //                     }
  //                   },
  //                   itemBuilder: (context) =>[
  //                     PopupMenuItem(
  //                       value: 0,
  //                       child: Row(
  //                         children: [
  //                           Icon(Icons.video_call_sharp),
  //                           SizedBox(
  //                             width: 10,
  //                           ),
  //                           Text("Watch camera")
  //                         ],
  //                       ),
  //
  //                     ),
  //                     PopupMenuItem(
  //                       value: 1,
  //                         child: Row(
  //                           children: [
  //                             Icon(Icons.delete_forever),
  //                             SizedBox(
  //                               width: 10,
  //                             ),
  //                             Text("Delete camera")
  //                           ],
  //                         ),
  //
  //                     ),
  //                   ],
  //                 ),
  //               );
  //             }
  //             )
  //                 .toList()
  //         );
  //       }
  //   );
  //
  // }


  //CollectionReference cam = FirebaseFirestore.instance.collection('cameraIp');

  @override
  Widget build(BuildContext context) {
    final width_screen = MediaQuery
        .of(context)
        .size
        .width;
    final height_screen = MediaQuery
        .of(context)
        .size
        .height;

    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.black87,
      primary: Colors.grey[300],
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.flip_camera_ios),
        title: Text('Danh sách camera'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: height_screen / 400,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     ElevatedButton(
          //       style: raisedButtonStyle,
          //       onPressed: () {
          //         Navigator.push(
          //           context,
          //           PageRouteBuilder(
          //             pageBuilder: (_, __, ___) =>
          //             SideMenu(currentIndex: 1, currentIndex_listcamera: 1, currentIndex_listProfile: 0, currentIndext_listSearch: 0,),
          //             opaque: false,
          //             transitionDuration: Duration(seconds: 0),
          //           ),
          //         );
          //       },
          //       child: Text('Add Camera'),
          //     ),
          //     SizedBox(
          //       width: width_screen / 200,
          //     ),
          //     // ElevatedButton(
          //     //   style: raisedButtonStyle,
          //     //   onPressed: () {
          //     //     Navigator.push(
          //     //       context,
          //     //       PageRouteBuilder(
          //     //         pageBuilder: (_, __, ___) =>
          //     //             show_camera('rtsp://admin:Admin@123@14.241.46.151:1554/profile3/media.smp'),
          //     //         //SideMenu(currentIndex: 1, currentIndex_listcamera: 2,),
          //     //         opaque: false,
          //     //         transitionDuration: Duration(seconds: 0),
          //     //       ),
          //     //     );
          //     //   },
          //     //   child: Text('Remove Camera'),
          //     // ),
          //   ],
          // ),
          // Consumer<Counter>(
          //   builder: (context, counter, child) {
          //     return GridView.count(
          //       crossAxisCount: 5,
          //       crossAxisSpacing: 10.0,
          //       mainAxisSpacing: 10.0,
          //       shrinkWrap: true,
          //       children: List.generate(
          //         counter.count,
          //             (index) {
          //           return Padding(
          //             padding: const EdgeInsets.all(10.0),
          //             child: Container(
          //               alignment: Alignment.center,
          //               child: Text("phuc"),
          //               decoration: BoxDecoration(
          //                 color: Colors.red,
          //                 borderRadius: BorderRadius.all(
          //                   Radius.circular(20.0),
          //                 ),
          //               ),
          //             ),
          //           );
          //         },
          //       ),
          //     );
          //   },
          // )
          Center(
            child: StreamBuilder<QuerySnapshot<Object?>>(
                stream: cam,
                builder: (context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot,
                    ) {
                  if (snapshot.hasError) {
                    print("over1");
                    return Text('Something went wrong.');
                  }
                  else if(snapshot.connectionState == ConnectionState.waiting){
                    print("over load");
                    return CircularProgressIndicator();
                  }else if (!snapshot.hasData) {
                    print("over2");
                    // Handle case when there is no data
                    return Text('No data available.');
                  }else{
                    return ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                          //print(document.id);
                          return ListTile(
                            title: Text('${data['namecam']}'),
                            trailing: PopupMenuButton(
                              icon: const Icon(
                                Icons.more_vert,
                                color: Colors.black,
                              ),
                              onSelected: (result) {
                                if (result == 0) {
                                  print("Data: ${data['Ipcamera']}");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>
                                        ViewCamera(link: data['Ipcamera'])
                                      //SideMenu(currentIndex: 1, currentIndex_listcamera: 2, currentIndext_listSearch: 0, currentIndex_listProfile: 0,)),
                                    ),
                                  );
                                }
                                if (result == 1) {
                                  CollectionReference camdl = FirebaseFirestore.instance.collection('cameraIp');
                                  camdl.doc(document.id).delete();
                                  AwesomeDialog(
                                    context: context,
                                    animType: AnimType.leftSlide,
                                    headerAnimationLoop: false,
                                    dialogType: DialogType.error,
                                    showCloseIcon: true,
                                    title: 'Đã xóa Camera',
                                    btnOkOnPress: () {
                                    },
                                    btnOkIcon: Icons.check_circle,
                                    onDismissCallback: (type) {
                                    },
                                  ).show();
                                }
                              },
                              itemBuilder: (context) =>[
                                PopupMenuItem(
                                  value: 0,
                                  child: Row(
                                    children: [
                                      Icon(Icons.video_call_sharp),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Watch camera")
                                    ],
                                  ),

                                ),
                                PopupMenuItem(
                                  value: 1,
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete_forever),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Delete camera")
                                    ],
                                  ),

                                ),
                              ],
                            ),
                          );
                        }
                        )
                            .toList()
                    );
                  }
                }
            ),
          ),


        ],
      ),
    );



  }


}

class Getname extends StatelessWidget {
  final String documentId;
  Getname(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference cam = FirebaseFirestore.instance.collection('cameraIp');
    return FutureBuilder<DocumentSnapshot>
      (
      future: cam.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {

          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          print('${data['namecam']}');
          //final files = snapshot.data!.hashCode;
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,

            itemCount: 3,
            itemBuilder: (context, index){
              return ListTile(
                title: Text('${data['namecam']}'),
                trailing: PopupMenuButton(
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ),
                  itemBuilder: (context) =>[
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(Icons.video_call_sharp),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Xem camera")
                        ],
                      ),
                      onTap: () {
                        launch('${data['Ipcamera']}');

                      },
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(Icons.delete_forever),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Xóa camera")
                        ],
                      ),
                      onTap: (){
                        cam.doc(documentId).delete();
                      },


                    ),
                  ],
                ),
              );
            },

          );
        }
        return Text("loading");
      },

    );
  }
}
