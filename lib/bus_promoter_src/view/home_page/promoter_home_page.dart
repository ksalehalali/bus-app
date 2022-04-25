import 'dart:ffi';
import 'package:bus_driver/bus_promoter_src/view/profile_page/promoter_profile_page.dart';
import 'package:bus_driver/common_src/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../../bus_driver_src/helper/shared_preferences.dart';
import '../../../common_src/constants/app_colors.dart';
import '../../../common_src/constants/screen_size.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../common_src/data/models/wallet_dto.dart';
import '../../../common_src/data/network_service.dart';
import '../../../common_src/data/repository.dart';
import '../../../common_src/widget/image_loader.dart';
import '../../data/models/user_profile_dto.dart';
import '../charge_wallet/balance_calculator.dart';
import '../charge_wallet/user_scanner.dart';
import '../wallet/incoming_wallet.dart';
import '../wallet/outgoing_wallet.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PromoterHomePage extends StatefulWidget {
  PromoterHomePage({Key? key}) : super(key: key);

  @override
  _PromoterHomePage createState() => _PromoterHomePage();
}

class _PromoterHomePage extends State<PromoterHomePage> {
  List<Color> currentGradientColors = AppColors.activeGradient;
  late final AppData _appData;
  late final Repository _repository;
  ProfileInformation? _profileInformation;
  Wallet? _wallet;

  @override
  void initState() {
    _appData = AppData();
    _repository = Repository(networkService: NetworkService());
    getProfileInformation();
    getUserWallet();
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

  void getUserWallet(){
    _repository.getUserWallet().then((response) async{
      if (response != null) {
        if(response.status == true){
          try {
            WalletDTO walletDTO = response as WalletDTO;
            if(walletDTO.wallet != null){
              _appData.getSharedPreferencesInstance().then((pref) {
                _appData.setUserId(pref!, walletDTO.wallet!.userId).then((value) {
                  if(value == true){
                    setState(() {_wallet = walletDTO.wallet;});
                  }
                });
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
  
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    var screenSize = ScreenSize();

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(gradient: LinearGradient(colors: currentGradientColors, begin: Alignment.centerLeft, end: Alignment.centerRight,),),
                  height: MediaQuery.of(context).size.height * .40,
                  padding: EdgeInsets.only(top: 55, left: 15, right: 15),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(padding: const EdgeInsets.all(8.0), child:  GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PromoterProfilePage()),), child: getAvatarImageWidget(_profileInformation?.image, Colors.white, 22.0),),),
                          Text(_profileInformation?.name != null ? 'Welcome ${_profileInformation?.name?.split(' ').first}!' : 'Routes', style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w500)),
                          IconButton(icon:  Icon(AntDesign.logout, color: Colors.white,), onPressed: () => _showLogoutConfirmationDialog(context))
                        ],
                      ),
                      SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(icon:  Icon(FontAwesomeIcons.moneyBillTransfer, color: Colors.white,), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserScanner()),)),
                      Text(_wallet?.total != null ? 'KWD ${_wallet?.total}' : '', style: TextStyle(color: Colors.white, fontSize: 27.0, fontWeight: FontWeight.bold),),
                      IconButton(icon:  Icon(FontAwesomeIcons.moneyBillTrendUp, color: Colors.white,), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BalanceCalculator(chargeAmount: true,)),))
                    ]
                  )
                    //  SizedBox(height: 20),
                    //  Text(r"+ $3,157.67 (23%)", style: TextStyle(color: Colors.white70, fontSize: 18.0, fontWeight: FontWeight.w300),)
                    ],
                  ),
                ),
                Container(height: MediaQuery.of(context).size.height * .6, color: Colors.grey,)
              ],
            ),
            Container(
              alignment: Alignment.topCenter,
              padding: new EdgeInsets.only(top: MediaQuery.of(context).size.height * .30, right: 10.0, left: 10.0),
              child: new Container(
                height: MediaQuery.of(context).size.height * .69,
                width: MediaQuery.of(context).size.width,
                child:

                DefaultTabController(
                  length: 2,
                  child: new Scaffold(
                    appBar: new PreferredSize(
                      preferredSize: Size.fromHeight(kMinInteractiveDimension),
                      child: new Container(
                        color: AppColors.rainBlueLight,
                        child: new SafeArea(
                          child: Column(
                            children: <Widget>[
                              new TabBar(
                                indicatorColor: Colors.white,
                                labelColor: Colors.white,
                                labelStyle: TextStyle(fontSize: 18.0,fontFamily: 'Family Name'),
                                unselectedLabelColor: Colors.grey,
                                unselectedLabelStyle: TextStyle(fontSize: 14.0,fontFamily: 'Family Name'),
                                tabs: [
                                  Tab(text: "Incoming"),
                                  Tab(text: "Outgoing")
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    body: new TabBarView(
                      children: [
                        IncomingWallet(),
                        OutgoingWallet(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showLogoutConfirmationDialog(BuildContext context){
    showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) =>AlertDialog(
          title: const Text('Logout', style: TextStyle(color: Colors.black),),
          content: const Text('Are you sure you want to logout ?', style: TextStyle(color: Colors.black),),
          actions: <Widget>[
        TextButton(onPressed: () => Navigator.pop(context, 'Cancel'), child: const Text('No', style: TextStyle(color: AppColors.rainBlueLight),),),
        TextButton(onPressed: () {Navigator.pop(context, 'OK'); _logout();}, child: const Text('Yes', style: TextStyle(color: AppColors.rainBlueLight),),),
          ],
        )
    );
  }

  _logout() async {
    _appData.getSharedPreferencesInstance().then((_pref) async {
      await _appData.clearSharedPreferencesData(_pref!).then((value) => null).then((value) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()),);
      });
    });
  }

  @override
  void dispose(){
    super.dispose();
  }
}