import 'package:bus_driver/bus_promoter_src/view/profile_page/promoter_profile_page.dart';
import 'package:bus_driver/common_src/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../../common_src/constants/app_colors.dart';
import '../../../common_src/constants/screen_size.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PromoterHomePage extends StatefulWidget {
  PromoterHomePage({Key? key}) : super(key: key);

  @override
  _PromoterHomePage createState() => _PromoterHomePage();
}

class _PromoterHomePage extends State<PromoterHomePage> {

  //final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  List<Color> currentGradientColors = AppColors.activeGradient;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    var screenSize = ScreenSize();
    /*
    return Scaffold(
      appBar: getAppBar(),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: currentGradientColors,
          ),
        ),
       /*
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 2),
              RouteInformationWidget(widgetHeight: screenSize.getScreenHeightExcludeSafeArea(context) * 10),
              const SizedBox(height: 2),
              TransactionListWidget(widgetHeight: screenSize.getScreenHeightExcludeSafeArea(context) * 80),
              const SizedBox(height: 2),
              TotalTransactionCountWidget(widgetHeight: screenSize.getScreenHeightExcludeSafeArea(context) * 10),
              const SizedBox(height: 2),
            ],
          ),
        ),
        */
      ),
    );
    */

    cryptoPortfolioItem(bool isIncoming, String name, double amount, double rate, String percentage) => Card(
          elevation: 1.0,
          child: InkWell(
            onTap: () => print("tapped"),
            child: Container(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0, right: 15.0),
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
                  padding: EdgeInsets.only(top: 55, left: 20, right: 20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(padding: const EdgeInsets.all(8.0), child:  GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PromoterProfilePage()),), child:  CircleAvatar(radius: 25.0, backgroundImage: NetworkImage('https://deathofhemingway.com/wp-content/uploads/2020/12/istockphoto-1045886560-612x612-1.jpg'),),),),
                          Text("Wallet History", style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.w500)),
                          IconButton(icon:  Icon(AntDesign.logout, color: Colors.white,), onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()),),)
                        ],
                      ),
                      SizedBox(height: 40),
                      Text(r" KWD 100.8", style: TextStyle(color: Colors.white, fontSize: 45.0, fontWeight: FontWeight.bold),),
                      SizedBox(height: 20),
                      Text(r"+ $3,157.67 (23%)", style: TextStyle(color: Colors.white70, fontSize: 18.0, fontWeight: FontWeight.w300),)
                    ],
                  ),
                ),
                Container(height: MediaQuery.of(context).size.height * .75, color: Colors.grey,)
              ],
            ),
            Container(
              alignment: Alignment.topCenter,
              padding: new EdgeInsets.only(top: MediaQuery.of(context).size.height * .25, right: 10.0, left: 10.0),
              child: new Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView(
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
              ),
            ),
            /*
            Positioned(
              bottom: MediaQuery.of(context).size.height * .37,
              left: MediaQuery.of(context).size.width * .05,
              child: RaisedButton(
                  padding: EdgeInsets.symmetric(
                    vertical: 18.0,
                    horizontal: 38.0,
                  ),
                  color: Color(0xFFEE112D),
                  onPressed: () {},
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(25.0)),
                  child: Text(
                    "Send",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * .37,
              right: MediaQuery.of(context).size.width * .05,
              child: RaisedButton(
                  padding: EdgeInsets.symmetric(
                    vertical: 18.0,
                    horizontal: 30.0,
                  ),
                  color: Color(0xFFEE112D),
                  onPressed: () {},
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(25.0)),
                  child: Text(
                    "Receive",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * .43,
              left: MediaQuery.of(context).size.width * .30,
              child: RaisedButton(
                  padding: EdgeInsets.symmetric(
                    vertical: 18.0,
                    horizontal: 34.0,
                  ),
                  color: Color(0xFFEE112D),
                  onPressed: () {},
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(25.0)),
                  child: Text(
                    "Exchange",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * .33,
              left: MediaQuery.of(context).size.width * .40,
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: null,
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ),
            */
          ],
        ),
      ),
    );
  }

  @override
  void dispose(){
    super.dispose();
  }

  getAppBar() {
    return new AppBar(
      leading: new Padding(
        padding: const EdgeInsets.all(8.0),
        child:  GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => PromoterProfilePage()),);
          },
          child:  CircleAvatar(
            radius: 55.0,
            backgroundImage: NetworkImage('https://deathofhemingway.com/wp-content/uploads/2020/12/istockphoto-1045886560-612x612-1.jpg'),
          ),
        ),
        ),

      actions: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                child:  Icon(AntDesign.logout, color: Colors.white,),
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()),);
                }
            )
        )
      ],
    );
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