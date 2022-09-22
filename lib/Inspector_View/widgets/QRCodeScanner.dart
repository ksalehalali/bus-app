
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../Inspector_Controllers/current_data.dart';
import '../../Inspector_Controllers/inspector_controller.dart';
import '../confirm_sendCredit_screen.dart';


class QRScanner extends StatefulWidget {
  final String scanType;
  BuildContext? context;

  QRScanner({Key? key, this.context,required this.scanType}) : super(key: key);

  @override
  _QRScannerState createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final InspectorController inspectorController = Get.find();

  Barcode? result;
  QRViewController? controller;
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            controller!.pauseCamera();
    inspectorController.openCam.value =false;

          },
          child: Icon(Icons.arrow_back),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white.withOpacity(0.0),
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text(
                  'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  : Text('Scan a code'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) async{


    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#5fa693', "Cancel", true, ScanMode.QR);
      print('data scanned =---- $qrCode');
      final jsonData = jsonDecode(qrCode);

      if (jsonData != null) {
        if(widget.scanType =='Bus'){
          var busId = jsonData['busId'];
          var b = jsonData['busId'];
          inspectorController.getBusData(busId,context);
        }else if(widget.scanType =='Ticket'){
          var userId = jsonData['userId'];
          var paymentId = jsonData['paymentId'];
          inspectorController.checkTickets(paymentId, userId);

        }else if(widget.scanType =='Send'){
          var userId = jsonData['userId'];
          var userName = jsonData['userName'];
          print('send money to userId : $userName');
          paySaved.userName =userName;
          paySaved.uid = userId;

          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const ConfirmSend()));
        }
        }


    } on PlatformException {
      Get.snackbar('Scan Failed', "Scan Failed try again");
    }
    }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
