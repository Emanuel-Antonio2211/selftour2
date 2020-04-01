import 'package:flutter/material.dart';

class CompraTourPage extends StatefulWidget {
  @override
  _CompraTourPageState createState() => _CompraTourPageState();
}

class _CompraTourPageState extends State<CompraTourPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proceso de Compra de Tour'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('Confirmar Compra'),
            RaisedButton(
              child: Text('Enviar'),
              onPressed: (){
                
              },
            )
          ],
        ),
      )
    );
  }
}