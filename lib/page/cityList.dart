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
      List<City> cities = await AccessApi().listCitiesByUf(txtUf.text);
      setState(() {
        list = cities;
      });
    }

    deleteCity(String id) async {
      await AccessApi().deleteCity(id);
      await listAll();
    }

    editCity(City c) {
      Navigator.of(context)
          .pushReplacementNamed('/cadastra-cidade', arguments: c);
    }

    return Scaffold(
      appBar: Components().createAppBar("Utilização de API", home),
      body: Form(
          key: formController,
          child: Column(
            children: [
              Components()
                  .createButton(formController, listAll, "Listar todos"),
              Components().createButton(
                  formController, listCityByUf, "Listar cidade por uf"),
              Components().createTextInput(
                  TextInputType.text, "Uf", txtUf, "Informe o estado"),
              Expanded(
                  child: Container(
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 6,
                      margin: const EdgeInsets.all(20),
                      child: Components()
                          .createItemCity(list[index], editCity, deleteCity),
                    );
                  },
                ),
              ))
            ],
          )),
    );
  }
}
