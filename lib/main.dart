import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iotproject/home.dart';

void main() {
  runApp(const IotApp());
}

class IotApp extends StatelessWidget {
  const IotApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Iotproject',
      home: home(),
    );
  }
}
