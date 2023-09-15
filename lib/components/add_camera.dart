import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fluttercontrolpanel/components/load_msg_dilog.dart';
import 'package:fluttercontrolpanel/components/preview_camera.dart';


class AddCamera extends StatefulWidget {
  @override
  _AddCameraState createState() => _AddCameraState();
}

class _AddCameraState extends State<AddCamera> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController _namecamera = TextEditingController();
  TextEditingController _Ipcamera = TextEditingController();
  TextEditingController _district = TextEditingController();
  TextEditingController _ward = TextEditingController();

  var _nameInvalid = false;
  var _IpInvalid = false;
  var _distInvalid = false;
  var _wardInvalid = false;

  var _nameError = "Inserted Name camrea is not valid";
  var _IpError = "Inserted Link camera is not valid";
  var _distError = "Inserted District is not valid";
  var _wardError = "Inserted Ward URL is not valid";

  var name = 'Name Camera';
  var link = 'Link Camera';
  var dist = 'District of Camera';
  var ward = 'Ward of Camera';

  bool already_saved = false;
  final Stream<QuerySnapshot> add_camera =
  FirebaseFirestore.instance.collection('cameraIp').snapshots();

  Widget show_camera(String link){
    //print(link);
    bool _isPlay = true;
    final VlcPlayerController _vlcPlayerController = VlcPlayerController.network(
        link,
        options: VlcPlayerOptions(),
        hwAcc: HwAcc.full,
        autoPlay: true
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Video'),
      ),
      body: Center(
          child: Container(
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
                        _isPlay =   false;
                        // setState(() {
                        //   _isPlay =   false;
                        // });
                        _vlcPlayerController.pause();
                      }else{
                        _isPlay = true;
                        // setState(() {
                        //   _isPlay = true;
                        // });
                        _vlcPlayerController.play();
                      }
                    },
                    child: _isPlay ?Icon(Icons.pause,size: 28,color: Colors.black,)  : Icon(Icons.play_arrow,size: 28,color: Colors.black,)
                )
              ],
            ),
          )
      ),
    );
  }

  void content() {
    setState(() {
      if (_namecamera.text.length < 2 ) {
        _nameInvalid = true;
      } else {
        _nameInvalid = false;
      }
      if (_Ipcamera.text.length < 2 ||
          !_Ipcamera.text.contains('rtsp')) {
        _IpInvalid = true;
      } else {
        _IpInvalid = false;
      }
      if (_district.text.length < 2 ) {
        _distInvalid = true;
      } else {
        _distInvalid = false;
      }
      if (_ward.text.length < 2 ) {
        _wardInvalid = true;
      } else {
        _wardInvalid = false;
      }
    });
  }

  Widget _entryField(
      bool obscure,
      String title,
      String hind_text,
      TextEditingController controller,
      var users,
      var error,
      ) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        errorText: users ? error : null,
        enabledBorder: OutlineInputBorder(
          // borderSide:
          // BorderSide(width: 3, color: Colors.greenAccent), //<-- SEE HERE
          borderRadius: BorderRadius.circular(20.0),
        ),
        labelText: title,
        hintText: hind_text,
      ),
    );
  }
  CollectionReference camera =
  FirebaseFirestore.instance.collection("cameraIp");

  @override
  Widget build(BuildContext context) {
    double  heightR,widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    var curR = widthR;
    // final User? user =
    //     auth.currentUser; // push user info to firebase when they update status
    // final uid = user?.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Camera'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.folder_shared,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot>(
            future: camera.doc().get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                // return Center(
                //   heightFactor: 20,
                //   widthFactor: 20,
                //   child: CircularProgressIndicator(
                //     backgroundColor: Colors.cyanAccent,
                //     valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                //   ),
                // );
              }
              if (snapshot.hasData && !snapshot.data!.exists) {
                // return  Center(
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       SizedBox(
                //         height: 50*heightR,
                //       ),
                //       Container(
                //         margin: EdgeInsets.all(22*heightR),
                //         child: _entryField(false, name, 'Insert your Name camera', _namecamera, _nameInvalid, _nameError),
                //         //child: _entryField(false, name, name, _namecamera, _nameInvalid, _nameError),
                //       ),
                //       Container(
                //         margin: EdgeInsets.all(20*heightR),
                //         child: _entryField(false, link, 'Insert your Link camera',
                //             _Ipcamera, _IpInvalid, _IpError),
                //       ),
                //       Container(
                //         margin: EdgeInsets.all(22*heightR),
                //         child: _entryField(false, dist, 'Insert your District',
                //             _district, _distInvalid, _distError),
                //       ),
                //       Container(
                //         margin: EdgeInsets.all(22*heightR),
                //         child: _entryField(false, ward, 'Insert your Ward',
                //             _ward, _wardInvalid, _wardError),
                //       ),
                //       Container(
                //           height: 80*heightR,
                //           margin: EdgeInsets.only(top: 70*heightR),
                //           padding:  EdgeInsets.fromLTRB(120*curR, 0, 120*curR, 0),
                //           child: ElevatedButton(
                //             child:  Text(
                //               'Add Camera',
                //               style: TextStyle(fontSize: 120*curR),
                //             ),
                //             onPressed: () {
                //               content();
                //               if (_nameInvalid == false &&
                //                   _IpInvalid == false &&
                //                   _distInvalid == false &&
                //                   _wardInvalid == false &&
                //                   already_saved == false) {
                //                 camera.doc(uid.toString()).set({
                //                   'namecam': _namecamera.text,
                //                   'Ipcamera': _Ipcamera.text,
                //                   'district': _district.text,
                //                   'ward': _ward.text,
                //                   'ID': uid,
                //                 })
                //                 //.then((value) => print('ID:${uid}'))
                //                     .catchError((error) =>
                //                     print('Faild to add camera: $error'));
                //                 already_saved = true;
                //                 AwesomeDialog(
                //                   context: context,
                //                   animType: AnimType.leftSlide,
                //                   headerAnimationLoop: false,
                //                   dialogType: DialogType.success,
                //                   showCloseIcon: true,
                //                   title: 'Successfully Add Camera',
                //                   desc:
                //                   'Congratulations!',
                //                   btnOkOnPress: () {
                //                   },
                //                   btnOkIcon: Icons.check_circle,
                //                   onDismissCallback: (type) {
                //                   },
                //                 ).show();
                //               } else if (already_saved == true) {
                //                 //content();
                //                 MsgDialog.showMsgDialog(
                //                     context,
                //                     "Failed to add camera",
                //                     "You have already created your QR");
                //               }
                //             },
                //           )),
                //     ],
                //   ),
                // );
              }


              return  Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50*heightR,
                    ),
                    Container(
                      margin: EdgeInsets.all(22*heightR),
                      child: _entryField(false, name, 'Insert your Name camera', _namecamera, _nameInvalid, _nameError),
                      //child: _entryField(false, name, name, _namecamera, _nameInvalid, _nameError),
                    ),
                    Container(
                      margin: EdgeInsets.all(20*heightR),
                      child: _entryField(false, link, 'Insert your Link camera',
                          _Ipcamera, _IpInvalid, _IpError),
                    ),
                    Container(
                      margin: EdgeInsets.all(22*heightR),
                      child: _entryField(false, dist, 'Insert your District',
                          _district, _distInvalid, _distError),
                    ),
                    Container(
                      margin: EdgeInsets.all(22*heightR),
                      child: _entryField(false, ward, 'Insert your Ward',
                          _ward, _wardInvalid, _wardError),
                    ),
                    Container(
                        height: 80*heightR,
                        margin: EdgeInsets.only(top: 70*heightR),
                        padding:  EdgeInsets.fromLTRB(120*curR, 0, 120*curR, 0),
                        child: ElevatedButton(
                          child:  Text(
                            'Add Camera',
                            style: TextStyle(fontSize: 120*curR),
                          ),
                          onPressed: () {
                            content();
                            if (_nameInvalid == false &&
                                _IpInvalid == false &&
                                _distInvalid == false &&
                                _wardInvalid == false &&
                                already_saved == false) {
                              camera.doc().set({
                                'namecam': _namecamera.text,
                                'Ipcamera': _Ipcamera.text,
                                'district': _district.text,
                                'ward': _ward.text,
                                //'ID': uid,
                              })
                              //.then((value) => print('ID:${uid}'))
                                  .catchError((error) =>
                                  print('Faild to add camera: $error'));
                              already_saved = true;
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.leftSlide,
                                headerAnimationLoop: false,
                                dialogType: DialogType.success,
                                showCloseIcon: true,
                                title: 'Successfully Add Camera',
                                desc:
                                'Congratulations!',
                                btnOkOnPress: () {
                                },
                                btnOkIcon: Icons.check_circle,
                                onDismissCallback: (type) {
                                },
                              ).show();
                            } else if (already_saved == true) {
                              //content();
                              MsgDialog.showMsgDialog(
                                  context,
                                  "Failed to add camera",
                                  "You have already created your QR");
                            }
                          },
                        )),
                    Container(
                        height: 80*heightR,
                        margin: EdgeInsets.only(top: 70*heightR),
                        padding:  EdgeInsets.fromLTRB(120*curR, 0, 120*curR, 0),
                        child: ElevatedButton(
                          child:  Text(
                            'Preview Camera',
                            style: TextStyle(fontSize: 120*curR),
                          ),
                          onPressed: () {
                            content();
                            if (_nameInvalid == false &&
                                _IpInvalid == false &&
                                _distInvalid == false &&
                                _wardInvalid == false &&
                                already_saved == false){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                  ViewCamera(link: _Ipcamera.text)
                                    //show_camera(_Ipcamera.text)
                                ),
                              );
                            }
                          },
                        )),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
