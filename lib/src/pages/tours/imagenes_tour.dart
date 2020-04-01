import 'package:flutter/material.dart';
import 'package:selftourapp/src/pages/tours/boton_crear_tour.dart';

class ImagenTour extends StatefulWidget {
  @override
  _ImagenTourState createState() => _ImagenTourState();
}

class _ImagenTourState extends State<ImagenTour> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Captura de Imagenes del Tour'),
      ),
      body: ListView(children: <Widget>[
        Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           SafeArea(
              child: SizedBox(height: size.height * 0.2,),
            ),
          Text('Ingresa las Fotos o imagenes del tour'),
          SizedBox(height: size.height * 0.05),
          _imagenTour(),
          _nuevaImagen(),
          SizedBox(height: size.height * 0.05),
          RaisedButton(
              child: Text('Siguiente'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => BotonCrearTour()
                ));
              },
            )
        ],
      )
    ]
    ),
    );
  }

  Widget _imagenTour() {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      child: IconButton(
        tooltip: 'Por favor ingrese una imagen',
        iconSize: 90.0,
        icon: Icon(
          Icons.add_a_photo,
          color: Colors.indigo,
        ),
        onPressed: () {},
      ),
    );
  }
  Widget _nuevaImagen(){
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      child: IconButton(
        iconSize: 90.0,
        icon: Icon(
          Icons.add,
          color: Colors.indigo,
        ),
        onPressed: () {},
      ),
    );
  }
}
