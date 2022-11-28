import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fullstack/api/access_api.dart';
import 'package:fullstack/model/city.dart';
import 'package:fullstack/util/components.dart';

class InsertCity extends StatefulWidget {
  const InsertCity({Key? key}) : super(key: key);

  @override
  State<InsertCity> createState() => _InsertCityState();
}

class _InsertCityState extends State<InsertCity> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtCity = TextEditingController();
  TextEditingController txtUf = TextEditingController();

  @override
  Widget build(BuildContext context) {
    dynamic args = {};
    if (ModalRoute.of(context)?.settings.arguments != null) {
      args = ModalRoute.of(context)?.settings.arguments as City;
      if (args.id > -1) {
        txtCity.text = args.name;
        txtUf.text = args.uf;
      }
    }

    register() {
      City c = City(0, txtCity.text, txtUf.text);
      AccessApi().insertCity(c.toJson());
      Navigator.of(context).pushReplacementNamed('/lista-cidades');
    }

    edit() {
      City c = City(args.id, txtCity.text, txtUf.text);
      AccessApi().editCity(c.toJson(), "${c.id}");
      Navigator.of(context).pushReplacementNamed('/lista-cidades');
    }

    home() {
      Navigator.of(context).pushReplacementNamed('/home');
    }

    return Scaffold(
      appBar: Components().createAppBar("Utilização de API", home),
      body: Form(
          key: formController,
          child: Column(
            children: [
              if (args is! City) ...[
                Components().createTextInput(
                    TextInputType.text, "Cidade", txtCity, "Informe a cidade"),
                Components().createTextInput(
                    TextInputType.text
                    , "UF", txtUf, "Informe a uf"),
                Components().createButton(formController, register, "cadastrar")
              ] else ...[
                Components().createTextInput(
                    TextInputType.text, "Cidade", txtCity, "Informe a cidade"),
                Components().createTextInput(
                    TextInputType.text, "UF", txtUf, "Informe a uf"),
                Components().createButton(formController, edit, "Atualizar")
              ]
            ],
          )),
    );
  }
}
