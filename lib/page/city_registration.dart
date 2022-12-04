import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fullstack/api/access_api.dart';
import 'package:fullstack/model/city_model.dart';
import 'package:fullstack/util/components.dart';

class CityRegistration extends StatefulWidget {
  const CityRegistration({Key? key}) : super(key: key);

  @override
  State<CityRegistration> createState() => _CityRegistrationState();
}

class _CityRegistrationState extends State<CityRegistration> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtCity = TextEditingController();
  TextEditingController txtUf = TextEditingController();

  @override
  Widget build(BuildContext context) {
    dynamic args = {};
    if (ModalRoute.of(context)?.settings.arguments != null) {
      args = ModalRoute.of(context)?.settings.arguments as CityModel;
      if (args.id > -1) {
        txtCity.text = args.name;
        txtUf.text = args.uf;
      }
    }

    register() {
      CityModel c = CityModel(0, txtCity.text, txtUf.text);
      AccessApi().insertCity(c.toJson());
      Navigator.of(context).pushReplacementNamed('/lista-de-cidades');
    }

    edit() {
      CityModel c = CityModel(args.id, txtCity.text, txtUf.text);
      AccessApi().editCity(c.toJson(), "${c.id}");
      Navigator.of(context).pushReplacementNamed('/lista-de-cidades');
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
      appBar: Components().createAppBar(
          "CityClient Creator", home, insertClient, insertCity),
      body: Form(
          key: formController,
          child: Column(
            children: [
              if (args is! CityModel) ...[
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
