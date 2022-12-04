import 'package:flutter/material.dart';
import 'package:nice_intro/intro_screen.dart';
import 'package:nice_intro/intro_screens.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screens = IntroScreens(
      onDone: () => Navigator.of(context).pushReplacementNamed('/home'),
      onSkip: () => Navigator.of(context).pushReplacementNamed('/home'),
      footerBgColor: Colors.blue,
      activeDotColor: Colors.white,
      footerRadius: 128.0,
      indicatorType: IndicatorType.CIRCLE,
      appTitle: 'CityClient Creator',
      skipText: 'pular',
      slides: [
        IntroScreen(
          title: 'Bem vindo',
          imageAsset: 'lib/assets/welcome_icon.png',
          description:
              'Seja bem vindo ao aplicativo feito no curso DEVTI Unisul!',
          headerBgColor: Colors.white,
        ),
        IntroScreen(
          title: 'CRUD',
          headerBgColor: Colors.white,
          imageAsset: 'lib/assets/crud_icon.png',
          description:
              'Nesse aplicativo você poderá inserir, atualizar e deletar cidades e clientes!',
        ),
      ],
    );

    return Scaffold(
      body: screens,
    );
  }
}
