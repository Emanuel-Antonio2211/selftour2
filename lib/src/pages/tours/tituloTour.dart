import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:selftourapp/src/pages/tours/descripcion_tour.dart';

class TituloTour extends StatefulWidget {
  @override
  _TituloTourState createState() => _TituloTourState();
}

class _TituloTourState extends State<TituloTour> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Titulo del Tour'),
      ),
      body: ListView(
        children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SafeArea(
              child: SizedBox(height: size.height * 0.3,),
            ),
            Text('Ingresa el nombre del Tour'),
            SizedBox(height: size.height * 0.05),
            _tituloTour(),
            SizedBox(height: size.height * 0.05),
            RaisedButton(
              child: Text('Siguiente'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => DescripcionTour()
                ));
                
                
              },
            )
          ],
        ),
      ]
      ),
    );
  }

  Widget _tituloTour() {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.0),
        //color: Colors.greenAccent
      ),
      width: size.width * 0.7,
      //height: size.height * 0.1,
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Título del Tour',
        ),
      ),
    );
  }
}
