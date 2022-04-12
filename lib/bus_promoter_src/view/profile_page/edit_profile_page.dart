import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import '../../../common_src/data/network_service.dart';
import '../../../common_src/data/repository.dart';
import '../../../common_src/widget/appbar_widget.dart';
import '../../../common_src/widget/profile_widget.dart';
import '../../../common_src/widget/textfield_widget.dart';
import '../../data/models/user_profile_dto.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key? key, required this.profileInformation}) : super(key: key);
  ProfileInformation? profileInformation;
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
 // late final Repository _repository;
  //ProfileInformation? _profileInformation;

  @override
  void initState() {
   // _repository = Repository(networkService: NetworkService());
    //getProfileInformation();
    super.initState();
  }
/*
  void getProfileInformation(){
    _repository.getUserProfile().then((response) async{
      if (response != null) {
        if(response.status == true){
          try {
            UserProfileDTO profileDTO = response as UserProfileDTO;
            if(profileDTO.profileInformation != null){
              setState(() {_profileInformation = profileDTO.profileInformation;});
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
  Widget build(BuildContext context) {
    /*
      ThemeSwitchingArea(
    child: Builder(
      builder: (context) =>
          */ return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: 'https://media.istockphoto.com/photos/portrait-of-smiling-handsome-man-in-blue-tshirt-standing-with-crossed-picture-id1045886560?k=20&m=1045886560&s=612x612&w=0&h=JL8Dy_sRUXJo6PofsX7XkQpWjSTDhD8LuV071LMlb3Y=',
            isEdit: true,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(label: 'Full Name', text: widget.profileInformation?.name, onChanged: (name) {},),
          const SizedBox(height: 24),
          TextFieldWidget(label: 'Email', text: widget.profileInformation?.email, onChanged: (email) {},),
          const SizedBox(height: 30),
         // TextFieldWidget(label: 'About', text: widget.profileInformation?.userName, maxLines: 5, onChanged: (about) {},),
          Container(
              height: 120,
              padding: const EdgeInsets.only(top: 60, bottom: 10, left: 10, right: 10),
              child: ElevatedButton(
                child: const Text('Login', style: TextStyle(fontSize: 20),),
                onPressed: ()  {
                  /*
                  if (_formKey.currentState!.validate()) {
                    _dialog.show(message: 'Please wait...');

                    final loginCredentials = LoginCredentials(userName: usernameController.text, password: passwordController.text);
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
                  */
                },
              )
          ),
        ],
      ),
      //),
      //),
    );
  }
}