import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class ViewCamera extends StatefulWidget {
  ViewCamera({Key? key, required this.link}) : super(key: key);

  final String link;

  @override
  State<ViewCamera> createState() => _ViewCameraState();
}

class _ViewCameraState extends State<ViewCamera> {
  bool _isPlay = true;




  @override
  Widget build(BuildContext context) {
    final VlcPlayerController _vlcPlayerController = VlcPlayerController.network(
      widget!.link,
      options: VlcPlayerOptions(),
      hwAcc: HwAcc.full,
      autoPlay: true,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Xem trực tiếp camera'),
      ),
      body: Center(
        child: Column(
          children: [

            VlcPlayer(
              controller: _vlcPlayerController,
              aspectRatio: 16 / 9,
              placeholder: Center(child: CircularProgressIndicator()),
            ),
            TextButton(
              onPressed: () {
                if (_isPlay) {
                  _isPlay = false;
                  _vlcPlayerController.pause();
                } else {
                  _isPlay = true;
                  _vlcPlayerController.play();
                }
              },
              child: _isPlay
                  ? Icon(Icons.pause, size: 28, color: Colors.black)
                  : Icon(Icons.play_arrow, size: 28, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}