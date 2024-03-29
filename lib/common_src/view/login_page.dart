import 'package:bus_driver/common_src/data/models/login_credentials.dart';
import 'package:bus_driver/common_src/data/models/login_response_dto.dart';
import 'package:flutter/material.dart';
import '../../Inspector_Controllers/current_data.dart';
import '../../Inspector_View/main_screen.dart';
import '../../bus_promoter_src/view/home_page/promoter_home_page.dart';
import '../constants/app_colors.dart';
import '../data/models/login_error_response_dto.dart';
import '../data/network_service.dart';
import '../data/repository.dart';
import '../../bus_driver_src/helper/shared_preferences.dart';
import '../../bus_driver_src/view/qrcode_scanner/bus_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  //static const String _title = 'Sample App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     // title: _title,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      //  appBar: AppBar(title: const Text(_title)),
        body: SafeArea(
          child: const LoginPageStatefulWidget(),
        )
      ),
    );
  }
}

class LoginPageStatefulWidget extends StatefulWidget {
  const LoginPageStatefulWidget({Key? key}) : super(key: key);

  @override
  State<LoginPageStatefulWidget> createState() => _LoginPageStatefulWidgetState();
}

class _LoginPageStatefulWidgetState extends State<LoginPageStatefulWidget> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  late final Repository repository;
  late final AppData _appData;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final cpi = CircularProgressIndicator();
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  @override
  void initState() {
    repository = Repository(networkService: NetworkService());
    _appData = AppData();
    _passwordVisible = false;
    initFirebaseCloudMessaging();
  }

  void initFirebaseCloudMessaging() {
    //if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((fcmToken){
      _appData.getSharedPreferencesInstance().then((pref) {
        _appData.setFcmToken(pref!, fcmToken).then((value) {
          print("FCM Token: $fcmToken, Set FcmToken result: $value");
        });
      });
    });
/*
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
    */
  }

/*
  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true)
    );
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings)
    {
      print("Settings registered: $settings");
    });
  }
*/

  @override
  Widget build(BuildContext context) {
    SimpleFontelicoProgressDialog _dialog = SimpleFontelicoProgressDialog(context: context, barrierDimisable:  false);

    return Form(
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 30),
            child: ListView(
              children: <Widget>[
                Padding(padding:  EdgeInsets.all(10), child:  Image(image: AssetImage('assets/icon/icon.png'),height: 120,
                  fit:BoxFit.contain,)),
                Container(alignment: Alignment.center, padding: const EdgeInsets.all(10), child: const Text('Sign in', style: TextStyle(fontSize: 20),)),
                Container(padding: const EdgeInsets.all(10), child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: usernameController, keyboardType: TextInputType.text, decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Username', prefixIcon: Icon(Icons.account_box)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username is required!';
                    }
                    return null;
                  },
                ),),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(textInputAction: TextInputAction.done, keyboardType: TextInputType.visiblePassword, controller: passwordController, obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(_passwordVisible ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {setState(() {_passwordVisible = !_passwordVisible;});},
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required!';
                      }
                      return null;
                    },
                  ),
                ),
                /* TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text('Forgot Password', style: TextStyle(fontSize: 15, color: AppColors.rainBlueLight),),
            ),*/
                Container(
                    height: 120,
                    padding: const EdgeInsets.only(top: 60, bottom: 10, left: 10, right: 10),
                    child: ElevatedButton(
                      child: const Text('Login', style: TextStyle(fontSize: 20),),
                      onPressed: ()  {
                        if (_formKey.currentState!.validate()) {
                          _dialog.show(message: 'Please wait...', indicatorColor: AppColors.rainBlueLight, textStyle: TextStyle(color: AppColors.rainBlueLight));

                        final loginCredentials = LoginCredentials(userName: usernameController.text, password: passwordController.text);
                        //Timer(Duration(seconds: 2), () {
                        repository.login(loginCredentials).then((response) {
                          if (response != null) {
                            if(response is LoginResponseDTO){
                              String? accountType = response.description?.role?.first;
                              print("loginResponseDTO... Status: ${response.status}, Description.token: ${response.description!.token}, AccountType: $accountType");
                              print('token ,login == ::------- ${response.description!.token!}');
                              userName =  response.description!.userName!;
                              _appData.getSharedPreferencesInstance().then((pref) {
                                _appData.setAccessToken(pref!, response.description!.token).then((value) {
                                  _appData.setAccountType(pref, accountType).then((value) {
                                    Navigator.of(_dialog.context!,rootNavigator: true).pop();
                                    switch(accountType){
                                      case 'Driver': Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BusScanner()),);
                                      break;
                                      case 'Inspector': Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreenInspector(currentPage: 0,)),);
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
                /* Row(
              children: <Widget>[
                const Text('Does not have account?', style: TextStyle(fontSize: 20),),
                TextButton(
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20, color: AppColors.rainBlueLight),
                  ),
                  onPressed: () {
                    //signup screen
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ), */
              ],
            ))
    );
  }
}