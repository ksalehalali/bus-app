import 'package:bus_driver/bus_promoter_src/view/profile_page/promoter_profile_page.dart';
import 'package:bus_driver/common_src/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../../bus_driver_src/helper/shared_preferences.dart';
import '../../../common_src/constants/app_colors.dart';
import '../../../common_src/constants/screen_size.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../wallet/incoming_wallet.dart';
import '../wallet/outgoing_wallet.dart';

class PromoterHomePage extends StatefulWidget {
  PromoterHomePage({Key? key}) : super(key: key);

  @override
  _PromoterHomePage createState() => _PromoterHomePage();
}

class _PromoterHomePage extends State<PromoterHomePage> {

  //final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  List<Color> currentGradientColors = AppColors.activeGradient;
  late final AppData _appData;

  @override
  void initState() {
    _appData = AppData();
    super.initState();
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
                          Padding(padding: const EdgeInsets.all(8.0), child:  GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PromoterProfilePage()),), child:  CircleAvatar(radius: 20.0, backgroundImage: NetworkImage('https://deathofhemingway.com/wp-content/uploads/2020/12/istockphoto-1045886560-612x612-1.jpg'),),),),
                          Text("Welcome Abdullah !", style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w500)),
                          IconButton(icon:  Icon(AntDesign.logout, color: Colors.white,), onPressed: () => _logout())
                        ],
                      ),
                      SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(r" KWD 100.8", style: TextStyle(color: Colors.white, fontSize: 45.0, fontWeight: FontWeight.bold),),
                      IconButton(icon:  Icon(FontAwesomeIcons.moneyBillTransfer, color: Colors.white,), onPressed: () => print("Clicked to transfer money!"))
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
                              new Expanded(child: new Container()),
                              new TabBar(
                                indicatorColor: Colors.white,
                                labelStyle: TextStyle(fontSize: 22.0,fontFamily: 'Family Name'),  //For Selected tab
                                unselectedLabelStyle: TextStyle(fontSize: 16.0,fontFamily: 'Family Name'), //For Un-selected Tabs
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