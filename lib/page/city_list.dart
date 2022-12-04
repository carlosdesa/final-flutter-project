import 'package:flutter/material.dart';
import 'package:fullstack/api/access_api.dart';
import 'package:fullstack/model/city_model.dart';
import 'package:fullstack/util/components.dart';

class CityList extends StatefulWidget {
  const CityList({super.key});

  @override
  State<CityList> createState() => _CityListState();
}

class _CityListState extends State<CityList> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtUf = TextEditingController();
  List<CityModel> list = [];
  bool checkSpecialField = false;

  listAll() async {
    List<CityModel> cities = await AccessApi().listCities();
    setState(() {
      list = cities;
    });
  }

  void initState() {
    super.initState();
    listAll();
  }

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 2;
    listCityByUf() async {
      if (txtUf.text != '') {
        List<CityModel> cities = await AccessApi().listCitiesByUf(txtUf.text);
        setState(() {
          list = cities;
        });
      }
    }

    alert(String responseMessage) async {
      await showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Erro!'),
          content: Text(responseMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () => {
                Navigator.pop(context, 'OK'),
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    }

    deleteCity(String id) async {
      String responseMessage = await AccessApi().deleteCity(id);
      if (responseMessage.length > 0) {
        await alert(responseMessage);
      }
      await listAll();
    }

    editCity(CityModel c) {
      Navigator.of(context)
          .pushReplacementNamed('/cadastra-cidade', arguments: c);
    }

    notifyChange(String value) {
      if (value != '') {
        setState(() {
          checkSpecialField = true;
        });
      } else {
        setState(() {
          checkSpecialField = false;
        });
      }
    }

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
              Components()
                  .createButton(formController, listAll, "Listar todos"),
              Row(
                children: [
                  Expanded(
                      child: Components().createDynamicTextInput(
                          TextInputType.text,
                          "Estado",
                          txtUf,
                          "Informe o estado",
                          notifyChange)),
                  Expanded(
                    child: Components().createDynamicButton(formController,
                        listCityByUf, "Listar por uf", checkSpecialField),
                  ),
                ],
              ),
              Expanded(
                  child: Container(
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 6,
                      margin: const EdgeInsets.only(bottom: 5, top: 5, left: 10, right: 10),
                      child: Components().createItemCity(
                          list[index], editCity, deleteCity, context),
                    );
                  },
                ),
              ))
            ],
          )),
    );
  }
}
