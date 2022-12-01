import 'package:flutter/material.dart';
import 'package:fullstack/api/access_api.dart';
import 'package:fullstack/model/client_model.dart';
import 'package:fullstack/util/components.dart';

class ClientList extends StatefulWidget {
  const ClientList({super.key});

  @override
  State<ClientList> createState() => _ClientListState();
}

class _ClientListState extends State<ClientList> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  List<ClientModel> list = [];
  TextEditingController txtCity = TextEditingController();
  bool checkSpecialField = false;

  listAll() async {
    List<ClientModel> clients = await AccessApi().listClients();
    setState(() {
      list = clients;
    });
  }

  void initState() {
    super.initState();
    listAll();
  }

  @override
  Widget build(BuildContext context) {
    home() {
      Navigator.of(context).pushReplacementNamed('/home');
    }

    listClientsByCity() async {
      if (txtCity.text != '') {
        List<ClientModel> clients =
            await AccessApi().listClientsByCity(txtCity.text);
        setState(() {
          list = clients;
        });
      }
    }

    deleteClient(String id) async {
      await AccessApi().deleteClient(id);
      await listAll();
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

    editClient(ClientModel c) {
      Navigator.of(context).pushReplacementNamed('/cadastrar-cliente', arguments: c);
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
                          "Cidade",
                          txtCity,
                          "Informe a cidade",
                          notifyChange)),
                  Expanded(
                    child: Components().createDynamicButton(
                        formController,
                        listClientsByCity,
                        "Listar por cidade",
                        checkSpecialField),
                  )
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
                      child: Components().createItemClient(
                          list[index], editClient, deleteClient, context),
                    );
                  },
                ),
              ))
            ],
          )),
    );
  }
}
