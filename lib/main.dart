import 'package:flutter/material.dart';
import 'package:fullstack/page/city_list.dart';
import 'package:fullstack/page/home.dart';
import 'package:fullstack/page/city_registration.dart';
import 'package:fullstack/page/client_list.dart';
import 'package:fullstack/page/client_registration.dart';
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
        '/cadastrar-cliente': (context) => const ClientRegistration(),
        '/lista-de-clientes': (context) => const ClientList(),
        '/cadastra-cidade': (context) => const CityRegistration(),
        '/lista-de-cidades': (context) => const CityList(),
      },
    );
  }
}