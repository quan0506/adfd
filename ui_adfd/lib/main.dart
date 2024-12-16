import 'package:flutter/material.dart';
import 'package:ui_adfd/screens/PlaceScreen.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ADFD Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PlaceScreen(),
    );
  }
}



