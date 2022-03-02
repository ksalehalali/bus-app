import 'package:bus_driver/bus_driver_src/features/qrcode_scanner/scanner.dart';
import 'package:flutter/material.dart';
import '../../entities/route/route_data.dart';

class RouteInformationWidget extends StatelessWidget {
  const RouteInformationWidget({Key? key, required this.routeData, required this.widgetHeight}) : super(key: key);
  final RouteData? routeData;
  final double? widgetHeight;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
        flex: 2,
        child: SizedBox(
          height: widgetHeight,
          child:  Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center ,
                    children: [
                      const SizedBox(height: 3),
                      Text('Route ${routeData!.number}', style: textTheme.subtitle1),
                      const SizedBox(height: 3),
                      Text('${routeData!.startFrom} to ${routeData!.endAt}', style: textTheme.subtitle1),
                      const SizedBox(height: 3),
                      Text('Bus plate number: ${routeData!.busPlateNumber}', style: textTheme.subtitle1),
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
}