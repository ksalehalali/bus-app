import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../../common_src/constants/app_colors.dart';
import '../../../common_src/constants/screen_size.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PromoterProfilePage extends StatefulWidget {
  PromoterProfilePage({Key? key}) : super(key: key);

  @override
  _PromoterProfilePage createState() => _PromoterProfilePage();
}

class _PromoterProfilePage extends State<PromoterProfilePage> {

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: currentGradientColors,),),),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 35),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(icon: Icon(AntDesign.arrowleft, color: Colors.white,), onPressed: () =>  Navigator.pop(context),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text('My Profile', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 34, fontFamily: 'Nisebuschgardens',),),
                  SizedBox(height: 22,),
                  Container(
                    height: height * 0.42,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double innerHeight = constraints.maxHeight;
                        double innerWidth = constraints.maxWidth;
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              bottom: 0, left: 0, right: 0,
                              child: Container(
                                height: innerHeight * 0.72,
                                width: innerWidth,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.white,),
                                child: Column(
                                  children: [
                                    SizedBox(height: 80,),
                                    Text('Abdullah Soubeih', style: TextStyle(color: Color.fromRGBO(39, 105, 171, 1), fontFamily: 'Nunito', fontSize: 35,),),
                                    SizedBox(height: 5,),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text('Orders', style: TextStyle(color: Colors.grey[700], fontFamily: 'Nunito', fontSize: 25,),),
                                            Text('10', style: TextStyle(color: Color.fromRGBO(39, 105, 171, 1), fontFamily: 'Nunito', fontSize: 25,),),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8,),
                                          child: Container(height: 50, width: 3, decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.grey,),),
                                        ),
                                        Column(
                                          children: [
                                            Text('Pending', style: TextStyle(color: Colors.grey[700], fontFamily: 'Nunito', fontSize: 25,),),
                                            Text('1', style: TextStyle(color: Color.fromRGBO(39, 105, 171, 1), fontFamily: 'Nunito', fontSize: 25,),),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(top: 100, right: 20, child: Icon(AntDesign.setting, color: Colors.grey[700], size: 30,),),
                            Positioned(top: 0, left: 0, right: 0, child: Center(child:  CircleAvatar(radius: 55.0, backgroundImage: NetworkImage('https://deathofhemingway.com/wp-content/uploads/2020/12/istockphoto-1045886560-612x612-1.jpg'),),),),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 22,),
                  Container(
                    height: height * 0.42,
                    width: width,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.white,),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          SizedBox(height: 20,),
                          Text('👇 Download 👇', style: TextStyle(color: Color.fromRGBO(39, 105, 171, 1), fontSize: 24, fontFamily: 'Nunito',),),
                          Divider(thickness: 2.5,),
                          SizedBox(height: 10,),
                          QrImage(data: 'http://routesme.com/', version: QrVersions.auto, size: 200.0, foregroundColor: Color.fromRGBO(39, 105, 171, 1),),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    height: height * 0.5,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'My Orders',
                            style: TextStyle(
                              color: Color.fromRGBO(39, 105, 171, 1),
                              fontSize: 27,
                              fontFamily: 'Nunito',
                            ),
                          ),
                          Divider(
                            thickness: 2.5,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: height * 0.15,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: height * 0.15,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose(){
    super.dispose();
  }
}