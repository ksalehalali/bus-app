import 'package:bus_driver/bus_driver_src/features/qrcode_scanner/scanner.dart';
import 'package:bus_driver/bus_driver_src/helper/event_bus_classes.dart';
import 'package:bus_driver/bus_driver_src/helper/event_bus_utils.dart';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../data/route/route_data.dart';

class RouteInformationWidget extends StatefulWidget {
  RouteInformationWidget({Key? key, required this.routeData, required this.widgetHeight}) : super(key: key);
  final RouteData? routeData;
  final double? widgetHeight;
  bool isSignalRActive = false;

  @override
  _RouteInformationWidget createState() => _RouteInformationWidget();
}

class _RouteInformationWidget extends State<RouteInformationWidget> {

  @override
  void initState() {
    super.initState();

    EventBusUtils.getInstance().on<OnSignalRStatusChanged>().listen((event) {
      setState(() {widget.isSignalRActive = event.isActive; });
    });
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
                    icon: new Icon(Icons.qr_code_scanner, color: Colors.white,),
                    onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Scanner()),);},
                  ),
                )
              ],
            )
        )
    );
  }

  Widget getCurrentStatus() {
    if(widget.isSignalRActive) return Text('Connected', style: TextStyle(color: Colors.white),);
    else return Text('Not connected', style: TextStyle(color: AppColors.rainRedDark),);
  }
}