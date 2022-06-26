import 'package:bus_driver/bus_driver_src/helper/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:myfatoorah_flutter/utils/MFCountry.dart';
import 'package:myfatoorah_flutter/utils/MFEnvironment.dart';
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


  int? currentTp = 0;
  late final AppData _appData = AppData();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MFSDK.init(
        'rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL',
        MFCountry.KUWAIT,
        MFEnvironment.TEST);
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
