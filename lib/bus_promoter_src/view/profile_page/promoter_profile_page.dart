import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../../bus_driver_src/helper/shared_preferences.dart';
import '../../../common_src/constants/app_colors.dart';
import '../../../common_src/constants/screen_size.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../common_src/data/network_service.dart';
import '../../../common_src/data/repository.dart';
import '../../../common_src/widget/image_loader.dart';
import '../../data/models/installation_list_by_promoter_credentials.dart';
import '../../data/models/installation_list_by_promoter_dto.dart';
import '../../data/models/user_profile_dto.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../home_page/promoter_home_page.dart';
import 'edit_profile_page.dart';

class PromoterProfilePage extends StatefulWidget {
  PromoterProfilePage({Key? key}) : super(key: key);

  @override
  _PromoterProfilePage createState() => _PromoterProfilePage();
}

class _PromoterProfilePage extends State<PromoterProfilePage> {
  List<Color> currentGradientColors = AppColors.activeGradient;
  late final Repository _repository;
  late final AppData _appData;
  ProfileInformation? _profileInformation;
  int appInstallationCountByPromoter= 0;
/*
  Future<bool> _onWillPop() async {
    return (await _backButton()) ?? false;
  }
  */

  @override
  void initState() {
    _repository = Repository(networkService: NetworkService());
    _appData = AppData();
    getProfileInformation();
    getInstallationListByPromoter();
    super.initState();
  }

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

  getInstallationListByPromoter() async {
    await _appData.getSharedPreferencesInstance().then((pref) {
      String promoterId = _appData.getUserId(pref!)!;
      final installationListByPromoterCredentials = InstallationListByPromoterCredentials(id: promoterId);
      _repository.getInstallationListByPromoter(installationListByPromoterCredentials).then((response){
        if (response != null) {
          if(response is InstallationListByPromoterDTO){if(response.isSuccess() != null && response.isSuccess() == true){setState(() {appInstallationCountByPromoter = response.total!;});}}
        } else{
          Fluttertoast.showToast(msg: "Something wrong!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: AppColors.rainBlueLight, textColor: Colors.white, fontSize: 16.0);
        }
      });
    } );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    var screenSize = ScreenSize();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: currentGradientColors,),),),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 35),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(icon: Icon(AntDesign.arrowleft, color: Colors.white,), onPressed: () =>  _backButton()),
                    ],
                  ),
                 // SizedBox(height: 10,),
                //  Text('My Profile', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 34, fontFamily: 'Nisebuschgardens',),),
                  SizedBox(height: 7,),
                  Container(
                    height: height * 0.26,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double innerHeight = constraints.maxHeight;
                        double innerWidth = constraints.maxWidth;
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              bottom: 0, left: 0, right: 0,
                              child: Container(
                                height: innerHeight * 0.8,
                                width: innerWidth,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.white,),
                                child: Column(
                                  children: [
                                    SizedBox(height: 85,),
                                    Text('${_profileInformation?.name?? ''}', style: TextStyle(color: Color.fromRGBO(39, 105, 171, 1), fontFamily: 'Nunito', fontSize: 24,),),
                                  //  SizedBox(height: 1,),
                                    //Text('${_profileInformation?.email?? ''}', style: TextStyle(color: Color.fromRGBO(39, 105, 171, 1), fontFamily: 'Nunito', fontSize: 14,),),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(top: 90, right: 15, child: IconButton(icon: Icon(AntDesign.setting, color: Color.fromRGBO(39, 105, 171, 1), size: 30,), onPressed: () {
                              if(_profileInformation != null){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage(profileInformation: _profileInformation!,)),);
                              }
                            },)),
                            Positioned(top: 0, left: 0, right: 0, child: Center(child:  getAvatarImageWidget(_profileInformation?.image, Colors.grey, 55.0),),),
                          //  Positioned(top: 69, right: 117, child: IconButton(icon: Icon(AntDesign.setting, color: Colors.grey[700], size: 25,), onPressed: () =>  print("edit avatar clicked"),)),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 22,),
                  Container(
                    height: height * 0.2,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Installation',
                            style: TextStyle(
                              color: Color.fromRGBO(39, 105, 171, 1),
                              fontSize: 27,
                              fontFamily: 'Nunito',
                            ),
                          ),
                          Divider(
                            thickness: 2.5,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('$appInstallationCountByPromoter', style: TextStyle(color: Color.fromRGBO(39, 105, 171, 1), fontFamily: 'Nunito', fontSize: 25,),),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 22,),
                  Container(
                    height: height * 0.42,
                    width: width,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.white,),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          SizedBox(height: 20,),
                          Text('👇 Download 👇', style: TextStyle(color: Color.fromRGBO(39, 105, 171, 1), fontSize: 24, fontFamily: 'Nunito',),),
                          Divider(thickness: 2.5,),
                          SizedBox(height: 10,),
                          QrImage(data: '${_profileInformation?.email?? 'http://routesme.com/'}', version: QrVersions.auto, size: 200.0, foregroundColor: Color.fromRGBO(39, 105, 171, 1),),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  /*
                  Container(
                    height: height * 0.5,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'My Orders',
                            style: TextStyle(
                              color: Color.fromRGBO(39, 105, 171, 1),
                              fontSize: 27,
                              fontFamily: 'Nunito',
                            ),
                          ),
                          Divider(
                            thickness: 2.5,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: height * 0.15,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: height * 0.15,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  */
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose(){
    super.dispose();
  }

  _backButton() {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => PromoterHomePage()),(route) => route.settings.name == "PromoterProfilePage");
  }
}