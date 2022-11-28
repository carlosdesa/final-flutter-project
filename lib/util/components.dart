import 'package:flutter/material.dart';
import 'package:fullstack/model/city.dart';

import '../model/clientt.dart';

class Components {
  createAppBar(text, action) {
    return AppBar(
      title: createText(text),
      centerTitle: true,
      actions: <Widget>[
        IconButton(onPressed: action, icon: const Icon(Icons.home))
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
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontSize: 20,
          ),
        ),
        textAlign: TextAlign.left,
        style: const TextStyle(fontSize: 30),
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
                    fontSize: 20.0,
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
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }

  createItemClient(Clientt c, funcEd, funcDel) {
    String gender = c.gender == 'M' ? 'Masculino' : 'Feminino';
    return ListTile(
        minVerticalPadding: 20,
        title: createText("${c.id} - ${c.name}"),
        subtitle: createText("${c.age} anos - (${c.gender})"),
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
                      icon: Icon(Icons.edit, size: 14)),
                  IconButton(
                      onPressed: () {
                        funcDel("${c.id}");
                      },
                      icon: Icon(Icons.delete, size: 14)), // icon-2
                ],
              ),
            ),
          ],
        ));
  }

  createItemCity(City c, funcEd, funcDel, context) {
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
                      icon: Icon(Icons.edit, size: 14)),
                  IconButton(
                      onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Remover item'),
                              content: Text(
                                  'Você deseja remover a cidade de ${c.name} ?'),
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
                      icon: Icon(Icons.delete, size: 14)), // icon-2
                ],
              ),
            ),
          ],
        ));
  }
}
