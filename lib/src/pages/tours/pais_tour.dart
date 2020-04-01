import 'package:flutter/material.dart';
import 'package:selftourapp/src/pages/tours/imagenes_tour.dart';

class PaisTour extends StatefulWidget {
  @override
  _PaisTourState createState() => _PaisTourState();
}

class _PaisTourState extends State<PaisTour> {
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Ubicacion del Tour'),
      ),
      body: ListView(children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SafeArea(
              child: SizedBox(height: size.height * 0.2,),
            ),
            _pais(),
             SizedBox(height: size.height * 0.05),
            _estado(),
            SizedBox(height: size.height * 0.05),
            _ciudad(),
            SizedBox(height: size.height * 0.05),
            RaisedButton(
              child: Text('Siguiente'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => ImagenTour()
                ));
              },
            )
          ],
        ),
      ]),
    );
  }

  Widget _pais() {
    String dropdownValue = 'Ingrese el pais';
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
          items: <String>['Ingrese el pais','One', 'Two', 'Free', 'Four']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList()),
    );
  }

  Widget _estado() {
    String dropdownValue = 'Elige el estado';
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
          items: <String>['Elige el estado', 'One', 'Two', 'Free', 'Four']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList()),
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
              value: value, child: Text(value));
        }).toList(),
      ),
    );
  }
}
