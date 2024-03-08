import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './menu_dashboard_widget.dart';

void main() {
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //     statusBarColor: Colors.white,
  //     statusBarIconBrightness: Brightness.light,
  //     systemNavigationBarColor: Colors.green,
  //     systemNavigationBarIconBrightness: Brightness.dark));
  runApp(const MyApp());

  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
  // });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Slide Dashboard",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MenuDashBoard(),
    );
  }
}
