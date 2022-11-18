import 'package:flutter/material.dart';

enum genderEnum { masculino, feminino }

class GenderRadioOptions extends StatefulWidget {
  TextEditingController? controller;

  GenderRadioOptions({Key? key, this.controller}) : super(key: key);

  @override
  State<GenderRadioOptions> createState() => _GenderRadioOptionsState();
}

class _GenderRadioOptionsState extends State<GenderRadioOptions> {
  genderEnum? _choice = genderEnum.masculino;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            title: const Text('Masculino'),
            leading: Radio<genderEnum>(
              value: genderEnum.masculino,
              groupValue: _choice,
              onChanged: (genderEnum? value) {
                setState(() {
                  _choice = value;
                  widget.controller?.text = 'M';
                });
              },
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            title: const Text('Feminino'),
            leading: Radio<genderEnum>(
              value: genderEnum.feminino,
              groupValue: _choice,
              onChanged: (genderEnum? value) {
                setState(() {
                  _choice = value;
                  widget.controller?.text = 'F';
                });
              },
            ),
          ),
        )
      ],
    );
  }
}
