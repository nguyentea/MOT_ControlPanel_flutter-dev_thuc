
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttercontrolpanel/components/empty_page.dart';
import 'package:fluttercontrolpanel/screens/list_camera.dart';
import 'package:fluttercontrolpanel/screens/list_profile.dart';
import 'package:fluttercontrolpanel/screens/list_video_search.dart';
import 'package:fluttercontrolpanel/screens/violation_list.dart';
import 'package:side_bar_custom/side_bar_custom.dart';
class SideMenu extends StatelessWidget {
  final int currentIndex;
  final int currentIndex_listcamera;
  final int currentIndex_listProfile;
  final int currentIndex_violationList;

  SideMenu({super.key,
  required this.currentIndex,
  required this.currentIndex_listcamera,
  required this.currentIndex_listProfile,
  required this.currentIndex_violationList});
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
          ),
          Center(
            child: ViolationListScreen(index: currentIndex_violationList,),
          ),
        ],
        items: [
          SideBarItem(
            text: "Trang chủ",
            icon: Icons.desktop_mac,
            tooltipText: "Trang chủ",
          ),
          SideBarItem(
            text: "Danh sách camera",
            icon: Icons.video_camera_back,
            tooltipText: "Danh sách camera",
          ),
          SideBarItem(
            text: "Danh sách vi phạm",
            icon: Icons.fact_check,
            tooltipText: "Danh sách vi phạm",
          ),
        ],
        config: SideBarConfig(
            // enablePageView: true,
            iconSize: 24,
            // floatingPadding: EdgeInsets.all(12),
            // enableFloating: true,
            // enableDivider: false,
            // backgroundColor: Color(0xE03)
        ),
      ),
    );
  }
}
