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

    cryptoPortfolioItem(bool isIncoming, String name, double amount, double rate, String percentage) => Card(
          elevation: 1.0,
          child: InkWell(
            onTap: () => print("tapped"),
            child: Container(
              padding: EdgeInsets.only(top: 10.0, bottom: 15.0, right: 15.0),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(left: 10.0, right: 15.0), child: getIcon(isIncoming),),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(name, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),),
                            Text("${getSign(isIncoming)} \ $percentage", style: TextStyle(fontSize: 14.0, color: getColor(isIncoming),))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("$rate BTC", style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.normal, color: Colors.grey)),
                            Text("\KWD $amount", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black))
                          ],
                        )
                      ],
                    ),
                    flex: 3,
                  ),
                ],
              ),
            ),
          ),
        );

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

                    /*
                DefaultTabController(
                  length: 2,
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text('Flutter Tabs Demo'),
                      bottom: TabBar(
                        tabs: [
                          Tab(text: "Incoming"),
                          Tab(text: "Outgoing")
                        ],
                      ),
                    ),
                    body: TabBarView(
                      children: [
                        IncomingWallet(),
                        OutgoingWallet(),
                      ],
                    ),
                  ),
                ),
*/
                /*
                ListView(
                  children: <Widget>[
                    cryptoPortfolioItem(true, "Cash", 100.800, 0.0036, "82.19"),
                    cryptoPortfolioItem(false, "Cash", 20, 126.0, "13.10"),
                    cryptoPortfolioItem(false, "Visa", 3, 23000, "120"),
                    cryptoPortfolioItem(false, "Cash", 42.500, 0.0036, "82.19"),
                    cryptoPortfolioItem(true, "Visa", 500, 126.0, "13.10"),
                    cryptoPortfolioItem(true, "Cash", 230, 23000, "120"),
                    cryptoPortfolioItem(true, "Cash", 90, 0.0036, "82.19"),
                    cryptoPortfolioItem(true, "Visa", 33, 126.0, "13.10"),
                    cryptoPortfolioItem(false, "Visa", 20.600, 23000, "120"),
                  ],
                ),
                */
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

  getIcon(bool isIncoming) {
    if(isIncoming) return Icon(FontAwesomeIcons.plus, color: Colors.green,); else return Icon(FontAwesomeIcons.minus, color: Colors.red,);
  }

  getSign(bool isIncoming) {
    if(isIncoming) return "+"; else return "-";
  }

  getColor(bool isIncoming) {
    if(isIncoming) return Colors.green; else return Colors.red;
  }
}