import 'package:flutter/material.dart';
import 'package:fullstack/api/access_api.dart';
import 'package:fullstack/model/clientt.dart';
import 'package:fullstack/util/components.dart';

class Query extends StatefulWidget {
  const Query({super.key});

  @override
  State<Query> createState() => _QueryState();
}

class _QueryState extends State<Query> {
  GlobalKey<FormState> formController = GlobalKey<FormState>();
  List<Clientt> list = [];
  TextEditingController txtCity = TextEditingController();

  listAll() async {
    List<Clientt> clients = await AccessApi().listClients();
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
      List<Clientt> clients = await AccessApi().listClientsByCity(txtCity.text);
      setState(() {
        list = clients;
      });
    }

    deleteClient(String id) async {
      await AccessApi().deleteClient(id);
      await listAll();
    }

    editClient(Clientt c) {
      Navigator.of(context).pushReplacementNamed('/cadastro', arguments: c);
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
                  formController, listClientsByCity, "Listar por cidade"),
              Components().createTextInput(
                  TextInputType.text, "Cidade", txtCity, "Informe a cidade"),
              Expanded(
                  child: Container(
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 6,
                      margin: const EdgeInsets.all(20),
                      child: Components().createItemClient(
                          list[index], editClient, deleteClient),
                    );
                  },
                ),
              ))
            ],
          )),
    );
  }
}
