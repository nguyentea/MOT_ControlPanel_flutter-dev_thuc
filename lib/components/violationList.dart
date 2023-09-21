import 'package:intl/intl.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttercontrolpanel/components/preview_camera.dart';
import 'package:fluttercontrolpanel/components/side_menu.dart';
import 'package:fluttercontrolpanel/components/violationDetail.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';




class ViolationList extends StatelessWidget {

  final Stream<QuerySnapshot> cam =
  FirebaseFirestore.instance.collection('violation').snapshots();

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
        leading: Icon(Icons.dvr),
        title: Text('Danh sách vi phạm'),
      ),
      body: Center(
            child: StreamBuilder<QuerySnapshot<Object?>>(
                stream: cam,
                builder: (context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot,
                    ) {
                  if (snapshot.hasError) {
                    print("over1");
                    return Text('Lỗi tải dữ liệu từ server');
                  }
                  else if(snapshot.connectionState == ConnectionState.waiting){
                    print("over load");
                    return CircularProgressIndicator();
                  }else if (!snapshot.hasData) {
                    print("over2");
                    // Handle case when there is no data
                    return Text('Không có dữ liệu từ server, hãy chạy module bắt vi phạm để ghi nhận dữ liệu nhé!');
                  }else{
                    return ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                          //print(document.id);
                          return ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                            shape: Border(
                              bottom: BorderSide(
                                color: Colors.blueGrey.shade100, //<-- SEE HERE
                              ),
                              // borderRadius: BorderRadius.circular(20.0),
                            ),
                            title: Text('Biển số vi phạm: ${data['licenseplate']}',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontWeight: FontWeight.bold,
                                    color: Colors.indigo),),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Loại vi phạm: ${data['violation']}',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold,
                                      color: Colors.black),),
                                Text('Thời gian: ${DateFormat('dd/MM/yyyy HH:mm').format(data['time'].toDate())}',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold,
                                      color: Colors.black),),
                                Text('Địa điểm: ${data['local']}',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold,
                                      color: Colors.black),),
                              ],
                            ),
                            trailing: PopupMenuButton(
                              icon: const Icon(
                                Icons.more_vert,
                                color: Colors.black,
                              ),
                              onSelected: (result) {
                                if (result == 0) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>
                                        ViolationDetail(violationData: data)
                                    ),
                                  );
                                }
                                if (result == 1) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>
                                        ViolationDetail(violationData: data)
                                    ),
                                  );
                                }
                              },
                              itemBuilder: (context) =>[
                                PopupMenuItem(
                                  value: 0,
                                  child: Row(
                                    children: [
                                      Icon(Icons.download_for_offline),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Tải video")
                                    ],
                                  ),

                                ),
                                PopupMenuItem(
                                  value: 1,
                                  child: Row(
                                    children: [
                                      Icon(Icons.info),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Xem chi tiết")
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
