import 'package:bus_driver/bus_driver_src/view/home_page/driver_home_page.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:convert';
import '../../../bus_driver_src/helper/shared_preferences.dart';
import '../../../common_src/constants/app_colors.dart';
import '../../../common_src/data/models/user_qrcode_data.dart';
import '../../../common_src/data/network_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../common_src/data/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../wallet/charge_user_wallet_page.dart';

class UserScanner extends StatefulWidget {
  @override
  _UserScannerState createState() => _UserScannerState();
}

class _UserScannerState extends State<UserScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  late final Repository repository;
  late final AppData _appData;

  @override
  void initState() {
    repository = Repository(networkService: NetworkService());
    _appData = AppData();
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User QR Code scanner"),
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
          final userData = UserQrCodeData.fromJson(decodedJSON);
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChargeUserWalletPage(userQrCodeData: userData)),);
        } catch(e) {
          Fluttertoast.showToast(msg: "Invalid QR Code!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: AppColors.rainBlueLight, textColor: Colors.white, fontSize: 16.0);
          controller.resumeCamera();
        }
      }else{
        controller.resumeCamera();
      }
    });
  }
}