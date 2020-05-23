import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leadittest/second_page.dart';
import 'my_home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      routes: {
        SecondPage.routeName: (context) => SecondPage(),
      },
    );
  }
}
