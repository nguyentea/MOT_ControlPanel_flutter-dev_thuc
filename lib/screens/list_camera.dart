import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fluttercontrolpanel/components/add_cam.dart';
import 'package:fluttercontrolpanel/components/add_camera.dart';
import 'package:fluttercontrolpanel/components/listcamera.dart';
class ListCameraScreen extends StatelessWidget  {
  final int index;
  const ListCameraScreen({super.key,required this.index});
  @override
  Widget build(BuildContext context) {
    final List<Widget> _page =[
      //VideoApp(),
      ListCamera(),
      AddCamera(),

    ];
    return _page[index];
  }
}


