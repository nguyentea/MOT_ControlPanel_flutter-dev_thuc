import 'package:flutter/material.dart';
import 'package:fluttercontrolpanel/components/profile.dart';
import 'package:fluttercontrolpanel/components/update_profile.dart';

class ListProfileScreen extends StatelessWidget  {
  final int index;
  const ListProfileScreen({super.key,required this.index});
  @override
  Widget build(BuildContext context) {
    final List<Widget> _page =[
      Profile_page(),
      Update_Profile(),

    ];
    return _page[index];
  }
}


