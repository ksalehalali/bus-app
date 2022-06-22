import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Inspector_Controllers/globals.dart';
import '../../Inspector_Controllers/inspector_controller.dart';

class BusDetails extends StatefulWidget {
  const BusDetails({Key? key}) : super(key: key);

  @override
  _BusDetailsState createState() => _BusDetailsState();
}

class _BusDetailsState extends State<BusDetails> {
  final InspectorController inspectorController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(

      child: SafeArea(child:Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0.0,
        //   foregroundColor: routes_color,
        // ),
        body: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(top:30.0,right: 12,left:12),
                child: Obx(()=>Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      Center(
                        child: Text(
                          inspectorController.busScanned.value ==true ?'${inspectorController.busScannedData['company']}':'',
                          style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green[700],),
                        ),
                      ),
                      const SizedBox(
                        height: 42.0,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                       Text(
                        'Bus plateNumber :',
                        style: TextStyle(fontSize: 13,color: Colors.grey[600]),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        inspectorController.busScanned.value==true?'${inspectorController.busScannedData['palteNumber']}':'',
                        style:  TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                            color: Colors.grey[900]
                        ),
                        maxLines: 1,
                      ),
                      dividerDesign(),

                      const SizedBox(
                        height: 12.0,
                      ),
                       Text(
                        'Kind :',
                        style: TextStyle(fontSize: 14,color: Colors.grey[600]),
                      ),
                      const SizedBox(
                        height:4.0,
                      ),
                      Text(
                        inspectorController.busScanned.value==true?'${inspectorController.busScannedData['kind']}':'',   style:  TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold,color: Colors.grey[700]),
                      ),
                      dividerDesign(),

                      const SizedBox(
                        height: 12.0,
                      ),
                       Text(
                        'Route :',
                        style: TextStyle(fontSize: 13,color: Colors.grey[600]),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        inspectorController.busScanned.value==true?'${inspectorController.busScannedData['routeName']}':'',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold,color: Colors.grey[700]),
                      ),
                      dividerDesign(),

                      const SizedBox(
                        height: 8.0,
                      ),
                       Text(
                        'From To :',
                        style: TextStyle(fontSize: 13,color: Colors.grey[600]),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      // Text(
                      //   inspectorController.busScanned.value==true?'${inspectorController.busScannedData['applicationRoute']['from_To_EN']}':'',
                      //   style: const TextStyle(
                      //       fontSize: 16, fontWeight: FontWeight.bold),
                      // ),
                      dividerDesign(),

                      const SizedBox(
                        height: 8.0,
                      ),
                       Text(
                        'active :',
                        style: TextStyle(fontSize: 13,color: Colors.grey[600]),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        inspectorController.busScanned.value==true?'${inspectorController.busScannedData['active'].toString()}':'',
                        style:  TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold,color: Colors.grey[700]),
                      ),
                      dividerDesign(),

                      const SizedBox(
                        height: 20.0,
                      ),

                      const SizedBox(
                        height: 8.0,
                      ),
                       Text(
                        'Today Passengers Count :',
                        style: TextStyle(fontSize: 13,color: Colors.grey[600]),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        inspectorController.busScanned.value==true?'${inspectorController.paymentsForBus.value.length}':'',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                            color: Colors.grey[700]
                        ),
                        maxLines: 1,
                      ),
                      dividerDesign(),

                      const SizedBox(
                        height: 12.0,
                      ),
                       Text(
                        'Existing Passengers Count :',
                        style: TextStyle(fontSize: 14,color: Colors.grey[600]),
                      ),
                      const SizedBox(
                        height:4.0,
                      ),
                      Text(
                        inspectorController.busScanned.value==true?'${inspectorController.paymentsForBus.value.length}':'',
                        style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold,color: Colors.grey[700]),
                      ),
                      dividerDesign(),

                      // Center(
                      //     child: Icon(
                      //       Icons.done,
                      //       size: 66,
                      //       color: Colors.green[800],
                      //     )),
                      // Align(
                      //   alignment: Alignment.bottomRight,
                      //   child: FlatButton(
                      //     onPressed: () {
                      //       Navigator.pop(context);
                      //     },
                      //     child: Text('Close'),
                      //   ),
                      // )
                    ],
                  ),
                ))
          ],
        ),
      )),
    );
  }
  Widget dividerDesign(){
    return const Divider(thickness: 2,);
  }
}
