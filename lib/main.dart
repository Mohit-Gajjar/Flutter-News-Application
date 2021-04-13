import 'package:flutter/material.dart';
import 'package:newsapp/views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My News',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home:Home(),
    );
  }
}
