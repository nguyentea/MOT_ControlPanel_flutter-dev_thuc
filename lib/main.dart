import 'package:flutter/material.dart';
import 'package:fluttercontrolpanel/changeNotifier.dart';
import 'package:fluttercontrolpanel/components/empty_page.dart';
import 'package:fluttercontrolpanel/components/side_menu.dart';
import 'package:fluttercontrolpanel/screens/login.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Counter(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        /*home: SideMenu(
          currentIndex: 0,
          currentIndex_listcamera: 0,
        ),*/
        home: LogInPage(),
      ),
    );
  }
}
