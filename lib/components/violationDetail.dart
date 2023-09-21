import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ViolationDetail extends StatefulWidget {
  ViolationDetail({Key? key, required this.violationData}) : super(key: key);

  final Map<String, dynamic> violationData;

  @override
  State<ViolationDetail> createState() => _ViolationDetailState();
}

class _ViolationDetailState extends State<ViolationDetail> {
  bool _isPlay = true;
  String imageUrl = '';

  _loadFirebaseImageUrl() async {
    final ref = FirebaseStorage.instance
        .ref('/Image_jetson')
        .child(widget.violationData["video_name"]+'.jpg');

    var url = await ref.getDownloadURL() as String;

    setState(() {
      imageUrl = url;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _loadFirebaseImageUrl();
    });
  }



  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_){
      _loadFirebaseImageUrl();
    });
    print("violationData, ${widget.violationData}");
    print("image url inside build ${imageUrl}");
    return Scaffold(
      appBar: AppBar(
        title: Text('Xem chi tiết vi phạm'),
        leading: Icon(Icons.feed),
      ),
      body: imageUrl != '' ? Image.network(imageUrl) : Text("Đang tải ảnh vi phạm, vui lòng chờ")
    );
  }
}