import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttercontrolpanel/components/add_camera.dart';
import 'package:fluttercontrolpanel/components/empty_page.dart';
// import 'package:fluttercontrolpanel/components/stream_cam.dart';
import 'package:fluttercontrolpanel/components/test.dart';
import 'package:fluttercontrolpanel/components/test_listvideo.dart';
import 'package:fluttercontrolpanel/components/test_search.dart';
import 'package:fluttercontrolpanel/screens/list_camera.dart';
import 'package:fluttercontrolpanel/screens/list_profile.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:side_bar_custom/side_bar_custom.dart';

import '../screens/list_video_search.dart';
class SideMenu extends StatelessWidget {
  final int currentIndex;
  final int currentIndex_listcamera;
  final int currentIndex_listProfile;
  final int currentIndext_listSearch;

  SideMenu({super.key,
  required this.currentIndex,
  required this.currentIndex_listcamera,
  required this.currentIndex_listProfile,
  required this.currentIndext_listSearch});
  //final  _database = FirebaseStorage.instance.ref('violation');
  @override
  Widget build(BuildContext context) {
    double  heightR,widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    var curR = widthR;

    return Scaffold(
      //backgroundColor: Color(0xF5F5F5),
      body: SideBar(
        initialIndex: currentIndex,
        children: [
          Center(

            child: ListProfileScreen(index: currentIndex_listProfile,),
          ),

          Center(
            child: ListCameraScreen(index: currentIndex_listcamera,),
            //child: ListCamera(),


          ),

          Center(
            child: ListVideoSearchScreen(index: currentIndext_listSearch,),
            //child: ListVideoViolation(),
            //child: VideoSearchScreen(database: _database,),
            //child: StorageSearchPage(),

          ),
          Center(
            //child: VideoScreen(),
            child: AddCamera(),
          ),
        ],
        items: [
          SideBarItem(
            text: "Profile",
            icon: Icons.person,
            tooltipText: "Profile page",
          ),
          SideBarItem(
            text: "List Camera",
            icon: Icons.video_call_sharp,
            tooltipText: "List camera page",
          ),
          SideBarItem(
            text: "Video violation",
            icon: Icons.video_library,
            tooltipText: "Video violation page",
          ),
          SideBarItem(
            text: "Statistic",
            icon: Icons.bar_chart,
            tooltipText: "Statistic page",
          ),
        ],
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Center(
          child:
          AnimatedTextKit(animatedTexts: [TyperAnimatedText('Dashboard')]))
    ]);
  }
}

// class ListCameraScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//       Center(
//           child:
//               AnimatedTextKit(animatedTexts: [TyperAnimatedText('Listcamera')]))
//     ]);
//   }
// }

class VideoViolationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Center(
          child: AnimatedTextKit(
              animatedTexts: [TyperAnimatedText('Video violation')]))
    ]);
  }
}

class StatisticScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Center(
          child:
          AnimatedTextKit(animatedTexts: [TyperAnimatedText('Statistic')]))
    ]);
  }
}