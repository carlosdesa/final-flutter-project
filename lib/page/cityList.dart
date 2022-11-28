import 'package:flutter/material.dart';
import 'package:fullstack/api/access_api.dart';
import 'package:fullstack/model/city.dart';
import 'package:fullstack/util/components.dart';

class CityList extends StatefulWidget {
  const CityList({super.key});

  @override
  State<CityList> createState() => _CityListState();
}

class _CityListState extends State<CityList> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtUf = TextEditingController();
  List<City> list = [];
  bool checkSpecialField = false;

  @override
  Widget build(BuildContext context) {
    home() {
      Navigator.of(context).pushReplacementNamed('/home');
    }

    listAll() async {
      List<City> cities = await AccessApi().listCities();
      setState(() {
        list = cities;
      });
    }

    listCityByUf() async {
      if (txtUf.text != '') {
        List<City> cities = await AccessApi().listCitiesByUf(txtUf.text);
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

    editCity(City c) {
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

    return Scaffold(
      appBar: Components().createAppBar("Utilização de API", home),
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
                      margin: const EdgeInsets.all(20),
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
