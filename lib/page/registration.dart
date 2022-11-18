import 'package:flutter/material.dart';
import 'package:fullstack/api/access_api.dart';
import 'package:fullstack/model/city.dart';
import 'package:fullstack/model/clientt.dart';
import 'package:fullstack/util/combobox_city.dart';
import 'package:fullstack/util/components.dart';
import 'package:fullstack/util/gender_radio_options.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtGender = TextEditingController(text: 'M');
  TextEditingController txtAge = TextEditingController();
  TextEditingController txtCity = TextEditingController();

  @override
  Widget build(BuildContext context) {
    dynamic args = {};
    if (ModalRoute.of(context)?.settings.arguments != null) {
      args = ModalRoute.of(context)?.settings.arguments as Clientt;
      if (args.id > -1) {
        txtName.text = args.name;
        txtGender.text = args.gender;
        txtAge.text = "${args.age}";
        txtCity.text = "${args.city.id}";
      }
    }
    print(args is Clientt);

    register() {
      Clientt c = Clientt(0, txtName.text, txtGender.text,
          int.parse(txtAge.text), City(int.parse(txtCity.text), "", ""));
      AccessApi().insertClient(c.toJson());
      Navigator.of(context).pushReplacementNamed('/consulta');
    }

    edit() {
      Clientt c = Clientt(args.id, txtName.text, txtGender.text,
          int.parse(txtAge.text), City(int.parse(txtCity.text), "", ""));
      AccessApi().editClient(c.toJson(), "${c.id}");
      Navigator.of(context).pushReplacementNamed('/consulta');
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
              if (args is !Clientt) ...[
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
                Components().createButton(formController, edit, "editar")
              ]
            ],
          )),
    );
  }
}
