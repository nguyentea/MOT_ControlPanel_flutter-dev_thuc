

import 'dart:io' as io;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttercontrolpanel/components/side_menu.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';

class Profile_page extends StatefulWidget {
  const Profile_page({Key? key}) : super(key: key);

  @override
  _Profile_pageState createState() => _Profile_pageState();
}

class _Profile_pageState extends State<Profile_page> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  // final Stream<QuerySnapshot> user_profile =
  // FirebaseFirestore.instance.collection('account').snapshots();
  CollectionReference profile = FirebaseFirestore.instance.collection("account");

  //String imageUrl = 'IILqtEiJAADZICtq3mNS';






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
      appBar: AppBar(
        title: Text('Profile'),
        leading: Icon(Icons.perm_contact_calendar),
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

                  return Text('Something went wrong');
                }

                if(snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

                  return Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Stack(
                          children: <Widget>[
                            SizedBox(
                              width: 150,
                              height: 150,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(data['image'], fit: BoxFit.cover,),
                                //backgroundImage: _imageFile == null ? AssetImage('assets/logo_appthuepin.png'): Image.file(_imageFile!),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => SideMenu(currentIndex: 0, currentIndex_listcamera: 0, currentIndex_listProfile: 1, currentIndext_listSearch: 0,),
                                  )
                                  );

                                  // showModalBottomSheet(
                                  //   context: context,
                                  //   builder: ((build) => Update_Profile()),
                                  // );
                                },
                                child: Icon(LineAwesomeIcons.camera, color: Colors.black, size: 20),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 50,),
                        Form(
                          child: Column(
                            children: [
                              ListTile(
                                leading: Icon(LineAwesomeIcons.user,
                                  size: 20,
                                  color: Colors.black87,),
                                title: Text(data['name']),
                                //subtitle: Text(data['name']),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                    color: Colors.deepPurpleAccent, //<-- SEE HERE
                                      ),
                                    borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              SizedBox(height: 50,),
                              ListTile(
                                leading: Icon(Icons.work,
                                  size: 20,
                                  color: Colors.black87,),
                                title: Text(data['nphone']),
                                //subtitle: Text(data['name']),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.deepPurpleAccent, //<-- SEE HERE
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              SizedBox(height: 50,),

                              ListTile(
                                leading: Icon(LineAwesomeIcons.calendar,
                                  size: 20,
                                  color: Colors.black87,),
                                title: Text(data['dateofbirth']),
                                //subtitle: Text(data['name']),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.deepPurpleAccent, //<-- SEE HERE
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              // TextFormField(
                              //   //controller: ,
                              //   decoration: InputDecoration(
                              //     label: Text('Ho va ten'),
                              //     prefixIcon: Icon(LineAwesomeIcons.user,
                              //       size: 20,
                              //       color: Colors.black87,),
                              //   ),
                              // ),


                              // TextFormField(
                              //   //controller: positiController,
                              //   decoration: InputDecoration(
                              //     label: Text(data['nphone']),
                              //     prefixIcon: Icon(Icons.work,
                              //       size: 20,
                              //       color: Colors.black87,),
                              //   ),
                              // ),

                              // TextFormField(
                              //   //controller: birthdayController,
                              //   decoration: InputDecoration(
                              //     label: Text(data['dateofbirth']),
                              //     prefixIcon: Icon(LineAwesomeIcons.calendar,
                              //       size: 20,
                              //       color: Colors.black87,),
                              //   ),
                              // ),
                              SizedBox(height: 50,),

                              ElevatedButton(
                                  style: TextButton.styleFrom(
                                    fixedSize: Size(2000*width, 100*height),
                                    foregroundColor: Colors.black,
                                    backgroundColor: Colors.blue,
                                    textStyle: TextStyle(fontSize: 20),

                                  ),
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => SideMenu(currentIndex: 0, currentIndex_listcamera: 0, currentIndex_listProfile: 1, currentIndext_listSearch: 0,),
                                      )
                                    );
                                    },
                                  child: Text('Update Profile')),


                            ],
                          ),
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
