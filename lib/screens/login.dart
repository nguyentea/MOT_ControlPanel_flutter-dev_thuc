import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttercontrolpanel/components/empty_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import '../components/side_menu.dart';
import 'msg_dialog.dart';

void main() async {
}

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {

  @override
  Widget build(BuildContext context) {
    double  heightR,widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    var curR = widthR;
    Widget example1 = SplashScreenView(
      navigateRoute: SignPage(),
      duration: 5000,
      imageSize: 300,
      imageSrc: "assets/logoApp.jpg",
      text: "Đang tải ...",
      textType: TextType.ColorizeAnimationText,
      textStyle: TextStyle(
        fontSize: 220*curR,
      ),
      colors: [
        Colors.purple,
        Colors.blue,
        Colors.yellow,
        Colors.red,
      ],
      backgroundColor: Colors.white,
    );

    return MaterialApp(
      home: example1,
      theme: _themeData(Brightness.light),
      darkTheme: _themeData(Brightness.light),
    );
  }
}

class SignPage extends StatefulWidget {
  const SignPage({Key? key}) : super(key: key);

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPass = true;
  save(var data, var name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(name, data);
  }
  savebool(var data, var name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(name, data);
  }
  @override
  void initState(){
    super.initState();
    _GetDataSave();
  }
  _GetDataSave() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? dataname = prefs.getString('username');
    String? datapass = prefs.getString('password');
    setState(() {
      dataname != null ? nameController.text = dataname! : "";
      datapass != null ? passwordController.text = datapass! : "";
    });

  }

  @override
  Widget build(BuildContext context) {
    double  heightR,widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    var curR = widthR;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding:  EdgeInsets.all(13*curR),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 80*heightR,
                ),
                Container(
                    alignment: Alignment.center,
                    padding:  EdgeInsets.only(top: 10*curR,left: 10*curR,right: 10*curR,bottom: 10*curR),
                    // margin: EdgeInsets.only(top: 70 * heightR),
                    child:  Text(
                      'Chào mừng!',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 220 * curR),
                    )),
                Container(
                  // color: Colors.red,
                  height: 400*heightR,
                  padding:  EdgeInsets.all(40*heightR),
                  margin: EdgeInsets.only(bottom: 30*heightR),
                  alignment: Alignment.center,
                  child: Image.asset('assets/logoApp.jpg'),
                ),
                Container(
                    padding:  EdgeInsets.fromLTRB(60*widthR, 0, 60*widthR, 10*heightR),
                    child: TextFormField(
                      controller: nameController,
                      decoration:  InputDecoration(
                        labelText: 'Nhập tên đăng nhập',
                      ),
                    ),
                ),
                Container(
                  padding:  EdgeInsets.fromLTRB(60*widthR, 10*heightR, 60*widthR, 0),
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Mật khẩu',
                      hintText: "Nhập mật khẩu",
                      suffixIcon: IconButton(
                          icon: Icon(
                            showPass ? Icons.visibility : Icons.visibility_off,
                            semanticLabel: showPass ? 'Ẩn mật khẩu' : 'Hiện mật khẩu',
                          ),
                          onPressed: () {
                            setState(() {
                              setState(() {
                                showPass = !showPass;
                              });
                              //print("Icon button pressed! state: $_passwordVisible"); //Confirmed that the _passwordVisible is toggled each time the button is pressed.
                            });
                          }),
                    ),
                    obscureText: showPass,

                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Navigator.push(context, MaterialPageRoute(
                      //   builder: (context) => EmptyPage(),
                      // )
                      // );
                      AwesomeDialog(
                        context: context,
                        animType: AnimType.leftSlide,
                        headerAnimationLoop: false,
                        dialogType: DialogType.info,
                        showCloseIcon: true,
                        title: 'Thông báo',
                        desc:
                        'Vui lòng liên hệ với quản trị viên để lấy lại mật khẩu!',
                        btnOkOnPress: () {
                        },
                        // btnOkIcon: Icons.cancel,
                        onDismissCallback: (type) {
                        },
                      ).show();
                    },
                    child:  Text(
                      'Quên mật khẩu?',
                      style: TextStyle(
                        fontSize: 100*curR,
                      ),
                    ),
                  ),
                ),
                Container(
                    height: 60*heightR,
                    // width: 60*widthR,
                    margin: EdgeInsets.only(top: 20*heightR, left: 220*widthR, right: 220*widthR),
                    padding:  EdgeInsets.fromLTRB(60*widthR, 0, 60*widthR, 0),
                    child: ElevatedButton(
                      child:  Text(
                        'Đăng nhập',
                        style: TextStyle(fontSize: 100*curR),
                      ),
                      onPressed: () {
                        signInEmailPassword(nameController.text, passwordController.text);
                        },
                    )),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                //     Container(
                //       margin: EdgeInsets.only(left: 200*widthR),
                //       child: Text('Do not have an account?',
                //         style: TextStyle(
                //           fontSize: 100*curR,
                //         ),),
                //     ),
                //     Container(
                //         margin: EdgeInsets.only(right: 170*widthR),
                //         child: TextButton(
                //           child:  Text(
                //             'Sign up',
                //             style: TextStyle(fontSize: 100*curR),
                //           ),
                //           onPressed: () {
                //             Navigator.push(context, MaterialPageRoute(
                //               builder: (context) => EmptyPage(),
                //             )
                //             );
                //           },
                //         )
                //     ),
                //   ],
                // ),
              ],
            ))
    );
  }
  Future signInEmailPassword(String email, String password) async {

       FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: email.toString(),
          password: password.toString()).then(
               (user) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    SideMenu(currentIndex: 0,currentIndex_listcamera: 0, currentIndex_listProfile: 0, currentIndext_listSearch: 0,)
            ));
            save(nameController.text,'username');
            save(passwordController.text,'password');
      }).catchError((e){
        print(e);
        MSG(e.code);
      });
  }
  void MSG(String code ){
    return _onLogninErr(code, (code){
      MsgDialog.showMsgDialog(context, "Sign-In",code);
    });
  }
  void _onLogninErr(String code, Function(String) onSignInError){
    switch(code){
      case "invalid-email":
        onSignInError("Invalid email");
        break;
      case "wrong-password":
        onSignInError("Incorrect password");
        break;
      case "user-not-found":
        onSignInError("Account does not exist or has been deleted");
        break;
    }
  }
}

ThemeData _themeData(Brightness brightness) {
  return ThemeData(
    fontFamily: "Poppins",
    brightness: brightness,
    // Matches app icon color.
    primarySwatch:  MaterialColor(0xFF4D8CFE, <int, Color>{
      50: Color(0xFFEAF1FF),
      100: Color(0xFFCADDFF),
      200: Color(0xFFA6C6FF),
      300: Color(0xFF82AFFE),
      400: Color(0xFF689DFE),
      500: Color(0xFF4D8CFE),
      600: Color(0xFF4684FE),
      700: Color(0xFF3D79FE),
      800: Color(0xFF346FFE),
      900: Color(0xFF255CFD),
    }),
    // appBarTheme: AppBarTheme(
    //   brightness: Brightness.dark,
    // ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      errorStyle: TextStyle(height: 0.75),
      helperStyle: TextStyle(height: 0.75),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
      minimumSize: Size.fromHeight(40),
    )),
    scaffoldBackgroundColor: brightness == Brightness.dark
        ? Colors.black
        : null,
    cardColor: brightness == Brightness.dark
        ? Color.fromARGB(255, 28, 28, 30)
        : null,
    dialogTheme: DialogTheme(
      backgroundColor: brightness == Brightness.dark
          ? Color.fromARGB(255, 28, 28, 30)
          : null,
    ),
    highlightColor: brightness == Brightness.dark
        ? Color.fromARGB(255, 44, 44, 46)
        : null,
    splashFactory: NoSplash.splashFactory,
  );
}

