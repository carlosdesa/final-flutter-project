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
  bool checkSpecialField = false;

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
      if (txtCity.text != '') {
        List<Clientt> clients =
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
