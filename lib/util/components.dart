import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fullstack/model/city_model.dart';

import '../model/client_model.dart';

class Components {
  createAppBar(text, homeAction, addClientAction, addCityAction) {
    return AppBar(
      title: createText(text),
      // centerTitle: true,
      actions: <Widget>[
        IconButton(onPressed: homeAction, icon: const Icon(Icons.home)),
        IconButton(
            onPressed: addClientAction, icon: const Icon(Icons.person_add)),
        IconButton(
            onPressed: addCityAction, icon: const Icon(Icons.add_location_alt))
      ],
    );
  }

  createText(text, [color]) {
    if (color != null) {
      return Text(
        text,
        style: TextStyle(color: color),
      );
    }
    return Text(text);
  }

  bigIcon() {
    return const Icon(
      Icons.maps_home_work_outlined,
      size: 180.00,
    );
  }

  createTextInput(keyboardType, label, controller, validationMessage) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 20),
      child: TextFormField(
        keyboardType: keyboardType,
        inputFormatters: TextInputType.number == keyboardType
            ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
            : null,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontSize: 14,
          ),
        ),
        textAlign: TextAlign.left,
        style: const TextStyle(fontSize: 20),
        controller: controller,
        validator: (value) {
          if (label != 'Uf' && label != 'Cidade' && value!.isEmpty) {
            return validationMessage;
          }
        },
      ),
    );
  }

  createDynamicTextInput(
      keyboardType, label, controller, validationMessage, notifyChange) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onChanged: ((value) => notifyChange(value)),
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontSize: 16,
          ),
        ),
        textAlign: TextAlign.left,
        style: const TextStyle(fontSize: 18),
        controller: controller,
        validator: (value) {
          if (label != 'Estado' && label != 'Cidade' && value!.isEmpty) {
            return validationMessage;
          }
        },
      ),
    );
  }

  createButton(controller, func, title) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                ),
                onPressed: () {
                  if (controller.currentState!.validate()) {
                    func();
                  }
                },
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ))
      ],
    );
  }

  createDynamicButton(controller, func, title, condition) {
    enabled() {
      if (controller.currentState!.validate()) {
        func();
      }
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
        ),
        onPressed: condition ? enabled : null,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }

  createItemClient(ClientModel c, funcEd, funcDel, context) {
    String gender = c.gender == 'M' ? 'Masculino' : 'Feminino';
    return ListTile(
        minVerticalPadding: 20,
        title: createText("${c.id} - ${c.name}"),
        subtitle: createText("${c.age} anos - ($gender)"),
        trailing: Column(
          children: [
            Expanded(
              flex: 0,
              child: createText("${c.city.name}/${c.city.uf}"),
            ),
            Expanded(
              flex: 1,
              child: Wrap(
                spacing: 4, // space between two icons
                children: <Widget>[
                  IconButton(
                      onPressed: () {
                        funcEd(c);
                      },
                      icon: const Icon(Icons.edit, size: 14)),
                  // IconButton(
                  //     onPressed: () {
                  //       funcDel("${c.id}");
                  //     },
                  //     icon: const Icon(Icons.delete, size: 14)), // icon-2
                  IconButton(
                      onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Remover item'),
                              content: Text(
                                  'Voc?? deseja remover o cliente ${c.name} ?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancelar'),
                                  child: const Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () => {
                                    Navigator.pop(context, 'OK'),
                                    funcDel("${c.id}")
                                  },
                                  child: const Text('Sim'),
                                ),
                              ],
                            ),
                          ),
                      icon: const Icon(Icons.delete, size: 14)), // icon-2
                ],
              ),
            ),
          ],
        ));
  }

  createItemCity(CityModel c, funcEd, funcDel, context) {
    return ListTile(
        minVerticalPadding: 20,
        title: createText("${c.id}"),
        subtitle: createText("${c.name} - (${c.uf})"),
        trailing: Column(
          children: [
            Expanded(
              flex: 1,
              child: Wrap(
                spacing: 4, // space between two icons
                children: <Widget>[
                  IconButton(
                      onPressed: () {
                        funcEd(c);
                      },
                      icon: const Icon(Icons.edit, size: 14)),
                  IconButton(
                      onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Remover item'),
                              content: Text(
                                  'Voc?? deseja remover a cidade de ${c.name} ?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancelar'),
                                  child: const Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () => {
                                    Navigator.pop(context, 'OK'),
                                    funcDel("${c.id}")
                                  },
                                  child: const Text('Sim'),
                                ),
                              ],
                            ),
                          ),
                      icon: const Icon(Icons.delete, size: 14)), // icon-2
                ],
              ),
            ),
          ],
        ));
  }
}
