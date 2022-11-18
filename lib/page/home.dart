import 'package:flutter/material.dart';
import 'package:fullstack/util/components.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    home() {
      Navigator.of(context).pushReplacementNamed('/home');
    }

    registration() {
      Navigator.of(context).pushReplacementNamed('/cadastro');
    }

    query() {
      Navigator.of(context).pushReplacementNamed('/consulta');
    }

    insertCity() {
      Navigator.of(context).pushReplacementNamed('/cadastra-cidade');
    }

    listCities() {
      Navigator.of(context).pushReplacementNamed('/lista-cidades');
    }

    return Scaffold(
      appBar: Components().createAppBar("Utilização de API", home),
      body: Form(
          key: formController,
          child: Column(
            children: [
              Components().createButton(formController, registration, "Cadastra cliente"),
              Components().createButton(formController, query, "Consulta cliente"),
              Components().createButton(formController, listCities, "Lista cidades"),
              Components().createButton(formController, insertCity, "Cadastra cidade"),
            ],
          )),
    );
  }
}
