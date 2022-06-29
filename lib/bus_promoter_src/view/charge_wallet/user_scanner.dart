import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:convert';
import '../../../bus_driver_src/helper/shared_preferences.dart';
import '../../../common_src/constants/app_colors.dart';
import '../../../common_src/constants/network_constants.dart';
import '../../../common_src/data/models/user_qrcode_data.dart';
import '../../../common_src/data/network_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../common_src/data/repository.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import '../../data/models/charge_user_wallet_credentials.dart';
import '../../data/models/charge_user_wallet_dto.dart';
import '../home_page/promoter_home_page.dart';

class UserScanner extends StatefulWidget {
  @override
  _UserScannerState createState() => _UserScannerState();
}

class _UserScannerState extends State<UserScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  late final Repository repository;
  late final AppData _appData;
  bool _isPaymentBottomSheetOpened = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();

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
      resizeToAvoidBottomInset: false,
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
      if(scanData.code != null && !_isPaymentBottomSheetOpened){
        try{
          final decodedJSON = json.decode(scanData.code!) as Map<String, dynamic>;
          final userData = UserQrCodeData.fromJson(decodedJSON);
          openBottomSheet(userData, controller);
        } catch(e) {
          Fluttertoast.showToast(msg: "Invalid QR Code!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: AppColors.rainBlueLight, textColor: Colors.white, fontSize: 16.0);
          controller.resumeCamera();
        }
      }else{
        controller.resumeCamera();
      }
    });
  }

  void openBottomSheet(UserQrCodeData userData, QRViewController controller) {
    _isPaymentBottomSheetOpened = true;
    Future<void> bottomSheetAwaitClose = showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        SimpleFontelicoProgressDialog _dialog = SimpleFontelicoProgressDialog(context: context, barrierDimisable:  false);
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          color: Colors.white,
          child: Center(
            child: Form(
                key: _formKey,
                child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 50),
                    child: ListView(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(padding:  EdgeInsets.all(10), child:  Icon(FontAwesomeIcons.moneyBillTransfer, color: AppColors.rainBlueLight,),),
                            Container(alignment: Alignment.center, padding: const EdgeInsets.all(10), child:  Text('Charge to ${userData.userName}', style: TextStyle(fontSize: 20, color: AppColors.rainBlueLight),)),
                          ],
                        ),
                        Container(padding: EdgeInsets.only(top: 12, right: 12, left: 12, bottom: MediaQuery.of(context).viewInsets.bottom), child:
                        TextFormField(
                          autofocus: true,
                          textInputAction: TextInputAction.send,
                          onFieldSubmitted: (val) => submitPayment(_dialog, userData),
                          style: TextStyle(color: AppColors.rainBlueLight),
                          controller: amountController, keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Amount',
                              prefixIcon: Icon(FontAwesomeIcons.moneyBill),
                              suffixIcon: IconButton(
                                onPressed: () => submitPayment(_dialog, userData),
                                icon: Icon(Icons.send),
                              ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Amount is required!';
                            }
                            return null;
                          },
                        ),),
                      ],
                    ))
            ),
          ),
        );
      },
    );

    bottomSheetAwaitClose.then((void value) {
      _isPaymentBottomSheetOpened = false;
      controller.resumeCamera();
    });
  }

  submitPayment(SimpleFontelicoProgressDialog dialog, UserQrCodeData userData) async{
      if (_formKey.currentState!.validate()) {
        dialog.show(message: 'Please wait...', textStyle: TextStyle(color: AppColors.rainBlueLight));
        await _appData.getSharedPreferencesInstance().then((pref) {
          String promoterId = _appData.getUserId(pref!)!;
          final chargeUserWalletCredentials = ChargeUserWalletCredentials(apiKey: NetworkConstants().api_key, apiSecret: NetworkConstants().api_secret, userID: userData.userId, promoterID: promoterId, invoiceValue: double.parse(amountController.text.toString().trim()));
          repository.chargeUserWallet(chargeUserWalletCredentials).then((response){
            if (response != null) {
              if(response is ChargeUserWalletDTO){
                if(response.isSuccess() != null){
                  if(response.isSuccess() == true){
                    Navigator.of(dialog.context!,rootNavigator: true).pop();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PromoterHomePage()),);
                    Fluttertoast.showToast(msg: "Transferred successfully!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: AppColors.rainBlueLight, textColor: Colors.white, fontSize: 16.0);
                  }else{
                    Navigator.of(dialog.context!,rootNavigator: true).pop();
                    Fluttertoast.showToast(msg: "${response.failedDescription.toString()}", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: AppColors.rainBlueLight, textColor: Colors.white, fontSize: 16.0);
                  }
                }
              }
            } else{
              Navigator.of(dialog.context!,rootNavigator: true).pop();
              Fluttertoast.showToast(msg: "Something wrong!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: AppColors.rainBlueLight, textColor: Colors.white, fontSize: 16.0);
            }
          });
        } );
      }
  }
}