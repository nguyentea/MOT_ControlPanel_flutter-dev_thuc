
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttercontrolpanel/components/empty_page.dart';
import 'package:fluttercontrolpanel/screens/list_camera.dart';
import 'package:fluttercontrolpanel/screens/list_profile.dart';
import 'package:fluttercontrolpanel/screens/list_video_search.dart';
import 'package:side_bar_custom/side_bar_custom.dart';
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


          ),
          // Center(
          //   child: EmptyPage(),
          // ),
        ],
        items: [
          SideBarItem(
            text: "Profile",
            icon: Icons.account_circle,
            tooltipText: "Profile page",
          ),
          SideBarItem(
            text: "List Camera",
            icon: Icons.video_camera_back,
            tooltipText: "List camera page",
          ),
          SideBarItem(
            text: "Video violation",
            icon: Icons.ondemand_video,
            tooltipText: "Video violation page",
          ),
          // SideBarItem(
          //   text: "Statistic",
          //   icon: Icons.bar_chart,
          //   tooltipText: "Statistic page",
          // ),
        ],
        config: SideBarConfig(
            enablePageView: true,
            iconSize: 10,
            floatingPadding: EdgeInsets.all(12),
            enableFloating: true,
            enableDivider: false,
            backgroundColor: Color(0xE03)
        ),
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