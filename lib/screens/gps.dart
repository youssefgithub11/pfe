 // ignore_for_file: unused_element

 import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
class Gps extends StatefulWidget {
   static const routeName ='/Gps';
  @override
  GpsScreen createState() => new GpsScreen();
}
void main() => runApp(Gps());

// ignore: use_key_in_widget_constructors
class GpsScreen extends State<Gps> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

    );
  }





bool _serviceEnabled;


@override
  void initState() {
    super.initState();
    checkLocationServicesInDevice();
 }
@override 
// ignore: missing_return

Future <void>checkLocationServicesInDevice() async {

Location location = new Location();
_serviceEnabled = await location.serviceEnabled();


if(_serviceEnabled) 
{

  print('GPS ENABLED');

}else{

  _serviceEnabled = await location.requestService();

if(_serviceEnabled)
{
 print('start tracking');
}
else{

  SystemNavigator.pop();
}
}

}

}





