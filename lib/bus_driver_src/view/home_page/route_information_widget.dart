import 'package:bus_driver/bus_driver_src/helper/event_bus_classes.dart';
import 'package:bus_driver/bus_driver_src/helper/event_bus_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../../common_src/constants/app_colors.dart';
import '../../../common_src/data/network_service.dart';
import '../../../common_src/view/login_page.dart';
import '../../data/models/bus_information_dto.dart';
import '../../data/models/bus_information_credentials.dart';
import '../../data/models/driver_enter_out_response_dto.dart';
import '../../data/models/driver_out_credentials.dart';
import '../../../common_src/data/repository.dart';
import '../../helper/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RouteInformationWidget extends StatefulWidget {
  RouteInformationWidget({Key? key, required this.widgetHeight}) : super(key: key);
  final double? widgetHeight;


  @override
  _RouteInformationWidget createState() => _RouteInformationWidget();
}

class _RouteInformationWidget extends State<RouteInformationWidget> {
  late final Repository _repository;
  late final AppData _appData;
  BusInformationResponseDTO? _busInformationResponseDTO = null;
  late final  String _busId;
  late final SharedPreferences? _pref;
  bool isSignalRActive = false;

  @override
  void initState(){
    _repository = Repository(networkService: NetworkService());
    _appData = AppData();
    _appData.getSharedPreferencesInstance().then((value) {
      _pref = value;
      _busId = _appData.getBusID(_pref!)!;
      getBusInformation();
    });
    EventBusUtils.getInstance().on<OnSignalRStatusChanged>().listen((event) {
      print("SignalRCurrentStatus: ${event.isActive}");
      setState(() {isSignalRActive = event.isActive; });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("SignalRCurrentStatus.. build(): ${isSignalRActive}");
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
        flex: 2,
        child: SizedBox(
            height: widget.widgetHeight,
            child:  Row(
              children: [
                /*
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: new Icon(Icons.qr_code_scanner, color: Colors.white,),
                    onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Scanner()),);},
                  ),
                ),
                */
                Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center ,
                      children: [
                        const SizedBox(height: 3),
                        Text('${_busInformationResponseDTO?.description?.company ?? ''}', style: TextStyle(color: Colors.white),),
                        const SizedBox(height: 3),
                        Text('Route number: ${_busInformationResponseDTO?.description?.routeName ?? ''}', style: TextStyle(color: Colors.white),),
                      //  Text('${_busInformationResponseDTO?.description?.applicationRoute?.nameEN} - ${_busInformationResponseDTO?.description?.applicationRoute?.fromToEN}', style: TextStyle(color: Colors.white),),
                        const SizedBox(height: 3),
                        Text('Plate number: ${_busInformationResponseDTO?.description?.palteNumber ?? ''}', style: TextStyle(color: Colors.white),),
                        const SizedBox(height: 3),
                        getCurrentStatus(),
                        const SizedBox(height: 3),
                      ],
                    )
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: new Icon(AntDesign.logout, color: Colors.white,),
                    onPressed: () => _showLogoutConfirmationDialog(context),
                  ),
                ),
              ],
            )
        )
    );
  }

  Widget getCurrentStatus() {
    print("SignalRCurrentStatus.. getCurrentStatus: ${isSignalRActive}");
    if(isSignalRActive) return Text('Connected', style: TextStyle(color: Colors.white),);
    else return Text('Not connected', style: TextStyle(color: AppColors.rainRedDark),);
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
    final driverOutCredentials = DriverOutCredentials(BusID: _busId);
    _repository.driverOut(driverOutCredentials).then((response) async {
      if (response != null && response is DriverEnterOutResponseDTO) {
        if(response.description!.status == true && response.description!.message == 'Seccess'){
          await _appData.clearSharedPreferencesData(_pref!).then((value) => null).then((value) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()),);
          });
        }else{
          Fluttertoast.showToast(msg: "${response.description!.message}", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
        }
      }else{
        Fluttertoast.showToast(msg: "Something wrong!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
      }
    });
  }

  void getBusInformation(){
    final busInformationCredentials = BusInformationCredentials(id: '$_busId');
    _repository.getBusInformation(busInformationCredentials).then((response) async{
      if (response != null) {
        if(response.status == true){
          setState(() {
            try{
              _busInformationResponseDTO = response;
            }catch(e){
              Fluttertoast.showToast(msg: "Something wrong!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
            }
          });
        }else{
          Fluttertoast.showToast(msg: "Something wrong!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
        }
      }else{
        Fluttertoast.showToast(msg: "Something wrong!", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
      }
    });
  }
}