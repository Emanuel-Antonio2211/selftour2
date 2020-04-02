import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:selfttour/src/pages/tours/categoria_tour.dart';
//import 'package:selfttour/src/pages/tours/pais_tour.dart';
//import 'package:selfttour/src/pages/tours/tituloTour.dart';

class CreateTourStep extends StatefulWidget {
  @override
  _CreateTourStepState createState() => _CreateTourStepState();
}

class _CreateTourStepState extends State<CreateTourStep> {
   final controller = PageController(
      initialPage: 1
    );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Creando un Tour',textAlign: TextAlign.center,),
      ),
      body: _pageView()
    );
      /*PageSlider(
        initialPage: 0,
        hidePaginationIndexer: false,
        disableSWiping: false,
        hideSliderIndicator: false,
        sliderIndicatorPosition: SliderIndicatorPosition.BOTTOM,
        overlaySliderIndicator: false,
        onPageChanged: (page) => print("page $page"),
        reverse: false,
        scrollDirection: Axis.horizontal,
        widgets: <Widget>[
          _tituloTour(),
          _descripcionTour(),
          _imagenesTour(),
          _botoncrearTour()
        ],
      ),
    );*/
  }

  Widget _pageView(){
    final pageview = PageView(
      controller: controller,
      children: <Widget>[
        _tituloTour(),
        _descripcionTour(),
        _imagenesTour(),
        _botoncrearTour()
      ],
    );
    return pageview;
  }

  Widget _tituloTour() {
    final size = MediaQuery.of(context).size;
    return Stack(
      children:<Widget>[ 
      ListView(
        shrinkWrap: true,
        children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: size.width * 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SafeArea(
                child: SizedBox(
                  height: size.height * 0.1,
                ),
              ),
              Text('Ingresa el nombre del Tour'),
              SizedBox(height: size.height * 0.05),
              Container(
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
              ),
              SizedBox(height: size.height * 0.05),
              _categoriaTour(),
              SizedBox(height: size.height * 0.05),
              _pais(),
              SizedBox(height: size.height * 0.05),
              _estado(),
              SizedBox(height: size.height * 0.05),
              _ciudad()
            ],
          ),
        ),
       ]
      ),
      Positioned(
        top: size.height * 0.4,
        left: size.width * 0.9,
        child: Icon(
          Icons.keyboard_arrow_right,
          size: 30.0,
          )
        )
      ]
    );
  }

  Widget _descripcionTour() {
    final size = MediaQuery.of(context).size;
    return Stack(
      children:<Widget>[ 
      ListView(
        shrinkWrap: true,
        children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SafeArea(
              child: SizedBox(
                height: size.height * 0.04,
              ),
            ),
            Text('Ingresa una descripcion'),
            SizedBox(height: size.height * 0.05),
            Container(
                width: size.width * 0.8,
                //height: size.height * 0.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(width: 0.5)),
                child: TextField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    labelText: 'Descripción del Tour',
                  ),
                )
              ),
            SizedBox(height: size.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(
                  Icons.keyboard_arrow_right,
                  size: 30.0,
                ),
              ],
            )
          ],
        )
        ]
        ),
      ]
    );
  }

  Widget _categoriaTour(){
    String dropdownValue = 'Elige una categoria';
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        //Text('Elige una Categoria del Tour'),
        //SizedBox(height: size.height * 0.05,),
        Container(
          width: size.width * 0.7,
          child: DropdownButton(
              isExpanded: true,
              value: dropdownValue,
              onChanged: (String value) {
                setState(() {
                  dropdownValue = value;
                });
              },
              items: <String>['Elige una categoria', 'One', 'Two', 'Free', 'Four']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList()),
        ),
      ],
    );
  }

  /*Widget _ubicacionTour(){
    final size = MediaQuery.of(context).size;
    return ListView(children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SafeArea(
              child: SizedBox(height: size.height * 0.2,),
            ),
            Text('Ubicacion del Tour'),
            SizedBox(height: size.height * 0.05,),
            _pais(),
             SizedBox(height: size.height * 0.05),
            _estado(),
            SizedBox(height: size.height * 0.05),
            _ciudad(),
            SizedBox(height: size.height * 0.05),
            
          ],
        ),
      ]);
  }*/
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

  Widget _imagenesTour(){
    final size = MediaQuery.of(context).size;
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           SafeArea(
              child: SizedBox(height: size.height * 0.2,),
            ),
          Text('Ingresa las Fotos o imagenes del tour'),
          SizedBox(height: size.height * 0.05),
          _imagenTour(),
          SizedBox(height: size.height * 0.05),
         _cargarImagen()
        ],
      )
    ]
    );
  }

  Widget _imagenTour() {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      child: IconButton(
        tooltip: 'Por favor ingrese una Foto',
        iconSize: 90.0,
        icon: Icon(
          Icons.add_a_photo,
          color: Colors.indigo,
        ),
        onPressed: () {},
      ),
    );
  }
  Widget _cargarImagen(){
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      child: IconButton(
        tooltip: 'Por favor ingrese una imagen',
        iconSize: 90.0,
        icon: Icon(
          Icons.add_photo_alternate,
          color: Colors.indigo,
        ),
        onPressed: () {},
      ),
    );
  }

  Widget _botoncrearTour(){
    final size = MediaQuery.of(context).size;
    return ListView(children:<Widget>[ 
        Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SafeArea(
              child: SizedBox(height: size.height * 0.35,),
            ),
          Text('Confirmar crear Tour'),
          SizedBox(height: size.height * 0.05,),
          _crearTour(),
        ],
      )]);
  }
  Widget _crearTour() {
    final size = MediaQuery.of(context).size;
    return Container(
      
      width: size.width * 0.4,
      //height: size.height * 0.05,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
          //shape: BoxShape.circle
          
      ),
      child: RaisedButton(
        color: Colors.greenAccent,
        child: Text('Crear Tour'),
        onPressed: () {},
        //shape: Border.all(width: 1.0),
      ),
    );
  }
}
