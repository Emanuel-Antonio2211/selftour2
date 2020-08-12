import 'dart:async';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:selftourapp/src/googlemaps/states/app_state.dart';
import 'package:selftourapp/src/models/tour_categoria_model.dart';
import 'package:selftourapp/src/providers/categorias_providers.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';
import 'package:selftourapp/src/utils/utils.dart';
import 'package:selftourapp/src/widgets/tree_size_dot_widget.dart';

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
  //Set<Marker> _marcadores = {};

  LatLng position;
  double radio;
  double zoom;
  int selectItem = 0;

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

    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          height: size.height * 0.057,
          child: Image.asset(
            'assets/iconoapp/selftouricon.png',
          ),
        ),
        centerTitle: false,
        elevation: 0.0,
      ),*/
      body: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target:  LatLng(appState.initialPosition.latitude, appState.initialPosition.longitude),// 20.97,-89.62  sitios[0].latitude, sitios[0].longitude appState.initialPosition.latitude,appState.initialPosition.longitude
              zoom: radio == null ? 7.0 : radio
            ),
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);


            },
            onCameraMove: (CameraPosition posicion){
              position = posicion.target;
              zoom = posicion.zoom;
              radio = 256 * 100 / math.pow(2, posicion.zoom); //6378137
              
              //print(radio);
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
            child: ProgressButton(
              defaultWidget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(
                    Icons.place,
                    color: Colors.white
                  ),
                  Text(
                    '$lugarCercano',
                    style: TextStyle(
                      fontFamily: 'Point-SemiBold',
                      color: Colors.white
                    ),
                    
                  ),
                ],
              ),
              animate: false,
              progressWidget: ThreeSizeDot(),
              width: size.width * 0.5,
              borderRadius: 5.0,
              color: Color(0xFFD62250),
              onPressed: ()async{
                await Future.delayed(Duration(seconds: 2),()async{
                  setState(() {
                  
                  });
                  places.clear();
                // sitios.clear();
                  marcadores.clear();
                  //sites.clear();
                  try{
                    places = await categoriasProvider.nearBySearch(position.latitude ,position.longitude, radio == null ? 30.0 : radio);
                    if(places.length == 0){
                      mostrarMensaje(context, '$noregistros', '');
                    }else{
                      for(int i = 0; i < places.length; i++){

                        setState(() {
                          
                        });

                        marcadores.addAll(
                          [
                          Marker(
                            visible: true,
                            markerId: MarkerId('${places[i].title}'),//'${places[i].title}'
                            position: LatLng(places[i].lat, places[i].lng),
                            infoWindow: InfoWindow(
                              title: '\$ ${double.parse(places[i].price.toString()).toString()}',
                              onTap: (){
                                Navigator.pushNamed(context, '/detalletour',arguments: places[i]);
                              }
                            ),
                            icon: BitmapDescriptor.defaultMarker,
                            
                          )
                          ]
                        );
                        Uint8List markerIcon = await getBytesFromCanvas(50, 20,"${(i+1).toString()}");//places[i].title
                          marcadores.add(
                            Marker(
                              visible: true,
                              markerId: MarkerId("${places[i].idtour}"),//${places[index].title}
                              position: LatLng(places[i].lat, places[i].lng),
                              icon: BitmapDescriptor.fromBytes(markerIcon)
                            )
                          );
                      }
                    }
                  }catch(e){
                    mostrarMensaje(context, '$nocoordenadas', '');
                  }
                });
                
              },
            )
            
            
           /* FloatingActionButton.extended(
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
             places = await categoriasProvider.nearBySearch(position.latitude ,position.longitude, zoom == null ? 30.0 : zoom);
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
                     markerId: MarkerId('${places[i].idtour}'),
                     position: LatLng(places[i].lat, places[i].lng),
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
            ),*/
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SingleChildScrollView(
              child: Container(
                width: size.width * 1.0,
                height: size.height * 0.3,
                child: 
                
                PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  itemCount: places.length,
                  onPageChanged: (index){
                    
                    setState((){
                      selectItem = index;
                      // _acercar(places[index].lat,places[index].lng, zoom);
                      _controller.future.then((result)async{

                        result.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                          target: LatLng(places[selectItem].lat,places[selectItem].lng),
                          zoom: zoom
                        )));

                      });
                      
                    });
                   
                  
                  },
                  itemBuilder: (BuildContext context,int index){
                    return lugares(places[index], index);
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


  List<Widget> lugaresTour( BuildContext context, List<InfoTour> tour){
    final size = MediaQuery.of(context).size;
   return tour.map((tourMap){
      return GestureDetector(
        onTap: (){
          
          Navigator.pushNamed(context, '/detalletour',arguments: tour);
        },
        child: Card(
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(topRight: Radius.circular(5.0),topLeft: Radius.circular(5.0) ),
                child: CachedNetworkImage(
                  imageUrl: tourMap.url,
                  fit: BoxFit.fill,
                  width: size.width * 0.9,
                  height: size.height * 0.18,
                ),
              ),
              Container(
                //alignment: Alignment.center,
                //width: size.width * 0.4,
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                height: size.height * 0.1,
                child: Text(
                  tourMap.title,
                  style: TextStyle(
                    fontFamily: 'Point-SemiBold'
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }


  Widget lugares(InfoTour tour, int i){
    final size = MediaQuery.of(context).size;
    
    return GestureDetector(
      onTap: (){
        
        Navigator.pushNamed(context, '/detalletour',arguments: tour);
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(topRight: Radius.circular(5.0),topLeft: Radius.circular(5.0) ),
              child: CachedNetworkImage(
                imageUrl: tour.url,
                fit: BoxFit.fill,
                width: size.width * 0.9,
                height: size.height * 0.2,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              //alignment: Alignment.center,
              //width: size.width * 0.4,
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              height: size.height * 0.1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: size.width * 0.8,
                    child: Text(
                      "${(i+1)}. ${tour.title}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Point-SemiBold'
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      '\$ ${ double.parse(tour.price.toString()).toString()}',
                      style: TextStyle(
                        fontFamily: 'Point-SemiBold',
                        color: Colors.redAccent
                      )
                    ),
                  )
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }

  /*Future<void> _acercar(double lat,double lng, double zoomCamara)async{
    final  controller = await _controller.future;
    
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, lng),
      zoom: zoomCamara
    )));
    
    //position = LatLng(lat, lng);
  }*/
  Future<void> irAlSitioCercano(double lat,double lng)async{
    final  controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, lng),
      zoom: 18.0
    )));
    
    //position = LatLng(lat, lng);
  }
  /*Future<void> _centrar(double lat, double lng)async{
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, lng),
      zoom: 7.0
    )));
   // position = LatLng(lat, lng);
  }*/

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
    TextPainter painter = TextPainter(
      textAlign: TextAlign.start,
      //textDirection: TextDirection.,
      ellipsis: text
    );
    painter.text = TextSpan(
      text: '$text',
      style: TextStyle(
        fontFamily: 'Point-SemiBold',
        fontSize: 10.0, 
        color: Colors.white,
      ), 
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