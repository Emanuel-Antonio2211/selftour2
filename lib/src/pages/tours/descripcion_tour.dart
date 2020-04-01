import 'package:flutter/material.dart';
import 'package:selftourapp/src/pages/tours/pais_tour.dart';

class DescripcionTour extends StatefulWidget {
  @override
  _DescripcionTourState createState() => _DescripcionTourState();
}

class _DescripcionTourState extends State<DescripcionTour> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Descripcion del Tour'),
      ),
      body: ListView(children: <Widget>[ 
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SafeArea(
              child: SizedBox(height: size.height * 0.2,),
            ),
            Text('Ingresa una descripcion'),
            SizedBox(height: size.height * 0.05),
            _descripcionTour(),
            SizedBox(height: size.height * 0.05),
            RaisedButton(
              child: Text('Siguiente'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => PaisTour()
                ));
              },
            )
          ],
        )]
        ),
    );
  }

  Widget _descripcionTour() {
    final size = MediaQuery.of(context).size;
    return Container(
        width: size.width * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(width: 0.5)
          ),
        child: TextField(
          maxLength: 450,
          maxLines: 5,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Descripción del Tour',
          ),
        ));
  }
}