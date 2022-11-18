import 'package:flutter/material.dart';
import 'package:fullstack/page/cityList.dart';
import 'package:fullstack/page/home.dart';
import 'package:fullstack/page/insertCity.dart';
import 'package:fullstack/page/query.dart';
import 'package:fullstack/page/registration.dart';
import 'package:fullstack/util/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme().createTheme(),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const Home(),
        '/consulta': (context) => const Query(),
        '/cadastro': (context) => const Registration(),
        '/cadastra-cidade': (context) => const InsertCity(),
        '/lista-cidades': (context) => const CityList(),
      },
    );
  }
}
