import 'home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'loader.dart';
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loader(),
      debugShowCheckedModeBanner: false,
    );
  }
}
