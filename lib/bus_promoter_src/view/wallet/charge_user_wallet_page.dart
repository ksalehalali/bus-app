import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../common_src/constants/app_colors.dart';
import '../../../common_src/data/models/user_qrcode_data.dart';
import '../../../common_src/data/repository.dart';

class ChargeUserWalletPage extends StatefulWidget {
  ChargeUserWalletPage({Key? key, required this.userQrCodeData}) : super(key: key);
  final UserQrCodeData? userQrCodeData;

  @override
  _ChargeUserWalletPageState createState() => _ChargeUserWalletPageState();
}

class _ChargeUserWalletPageState extends State<ChargeUserWalletPage> {
  List<Color> currentGradientColors = AppColors.activeGradient;
  late final Repository _repository;
  final _formKey = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
   // getIncomingWalletList();
    super.initState();
  }
/*
  void getIncomingWalletList(){
    _repository = Repository(networkService: NetworkService());
    final userIncomingWalletCredentials = UserIncomingWalletCredentials(pageNumber: 1, pageSize: 500);
    _repository.getUserIncomingWalletList(userIncomingWalletCredentials).then((response) async{
      if (response != null) {
        if(response.status == true){
          try {
            UserIncomingWalletDTO userIncomingWalletDTO = response as UserIncomingWalletDTO;
            if(userIncomingWalletDTO.incomingWalletItems != null && userIncomingWalletDTO.incomingWalletItems!.isNotEmpty){
              userIncomingWalletDTO.incomingWalletItems!.toList().forEach((element) { incomingWalletItemWidgets.add(WalletItemWidget(true, element.paymentGateway.toString(), element.value.toString(), element.time)); });

              setState(() {
                _listView = ListView(children: incomingWalletItemWidgets ,);
              });
            }
          }catch(e){
            Fluttertoast.showToast(msg: "Something wrong!..", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
          }
        }else{
          Fluttertoast.showToast(msg: "Something wrong!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
        }
      }else{
        Fluttertoast.showToast(msg: "Something wrong!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
      }
    });
  }
*/
  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 30),
            child: ListView(
              children: <Widget>[
                Padding(padding:  EdgeInsets.all(10), child:  Icon(FontAwesomeIcons.moneyBillTransfer, color: Colors.blue,),),
                Container(alignment: Alignment.center, padding: const EdgeInsets.all(10), child:  Text('Charge to ${widget.userQrCodeData?.userName}', style: TextStyle(fontSize: 20),)),
                Container(padding: const EdgeInsets.all(10), child: TextFormField(
                  controller: amountController, keyboardType: TextInputType.number, decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Amount', prefixIcon: Icon(Icons.attach_money)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Amount is required!';
                    }
                    return null;
                  },
                ),),
                /*
                Container(
                    height: 120,
                    padding: const EdgeInsets.only(top: 60, bottom: 10, left: 10, right: 10),
                    child: ElevatedButton(
                      child: const Text('Login', style: TextStyle(fontSize: 20),),
                      onPressed: ()  {
                        if (_formKey.currentState!.validate()) {
                          _dialog.show(message: 'Please wait...');

                          final loginCredentials = LoginCredentials(userName: amountController.text, password: passwordController.text);
                          //Timer(Duration(seconds: 2), () {
                          repository.login(loginCredentials).then((response) {
                            if (response != null) {
                              if(response is LoginResponseDTO){
                                String? accountType = response.description?.role?.first;
                                print("loginResponseDTO... Status: ${response.status}, Description.token: ${response.description!.token}, AccountType: $accountType");
                                _appData.getSharedPreferencesInstance().then((pref) {
                                  _appData.setAccessToken(pref!, response.description!.token).then((value) {
                                    _appData.setAccountType(pref, accountType).then((value) {
                                      Navigator.of(_dialog.context!,rootNavigator: true).pop();
                                      switch(accountType){
                                        case 'Driver': Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BusScanner()),);
                                        break;
                                        default: Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PromoterHomePage()),);;
                                        break;
                                      }
                                    });
                                  });
                                });
                              }else if(response is LoginErrorResponseDTO){
                                Navigator.of(_dialog.context!,rootNavigator: true).pop();
                                Fluttertoast.showToast(msg: "Invalid username or password!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: AppColors.rainBlueLight, textColor: Colors.white, fontSize: 16.0);
                              }
                            }else{
                              Navigator.of(_dialog.context!,rootNavigator: true).pop();
                              Fluttertoast.showToast(msg: "Something wrong!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, backgroundColor: AppColors.rainBlueLight, textColor: Colors.white, fontSize: 16.0);
                            }
                          });
                          // });
                        }
                      },
                    )
                ),
                */
              ],
            ))
    );
  }
}