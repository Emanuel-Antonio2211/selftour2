import 'dart:async';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:selftourapp/src/googlemaps/states/app_state.dart';
import 'package:selftourapp/src/models/tour_categoria_model.dart';
import 'package:selftourapp/src/providers/categorias_providers.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';
import 'package:selftourapp/src/utils/utils.dart';

class ToursMapaPage extends StatefulWidget {
  @override
  _ToursMapaPageState createState() => _ToursMapaPageState();
}

class _ToursMapaPageState extends State<ToursMapaPage> {
  CategoriasProvider categoriasProvider = CategoriasProvider();
  final Completer<GoogleMapController> _controller = Completer();
  
  //final ScrollController scrollController = ScrollController();
  final _pageController = new PageController(
    initialPage: 0,
    //cuantos elementos van a aparecer en pantalla
    viewportFraction: 0.8
  ); 
  var currentPageValue = 0.0;
  List<LatLng> sitios = List();
  List<InfoTour> places = List();
  List<Marker> marcadores = List();
  Set<Marker> _marcadores = {};

  LatLng position;
  double zoom;

  @override
  void initState() { 
    
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    //20.9333, -89.0167  20.97,-89.62 appState.initialPosition.latitude,appState.initialPosition.longitude
    AppState appState = Provider.of<AppState>(context);
    String nocoordenadas = AppTranslations.of(context).text('title_nocoordenadas');
    String noregistros = AppTranslations.of(context).text('title_noregistros');
    String lugarCercano = AppTranslations.of(context).text('title_lugares_cercanos');
    /*

    GoogleMap(
      initialCameraPosition: CameraPosition(
        target:  LatLng(20.97,-89.62),//sitios[0].latitude, sitios[0].longitude appState.initialPosition.latitude,appState.initialPosition.longitude
        zoom: 7.0
      ),
      onMapCreated: (GoogleMapController controller){
        _controller.complete(controller);

      },
      onCameraMove: (CameraPosition posicion){
        position = posicion.target;
        zoom = posicion.zoom; //6378137
        print("Posicion: $posicion");
        print("Zoom: $zoom");
      },
      mapType: MapType.normal,
      compassEnabled: true,
      markers: marcadores,
      rotateGesturesEnabled: true,
      scrollGesturesEnabled: true,
      myLocationEnabled: true,
      zoomGesturesEnabled: true,
      tiltGesturesEnabled: true,
    ),

    */


    /*

    Align(
      alignment: Alignment.topCenter,
      child: FloatingActionButton.extended(
        label: Text('Near Place'),
        icon: Icon(Icons.place),
        onPressed: ()async{
          places.clear();
          sitios.clear();
          marcadores.clear();
          
        //sites.clear();
        await categoriasProvider.nearBySearch( position.latitude,position.longitude, 0.230).then((results){
          for(int i = 0; i < results.length; i++){
            marcadores.clear();
            places.clear();
            places.add(
              results[i]
            );
            sitios.add(
              LatLng(places[i].latitude, places[i].longitude)
            );
            marcadores.add(
              Marker(
                markerId: MarkerId('${places[i].idtour}'),
                position: sitios[i],
                infoWindow: InfoWindow(
                  title: '${places[i].title_route}'
                ),
                icon: BitmapDescriptor.defaultMarker
              )
            );
          }
        });

        for(int i = 0; i < places.length; i++){
          print("Ejemplo");
          print(places[i].title_route);
        }
        },
      ),
    ),

    */


    /*
    Align(
      alignment: Alignment.bottomRight,
      child: SingleChildScrollView(
        child: Container(
          width: size.width * 1.0,
          height: size.height * 0.1,
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: _pageController,
            itemCount: places.length,
            itemBuilder: (context,index){
              if(places == null){
                return CircularProgressIndicator();
              }
              return lugares(places[index]);
            },
          ),
        ),
      ),
    ),

    */

    /*

    Align(
        alignment: Alignment.centerRight,
        child: FloatingActionButton(
          child: Icon(Icons.place),
          onPressed: (){
            _centrar(sitios[0].latitude,sitios[0].longitude);
          },
        ),
      )

    */

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          height: size.height * 0.057,
          child: Image.asset(
            'assets/iconoapp/selftouricon.png',
          ),
        ),
        centerTitle: false,
        elevation: 0.0,
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target:  LatLng(20.97,-89.62),//sitios[0].latitude, sitios[0].longitude appState.initialPosition.latitude,appState.initialPosition.longitude
              zoom: zoom == null ? 7.0 : zoom
            ),
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);


            },
            onCameraMove: (CameraPosition posicion){
              position = posicion.target;
              zoom = 256 * 100 / math.pow(2, posicion.zoom); //6378137
              
              print(zoom);
            },
            mapType: MapType.normal,
            compassEnabled: true,
            markers: marcadores.toSet(),
            rotateGesturesEnabled: true,
            scrollGesturesEnabled: true,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            tiltGesturesEnabled: true,
          ),

          Align(
            alignment: Alignment.topCenter,
            child: FloatingActionButton.extended(
              label: Text('$lugarCercano',style: TextStyle(fontFamily: 'Point-SemiBold'),),
              icon: Icon(Icons.place),
              onPressed: ()async{
                setState(() {
                  
                });
               places.clear();
               // sitios.clear();
                marcadores.clear();
              //sites.clear();
              try{
             places = await categoriasProvider.nearBySearch( position.latitude ,position.longitude, zoom == null ? 30.0 : zoom);
             if(places.length == 0){
               mostrarMensaje(context, '$noregistros', '');
             }
               for(int i = 0; i < places.length; i++){

                 setState(() {
                   
                 });

                 marcadores.addAll(
                   [
                   Marker(
                     visible: true,
                     markerId: MarkerId('${places[i].idroute}'),
                     position: LatLng(places[i].latitude, places[i].longitude),
                     infoWindow: InfoWindow(
                       title: '${places[i].title}'
                     ),
                     icon: BitmapDescriptor.defaultMarker
                   )
                   ]
                 );

               }
               }catch(e){
                 mostrarMensaje(context, '$nocoordenadas', '');
               }
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SingleChildScrollView(
              child: Container(
                width: size.width * 1.0,
                height: size.height * 0.1,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  itemCount: places.length,
                  itemBuilder: (context,index){
                    return lugares(places[index]);
                  },
                ),
              ),
            ),
          ),
         /* Align(
            alignment: Alignment.centerRight,
            child: FloatingActionButton(
              child: Icon(Icons.place),
              onPressed: (){
                _centrar(sitios[0].latitude,sitios[0].longitude);
              },
            ),
          )*/
        ],
      )
    );
  }


  Widget lugares(InfoTour tour){
    final size = MediaQuery.of(context).size;
    
    return GestureDetector(
      onTap: ()async{
        setState(() {
          
        });
        _acercar(tour.latitude,tour.longitude);
        final Uint8List markerIcon = await getBytesFromCanvas(140, 20,'${tour.title.toString()}');
        marcadores.add(
          Marker(
            visible: true,
            markerId: MarkerId('markerId'),
            position: LatLng(tour.latitude, tour.longitude),
            icon: BitmapDescriptor.fromBytes(markerIcon)
          )
        );
      },
      child: Card(
        child: Container(
          alignment: Alignment.center,
          width: size.width * 0.4,
          height: size.height * 0.2,
          child: Text(tour.title),
        ),
      ),
    );
  }

  Future<void> _acercar(double lat,double lng)async{
    final  controller = await _controller.future;
    
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, lng),
      zoom: zoom
    )));
    
    //position = LatLng(lat, lng);
  }
  Future<void> irAlSitioCercano(double lat,double lng)async{
    final  controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, lng),
      zoom: 18.0
    )));
    
    //position = LatLng(lat, lng);
  }
  Future<void> _centrar(double lat, double lng)async{
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, lng),
      zoom: 7.0
    )));
   // position = LatLng(lat, lng);
  }

  Future<Uint8List> getBytesFromCanvas(int width, int height,String text)async{
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color = Colors.blue;
    final Radius radius = Radius.circular(20.0);
    canvas.drawRRect(
      RRect.fromRectAndCorners(Rect.fromLTWH(0.0, 0.0, width.toDouble(), height.toDouble()),
      topLeft: radius,
      topRight: radius,
      bottomLeft: radius,
      bottomRight: radius,
      ),
      paint
    );
    TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
    painter.text = TextSpan(
      text: '$text',
      style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 14.0, color: Colors.white),
    );
    painter.layout();
    painter.paint(
      canvas,
      Offset(
        (width * 0.5)- painter.width * 0.5,(height * 0.5) - painter.height * 0.5)
      );
    final img = await pictureRecorder.endRecording().toImage(width, height);
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data.buffer.asUint8List();
  }
}