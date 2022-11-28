import 'package:flutter/material.dart';

enum GenderEnum { masculino, feminino }

class GenderRadioOptions extends StatefulWidget {
  final TextEditingController? controller;

  const GenderRadioOptions({Key? key, this.controller}) : super(key: key);

  @override
  State<GenderRadioOptions> createState() => _GenderRadioOptionsState();
}

class _GenderRadioOptionsState extends State<GenderRadioOptions> {
  GenderEnum? _choice = GenderEnum.masculino;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            title: const Text('Masculino'),
            leading: Radio<GenderEnum>(
              value: GenderEnum.masculino,
              groupValue: _choice,
              onChanged: (GenderEnum? value) {
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
            leading: Radio<GenderEnum>(
              value: GenderEnum.feminino,
              groupValue: _choice,
              onChanged: (GenderEnum? value) {
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
