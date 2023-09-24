import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class ViolationDetail extends StatefulWidget {
  ViolationDetail({Key? key, required this.violationData}) : super(key: key);

  final Map<String, dynamic> violationData;

  @override
  State<ViolationDetail> createState() => _ViolationDetailState();
}

class _ViolationDetailState extends State<ViolationDetail> {

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    bool _isViolationImageUrlValid = Uri.parse(widget.violationData["image_violation_link"]).isAbsolute;
    bool _isLicensePlateImageUrlValid = Uri.parse(widget.violationData["image_licenseplate_violation_link"]).isAbsolute;
    print("violationData, ${widget.violationData}");
    print("_isLicensePlateImageUrlValid: ${_isLicensePlateImageUrlValid}");
    return Scaffold(
      appBar: AppBar(
        title: Text('Xem chi tiết vi phạm'),
        leading: BackButton(),
      ),
      body: ListView(
            children: [
              SizedBox(height: 15),
              Center(
                child: Text("Ảnh phương tiện vi phạm", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
              ),
              SizedBox(height: 10),
              Container(
                  margin: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: _isViolationImageUrlValid ?
                  Image.network(widget.violationData["image_violation_link"]) :
                  Text("Đang tải ảnh vi phạm, vui lòng đợi"),
              ),
              SizedBox(height: 5),
              Center(
                  child: Text("Ảnh biển số xe vi phạm", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: _isLicensePlateImageUrlValid ?
                Image.network(widget.violationData["image_licenseplate_violation_link"]) :
                Text("Đang tải ảnh biển số xe, vui lòng đợi"),
              ),
              SizedBox(height: 15),
              Center(
                  child: Text("Thông tin khác", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child:
                    Row(
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Lỗi vi phạm:",
                                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.blue.shade900)),
                              SizedBox(height: 5),
                              Text("Loại phương tiện:",
                                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.blue.shade900)),
                              SizedBox(height: 5),
                              Text("Biển số xe:",
                                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.blue.shade900)),
                              SizedBox(height: 5),
                              Text("Vị trí camera:",
                                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.blue.shade900)),
                              SizedBox(height: 5),
                              Text("Loại phương tiện:",
                                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.blue.shade900)),
                              SizedBox(height: 5),
                              Text("Thời gian:",
                                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.blue.shade900)),
                            ]
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${widget.violationData["violation"]}", overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                                SizedBox(height: 5),
                                Text("${widget.violationData["type_traffic"]}", overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                                SizedBox(height: 5),
                                Text("${widget.violationData["licenseplate"]}", overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                                SizedBox(height: 5),
                                Text("${widget.violationData["local_camera"]}", overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                                SizedBox(height: 5),
                                Text("${widget.violationData["type_traffic"]}", overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                                SizedBox(height: 5),
                                Text("${DateFormat('HH:mm dd/MM/yyyy').format(widget.violationData['time'].toDate())}", overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                              ]
                          ),
                        )
                      ]
                    )

              ),
            ]
        )

    );
  }
}