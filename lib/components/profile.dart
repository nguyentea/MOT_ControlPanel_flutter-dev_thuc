

import 'dart:io' as io;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttercontrolpanel/components/side_menu.dart';
import 'package:fluttercontrolpanel/components/avatar_image.dart';
import 'package:fluttercontrolpanel/theme/colors.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttercontrolpanel/components/service_box.dart';

class Profile_page extends StatefulWidget {
  const Profile_page({Key? key}) : super(key: key);

  @override
  _Profile_pageState createState() => _Profile_pageState();
}

class _Profile_pageState extends State<Profile_page> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference profile = FirebaseFirestore.instance.collection("account");
  // final Stream<QuerySnapshot> user_profile =
  // FirebaseFirestore.instance.collection('account').snapshots();
  @override
  void initState() {
    super.initState();
    profile = FirebaseFirestore.instance.collection("account");
  }

  _buildServices() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          const SizedBox(
          width: 15,
          ),
          Expanded(
            child: ServiceBox(
            title: "Camera list",
            icon: Icons.video_camera_back,
            bgColor: AppColor.green,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: ServiceBox(
            title: "Violation list",
            icon: Icons.ondemand_video,
            bgColor: AppColor.yellow,
            ),
            ),
          const SizedBox(
            width: 15,
          ),
          ]
       ),
        const SizedBox(
          height: 30,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: ServiceBox(
                  title: "Statistics",
                  icon: Icons.insert_chart,
                  bgColor: Colors.blue.shade100,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: ServiceBox(
                  title: "User management",
                  icon: Icons.supervisor_account,
                  bgColor: Colors.deepOrange.shade100,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
            ]
        ),
      ],
    );
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //   children: [
    //     const SizedBox(
    //       width: 15,
    //     ),
    //     Expanded(
    //       child: ServiceBox(
    //         title: "Send",
    //         icon: Icons.send_rounded,
    //         bgColor: AppColor.green,
    //       ),
    //     ),
    //     const SizedBox(
    //       width: 15,
    //     ),
    //     Expanded(
    //       child: ServiceBox(
    //         title: "Request",
    //         icon: Icons.arrow_circle_down_rounded,
    //         bgColor: AppColor.yellow,
    //       ),
    //     ),
    //     const SizedBox(
    //       width: 15,
    //     ),
    //     Expanded(
    //       child: ServiceBox(
    //         title: "More",
    //         icon: Icons.widgets_rounded,
    //         bgColor: AppColor.purple,
    //       ),
    //     ),
    //     const SizedBox(
    //       width: 15,
    //     ),
    //   ],
    // );
  }

  _buildHeader(userName, avatarUrl) {
    return Container(
      height: 100,
      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      decoration: BoxDecoration(
        color: AppColor.appBgColor,
        border: Border.all(color: Colors.blueAccent),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.shadowColor.withOpacity(0.1),
            blurRadius: .5,
            spreadRadius: .5,
            offset: Offset(0, 1),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AvatarImage(avatarUrl, isSVG: false, width: 35, height: 35),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello ${userName}",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Welcome Back!",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          // _buildNotification()
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {

    double height, width;
    height = MediaQuery.of(context).size.height / 1080; //v26
    width = MediaQuery.of(context).size.width / 2400;

    final User? user =
        auth.currentUser; // push user info to firebase when they update status
    final uid = user?.uid;
    final pro = user?.email;
  //print(pro);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Dashboard'),
        leading: Icon(Icons.screenshot_monitor),
      ),
      //backgroundColor: Color(0xF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<DocumentSnapshot>(
              future: profile.doc(pro.toString()).get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot){
                if (snapshot.hasError){

                  return Text('Fail to connect to Firebase server and obtain user information');
                }

                if(snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

                  return Container(
                    child: Column(
                      children: [
                        Stack(
                          children: <Widget>[
                            _buildHeader(data['name'], data['image']),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => SideMenu(currentIndex: 0, currentIndex_listcamera: 0, currentIndex_listProfile: 1, currentIndext_listSearch: 0,),
                                  )
                                  );
                                },
                                // child: Icon(LineAwesomeIcons.camera, color: Colors.black, size: 20),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 70,),

                        _buildServices(),
                        // Form(
                        //   child: Column(
                        //     children: [
                        //       ListTile(
                        //         leading: Icon(LineAwesomeIcons.user,
                        //           size: 20,
                        //           color: Colors.black87,),
                        //         title: Text(data['name']),
                        //         //subtitle: Text(data['name']),
                        //         shape: RoundedRectangleBorder(
                        //             side: BorderSide(
                        //             color: Colors.deepPurpleAccent, //<-- SEE HERE
                        //               ),
                        //             borderRadius: BorderRadius.circular(20.0),
                        //         ),
                        //       ),
                        //       SizedBox(height: 50,),
                        //       ListTile(
                        //         leading: Icon(Icons.work,
                        //           size: 20,
                        //           color: Colors.black87,),
                        //         title: Text(data['nphone']),
                        //         //subtitle: Text(data['name']),
                        //         shape: RoundedRectangleBorder(
                        //           side: BorderSide(
                        //             color: Colors.deepPurpleAccent, //<-- SEE HERE
                        //           ),
                        //           borderRadius: BorderRadius.circular(20.0),
                        //         ),
                        //       ),
                        //       SizedBox(height: 50,),
                        //
                        //       ListTile(
                        //         leading: Icon(LineAwesomeIcons.calendar,
                        //           size: 20,
                        //           color: Colors.black87,),
                        //         title: Text(data['dateofbirth']),
                        //         //subtitle: Text(data['name']),
                        //         shape: RoundedRectangleBorder(
                        //           side: BorderSide(
                        //             color: Colors.deepPurpleAccent, //<-- SEE HERE
                        //           ),
                        //           borderRadius: BorderRadius.circular(20.0),
                        //         ),
                        //       ),
                        //       // TextFormField(
                        //       //   //controller: ,
                        //       //   decoration: InputDecoration(
                        //       //     label: Text('Ho va ten'),
                        //       //     prefixIcon: Icon(LineAwesomeIcons.user,
                        //       //       size: 20,
                        //       //       color: Colors.black87,),
                        //       //   ),
                        //       // ),
                        //
                        //
                        //       // TextFormField(
                        //       //   //controller: positiController,
                        //       //   decoration: InputDecoration(
                        //       //     label: Text(data['nphone']),
                        //       //     prefixIcon: Icon(Icons.work,
                        //       //       size: 20,
                        //       //       color: Colors.black87,),
                        //       //   ),
                        //       // ),
                        //
                        //       // TextFormField(
                        //       //   //controller: birthdayController,
                        //       //   decoration: InputDecoration(
                        //       //     label: Text(data['dateofbirth']),
                        //       //     prefixIcon: Icon(LineAwesomeIcons.calendar,
                        //       //       size: 20,
                        //       //       color: Colors.black87,),
                        //       //   ),
                        //       // ),
                        //       SizedBox(height: 50,),
                        //
                        //       // ElevatedButton(
                        //       //     style: TextButton.styleFrom(
                        //       //       fixedSize: Size(2000*width, 100*height),
                        //       //       foregroundColor: Colors.black,
                        //       //       backgroundColor: Colors.blue,
                        //       //       textStyle: TextStyle(fontSize: 20),
                        //       //
                        //       //     ),
                        //       //     onPressed: (){
                        //       //       Navigator.push(context, MaterialPageRoute(
                        //       //           builder: (context) => SideMenu(currentIndex: 0, currentIndex_listcamera: 0, currentIndex_listProfile: 1, currentIndext_listSearch: 0,),
                        //       //         )
                        //       //       );
                        //       //       },
                        //       //     child: Text('Update Profile')),
                        //
                        //
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  );
                }
                return Center(
                    // heightFactor: 3,
                    // widthFactor: 0.8,
                    child: Container(
                    child: Text(
                    'Loading, please wait',
                    textScaleFactor: 3,
                    style: TextStyle(
                        color: AppColor.primary,
                        fontSize: 6),
                    ),
                    ),
                  );
              },


            ),



          ],
        ),
      ),

    );
  }
}
