import 'package:flutter/material.dart';

class MyTheme {
  createTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.lightBlue[800],
      fontFamily: 'Georgia',
      textTheme: const TextTheme(
        headline1: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 22.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(fontSize: 12.0, fontFamily: 'Hind'),
      ),
    );
  }
}
