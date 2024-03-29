import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Inspector_View/main_screen.dart';
import '../Inspector_View/widgets/dialogs.dart';
import '../common_src/constants/app_colors.dart';
import 'current_data.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class InspectorController extends GetxController{
  var openCam =false.obs;
  var busScanned =false.obs;
  var busScannedData = {}.obs;
  var inspectorBusesChecked =[].obs;
  var inspectorTicketsChecked =[].obs;
  var ticketChecked ={}.obs;
  var paymentsForBus = [].obs;
  var gotBusesChecked =false.obs;
  var gotTicketsChecked =false.obs;
  var ticketIdScanned =''.obs;


  Future getBusData(String busId,BuildContext context)async{

    var headers = {
      'Authorization': '$myToken',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://route.click68.com/api/GetBus'));
    request.body = json.encode({
      "id":busId
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('----------------bus---------------');
      var json = jsonDecode(await response.stream.bytesToString());
      var data = json['description'];
      busScannedData.value =data;
      print("bus data :: ${data}");
      openCam.value =false;
      //getInspectorBusesChecked(context);
      busScanned.value =true;
      await checkBus(busId);
      Get.offAll(()=>  const MainScreenInspector( currentPage: 2,));
      update();
    }else{
      busScanned.value =false;
      Get.snackbar(
          'Error', 'Error while getting bus dataB',
          duration: 3.seconds, colorText: Colors.red[900]);
      Get.to(()=> const MainScreenInspector(currentPage: 0,));

    }


  }
  Future checkTickets(String paymentId,String userId,)async{
    ticketIdScanned.value = paymentId;
    var headers = {
      'Authorization': '$myToken',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://route.click68.com/api/CheckPaymentByInspector'));
    request.body = json.encode({
      "PaymentId": paymentId,
      "UserId":userId,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = jsonDecode(await response.stream.bytesToString());
      ticketChecked.value =json;
      var data = json['description'];
      print('scanned ticket data ..------ $data');
      ticketChecked.value =data;

      if(json['status'] ==true){
        openCam.value =false;
        Get.dialog(CustomDialogTickets( failed: false,message: 'done',));
      }else{
        Get.dialog(CustomDialogTickets( failed: true,message: data,));

      }

    }
    else {
      print(response.statusCode);
      print(response.reasonPhrase);

    }
update();
  }

  Future sendCreditRequest()async{

    var headers = {
      'Authorization': myToken,
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://route.click68.com/api/ChargeWalletByInspector'));
    request.body = json.encode({
      "api_key": "\$FhlF]3;.OIic&{>H;_DeW}|:wQ,A8",
      "api_secret": "Z~P7-_/i!=}?BIwAd*S67LBzUo4O^G",
      "UserID": paySaved.uid,
      "invoiceId": "",
      "invoiceValue": paySaved.value
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {

      print(await response.stream.bytesToString());

      openCam.value =false;
      Get.offUntil(MaterialPageRoute(builder: (context)=>const MainScreenInspector(currentPage: 0,)), (route) => false);

      Get.dialog(CustomDialog( sendFailed: false));

    }
    else {
      print(response.statusCode);

      print(response.reasonPhrase);
    }


  }

  //get inspector buses checked
Future getInspectorBusesChecked(BuildContext context)async{
  SimpleFontelicoProgressDialog _dialog = SimpleFontelicoProgressDialog(context: context, barrierDimisable:  false);
  _dialog.show(message: 'Please wait...', indicatorColor: AppColors.rainBlueLight, textStyle: TextStyle(color: AppColors.rainBlueLight));

  gotBusesChecked.value =false ;
    print('token is ==-getInspectorBusesChecked-== $myToken');
  var headers = {
    'Authorization': myToken,
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('https://route.click68.com/api/ListInspictionBusByInspector'));
  request.body = json.encode({
    "PageSize": "1113",
    "PageNumber": "1"
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var json = jsonDecode(await response.stream.bytesToString());
    var data = json['description'];
    print('buses checked :: ${json}');
    inspectorBusesChecked.value = data;
    gotBusesChecked.value =true ;
update();
    Navigator.of(_dialog.context!,rootNavigator: true).pop();
   // Get.offAll(MainScreenInspector(currentPage: 0));

  }
  else {
    print(response.reasonPhrase);
  }

}

  //check  bus
  Future checkBus(String busId)async{
    var headers = {
      'Authorization': '$myToken',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://route.click68.com/api/InspectionBus'));
    request.body = json.encode({
      "id":busId
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = jsonDecode(await response.stream.bytesToString());
      var data = json['description'];
      print('bus checked  :: ${json}');
      paymentsForBus.value = data;
update();
    }
    else {
      print(response.reasonPhrase);
    }

  }

  Future getTicketsChecked(BuildContext context)async{
    gotTicketsChecked.value =false;
    SimpleFontelicoProgressDialog _dialog = SimpleFontelicoProgressDialog(context: context, barrierDimisable:  false);
    _dialog.show(message: 'Please wait...', indicatorColor: AppColors.rainBlueLight, textStyle: TextStyle(color: AppColors.rainBlueLight));

    var headers = {
      'Authorization': myToken,
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://route.click68.com/api/ListInspictionUserByInspector'));
    request.body = json.encode({
      "PageNumber": 1,
      "PageSize": 1110
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = jsonDecode(await response.stream.bytesToString());
      var data = json['description'];
      print('tickets checked  :: ${json}');
      inspectorTicketsChecked.value = data;
      gotTicketsChecked.value =true;
      update();
      Navigator.of(_dialog.context!,rootNavigator: true).pop();

    }
    else {
      print('get tickets checked error :: ${json}');

      print(response.reasonPhrase);
    }


  }


}