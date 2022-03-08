import 'package:bus_driver/bus_driver_src/constants/app_colors.dart';
import 'package:flutter/material.dart';

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
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void initState() {
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
            Container(padding: const EdgeInsets.all(10), child: TextField(controller: nameController, keyboardType: TextInputType.number, decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Phone Number', prefixIcon: Icon(Icons.contact_phone)),),),
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
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text('Forgot Password', style: TextStyle(fontSize: 15, color: AppColors.rainBlueLight),),
            ),
            Container(

                height: 70,
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  child: const Text('Login', style: TextStyle(fontSize: 20),),
                  onPressed: () {
                    print(nameController.text);
                    print(passwordController.text);
                  },
                )
            ),
            Row(
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
            ),
          ],
        ));
  }
}