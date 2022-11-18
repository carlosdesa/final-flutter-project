import 'package:flutter/material.dart';
import 'package:fullstack/api/access_api.dart';
import 'package:fullstack/model/city.dart';

class ComboBoxCity extends StatefulWidget {
  TextEditingController? controller;

  ComboBoxCity({Key? key, this.controller}) : super(key: key);

  @override
  State<ComboBoxCity> createState() => _ComboBoxCityState();
}

class _ComboBoxCityState extends State<ComboBoxCity> {
  int? city_selected;

  @override
  Widget build(BuildContext context) {
    if (widget.controller?.text != null) {
      String text = widget.controller!.text;
      if (text != '') {
        city_selected = int.parse(text);
      }
    }
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 1))
          .then((value) => AccessApi().listCities()),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          List<City> cities = snapshot.data;
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton(
                isExpanded: true,
                value: city_selected,
                icon: const Icon(Icons.arrow_downward),
                hint: const Text('Selecione sua cidade...'),
                elevation: 26,
                onChanged: (int? value) {
                  setState(() {
                    city_selected = value;
                    widget.controller?.text = "$value";
                  });
                },
                items: cities.map<DropdownMenuItem<int>>((City c) {
                  return DropdownMenuItem<int>(
                      value: c.id, child: Text(c.name));
                }).toList(),
              ));
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              Text('Carregando cidades...')
            ],
          );
        }
      },
    );
  }
}
