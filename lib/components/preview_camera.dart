// // // import 'package:flutter_mjpeg/flutter_mjpeg.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
// // // import 'dart:convert';
// // // // import 'package:flutter_hooks/flutter_hooks.dart';
// // // import 'package:cached_network_image/cached_network_image.dart';
// // //
// // // import 'package:flutter_svg/flutter_svg.dart';
// // // class PreviewCamera extends StatelessWidget {
// // //   // final String camUrl;
// // //   // final String username;
// // //   // final String password;
// // //
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //
// // //     // return CachedNetworkImage(
// // //     //   imageUrl: "http://admin:Admin%40123@14.241.46.213:1880/video,jpg",
// // //     //   placeholder: (context, url) => CircularProgressIndicator(),
// // //     //   errorWidget: (context, url, error) => Icon(Icons.error),
// // //     // );
// // //     //   Expanded(
// // //     //   child: Center(
// // //     //     child: Mjpeg(
// // //     //       isLive: isRunning.value,
// // //     //       error: (context, error, stack) {
// // //     //         print(error);
// // //     //         print(stack);
// // //     //         return Text(error.toString(), style: TextStyle(color: Colors.red));
// // //     //       },
// // //     //       stream:
// // //     //       'http://uk.jokkmokk.jp/photo/nr4/latest.jpg', //'http://192.168.1.37:8081',
// // //     //     ),
// // //     //   ),
// // //     // );
// // //     // ;
// // //     return Container(
// // //       child: Image.network(
// // //         'http://admin:Admin%40123@14.241.46.213:1880/stw-cgi/video.cgi?msubmenu=snapshot&action=view',
// // //       )
// // //     );
// // //     // return SvgPicture.network('http://14.241.46.213:1880/stw-cgi/video.cgi?msubmenu=snapshot&action=view');
// // //   }
// // // }
// // // // // // // // // // // import 'dart:typed_data';
// // // // // // // // // // import 'package:flutter/material.dart';
// // // // // // // // // // import 'package:http/http.dart' as http;
// // // // // // // // // //
// // // // // // // // // // class ImageFromUrl extends StatefulWidget {
// // // // // // // // // //   @override
// // // // // // // // // //   _ImageFromUrlState createState() => _ImageFromUrlState();
// // // // // // // // // // }
// // // // // // // // // //
// // // // // // // // // // class _ImageFromUrlState extends State<ImageFromUrl> {
// // // // // // // // // //   Uint8List _imageBytes = Uint8List(0) ;
// // // // // // // // // //   Future<void> getImageFromUrl() async {
// // // // // // // // // //     // Send an HTTP GET request to the server
// // // // // // // // // //     final response = await http.get(
// // // // // // // // // //       Uri.parse('http://admin:Admin%40123@14.241.46.213:1880/stw-cgi/video.cgi?msubmenu=snapshot&action=view'),
// // // // // // // // // //     );
// // // // // // // // // //
// // // // // // // // // //     if (response.statusCode == 200) {
// // // // // // // // // //       // If the server returns a successful response, decode the image bytes
// // // // // // // // // //       setState(() {
// // // // // // // // // //         _imageBytes = response.bodyBytes;
// // // // // // // // // //       });
// // // // // // // // // //     } else {
// // // // // // // // // //       // If the server returns an error response, print the error message
// // // // // // // // // //       print('Failed to load image: ${response.statusCode}');
// // // // // // // // // //     }
// // // // // // // // // //   }
// // // // // // // // // //
// // // // // // // // // //   @override
// // // // // // // // // //   void initState() {
// // // // // // // // // //     super.initState();
// // // // // // // // // //     getImageFromUrl();
// // // // // // // // // //   }
// // // // // // // // // //
// // // // // // // // // //   @override
// // // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // // //     return Scaffold(
// // // // // // // // // //       appBar: AppBar(
// // // // // // // // // //         title: Text('Image from URL'),
// // // // // // // // // //       ),
// // // // // // // // // //       body: Center(
// // // // // // // // // //         child: _imageBytes != null
// // // // // // // // // //             ? Image.memory(_imageBytes)
// // // // // // // // // //             : CircularProgressIndicator(),
// // // // // // // // // //       ),
// // // // // // // // // //     );
// // // // // // // // // //   }
// // // // // // // // // // }
// // // import 'dart:convert';
// // // import 'dart:io';
// // // import 'package:flutter/material.dart';
// // // import 'package:http/http.dart' as http;
// // // import 'dart:typed_data';
// // // class WisenetCamera extends StatefulWidget {
// // //   final String snapshotUrl;
// // //   const WisenetCamera({required this.snapshotUrl, Key? key}) : super(key: key);
// // //
// // //   @override
// // //   _WisenetCameraState createState() => _WisenetCameraState();
// // // }
// // //
// // // class _WisenetCameraState extends State<WisenetCamera> {
// // //   late List<int> _imageBytes;
// // //
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _getImage();
// // //   }
// // //
// // //   Future<void> _getImage() async {
// // //     try {
// // //       final response = await http.get(Uri.parse(widget.snapshotUrl),
// // //           headers: {
// // //             HttpHeaders.authorizationHeader:
// // //             'Basic ${base64Encode(utf8.encode('Username:Password'))}'
// // //           });
// // //       if (response.statusCode == HttpStatus.ok) {
// // //         setState(() {
// // //           _imageBytes = response.bodyBytes;
// // //         });
// // //       } else {
// // //         throw Exception('Failed to load image');
// // //       }
// // //     } catch (e) {
// // //       throw Exception('Failed to load image: $e');
// // //     }
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     if (_imageBytes.isNotEmpty) {
// // //       return Image.memory(Uint8List.fromList(_imageBytes));
// // //     } else {
// // //       return const CircularProgressIndicator();
// // //     }
// // //   }
// // // }
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';
import 'package:http/http.dart';

class MyHomePage extends HookWidget {
   Pot() async {
    var resquest = await post(Uri.parse('http://14.241.46.213:1880/')
   ,  headers: {

        'Username' : "admin",
        'Password' : "Admin%40123",
      },
      // body: {
      //   'Username' : "admin",
      //   'Password' : "Admin%40123",
      // },
    );
    print("${resquest.body}\n${resquest.statusCode}");
    var _get = await get(Uri.parse('http://14.241.46.213:1880/stw-cgi/video.cgi?msubmenu=snapshot&action=view')
      ,  headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
    );
    print("get: ${_get.body}");

  }
  @override
  Widget build(BuildContext context) {
     Pot();
    final isRunning = useState(true);
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo Home Page'),
      ),
      body: Column(
        children: <Widget>[
          Image.network('http://admin:Admin%40123@14.241.46.213:1880/stw-cgi/video.cgi?msubmenu=snapshot&action=view'),
          // Expanded(
          //   child: Center(
          //     child: Mjpeg(
          //       isLive: isRunning.value,
          //       error: (context, error, stack) {
          //         print(error);
          //         print(stack);
          //         return Text(error.toString(), style: TextStyle(color: Colors.red));
          //       },
          //       stream:
          //       'http://14.241.46.213:1880/stw-cgi/video.cgi?msubmenu=snapshot&action=view', //'http://192.168.1.37:8081',
          //     ),
          //   ),
          // ),
          Row(
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  isRunning.value = !isRunning.value;
                },
                child: Text('Toggle'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Scaffold(
                        appBar: AppBar(),
                      )));
                },
                child: Text('Push new route'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
// // // import 'dart:convert';
// // // import 'dart:io';
// // // import 'package:flutter/material.dart';
// // // import 'package:http/http.dart' as http;
// // // import 'dart:typed_data';
// // // class WisenetCamera extends StatefulWidget {
// // //   final String snapshotUrl;
// // //   const WisenetCamera({required this.snapshotUrl, Key? key}) : super(key: key);
// // //
// // //   @override
// // //   _WisenetCameraState createState() => _WisenetCameraState();
// // // }
// // //
// // // class _WisenetCameraState extends State<WisenetCamera> {
// // //   late List<int> _imageBytes;
// // //
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _getImage();
// // //   }
// // //
// // //   Future<void> _getImage() async {
// // //     try {
// // //       final response = await http.get(Uri.parse(widget.snapshotUrl),
// // //           headers: {
// // //             HttpHeaders.authorizationHeader:
// // //             'Basic ${base64Encode(utf8.encode('Username:Password'))}'
// // //           });
// // //       if (response.statusCode == HttpStatus.ok) {
// // //         setState(() {
// // //           _imageBytes = response.bodyBytes;
// // //         });
// // //       } else {
// // //         throw Exception('Failed to load image');
// // //       }
// // //     } catch (e) {
// // //       throw Exception('Failed to load image: $e');
// // //     }
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     if (_imageBytes.isNotEmpty) {
// // //       return Image.memory(Uint8List.fromList(_imageBytes));
// // //     } else {
// // //       return const CircularProgressIndicator();
// // //     }
// // //   }
// // // }
// // //
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
//
// class CameraListPage extends StatefulWidget {
//   const CameraListPage({Key? key}) : super(key: key);
//
//   @override
//   _CameraListPageState createState() => _CameraListPageState();
// }
//
// class _CameraListPageState extends State<CameraListPage> {
//   List<CameraDescription> _cameras = [];
//   int _cameraCount = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _initCameras();
//   }
//
//   Future<void> _initCameras() async {
//     _cameras = await availableCameras();
//     _cameraCount = _cameras.length;
//     setState(() {});
//   }
//
//   void _addCamera() {
//     setState(() {
//       // _cameras.add(_cameras[_cameraCount % _cameras.length]);
//       _cameraCount++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Camera List'),
//       ),
//       body: ListView.builder(
//         itemCount: _cameraCount,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text('Camera'),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _addCamera,
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
//
