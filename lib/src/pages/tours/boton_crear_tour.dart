import 'package:flutter/material.dart';

class BotonCrearTour extends StatefulWidget {
  @override
  _BotonCrearTourState createState() => _BotonCrearTourState();
}

class _BotonCrearTourState extends State<BotonCrearTour> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmar Tour'),
      ),
      body: ListView(children:<Widget>[ 
        Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SafeArea(
              child: SizedBox(height: size.height * 0.3,),
            ),
          _crearTour(),
        ],
      )]),
    );
  }
  Widget _crearTour() {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.4,
      decoration: BoxDecoration(
          //borderRadius: BorderRadius.circular(40.0),
          shape: BoxShape.circle),
      child: RaisedButton(
        color: Colors.greenAccent,
        child: Text('Crear Tour'),
        onPressed: () {},
        //shape: Border.all(width: 1.0),
      ),
    );
  }
}