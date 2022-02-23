import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center ,
            children: [
              const SizedBox(height: 3),
              Text('Route ${routeData!.number}', style: textTheme.subtitle1),
              const SizedBox(height: 3),
              Text('${routeData!.startFrom} to ${routeData!.endAt}', style: textTheme.subtitle1),
              const SizedBox(height: 3),
              Text('Bus plate number ${routeData!.busPlateNumber}', style: textTheme.subtitle1),
              const SizedBox(height: 3),
            ],
          ),
        )
    );
  }
}