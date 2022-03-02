import 'package:bus_driver/bus_driver_src/constants/app_colors.dart';
import 'package:bus_driver/bus_driver_src/features/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:convert';
import '../../entities/route/route_data.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Scanner extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bus QR Code scanner"),
        backgroundColor: AppColors.rainBlueLight,
      ),
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    QRView(key: qrKey, onQRViewCreated: _onQRViewCreated,),
                    Center(child: Container(width: 300, height: 300, decoration: BoxDecoration(border: Border.all(color: AppColors.rainBlueDark, width: 4,), borderRadius: BorderRadius.circular(12),),),)
                  ],
                ),
              ),
              Expanded(flex: 1, child: Center(child: Text('Move the camera towards the QR Code', style: TextStyle(color: AppColors.rainBlueDark, fontSize: 15),),),)
            ],
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      if(scanData.code != null){
        try{
          final decodedJSON = json.decode(scanData.code!) as Map<String, dynamic>;
          final routeData = RouteData.fromJson(decodedJSON);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(routeData: routeData,)),);
        } catch(e) {
          Fluttertoast.showToast(msg: "This QR Code invalid!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, backgroundColor: AppColors.rainBlueDark, textColor: Colors.white, fontSize: 16.0);
          controller.resumeCamera();
        }
      }else{
        controller.resumeCamera();
      }
    });
  }
}