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
    int _selectedIndex = 0;

    home() {
      Navigator.of(context).pushReplacementNamed('/home');
    }

    insertClient() {
      Navigator.of(context).pushReplacementNamed('/cadastrar-cliente');
    }

    listClients() {
      Navigator.of(context).pushReplacementNamed('/lista-de-clientes');
    }

    insertCity() {
      Navigator.of(context).pushReplacementNamed('/cadastra-cidade');
    }

    listCities() {
      Navigator.of(context).pushReplacementNamed('/lista-de-cidades');
    }

    return Scaffold(
      appBar: Components()
          .createAppBar("CityClient Creator", home, insertClient, insertCity),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 20,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Lista de Clientes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city),
            label: 'Lista de Cidades',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 0, 85, 255),
        onTap: (int index) {
          switch (index) {
            case 0:
              home();
              break;
            case 1:
              listClients();
              break;
            case 2:
              listCities();
              break;
          }
          setState(
            () {
              _selectedIndex = index;
            },
          );
        },
      ),
      body: Form(
          key: formController,
          child: Column(
            children: [
              Image.asset(
                'lib/assets/crud_icon.png',
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Components().createText(
                    'Bem vindo a versão 1.0 de CRUD completo de clientes e cidades!'),
              ),
            ],
          )),
    );
  }
}
