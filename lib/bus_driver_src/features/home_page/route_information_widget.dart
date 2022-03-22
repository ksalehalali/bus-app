import 'package:bus_driver/bus_driver_src/helper/event_bus_classes.dart';
import 'package:bus_driver/bus_driver_src/helper/event_bus_utils.dart';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/models/driver_enter_out_response_dto.dart';
import '../../data/models/driver_out_credentials.dart';
import '../../data/route/route_data.dart';
import '../../data/repository.dart';
import '../../data/network_service.dart';
import '../../helper/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../login/login_page.dart';

class RouteInformationWidget extends StatefulWidget {
  RouteInformationWidget({Key? key, required this.widgetHeight}) : super(key: key);
  final double? widgetHeight;
  bool isSignalRActive = false;

  @override
  _RouteInformationWidget createState() => _RouteInformationWidget();
}

class _RouteInformationWidget extends State<RouteInformationWidget> {
  late final Repository repository;
  late final AppData _appData;
  late final  String busId;
  late final SharedPreferences? pref;


  @override
  void initState(){
    repository = Repository(networkService: NetworkService());
    _appData = AppData();
    _appData.getSharedPreferencesInstance().then((value) {
      pref = value;
      busId = _appData.getBusID(pref!)!;
    });
    EventBusUtils.getInstance().on<OnSignalRStatusChanged>().listen((event) {setState(() {widget.isSignalRActive = event.isActive; });});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        Text('Route ${widget.routeData!.number}', style: TextStyle(color: Colors.white),),
                        const SizedBox(height: 3),
                        Text('${widget.routeData!.startFrom} to ${widget.routeData!.endAt}', style: TextStyle(color: Colors.white),),
                        const SizedBox(height: 3),
                        Text('Bus plate number: ${widget.routeData!.busPlateNumber}', style: TextStyle(color: Colors.white),),
                        const SizedBox(height: 3),
                        getCurrentStatus(),
                        const SizedBox(height: 3),
                      ],
                    )
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: new Icon(Icons.logout, color: Colors.white,),
                    onPressed: () => _logout(),
                  ),
                ),
              ],
            )
        )
    );
  }

  Widget getCurrentStatus() {
    if(widget.isSignalRActive) return Text('Connected', style: TextStyle(color: Colors.white),);
    else return Text('Not connected', style: TextStyle(color: AppColors.rainRedDark),);
  }

  _logout() async {
    final driverOutCredentials = DriverOutCredentials(BusID: busId);
    repository.driverOut(driverOutCredentials).then((response) async {
      if (response != null && response is DriverEnterOutResponseDTO) {
        if(response.description!.status == true && response.description!.message == 'Seccess'){
          await _appData.clearSharedPreferencesData(pref!).then((value) => null).then((value) {
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
}