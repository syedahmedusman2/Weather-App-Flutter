import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp/Screens/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData( 
      ),
      home: MyHomePage(),
    );
  }
}
