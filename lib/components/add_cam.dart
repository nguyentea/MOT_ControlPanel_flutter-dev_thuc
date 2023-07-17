import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttercontrolpanel/components/side_menu.dart';
import 'package:provider/single_child_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class Add_camera extends StatefulWidget {
  const Add_camera({Key? key}) : super(key: key);

  @override
  _Add_cameraState createState() => _Add_cameraState();
}

class _Add_cameraState extends State<Add_camera> {
  TextEditingController _namecamera = TextEditingController();
  TextEditingController _Ipcamera = TextEditingController();
  TextEditingController _district = TextEditingController();
  TextEditingController _ward = TextEditingController();

  CollectionReference add_cam =
  FirebaseFirestore.instance.collection("cameraIp");

  Future<void> addCamera() async {
    // Call the user's CollectionReference to add a new user
    if(_district != Null && _Ipcamera != Null && _namecamera != Null && _ward != Null){
      return add_cam
          .add({
        'Ipcamera': _Ipcamera.text,
        'district': _district.text,
        'namecam': _namecamera.text,
        'ward': _ward.text,
      })
          .then((value) => print("Camera Added"))
          .catchError((error) => print("Failed to add camera: $error"));
    }

  }

  @override
  Widget build(BuildContext context) {
    double  heightR,widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;





    return Scaffold(
      appBar: AppBar(
        title: Text('Add camera'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder<DocumentSnapshot>(
              future: add_cam.doc().get(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError){

                  return Text('Something went wrong');
                }
                if (snapshot.hasData && !snapshot.data!.exists){
                  return Container(
                    child: Column(
                      children: [
                        //SizedBox(height: 70,),
                        // Container(
                        //   alignment: Alignment.centerLeft,
                        //   child: BackButton(
                        //     onPressed: () {
                        //       Navigator.push(
                        //         context,
                        //         PageRouteBuilder(
                        //           pageBuilder: (_, __, ___) => SideMenu(currentIndex: 1,currentIndex_listcamera: 0, currentIndex_listProfile: 0, currentIndext_listSearch: 0,),
                        //           opaque: false,
                        //           transitionDuration: Duration(seconds: 0),
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // ),
                        SizedBox(
                          height: 50,
                        ),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Row(
                        //       children:<Widget> [
                        //         SizedBox(
                        //           width: 20,
                        //         ),
                        //         Container(
                        //           height: 70*heightR,
                        //           width: 500* widthR,
                        //           alignment: Alignment.center,
                        //           child: Text("Name cam :"),
                        //           decoration: BoxDecoration(
                        //             color: Color.fromRGBO(135, 207, 248, 1),
                        //             borderRadius: BorderRadius.all(
                        //               Radius.circular(20.0),
                        //             ),
                        //           ),
                        //         ),
                        //         SizedBox(
                        //           width: 20,
                        //         ),
                        //         Center(
                        //           child:Container(
                        //             height: 120*heightR,
                        //             width: 1300*widthR,
                        //             alignment: Alignment.center,
                        //             child: TextField(
                        //               controller: _namecamera,
                        //               decoration: InputDecoration(
                        //                 border: OutlineInputBorder(),
                        //                 hintText: 'Enter your name camera',
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //     SizedBox(
                        //       height: 20,
                        //     ),
                        //     Row(
                        //       children: [
                        //         SizedBox(
                        //           width: 20,
                        //         ),
                        //         Container(
                        //           height: 70*heightR,
                        //           width: 500* widthR,
                        //           alignment: Alignment.center,
                        //           child: Text("Link camera :"),
                        //           decoration: BoxDecoration(
                        //             color: Color.fromRGBO(135, 207, 248, 1),                    borderRadius: BorderRadius.all(
                        //             Radius.circular(20.0),
                        //           ),
                        //           ),
                        //         ),
                        //         SizedBox(
                        //           width: 20,
                        //         ),
                        //         Center(
                        //           child:Container(
                        //             height: 120*heightR,
                        //             width: 1300*widthR,
                        //             alignment: Alignment.center,
                        //             child: TextField(
                        //               controller: _Ipcamera,
                        //               decoration: InputDecoration(
                        //                 border: OutlineInputBorder(),
                        //                 hintText: 'Enter your link camera',
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //     SizedBox(
                        //       height: 20,
                        //     ),
                        //     Row(
                        //       children: [
                        //         SizedBox(
                        //           width: 20,
                        //         ),
                        //         Container(
                        //           height: 70*heightR,
                        //           width: 500* widthR,
                        //           alignment: Alignment.center,
                        //           child: Text("Phường/thị xã:"),
                        //           decoration: BoxDecoration(
                        //             color: Color.fromRGBO(135, 207, 248, 1),
                        //             borderRadius: BorderRadius.all(
                        //               Radius.circular(20.0),
                        //             ),
                        //           ),
                        //         ),
                        //         SizedBox(
                        //           width: 20,
                        //         ),
                        //         Center(
                        //           child:Container(
                        //             height: 120*heightR,
                        //             width: 1300*widthR,
                        //             alignment: Alignment.center,
                        //             child: TextField(
                        //               controller: _ward ,
                        //               decoration: InputDecoration(
                        //                 border: OutlineInputBorder(),
                        //                 hintText: 'Enter your ward',
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //     SizedBox(
                        //       height: 20,
                        //     ),
                        //     Row(
                        //       children: [
                        //         SizedBox(
                        //           width: 20,
                        //         ),
                        //         Container(
                        //           height: 70*heightR,
                        //           width: 500* widthR,
                        //           alignment: Alignment.center,
                        //           child: Text("Quận/Huyện:"),
                        //           decoration: BoxDecoration(
                        //             color: Color.fromRGBO(135, 207, 248, 1),
                        //             borderRadius: BorderRadius.all(
                        //               Radius.circular(20.0),
                        //             ),
                        //           ),
                        //         ),
                        //         SizedBox(
                        //           width: 20,
                        //         ),
                        //         Center(
                        //           child:Container(
                        //             height: 120*heightR,
                        //             width: 1300*widthR,
                        //             alignment: Alignment.center,
                        //             child: TextField(
                        //               controller: _district ,
                        //               decoration: InputDecoration(
                        //                 border: OutlineInputBorder(),
                        //                 hintText: 'Enter your district',
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ],
                        // ),
                        Container(
                          //padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                          padding:  EdgeInsets.fromLTRB(60*widthR, 10*heightR, 60*widthR, 0),
                          child: TextField(
                            controller: _namecamera,
                            decoration: InputDecoration(
                              //border: UnderlineInputBorder(),
                              labelText: 'Name cam',
                              hintText: "Enter your name camera",
                              //prefixIcon: Icon(Icons.add),
                            ),


                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        Container(
                          padding:  EdgeInsets.fromLTRB(60*widthR, 10*heightR, 60*widthR, 0),
                          child: TextField(
                            controller: _Ipcamera,
                            decoration: InputDecoration(
                              //border: UnderlineInputBorder(),
                              labelText: 'Link camera',
                              hintText: 'Enter your link camera',
                            ),


                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        Container(
                          padding:  EdgeInsets.fromLTRB(60*widthR, 10*heightR, 60*widthR, 0),
                          child: TextField(
                            controller: _ward,
                            decoration: InputDecoration(
                              //border: UnderlineInputBorder(),
                              labelText: 'Phường/Thị xã',
                              hintText: 'Enter your ward',
                            ),


                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        Container(
                          padding:  EdgeInsets.fromLTRB(60*widthR, 10*heightR, 60*widthR, 0),
                          child: TextField(
                            controller: _district,
                            decoration: InputDecoration(
                              //border: UnderlineInputBorder(),
                              labelText: 'Quận/Huyện',
                              hintText: 'Enter your district',
                            ),


                          ),
                        ),

                        SizedBox(
                          height: 50,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: (){
                                  addCamera();
                                },
                                child: Text('Add camera')),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                onPressed: (){launch(_Ipcamera.text);

                                },
                                child: Text('Preview camera')),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                onPressed: (){
                                  String link = _Ipcamera.toString();
                                  //http://27.72.149.120:1880/
                                  //http://admin:Admin@123@14.241.46.213:1880/stw-cgi/video.cgi?msubmenu=snapshot&action=view
                                  var tachlink = link.split('//');
                                  print(tachlink[1]);
                                  var tach = tachlink[1].split('/');
                                  String linksum = 'http://admin:Admin@123@'+tach[0]+'/stw-cgi/video.cgi?msubmenu=snapshot&action=view';
                                  print('day la ${linksum}');
                                  launch(linksum);

                                },
                                child: Text('Xem nhanh camera')),
                          ],
                        ),
                      ],
                    ),
                  );

                }
                return Text('Data');
              },
            ),
          ],
        ),
      ),
    );
  }
}
