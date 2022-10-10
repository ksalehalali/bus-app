import 'package:bus_driver/Inspector_Controllers/current_data.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

import '../../Inspector_Controllers/consts.dart';
import '../../Inspector_Controllers/globals.dart';
import '../../Inspector_Controllers/inspector_controller.dart';
import '../../bus_driver_src/helper/shared_preferences.dart';
import '../../bus_promoter_src/data/models/user_profile_dto.dart';
import '../../bus_promoter_src/view/charge_wallet/balance_calculator.dart';
import '../../common_src/constants/app_colors.dart';
import '../../common_src/data/network_service.dart';
import '../../common_src/data/repository.dart';
import '../../common_src/view/login_page.dart';
import '../widgets/QRCodeScanner.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final Repository _repository;
  ProfileInformation? _profileInformation;
  var box = GetStorage();

  @override
  initState() {
    super.initState();
    //myToken = 'bearer ${box.read('myToken')}';

    _repository = Repository(networkService: NetworkService());
    getProfileInformation();

    _tabController = TabController(length: homeTabs.length, vsync: this);
    _tabController!.addListener(_onTextChanged);

  }

  void _onTextChanged() {
    setState(() {
      print(_tabController!.index);
      tabIndex = _tabController!.index;
    });
    if(_tabController!.index ==1){
      inspectorController.getInspectorBusesChecked(context);
    }
  }

  @override
  dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  bool searchSelected = false;
  TabController? _tabController;
  int tabIndex = 0;
  bool changeFromTo = false;

  List<Tab> homeTabs = [
    const Tab(text: 'Actions'),
    const Tab(text: 'Buses Checked'),
  ];
  final InspectorController inspectorController = Get.find();
  var scanType = '';
  final screenSize = Get.size;

  //get profile
  void getProfileInformation() {

    _repository.getUserProfile().then((response) async {
      if (response != null) {
        if (response.status == true) {
          try {
            UserProfileDTO profileDTO = response as UserProfileDTO;
            if (profileDTO.profileInformation != null) {
              setState(() {
                _profileInformation = profileDTO.profileInformation;
                userName = _profileInformation!.userName!;
              });
            }
          } catch (e) {
            Fluttertoast.showToast(
                msg: "Something wrong!..",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM);
          }
        } else {
          Fluttertoast.showToast(
              msg: "Something wrong!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM);
        }
      } else {
        Fluttertoast.showToast(
            msg: "Something wrong!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
      }
    });
  }

//logout
  late final AppData _appData;
  _showLogoutConfirmationDialog(BuildContext context) {
    _appData = AppData();

    showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
          title: const Text(
            'Logout',
            style: TextStyle(color: Colors.black),
          ),
          content: const Text(
            'Are you sure you want to logout ?',
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text(
                'No',
                style: TextStyle(color: AppColors.rainBlueLight),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
                _logout();
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: AppColors.rainBlueLight),
              ),
            ),
          ],
        ));
  }

  _logout() async {
    _appData.getSharedPreferencesInstance().then((_pref) async {
      await _appData
          .clearSharedPreferencesData(_pref!)
          .then((value) => null)
          .then((value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> tabViews = [
      Container(
        color: Colors.white,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  scanType = 'Bus';
                  Get.to(()=>QRScanner(context: context,scanType: scanType,));
                },
                child: const Text(
                  "Scan Bus",
                  style: TextStyle(fontSize: 17, letterSpacing: 1),
                ),
                style: ElevatedButton.styleFrom(
                    maximumSize: Size(Get.size.width - 90, Get.size.width - 90),
                    minimumSize: Size(Get.size.width - 90, 40),
                    primary: routes_color2,
                    onPrimary: Colors.white,
                    alignment: Alignment.center),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  scanType = 'Ticket';
                  Get.to(()=>QRScanner(context: context,scanType: scanType,));
                },
                child: const Text(
                  "Scan Ticket",
                  style: TextStyle(fontSize: 17, letterSpacing: 1),
                ),
                style: ElevatedButton.styleFrom(
                    maximumSize: Size(Get.size.width - 90, Get.size.width - 90),
                    minimumSize: Size(Get.size.width - 90, 40),
                    primary: routes_color2,
                    onPrimary: Colors.white,
                    alignment: Alignment.center),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  Get.to(() => const BalanceCalculator(
                        chargeAmount: false,
                      ));
                },
                child: const Text(
                  "Send money",
                  style: TextStyle(fontSize: 17, letterSpacing: 1),
                ),
                style: ElevatedButton.styleFrom(
                    maximumSize: Size(Get.size.width - 90, Get.size.width - 90),
                    minimumSize: Size(Get.size.width - 90, 40),
                    primary: routes_color2,
                    onPrimary: Colors.white,
                    alignment: Alignment.center),
              ),
            ],
          ),
        ),
      ),
      Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: screenSize.height *.1 -40,),
            Expanded(
              child: SizedBox(
                height: 500,
                child: CustomScrollView(
                  slivers: [
                    Obx(()=> SliverList(delegate: SliverChildBuilderDelegate((context,index){
                      return Column(
                        children: [
                          ListTile(
                            leading:Text('${index+1}',style: TextStyle(color: Colors.black,fontSize: 16),),
                            title: Text('${inspectorController.inspectorBusesChecked.value[index]['company']}',style: TextStyle(color: Colors.black),),
                            subtitle:  Text("Plate Number : ${inspectorController.inspectorBusesChecked[index]['palteNumber']}",style: TextStyle(height: 2,color: Colors.black),),
                            trailing:  Text("Route : ${inspectorController.inspectorBusesChecked[index]['route']}",style: TextStyle(color:Colors.red,fontWeight: FontWeight.w600),),
                            onTap: (){

                            },
                          ),
                          Divider(thickness: 1,height: 10,),
                        ],
                      );
                    },childCount:inspectorController.inspectorBusesChecked.length ),),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ];

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            routes_color4,
            routes_color,
          ]),
          color: Colors.white),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                onTap: (){
                  _showLogoutConfirmationDialog(context);},
                child: Icon(Icons.login_outlined,size: 32,color: Colors.white,),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top:0),
          child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            routes_color4,
                            routes_color,
                          ]),
                          color: Colors.white),
                      height: MediaQuery.of(context).size.height * 0.25,
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: tabViews,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(11.0),
                        height: (MediaQuery.of(context).size.height * 0.25) - 42,
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children:  [

                                        DelayedDisplay(
                                          child: Text(
                                            'Welcome ${_profileInformation?.name?.split(' ').first}!',
                                            style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    !searchSelected
                                        ? Container(
                                            width: 1,
                                            height: 32,
                                            color: Colors.white.withOpacity(0.4),
                                          )
                                        : Container(),
                                  ],
                                ),
                                Spacer(),
                              ],
                            ),
                            searchSelected
                                ? Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 14),
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            changeFromTo = !changeFromTo;
                                          });
                                        },
                                        child: const Center(
                                          child: RotatedBox(
                                            quarterTurns: 3,
                                            child: Icon(
                                              Icons.compare_arrows_sharp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                      searchSelected
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                    )
                                  ],
                                ),
                                child: InkWell(
                                  onTap: () {},
                                  child: Center(
                                    child: Icon(
                                      Icons.filter_alt_outlined,
                                      color: veppoBlue,
                                      size: 32,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.fromLTRB(11, 0, 11, 0),
                              height: 52,
                              child: Stack(
                                children: [
                                  Container(
                                    height: 52,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(28),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 2,
                                          blurRadius: 4,
                                        )
                                      ],
                                    ),
                                  ),
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    height: 44,
                                    width:
                                        (MediaQuery.of(context).size.width / 2) -
                                            26,
                                    margin: EdgeInsets.fromLTRB(
                                        tabIndex == 1
                                            ? (MediaQuery.of(context).size.width /
                                                    2) -
                                                26
                                            : 4,
                                        4,
                                        tabIndex == 4
                                            ? (MediaQuery.of(context).size.width /
                                                    2) -
                                                26
                                            : 4,
                                        4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(24),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 2,
                                          blurRadius: 4,
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 52,
                                    width: MediaQuery.of(context).size.width,
                                    child: TabBar(
                                      labelColor: veppoBlue,
                                      unselectedLabelColor: veppoLightGrey,
                                      indicatorColor: Colors.transparent,
                                      controller: _tabController,
                                      onTap: (index) {
                                        setState(() {
                                          tabIndex = index;
                                        });
                                      },
                                      tabs: homeTabs,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                    ],
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}
