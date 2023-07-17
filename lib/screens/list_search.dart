import 'package:flutter/material.dart';
import 'package:fluttercontrolpanel/components/list_video.dart';
import 'package:fluttercontrolpanel/components/test_search.dart';


class ListSearchScreen extends StatelessWidget  {
  final int index;
  const ListSearchScreen({super.key,required this.index});
  @override
  Widget build(BuildContext context) {
    final List<Widget> _page =[
      ListVideoViolation(),
      StorageSearchPage(),

    ];
    return _page[index];
  }
}