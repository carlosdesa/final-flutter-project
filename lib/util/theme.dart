import 'package:flutter/material.dart';

class MyTheme {
  createTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.lightBlue[600],
      fontFamily: 'Georgia',
      textTheme: const TextTheme(
        headline1: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Georgia'),
      ),
    );
  }
}
