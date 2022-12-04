import 'package:flutter/material.dart';
import 'package:fullstack/api/access_api.dart';
import 'package:fullstack/model/city_model.dart';
import 'package:fullstack/model/client_model.dart';
import 'package:fullstack/util/combobox_city.dart';
import 'package:fullstack/util/components.dart';
import 'package:fullstack/util/gender_radio_options.dart';

class ClientRegistration extends StatefulWidget {
  const ClientRegistration({Key? key}) : super(key: key);

  @override
  State<ClientRegistration> createState() => _ClientRegistrationState();
}

class _ClientRegistrationState extends State<ClientRegistration> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtGender = TextEditingController(text: 'M');
  TextEditingController txtAge = TextEditingController();
  TextEditingController txtCity = TextEditingController();

  @override
  Widget build(BuildContext context) {
    dynamic args = {};
    if (ModalRoute.of(context)?.settings.arguments != null) {
      args = ModalRoute.of(context)?.settings.arguments as ClientModel;
      if (args.id > -1) {
        txtName.text = args.name;
        txtGender.text = args.gender;
        txtAge.text = "${args.age}";
        txtCity.text = "${args.city.id}";
      }
    }

    register() {
      ClientModel c = ClientModel(0, txtName.text, txtGender.text,
          int.parse(txtAge.text), CityModel(int.parse(txtCity.text), "", ""));
      AccessApi().insertClient(c.toJson());
      Navigator.of(context).pushReplacementNamed('/lista-de-clientes');
    }

    edit() {
      ClientModel c = ClientModel(args.id, txtName.text, txtGender.text,
          int.parse(txtAge.text), CityModel(int.parse(txtCity.text), "", ""));
      AccessApi().editClient(c.toJson(), "${c.id}");
      Navigator.of(context).pushReplacementNamed('/lista-de-clientes');
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
      body: Form(
          key: formController,
          child: Column(
            children: [
              Icon(Icons.person_add, size: 170),
              if (args is! ClientModel) ...[
                Components().createTextInput(
                    TextInputType.text, "Nome", txtName, "Informe o nome"),
                Components().createTextInput(
                    TextInputType.number, "Idade", txtAge, "Informe a idade"),
                Center(child: GenderRadioOptions(controller: txtGender)),
                Center(child: ComboBoxCity(controller: txtCity)),
                Components().createButton(formController, register, "cadastrar")
              ] else ...[
                Components().createTextInput(
                    TextInputType.text, "Nome", txtName, "Informe o nome"),
                Components().createTextInput(
                    TextInputType.number, "Idade", txtAge, "Informe a idade"),
                Center(child: GenderRadioOptions(controller: txtGender)),
                Center(child: ComboBoxCity(controller: txtCity)),
                Components().createButton(formController, edit, "Atualizar")
              ],
            ],
          )),
    );
  }
}
