import 'package:flutter/material.dart';

class CategoriaTour extends StatefulWidget {
  @override
  _CategoriaTourState createState() => _CategoriaTourState();
}

class _CategoriaTourState extends State<CategoriaTour> {
  String dropdownValue = 'Elige una ciudad';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _categoria(),
    );
  }

  Widget _categoria() {
    String dropdownValue = 'Elige una ciudad';
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.7,
      child: DropdownButton(
          isExpanded: true,
          value: dropdownValue,
          onChanged: (String value) {
            setState(() {
              dropdownValue = value;
            });
          },
          items: <String>['Elige una ciudad', 'One', 'Two', 'Free', 'Four']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text('Elige una categoria'),
            );
          }).toList()),
    );
  }
}