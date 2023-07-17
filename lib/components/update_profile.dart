
import 'dart:io' as io;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
class Update_Profile extends StatefulWidget {
  const Update_Profile({Key? key}) : super(key: key);

  @override
  _Update_ProfileState createState() => _Update_ProfileState();
}

class _Update_ProfileState extends State<Update_Profile> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController nameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController positiController = TextEditingController();

  CollectionReference add_profile = FirebaseFirestore.instance.collection("account");
  String imageUrl = '';

  var _nameInvalid = false;
  var _birthInvalid = false;
  var _posiInvalid = false;

  var _nameError = 'Inserted Name is not valid';
  var _birthError = 'Inserted Birthday is not valid';
  var _posiError = 'Inserted Positi is not valid';

  void content() {
    setState(() {
      if (nameController.text.length < 2 ) {
        _nameInvalid = true;
      } else {
        _nameInvalid = false;
      }
      if (birthdayController.text.length < 2) {
        _birthInvalid = true;
      } else {
        _birthInvalid = false;
      }
      if (positiController.text.length < 2 ) {
        _posiInvalid = true;
      } else {
        _posiInvalid = false;
      }
    });
  }

  Future<void> addProfile() async{
    final User? user = auth.currentUser;
    final email = user?.email;
    // Call the user's CollectionReference to update a user
      return add_profile
          .doc(email)
          .update({
        'name': nameController.text,
        'nphone': positiController.text,
        'dateofbirth': birthdayController.text,
        'image': imageUrl,
      })
          .then((value) => print("profile Added"))
          .catchError((error) => print("Failed to add camera: $error"));
  }

  Widget _entryField(
      bool obscure,
      String title,
      String hind_text,
      TextEditingController controller,
      var users,
      var error,
      var icon,
      ) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        prefixIcon: icon,
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


  final ImagePicker _picker = ImagePicker();
  io.File? _imageFile;

  Widget bottomSheet(){
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            'Pick Image',
            style: TextStyle(
              fontSize: 20,
            ),
          ),

          SizedBox(
            height: 20,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                icon: Icon(Icons.camera),
                onPressed: (){
                  takePhoto(ImageSource.camera);
                },
                label: Text('Camera'),
              ),
              TextButton.icon(
                icon: Icon(Icons.image),
                onPressed: (){
                  takePhoto(ImageSource.gallery);
                },
                label: Text('Galley'),
              ),

            ],
          ),
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async{
    final pickedFile = await _picker.getImage(
      source: source,
    );
    if(pickedFile != null){
      setState(() {
        _imageFile = io.File(pickedFile.path);
        //upImage();
      });
    }

  }
  void upImage() async{
    if(_imageFile == null) return;
    //final destination = 'file/$_imageFile';
    //print(_imageFile);
    try {

      final ref = FirebaseStorage.instance
          .ref('Avatar/')
          .child('${nameController.text}/');
      await ref.putFile(_imageFile!);

      imageUrl = await ref.getDownloadURL();
      //print(imageUrl);
    } catch (e) {
      print('error occured');
    }
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
      ),
      //backgroundColor: Color(0xF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<DocumentSnapshot>(
              future: add_profile.doc(pro.toString()).get(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                if (snapshot.hasError){

                  return Text('Something went wrong');
                }
                if (snapshot.hasData && !snapshot.data!.exists){
                  return Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Stack(
                          children: <Widget>[
                            Container(
                              width: 180*height,
                              height: 180*height,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 4*height,
                                  ),
                                  //     boxShadow: [
                                  //   BoxShadow(
                                  //     color: Colors.black,
                                  //     blurRadius: 2.0,
                                  //     spreadRadius: 0.0,
                                  //     offset: Offset(
                                  //         2.0, 2.0), // shadow direction: bottom right
                                  //   )
                                  // ],
                                  borderRadius: BorderRadius.circular(100)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: _imageFile != null ? Image.file(_imageFile!, fit: BoxFit.cover,): Image.network("https://res.cloudinary.com/teepublic/image/private/s--WlHDkW0o--/t_Preview/b_rgb:0195c3,c_lpad,f_jpg,h_630,q_90,w_1200/v1570281377/production/designs/6215195_0.jpg"),
                                //backgroundImage: _imageFile == null ? AssetImage('assets/logo_appthuepin.png'): Image.file(_imageFile!),
                              ),
                            ),
                            // SizedBox(
                            //   width: 150,
                            //   height: 150,
                            //   child: ClipRRect(
                            //     borderRadius: BorderRadius.circular(100),
                            //     //backgroundImage: _imageFile == null ? AssetImage('assets/logo_appthuepin.png'): Image.file(_imageFile!),
                            //   ),
                            // ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: (){
                                  showModalBottomSheet(
                                    context: context,
                                    builder: ((build) => bottomSheet()),
                                  );
                                },
                                child: Icon(LineAwesomeIcons.camera, color: Colors.black, size: 20),
                              ),

                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 50,),
                      Form(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                label: Text('Name'),
                                hintText: data['name'],
                                prefixIcon: Icon(LineAwesomeIcons.user,
                                  size: 20,
                                  color: Colors.black87,),
                              ),
                            ),
                            SizedBox(height: 50,),

                            TextFormField(
                              controller: positiController,
                              decoration: InputDecoration(
                                label: Text('Chuc Vu'),
                                prefixIcon: Icon(Icons.work,
                                  size: 20,
                                  color: Colors.black87,),
                              ),
                            ),
                            SizedBox(height: 50,),

                            TextFormField(
                              controller: birthdayController,
                              decoration: InputDecoration(
                                label: Text('Ngay Sinh'),
                                prefixIcon: Icon(LineAwesomeIcons.calendar,
                                  size: 20,
                                  color: Colors.black87,),
                              ),
                            ),
                            SizedBox(height: 50,),

                            // Container(
                            //   padding:  EdgeInsets.fromLTRB(50*width, 0, 20*width, 5*height),
                            //   child: TextFormField(
                            //     controller: nameController,
                            //     decoration:  InputDecoration(
                            //       labelText: 'Enter your Username',
                            //     ),
                            //   ),
                            // ),
                            Column(
                              children: [
                                Container(
                                  child: ElevatedButton(
                                    style: TextButton.styleFrom(
                                      fixedSize: Size(2000*width, 100*height),
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.blue,
                                      textStyle: TextStyle(fontSize: 20),

                                    ),
                                    onPressed: () {
                                      addProfile();
                                      upImage();
                                    },
                                    child: Text('Save Your Profie'),
                                  ),
                                )
                              ],
                            ),


                          ],
                        ),
                      ),
                    ],
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
