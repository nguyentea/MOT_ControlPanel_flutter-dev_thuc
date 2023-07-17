import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final Stream<QuerySnapshot> link_camera =
  FirebaseFirestore.instance.collection('cameraIp').snapshots();

  _show(){
    return StreamBuilder<QuerySnapshot>(
              stream: link_camera,
              builder: (
                  context,
                  AsyncSnapshot<QuerySnapshot> snapshot,
                  ) {
                if (snapshot.hasError) {
                  return Text('Something went wrong.');
                }
                return ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                      bool _isPlay = true;
                      final VlcPlayerController _vlcPlayerController = VlcPlayerController.network(
                        //'rtsp://admin:Admin@123@27.72.149.50:1554/profile3/media.smp',
                        //'rtsp://admin:Admin@123@14.241.46.232:554/profile3/media.smp',
                          '${data['Ipcamera']}',
                          options: VlcPlayerOptions(),
                          hwAcc: HwAcc.full,
                          autoPlay: true
                      );
                      // print(document.id);
                      // print(data["Ipcamera"]);

                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            VlcPlayer(
                              controller: _vlcPlayerController,
                              aspectRatio: 16 / 9, // Tùy chỉnh tỷ lệ khung hình
                              placeholder: Center(child: CircularProgressIndicator()),
                            ),
                            TextButton(
                                onPressed: (){
                                  if(_isPlay){
                                    setState(() {
                                      _isPlay =   false;
                                    });
                                    _vlcPlayerController.pause();
                                  }else{
                                    setState(() {
                                      _isPlay = true;
                                    });
                                    _vlcPlayerController.play();
                                  }
                                },
                                child: _isPlay ?Icon(Icons.pause,size: 28,color: Colors.black,)  : Icon(Icons.play_arrow,size: 28,color: Colors.black,)
                            ),
                          ],
                        ),
                      );

                    }
                    )
                        .toList()
                );
              }
          );



  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video'),
      ),
      body: Container(
        child: _show(),
      ),
    );
  }
}
