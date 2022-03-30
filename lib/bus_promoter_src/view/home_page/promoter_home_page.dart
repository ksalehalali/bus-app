import 'package:bus_driver/bus_promoter_src/view/profile_page/promoter_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../../common_src/constants/app_colors.dart';
import '../../../common_src/constants/screen_size.dart';

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
  }

  @override
  void dispose(){
    super.dispose();
  }
/*
  getAppBar() {
    return new AppBar(
      leading: Icon(Icons.account_circle_rounded),
      leadingWidth: 100, // default is 56
    );
  }
*/

  getAppBar() {
    return new AppBar(
      //title: new Text("Promoter App"),
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
          //shape: new CircleBorder(),
          //child: Image.network('https://deathofhemingway.com/wp-content/uploads/2020/12/istockphoto-1045886560-612x612-1.jpg'),
        ),

      actions: [
        Padding(padding: const EdgeInsets.all(8.0), child: Icon(AntDesign.logout, color: Colors.white,))
      ],
    );
  }
}