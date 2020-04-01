import 'package:flutter/material.dart';

class CiudadTour extends StatefulWidget {
  @override
  _CiudadTourState createState() => _CiudadTourState();
}

class _CiudadTourState extends State<CiudadTour> {
  String dropdownValue = 'Elige una ciudad';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ciudad(),
    );
  }
  Widget _ciudad() {
    String dropdownValue = 'Elige una ciudad';
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.7,
      child: DropdownButton<String>(
        isExpanded: true,
        value: dropdownValue,
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: <String>['Elige una ciudad', 'One', 'Two', 'Free', 'Four']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
              value: value, child: Text('Elige una ciudad'));
        }).toList(),
      ),
    );
  }
}