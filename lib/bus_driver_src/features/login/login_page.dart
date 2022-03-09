import 'dart:async';
import 'package:bus_driver/bus_driver_src/constants/app_colors.dart';
import 'package:bus_driver/bus_driver_src/data/models/login_credentials.dart';
import 'package:flutter/material.dart';
import '../../data/network_service.dart';
import '../../data/repository.dart';
import '../../helper/shared_preferences.dart';

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
  late final Repository repository;
  late final AppData _appData;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void initState() {
    repository = Repository(networkService: NetworkService());
    _appData = AppData();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Padding(padding:  EdgeInsets.all(10), child:  Image(image: AssetImage('assets/icon/icon.png'),height: 120,
              fit:BoxFit.contain,)),
            Container(alignment: Alignment.center, padding: const EdgeInsets.all(10), child: const Text('Sign in', style: TextStyle(fontSize: 20),)),
            Container(padding: const EdgeInsets.all(10), child: TextField(controller: usernameController, keyboardType: TextInputType.text, decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Username', prefixIcon: Icon(Icons.account_box)),),),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(keyboardType: TextInputType.visiblePassword, controller: passwordController, obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(_passwordVisible ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {setState(() {_passwordVisible = !_passwordVisible;});},
                  ),
                ),
              ),
            ),
           /* TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text('Forgot Password', style: TextStyle(fontSize: 15, color: AppColors.rainBlueLight),),
            ),*/
            Container(
                height: 100,
                padding: const EdgeInsets.only(top: 40, bottom: 10, left: 10, right: 10),
                child: ElevatedButton(
                  child: const Text('Login', style: TextStyle(fontSize: 20),),
                  onPressed: () {
                    final loginCredentials = LoginCredentials(userName: usernameController.text, password: passwordController.text);
                    //Timer(Duration(seconds: 2), () {
                      repository.login(loginCredentials).then((loginResponseDTO) {
                        if (loginResponseDTO != null) {
                          print("loginResponseDTO... Status: ${loginResponseDTO.status}, Description.token: ${loginResponseDTO.description!.token}");
                          _appData.getSharedPreferencesInstance().then((pref) {
                            _appData.setAccessToken(pref!, loginResponseDTO.description!.token).then((value) {
                              print("loginResponseDTO... Set AccessToken result: $value");
                              print("loginResponseDTO... Get AccessToken: ${_appData.getAccessToken(pref)}");
                            });
                          });
                        }
                      });
                   // });
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
        ));
  }
}