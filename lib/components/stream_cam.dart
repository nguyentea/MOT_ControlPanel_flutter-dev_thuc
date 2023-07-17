import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class VideoScreen extends StatefulWidget {

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  // String link_cam;
  // _VideoScreenState({super.key, required this.link_cam});
  bool _isPlay = true;
  final VlcPlayerController _vlcPlayerController = VlcPlayerController.network(

      'rtsp://admin:Admin@123@27.72.149.50:1554/profile3/media.smp',
      options: VlcPlayerOptions(),
      hwAcc: HwAcc.full,
      autoPlay: true
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video'),
      ),
      body: Center(
          child: Container(
            child: Column(
              children: [
                VlcPlayer(
                  controller: _vlcPlayerController,
                  aspectRatio: 16 / 9, // Tùy chỉnh tỷ lệ khung hình
                  placeholder: Center(child: CircularProgressIndicator()),
                ),
                TextButton(
                    onPressed: (){
                      if(_isPlay){
                        setState(() {
                          _isPlay =   false;
                        });
                        _vlcPlayerController.pause();
                      }else{
                        setState(() {
                          _isPlay = true;
                        });
                        _vlcPlayerController.play();
                      }
                    },
                    child: _isPlay ?Icon(Icons.pause,size: 28,color: Colors.black,)  : Icon(Icons.play_arrow,size: 28,color: Colors.black,)
                )
              ],
            ),
          )
      ),
    );
  }
}
