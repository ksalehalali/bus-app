import 'package:bus_driver/bus_driver_src/helper/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../bus_driver_src/helper/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Inspector_Controllers/current_data.dart';
import '../Inspector_Controllers/globals.dart';
import '../Inspector_Controllers/inspector_controller.dart';
import '../bus_promoter_src/data/models/user_profile_dto.dart';
import '../common_src/data/network_service.dart';
import '../common_src/data/repository.dart';
import 'home/bus_details.dart';
import 'home/home_page.dart';
import 'home/profile_screen.dart';
import 'wallet/wallet_screen.dart';

class MainScreenInspector extends StatefulWidget {
  final int currentPage;
  const MainScreenInspector({Key? key, required this.currentPage}) : super(key: key);

  @override
  _MainScreenInspectorState createState() => _MainScreenInspectorState();
}

class _MainScreenInspectorState extends State<MainScreenInspector> {
  final List<Widget> screens = [
    const HomePage(),
    const WalletScreen(),
    const BusDetails(),
    ProfileScreen(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomePage();
  final InspectorController inspectorController = Get.find();

  var box = GetStorage();

  int? currentTp = 0;
  late final AppData _appData = AppData();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAccessToken();
      setState(() {
        currentScreen = screens[widget.currentPage];
        currentTp = widget.currentPage;

    });
  }
  getAccessToken()async{
    SharedPreferences? pref =  await _appData.getSharedPreferencesInstance();
    String accessToken = _appData.getAccessToken(pref!)!;
    myToken = accessToken;
    print('....................acc $myToken');
  }
  @override
  Widget build(BuildContext context) {
    return Container(

        child:SafeArea(child: Scaffold(
    body: PageStorage(bucket: bucket, child: currentScreen,

    ),
        bottomNavigationBar: NavigationBar(
            height: 62.0,
            backgroundColor: Colors.white,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            selectedIndex: currentTp!,
            onDestinationSelected: (index) {
              setState(() {
                currentScreen = screens[index];
                currentTp = index;
              });
            },
            animationDuration: Duration(milliseconds: 1),
            destinations: [


              NavigationBarTheme(
                  data: NavigationBarThemeData(
                      indicatorColor: Colors.grey.shade200,
                      labelTextStyle:
                      MaterialStateProperty.all(TextStyle(fontSize: 12))),
                  child: NavigationDestination(
//                    icon: Icon(Icons.home_outlined,color: Colors.blue[900]),
                    label: 'Home',
                    icon: SvgPicture.asset("${assetsDir}home_svg.svg", width: 20, color: Colors.grey[600],),
                    selectedIcon: SvgPicture.asset("${assetsDir}home_svg.svg", width: 25, color: Colors.blue[900],),
                  )),

              NavigationBarTheme(
                  data: NavigationBarThemeData(
                      indicatorColor: Colors.grey.shade200,
                      labelTextStyle:
                      MaterialStateProperty.all(TextStyle(fontSize: 12))),
                  child: NavigationDestination(
                    icon: SvgPicture.asset("${assetsDir}wallet.svg", width: 20, color: Colors.grey[600],),
                    label: 'Wallet',
                    selectedIcon: SvgPicture.asset("${assetsDir}wallet.svg", width: 25, color: Colors.blue[900],),
                  )),
              NavigationBarTheme(
                  data: NavigationBarThemeData(
                      indicatorColor: Colors.grey.shade200,
                      labelTextStyle:
                      MaterialStateProperty.all(TextStyle(fontSize: 12))),
                  child: NavigationDestination(
                    icon: SvgPicture.asset("assets/images/businfoo.svg", width: 25, color: Colors.grey[600],),
                    label: 'Bus',
                    selectedIcon: SvgPicture.asset("assets/images/businfoo.svg", width: 30, color: Colors.blue[900],),
                  )),

              NavigationBarTheme(
                  data: NavigationBarThemeData(
                      indicatorColor: Colors.grey.shade200,
                      labelTextStyle:
                      MaterialStateProperty.all(TextStyle(fontSize: 12))),
                  child: NavigationDestination(
                    icon: SvgPicture.asset("${assetsDir}profile.svg", width: 20, color: Colors.grey[600],),
                    label: 'Profile',
                    selectedIcon: SvgPicture.asset("${assetsDir}profile.svg", width: 25, color: Colors.blue[900],),
                  )),
            ])
    )));
  }
}
