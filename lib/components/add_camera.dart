import 'package:flutter/material.dart';
import 'package:fluttercontrolpanel/changeNotifier.dart';
import 'package:fluttercontrolpanel/screens/list_camera.dart';
import 'package:fluttercontrolpanel/components/side_menu.dart';
import 'package:fluttercontrolpanel/components/preview_camera.dart';
import 'package:provider/provider.dart';

class AddCamera extends StatelessWidget {

  const AddCamera({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    final width_screen = MediaQuery.of(context).size.width;
    final height_screen = MediaQuery.of(context).size.height;
    final ButtonStyle Addcam = ElevatedButton.styleFrom(
      onPrimary: Colors.black87,
      primary: Color.fromARGB(91, 196, 219, 1),
      minimumSize: Size(88, 46),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    );
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: BackButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => SideMenu(currentIndex: 1,currentIndex_listcamera: 0,),
                  opaque: false,
                  transitionDuration: Duration(seconds: 0),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 100,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Row(
              children:<Widget> [
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 50,
                  width: 100,
                  alignment: Alignment.center,
                  child: Text("Name cam :"),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(135, 207, 248, 1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Center(
                  child:Container(
                    height: 50,
                    width: width_screen*0.6,
                    alignment: Alignment.center,
                    child: TextField(
                      controller: _controller ,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter name cam',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 50,
                  width: 100,
                  alignment: Alignment.center,
                  child: Text("Link camera :"),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(135, 207, 248, 1),                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Center(
                  child:Container(
                    height: 50,
                    width: width_screen*0.6,
                    alignment: Alignment.center,
                    child: TextField(
                      controller: _controller ,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Link cam',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 50,
                  width: 100,
                  alignment: Alignment.center,
                  child: Text("Phường/thị xã:"),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(135, 207, 248, 1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Center(
                  child:Container(
                    height: 50,
                    width: width_screen*0.2,
                    alignment: Alignment.center,
                    child: TextField(
                      controller: _controller ,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter district',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 50,
                  width: 100,
                  alignment: Alignment.center,
                  child: Text("Quận/Huyện:"),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(135, 207, 248, 1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Center(
                  child:Container(
                    height: 50,
                    width: width_screen*0.2,
                    alignment: Alignment.center,
                    child: TextField(
                      controller: _controller ,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter district',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              ElevatedButton(
                onPressed: (){
                  Provider.of<Counter>(context, listen: false).increment();
                },
                  child: Text('Add camera')),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: (){
                  // Navigator.push(
                  //   context,
                  //   PageRouteBuilder(
                  //     pageBuilder: (_, __, ___) =>  MyHomePage(),
                  //     opaque: false,
                  //     transitionDuration: Duration(seconds: 0),
                  //   ),
                  // );

                },
                child: Text('Preview camera')),
          ],
        ),

      ],
    );
    // return
    // Container(
    //   color: Colors.red,
    //   child: BackButton(
    //     onPressed: () {
    //       Navigator.push(
    //         context,
    //         PageRouteBuilder(
    //           pageBuilder: (_, __, ___) => SideMenu(currentIndex: 1,currentIndex_listcamera: 0,),
    //           opaque: false,
    //           transitionDuration: Duration(seconds: 0),
    //         ),
    //       );
    //
    //     },
    //   ),
    // );
  }
}