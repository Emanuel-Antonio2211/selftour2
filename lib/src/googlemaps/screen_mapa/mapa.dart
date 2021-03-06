import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
//import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_map/plugin_api.dart' as prefix0;
//import 'package:http/http.dart' as http;
import 'package:flutter_mapbox_navigation/library.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:selfttour/src/googlemaps/screen_mapa/navigator.dart';
//import 'package:provider/provider.dart';
//import 'package:selfttour/src/googlemaps/requests/google_maps_requests.dart';
import 'package:selftourapp/src/googlemaps/states/app_state.dart';
//import 'package:selfttour/src/models/detalle_tour_model.dart';
//import 'package:selfttour/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:selftourapp/src/models/tour_categoria_model.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:selftourapp/src/providers/categorias_providers.dart';
//import 'package:selfttour/src/providers/categorias_providers.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
//import 'package:polyline/polyline.dart' as polyline;

class Mapa extends StatefulWidget {
  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {

  MapboxNavigation _directions;
  bool _arrived = false;
  double _distanceRemaining, _durationRemaining;
    
  final ScrollController scrollController = ScrollController();
  final pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.67
  );
  int selectItem = 0;
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _marcadores = {};

  @override
  void initState() {
    super.initState();

    // _directions = MapboxNavigation(onRouteProgress: (arrived) async{
      
    //         _distanceRemaining = await _directions.distanceRemaining;
    //         _durationRemaining = await _directions.durationRemaining;
      
    //         setState(() {
    //           _arrived = arrived;
    //         });
    //         if(arrived)
    //           await _directions.finishNavigation();
      
    //       });

    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState()async{
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    _directions = MapboxNavigation(onRouteProgress: (arrived) async {
      _distanceRemaining = await _directions.distanceRemaining;
      _durationRemaining = await _directions.durationRemaining;

      setState(() {
        _arrived = arrived;
      });
      if (arrived)
        {
          await Future.delayed(Duration(seconds: 3));
          await _directions.finishNavigation();
        }
    });

    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await _directions.platformVersion;
    }catch(e) {
      platformVersion = 'Failed to get platform version.';
    }

    setState(() {
      platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final appState = AppState();
    String locationMap = AppTranslations.of(context).text('title_locationmap');
    //final appState =Provider.of<AppState>(context);
    //DetalleTour tour = ModalRoute.of(context).settings.arguments;
    InfoTour tour = ModalRoute.of(context).settings.arguments;
    List<LatLng> puntos = List();
    //List<LatLng> coords = List();
    String cadena = '';
    String result = '';
    //Map<String,dynamic> resp;
    List<Polyline> _polilineas = List();
    final categoriasProvider = CategoriasProvider();
    double sumaX = 0;
    double sumaY = 0;
    double posicionX = 0;
    double posicionY = 0;

    setState(() {

    });

    for(int i = 1; i < tour.route.length; i++){
      
      /*points.addAll([
        tours.route[i]['lat'],
        tours.route[i]['lng']+'|'
      ]);*/

      /*if(coords.isNotEmpty){
        coords.clear();
        coords.add(
        LatLng(double.parse(tour.route[i]['lat']),double.parse(tour.route[i]['lng']))
      
        );
      }else{
        coords.add(
        LatLng(double.parse(tour.route[i]['lat']),double.parse(tour.route[i]['lng']))
      
        );
      }*/

      /*coords.clear();

      coords.add(
        LatLng(double.parse(tour.route[i]['lat']),double.parse(tour.route[i]['lng']))
      
        );*/
      

      //print("Tamaño de la lista");
        //print(coords.length);
        //coords.removeAt(0);
        //coords.removeLast();
        //print("Nuevo tamaño de la lista");
        //print(coords.length);
      /*for(int j = 1; j < coords.length-1;j++){
        
        print("Coords");
        print(coords[j]);
        cadena = cadena + 'via:' +coords[j].latitude.toString()+'%2C'+coords[j].longitude.toString()+'%7C';
        final init = cadena.length - 3;
        result = cadena.substring(0,init);
      }*/
      
      
      //cadena = cadena + tour.route[i]['lat']+','+tour.route[i]['lng']+'|';
      cadena = cadena + 'via:' +tour.route[i]['lat']+'%2C'+tour.route[i]['lng']+'%7C';
      //cadena2 = cadena + 'via:' +tour.route[i]['lat']+'%2C'+tour.route[i]['lng']+',';
      final init = cadena.length - 3;
    
      //print(init);
      result = cadena.substring(0,init);
      
      //print(ultimoElemento);
      
    }

     /*final init2 = cadena.substring(33,195);
      print("Lista Cadena: ");
      print(cadena.length);
      print(init2);*/
   
    /*Future.sync(()async{
        resp = await categoriasProvider.waypoints(result);
        print("Respuesta api maps");
        print(resp['snappedPoints']);
        for(int i = 0; i < resp['snappedPoints'].length;i++){
          points.add(
            LatLng(resp['snappedPoints'][i]['location']['latitude'], resp['snappedPoints'][i]['location']['longitude'])
          );
        }
        
      });*/
    print("Result");
    print(result);

    /*Future<void> cargarWaypoints()async{
      resp = await categoriasProvider.waypoints(result);
      
      
      
        
    }*/


    /*print("Respuesta api maps");
        print(resp['snappedPoints']);
        for(int i = 0; i < resp['snappedPoints'].length;i++){
          points.add(
            LatLng(resp['snappedPoints'][i]['location']['latitude'], resp['snappedPoints'][i]['location']['longitude'])
          );
        }*/

    Future<void> cargarMarcadores()async{
      for(int i = 0; i < tour.route.length;i++){
        final byteData = await getBytesCanvas(80, 60, '${(i+1).toString()}');
        _marcadores.add(
          Marker(
            visible: true,
            markerId: MarkerId('${tour.route[i]['site']}'),
            position: LatLng(double.parse(tour.route[i]['lat']), double.parse(tour.route[i]['lng'])),
            infoWindow: InfoWindow(
              title: '${tour.route[i]['site']}',
              //snippet: '${tour.route[i]['site']}'
            ),
            icon: BitmapDescriptor.fromBytes(byteData)
          )
        );
      }
      
    }

   /* if(_marcadores.isEmpty){
      Future.delayed(Duration(seconds: 2),()async{
        setState(() {
          
        });
        await cargarMarcadores();
      });
    }else{
      print('Datos cargados');
    }*/
    cargarMarcadores();

    double x;
    double y;

    for(int i = 0; i< tour.route.length; i++){
      puntos.add(
        LatLng(double.parse(tour.route[i]['lat']), double.parse(tour.route[i]['lng']))
      );
      //print("$i $puntos");
    }

    for(int i = 0; i < tour.route.length; i++){
      
      _marcadores.addAll(
        [
          Marker(
            visible: true,
            markerId: MarkerId(tour.route[i]['_idsite']),
            position: LatLng(double.parse(tour.route[i]['lat']), double.parse(tour.route[i]['lng'])),
            infoWindow: InfoWindow(
              title: '${tour.route[i]['site']}',
              snippet: '${tour.route[i]['site']}'
            ),
            icon: BitmapDescriptor.defaultMarker,
          )
        ]
      );
      /*_polilineas.add(
        Polyline(
          geodesic: true,
          polylineId: PolylineId(tour.route[i]['_idsite']),
          patterns: [
            
            PatternItem.dash(20.0),
            PatternItem.dot,
            PatternItem.gap(20)
            
          ],
          //jointType: JointType.bevel,
          width: 5,
          color: Colors.red,
          points: puntos
        )
      );*/
    }

  

    setState(() {
      
    });
    //Cálculo del punto medio de entre varias coordenadas
    for(int p = 0; p < puntos.length; p++){
      sumaX = sumaX + puntos[p].latitude;
      sumaY = sumaY + puntos[p].longitude;
    }
    print("Suma lista");
    print(sumaX/puntos.length);
    print(sumaY/puntos.length);
    posicionX = sumaX/puntos.length;
    posicionY = sumaY/puntos.length;

    x = posicionX;
    y = posicionY;
   
   //Calcula el punto medio de entre dos puntos
   /* x = (puntos.first.latitude + puntos.last.latitude)/2;
    y = (puntos.first.longitude + puntos.last.longitude)/2;*/
    

  print("Media");
  print("${x.toString()}, ${y.toString()}");


  //Se evalúa si la posición inicial es nulo o todavía no se ha
  //permitido el acceso a la ubicación del usuario
  //Se mostrará un circularprogressindicator
   return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text(
            '$locationMap',
            style: TextStyle(
              fontFamily: 'Point-ExtraBold',
              color: Colors.black
            ),
          ),
        ),
        /*
        
        appState.lastPosition == null ? Center(
                child: CircularProgressIndicator(),
              ) : 
        
        */
        body: Stack(
          children: <Widget>[
            FutureBuilder(//, ${tour.route.first['site']}, ${tour.city} tour.route.first['site'] tour.route.last['site']
              future: categoriasProvider.ruta("${tour.route.first['lat']}, ${tour.route.first['lng']}", "${tour.route.first['lat']}, ${tour.route.first['lng']} ", result),
             // initialData: InitialData,
              builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot) {
                PolylinePoints polylinePoints = PolylinePoints();
                List<LatLng> pointsDecoded = List();
                final resp = snapshot.data;
                //resp['routes'][0]['legs'][0]['steps']

                if(snapshot.hasData){

                  for(int j = 0; j < tour.route.length; j++){
                    

                      final resultado = polylinePoints.decodePolyline(resp['routes'][0]['overview_polyline']['points']);
                      //final res = polyline.Polyline.Decode(encodedString: resp['routes'][i]['overview_polyline']['points'],precision: 5);
                      
                      //print("Polylinea decodificada");
                      //print(resultado);

                    // print("Polylinea decoded");
                    // print(res.decodedCoords);
                    /* for(int coord = 0; coord < res.decodedCoords.length; coord++){
                        //print(res.decodedCoords[coord][0]);
                        //print(res.decodedCoords[coord][1]);
                      /* pointsDecoded.addAll([
                          LatLng(res.decodedCoords[coord][0],res.decodedCoords[coord][1])
                        ]);*/
                      }*/
                        final resultadoSet = resultado.toSet();
                        for(int c = 0; c < resultadoSet.length; c++){
                          pointsDecoded.addAll([
                            LatLng(resultadoSet.elementAt(c).latitude,resultadoSet.elementAt(c).longitude)
                          ]);
                        }
                          _polilineas.add(
                            Polyline(
                              geodesic: false,
                              polylineId: PolylineId("${tour.route[j]['_idsite']}"),
                              /*patterns: [
                                PatternItem.dash(20.0),
                                PatternItem.dot,
                                PatternItem.gap(20)
                                
                              ],*/
                              width: 3,
                              color: Colors.blue,
                              points: pointsDecoded
                            )
                          );
                  
                      }
                    
                    print("Puntos");
                    print(pointsDecoded);
                  return GoogleMap(
                    initialCameraPosition: CameraPosition(
                    target: LatLng(x,y), 
                    zoom: puntos.length == 5 ? 8.4 : puntos.length == 2 ? 10.8 : puntos.length == 3 ? 10.8 : puntos.length == 4 ? 8.5 : puntos.length == 6 ? 9.0 : 14.3
                    ),// 11.2 double.parse(tour.route[0]['lat']), double.parse(tour.route[0]['lng'])
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },//appState.onCreated,
                    myLocationEnabled: true,
                    mapType: MapType.normal,
                    compassEnabled: true,
                    markers: _marcadores,//appState.markers
                    onCameraMove: appState.onCameraMove,
                    polylines: _polilineas.toSet(),
                    //mapToolbarEnabled: true,
                    rotateGesturesEnabled: true,
                    scrollGesturesEnabled: true,
                    zoomGesturesEnabled: true,
                    tiltGesturesEnabled: true,
                    myLocationButtonEnabled: true,
                   
                    //indoorViewEnabled: true,
                    //trafficEnabled: true,
                  );
                }else{
                  return Container();
                }
                
              },
            ),
                
              
                Align(
                  alignment: Alignment.centerRight,
                  child: FloatingActionButton(
                    backgroundColor: Color(0xFFD62250),
                    child: Icon(Icons.location_on),
                    onPressed: (){
                      _centrar(x,y,puntos);//double.parse(tour.route[0]['lat']) ,double.parse(tour.route[0]['lng']) 

                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    color: Colors.transparent,
                    width: size.width * 1.0,
                    height: size.height * 0.35,
                    child: PageView(
                      controller: pageController,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index){
                        setState(() {
                          selectItem = index;
                          _controller.future.then((result)async{
                            result.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                              target: LatLng(double.parse(tour.route[selectItem]['lat']), double.parse(tour.route[selectItem]['lng'])),
                              zoom: 14.5
                            )));

                            final Uint8List markerIcon = await getBytesFromCanvas(140, 20,'${tour.route[selectItem]['site']}');
                            _marcadores.add(
                              Marker(
                                visible: true,
                                markerId: MarkerId(tour.title.toString()),
                                position: LatLng(double.parse(tour.route[selectItem]['lat']), double.parse(tour.route[selectItem]['lng'])),
                                infoWindow: InfoWindow(
                                  title: '${tour.route[selectItem]['site']}'
                                ),
                                icon: BitmapDescriptor.fromBytes(markerIcon),
                                onTap: (){
                                  
                                }
                              )
                            );
                          });
                        });
                        
                      },
                      children: tours(context, tour),
                    )
                    
                    /*ListView(
                      //controller: scrollController,
                      physics: AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: tours(context,tour)
                    ),*/
                  ),
                ),
               /* Positioned(
                top: size.height * 0.1,
                left: size.width * 0.37,
                child: RaisedButton(
                  child: Text('Navegar'),
                  shape: StadiumBorder(),
                  textTheme: ButtonTextTheme.primary,
                  color: Colors.blue,
                  onPressed: ()async{
                    setState(() {
                      
                    });
                    final origen = Location(name: '${appState.initialPosition.toString()}',latitude: appState.initialPosition.latitude,longitude: appState.initialPosition.longitude );
                    final destino = Location(name: '${tour.route[0]['site']}',latitude: double.parse(tour.route[0]['lat']) ,longitude: double.parse(tour.route[0]['lng']) );
                    await FlutterMapboxNavigation.startNavigation(origen, destino);
                  },
                ),
              )*/
              ]
            ),
            
        
        
        /*FutureBuilder(
          future: appState.sendRequest('${tour.route[0]['site'].toString()},${tour.city.toString()}'),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(appState.lastPosition == null){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
           return 
          },
        ),*/
        
        
        

              /*Positioned(
                top: size.height * 0.01,
                right: 15.0,
                left: 15.0,
                child: Container(
                  height: 50.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(1.0, 5.0),
                          blurRadius: 10,
                          spreadRadius: 3)
                    ],
                  ),
                  child: TextField(
                    cursorColor: Colors.black,
                    controller: appState.destinationController,
                    textInputAction: TextInputAction.go,
                    onSubmitted: (value) {
                      appState.sendRequest(value);
                    },
                    decoration: InputDecoration(
                      icon: Container(
                        margin: EdgeInsets.only(left: 20, top: 5),
                        width: 10,
                        height: 10,
                        child: Icon(
                          Icons.local_taxi,
                          color: Colors.black,
                        ),
                      ),
                      hintText: "destination?",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                    ),
                  ),
                ),
              ),*/
            /*Positioned(
              top: size.height * 0.78,
              left: size.width * 0.33,
              child: RaisedButton(
                child: Text('Trazar ruta'),
                
              ),
            )*/
        );
  }

  List<Widget> tours (BuildContext context,InfoTour tour){
    final tours = tour;
    final size = MediaQuery.of(context).size;
    String navegar = AppTranslations.of(context).text('title_navegar');
    //final int targetWidth = 60;
    String verdetalle = AppTranslations.of(context).text('title_verdetalle');
    
   // final Completer<GoogleMapController> _controller = Completer();
    AppState appState = AppState();
    MarkerId markerId = MarkerId(tours.title.toString());
    InfoWindow infoWindow = InfoWindow(title: tours.title.toString());
    List<dynamic> sites = List();
    List<Widget> items = List();
    Card item;
    
    for(int j = 0; j < tour.route.length; j++){
        sites.add((j+1));//tour.route[j]['site'].toString()

      }

    for(int i = 0; i < tour.route.length; i++){
      final detalletour = tour.route[i];
      // print("Lista Tour: ");
      // print("${i+1} ${detalletour['site']}");
      item = Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: ()async{
                  _acercar(double.parse(detalletour['lat']) ,double.parse( detalletour['lng']));
                    final Uint8List markerIcon = await getBytesFromCanvas(140, 20,'${detalletour['site'].toString()}');
                    //final http.Response response = await http.get(detalletour['gallery'][0]['url'].toString());
                    //final File markerImageFile = await DefaultCacheManager().getSingleFile(imageUrl);
                  setState(() {
                    _marcadores.add(
                      Marker(
                        consumeTapEvents: true,
                        visible: true,
                        markerId: markerId,
                        position: LatLng(double.parse(detalletour['lat']), double.parse(detalletour['lng'])),
                        infoWindow: infoWindow,
                        icon: BitmapDescriptor.fromBytes(markerIcon),
                        onTap: (){
                          
                        }
                      )

                    
                    );
                    
                  });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0),topRight: Radius.circular(5.0)),
                  child: 
                  /*Image.network(
                    tour['gallery'][0]['url'].toString(),
                    width: size.width * 0.65,//size.width * 0.65
                    height: size.height * 0.2,
                    fit: BoxFit.fill,
                    scale: 1.0,
                  )*/
                  CachedNetworkImage(
                    imageUrl: "${detalletour['gallery'][0]['url'].toString()}",
                    //errorWidget: (context, url, error)=>Icon(Icons.error),
                    //cacheManager: baseCacheManager,
                    useOldImageOnUrlChange: true,
                    width: size.width * 0.65,//size.width * 0.65
                    height: size.height * 0.2,
                    fit: BoxFit.fill,
                  )
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.0,vertical: 10.0),
                child: Row(
                  children: <Widget>[
                    /*Text(
                      '${tour.toString()}. ',//tour['_idsite'].toString()
                      style: TextStyle(
                        fontFamily: 'Point-SemiBold',
                        fontSize: 11.0,
                        fontStyle: FontStyle.italic)
                    ),*/
                    //site,
                    Text(
                      '${(i+1).toString()}.- ${detalletour['site'].toString()}',
                      style: TextStyle(
                        fontFamily: 'Point-SemiBold',
                        fontSize: 11.0,
                        fontStyle: FontStyle.italic)
                    ),
                  ],
                )
              ),
              SizedBox(
                height:size.height * 0.01 
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(0xFFD62250),
                      ),
                      width: size.width * 0.27,
                      height: size.height * 0.04,
                      child: PopupMenuButton(
                        onSelected: (value)async{
                          PreferenciasUsuario prefs = PreferenciasUsuario();
                          if(value == 1){
                            print("Opcion: $value");
                            // String origin;
                            // String destination;
                            // String calle;
                            // String numero;
                            /*await appState.userLocation().then((result){
                                // prefs.ciudad = result[0];
                                // prefs.estado = result[1];
                                // prefs.pais = result[2];
                                // origin = result[3];
                                // destination = result[4];
                                // calle = result[5];
                                // numero = result[6];

                                print(result[0]);
                                print(result[1]);
                                print(result[2]);
                                print(result[3]);
                                print(result[4]);
                                print(result[5]);
                                print(result[6]);
                                print(result[7]);
                                print(result[8]);
                                print(result[9]);
                                print(result[10]);
                              });*/
                              
                            final origen = WayPoint(name: '${appState.initialPosition.toString()}',latitude: appState.initialPosition.latitude,longitude: appState.initialPosition.longitude );
                            final destino = WayPoint(name: '${detalletour['site']}',latitude: double.parse(detalletour['lat']) ,longitude: double.parse(detalletour['lng']) );
                            await _directions.startNavigation( origin: origen, destination: destino,mode: MapBoxNavigationMode.walking,simulateRoute: false,language: "${prefs.idioma}",units: VoiceUnits.metric);//units: VoiceUnits.imperial
                           
                              
                            // await appState.userLocation().then((result){
                            //     prefs.ciudad = result[0];
                            //     prefs.estado = result[1];
                            //     prefs.pais = result[2];
                            //     origin = result[3];
                            //     destination = result[4];
                            //     calle = result[5];
                            //     numero = result[6];
                            //   });
                            //   Navigator.push(context, MaterialPageRoute(
                            //     builder: (BuildContext context){
                            //       return NavigationRoute(origin: '${calle.toString()} No.${numero.toString()},${origin.toString()},${destination.toString()},${prefs.ciudad}, ${prefs.estado}, ${prefs.pais}', destination: detalletour['site']);
                            //     }
                            //     )
                            //   );
                          }else if(value == 2){
                            print("Opcion: $value");
                            final origen = WayPoint(name: '${appState.initialPosition.toString()}',latitude: appState.initialPosition.latitude,longitude: appState.initialPosition.longitude );
                            final destino = WayPoint(name: '${detalletour['site']}',latitude: double.parse(detalletour['lat']) ,longitude: double.parse(detalletour['lng']) );
                            //_directions.startNavigation( origin: origen, destination: destino,mode: NavigationMode.cycling,simulateRoute: false,language: 'German',units: VoiceUnits.metric);
                            await _directions.startNavigation( origin: origen, destination: destino,mode: MapBoxNavigationMode.cycling,simulateRoute: false,language: "${prefs.idioma}",units: VoiceUnits.metric);//units: VoiceUnits.metric
                          }else if(value == 3){
                            print("Opcion: $value");
                            final origen = WayPoint(name: '${appState.initialPosition.toString()}',latitude: appState.initialPosition.latitude,longitude: appState.initialPosition.longitude );
                            final destino = WayPoint(name: '${detalletour['site']}',latitude: double.parse(detalletour['lat']) ,longitude: double.parse(detalletour['lng']) );
                            await _directions.startNavigation( origin: origen, destination: destino,mode: MapBoxNavigationMode.driving,simulateRoute: false,language: "${prefs.idioma}",units: VoiceUnits.metric);//units: VoiceUnits.metric
                          }
                          //print("Opcion: $value");
                        },
                        child: Text('$navegar',style: TextStyle(color: Colors.white,fontFamily: 'Point-SemiBold',fontSize: 10.0),),
                        itemBuilder: (context){
                          String caminando = AppTranslations.of(context).text('title_walking');
                          String bicicleta = AppTranslations.of(context).text('title_bicycle');
                          String auto = AppTranslations.of(context).text('title_car');

                          return [
                            PopupMenuItem(
                              value: 1,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(
                                    Icons.directions_walk,
                                    color: Color(0xFFD62250)
                                  ),
                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),
                                  Text(
                                    "$caminando",
                                    style: TextStyle(
                                      fontFamily: 'Point-SemiBold'
                                    ),
                                  )
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 2,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(
                                    Icons.directions_bike,
                                    color: Color(0xFFD62250)
                                  ),
                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),
                                  Text(
                                    "$bicicleta",
                                    style: TextStyle(
                                      fontFamily: 'Point-SemiBold'
                                    ),
                                  )
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 3,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(
                                    Icons.drive_eta,
                                    color: Color(0xFFD62250)
                                  ),
                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),
                                  Text(
                                    "$auto",
                                    style: TextStyle(
                                      fontFamily: 'Point-SemiBold'
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ];
                        },
                      )
                      
                      /*RaisedButton(
                        shape: StadiumBorder(),
                        child: Text('$navegar',style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 10.0),),
                        textTheme: ButtonTextTheme.primary,
                        color: Color(0xFFD62250),
                        onPressed: ()async{

                            //appState.sendRequest("${tour['site'].toString()}, ${tours.city.toString()}");
                          final origen = Location(name: '${appState.initialPosition.toString()}',latitude: appState.initialPosition.latitude,longitude: appState.initialPosition.longitude );
                          final destino = Location(name: '${tour['site']}',latitude: double.parse(tour['lat']) ,longitude: double.parse(tour['lng']) );
                          await _directions.startNavigation( origin: origen, destination: destino,mode: NavigationMode.driving,simulateRoute: false);
                        },
                      ),*/
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    Container(
                        width: size.width * 0.3,
                        height: size.height * 0.04,
                        child: RaisedButton(
                          shape: StadiumBorder(),
                          child: Text('$verdetalle',style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 10.0),),
                          textTheme: ButtonTextTheme.primary,
                          color: Color(0xFFD62250),
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context){
                                return DetalleSitio(title: detalletour['site'].toString(), image: detalletour['gallery'][0]['url'].toString(), descripcion: detalletour['description'].toString(), imagen: detalletour['gallery']);
                                //detallesSitio(detalletour['site'].toString(), detalletour['gallery'][0]['url'].toString(), detalletour['description'].toString(),detalletour['gallery']);
                              },
                              fullscreenDialog: true
                            ));
                            
                          },
                      ),
                    )
                  ],
                ),
              ),

            ],
          ),
        );

        items.add(item);
    }
    return items;
    
    // return tour.route.map((detalletour){
    //   return GestureDetector(
    //     onTap: ()async{
    //       /*_acercar(double.parse(detalletour['lat']) ,double.parse( detalletour['lng']));
    //       final Uint8List markerIcon = await getBytesFromCanvas(140, 20,'${detalletour['site'].toString()}');
    //       final http.Response response = await http.get(detalletour['gallery'][0]['url'].toString());
    //       //final File markerImageFile = await DefaultCacheManager().getSingleFile(imageUrl);
    //    setState(() {
    //     _marcadores.add(
    //       Marker(
    //         consumeTapEvents: true,
    //         visible: true,
    //         markerId: markerId,
    //         position: LatLng(double.parse(detalletour['lat']), double.parse(detalletour['lng'])),
    //         infoWindow: infoWindow,
    //         icon: BitmapDescriptor.fromBytes(markerIcon),
    //         onTap: (){
              
    //         }
    //       )

         
    //     );
        
    //    });*/
    //     },
    //     child: Card(
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: <Widget>[
    //           GestureDetector(
    //             onTap: ()async{
    //               _acercar(double.parse(detalletour['lat']) ,double.parse( detalletour['lng']));
    //                 final Uint8List markerIcon = await getBytesFromCanvas(140, 20,'${detalletour['site'].toString()}');
    //                 //final http.Response response = await http.get(detalletour['gallery'][0]['url'].toString());
    //                 //final File markerImageFile = await DefaultCacheManager().getSingleFile(imageUrl);
    //               setState(() {
    //                 _marcadores.add(
    //                   Marker(
    //                     consumeTapEvents: true,
    //                     visible: true,
    //                     markerId: markerId,
    //                     position: LatLng(double.parse(detalletour['lat']), double.parse(detalletour['lng'])),
    //                     infoWindow: infoWindow,
    //                     icon: BitmapDescriptor.fromBytes(markerIcon),
    //                     onTap: (){
                          
    //                     }
    //                   )

                    
    //                 );
                    
    //               });
    //             },
    //             child: ClipRRect(
    //               borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0),topRight: Radius.circular(5.0)),
    //               child: 
    //               /*Image.network(
    //                 tour['gallery'][0]['url'].toString(),
    //                 width: size.width * 0.65,//size.width * 0.65
    //                 height: size.height * 0.2,
    //                 fit: BoxFit.fill,
    //                 scale: 1.0,
    //               )*/
    //               CachedNetworkImage(
    //                 imageUrl: "${detalletour['gallery'][0]['url'].toString()}",
    //                 //errorWidget: (context, url, error)=>Icon(Icons.error),
    //                 //cacheManager: baseCacheManager,
    //                 useOldImageOnUrlChange: true,
    //                 width: size.width * 0.65,//size.width * 0.65
    //                 height: size.height * 0.2,
    //                 fit: BoxFit.fill,
    //               )
    //             ),
    //           ),
    //           Padding(
    //             padding: EdgeInsets.symmetric(horizontal: 6.0,vertical: 10.0),
    //             child: Row(
    //               children: <Widget>[
    //                 /*Text(
    //                   '${tour.toString()}. ',//tour['_idsite'].toString()
    //                   style: TextStyle(
    //                     fontFamily: 'Point-SemiBold',
    //                     fontSize: 11.0,
    //                     fontStyle: FontStyle.italic)
    //                 ),*/
    //                 //site,
    //                 Text(
    //                   '${detalletour['site'].toString()}',
    //                   style: TextStyle(
    //                     fontFamily: 'Point-SemiBold',
    //                     fontSize: 11.0,
    //                     fontStyle: FontStyle.italic)
    //                 ),
    //               ],
    //             )
    //           ),
    //           SizedBox(
    //             height:size.height * 0.01 
    //           ),
    //           Padding(
    //             padding: EdgeInsets.symmetric(horizontal: 10.0),
    //             child: Row(
    //               children: <Widget>[
    //                 Container(
    //                   alignment: Alignment.center,
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(10.0),
    //                     color: Color(0xFFD62250),
    //                   ),
    //                   width: size.width * 0.27,
    //                   height: size.height * 0.04,
    //                   child: PopupMenuButton(
    //                     onSelected: (value)async{
    //                       PreferenciasUsuario prefs = PreferenciasUsuario();
    //                       if(value == 1){
    //                         print("Opcion: $value");
    //                         // String origin;
    //                         // String destination;
    //                         // String calle;
    //                         // String numero;
    //                         /*await appState.userLocation().then((result){
    //                             // prefs.ciudad = result[0];
    //                             // prefs.estado = result[1];
    //                             // prefs.pais = result[2];
    //                             // origin = result[3];
    //                             // destination = result[4];
    //                             // calle = result[5];
    //                             // numero = result[6];

    //                             print(result[0]);
    //                             print(result[1]);
    //                             print(result[2]);
    //                             print(result[3]);
    //                             print(result[4]);
    //                             print(result[5]);
    //                             print(result[6]);
    //                             print(result[7]);
    //                             print(result[8]);
    //                             print(result[9]);
    //                             print(result[10]);
    //                           });*/
                              
    //                         final origen = Location(name: '${appState.initialPosition.toString()}',latitude: appState.initialPosition.latitude,longitude: appState.initialPosition.longitude );
    //                         final destino = Location(name: '${detalletour['site']}',latitude: double.parse(detalletour['lat']) ,longitude: double.parse(detalletour['lng']) );
    //                         await _directions.startNavigation( origin: origen, destination: destino,mode: NavigationMode.walking,simulateRoute: false,language: "${prefs.idioma}", units: VoiceUnits.metric);
                           
                              
    //                         // await appState.userLocation().then((result){
    //                         //     prefs.ciudad = result[0];
    //                         //     prefs.estado = result[1];
    //                         //     prefs.pais = result[2];
    //                         //     origin = result[3];
    //                         //     destination = result[4];
    //                         //     calle = result[5];
    //                         //     numero = result[6];
    //                         //   });
    //                         //   Navigator.push(context, MaterialPageRoute(
    //                         //     builder: (BuildContext context){
    //                         //       return NavigationRoute(origin: '${calle.toString()} No.${numero.toString()},${origin.toString()},${destination.toString()},${prefs.ciudad}, ${prefs.estado}, ${prefs.pais}', destination: detalletour['site']);
    //                         //     }
    //                         //     )
    //                         //   );
    //                       }else if(value == 2){
    //                         print("Opcion: $value");
    //                         final origen = Location(name: '${appState.initialPosition.toString()}',latitude: appState.initialPosition.latitude,longitude: appState.initialPosition.longitude );
    //                         final destino = Location(name: '${detalletour['site']}',latitude: double.parse(detalletour['lat']) ,longitude: double.parse(detalletour['lng']) );
    //                         //_directions.startNavigation( origin: origen, destination: destino,mode: NavigationMode.cycling,simulateRoute: false,language: 'German',units: VoiceUnits.metric);
    //                         await _directions.startNavigation( origin: origen, destination: destino,mode: NavigationMode.cycling,simulateRoute: false,language: "${prefs.idioma}",units: VoiceUnits.metric);
    //                       }else if(value == 3){
    //                         print("Opcion: $value");
    //                         final origen = Location(name: '${appState.initialPosition.toString()}',latitude: appState.initialPosition.latitude,longitude: appState.initialPosition.longitude );
    //                         final destino = Location(name: '${detalletour['site']}',latitude: double.parse(detalletour['lat']) ,longitude: double.parse(detalletour['lng']) );
    //                         await _directions.startNavigation( origin: origen, destination: destino,mode: NavigationMode.driving,simulateRoute: false,language: "${prefs.idioma}",units: VoiceUnits.metric);
    //                       }
    //                       //print("Opcion: $value");
    //                     },
    //                     child: Text('$navegar',style: TextStyle(color: Colors.white,fontFamily: 'Point-SemiBold',fontSize: 10.0),),
    //                     itemBuilder: (context){
    //                       String caminando = AppTranslations.of(context).text('title_walking');
    //                       String bicicleta = AppTranslations.of(context).text('title_bicycle');
    //                       String auto = AppTranslations.of(context).text('title_car');

    //                       return [
    //                         PopupMenuItem(
    //                           value: 1,
    //                           child: Row(
    //                             mainAxisSize: MainAxisSize.min,
    //                             children: <Widget>[
    //                               Icon(
    //                                 Icons.directions_walk,
    //                                 color: Color(0xFFD62250)
    //                               ),
    //                               SizedBox(
    //                                 width: size.width * 0.02,
    //                               ),
    //                               Text(
    //                                 "$caminando",
    //                                 style: TextStyle(
    //                                   fontFamily: 'Point-SemiBold'
    //                                 ),
    //                               )
    //                             ],
    //                           ),
    //                         ),
    //                         PopupMenuItem(
    //                           value: 2,
    //                           child: Row(
    //                             mainAxisSize: MainAxisSize.min,
    //                             children: <Widget>[
    //                               Icon(
    //                                 Icons.directions_bike,
    //                                 color: Color(0xFFD62250)
    //                               ),
    //                               SizedBox(
    //                                 width: size.width * 0.02,
    //                               ),
    //                               Text(
    //                                 "$bicicleta",
    //                                 style: TextStyle(
    //                                   fontFamily: 'Point-SemiBold'
    //                                 ),
    //                               )
    //                             ],
    //                           ),
    //                         ),
    //                         PopupMenuItem(
    //                           value: 3,
    //                           child: Row(
    //                             mainAxisSize: MainAxisSize.min,
    //                             children: <Widget>[
    //                               Icon(
    //                                 Icons.drive_eta,
    //                                 color: Color(0xFFD62250)
    //                               ),
    //                               SizedBox(
    //                                 width: size.width * 0.02,
    //                               ),
    //                               Text(
    //                                 "$auto",
    //                                 style: TextStyle(
    //                                   fontFamily: 'Point-SemiBold'
    //                                 ),
    //                               )
    //                             ],
    //                           ),
    //                         ),
    //                       ];
    //                     },
    //                   )
                      
    //                   /*RaisedButton(
    //                     shape: StadiumBorder(),
    //                     child: Text('$navegar',style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 10.0),),
    //                     textTheme: ButtonTextTheme.primary,
    //                     color: Color(0xFFD62250),
    //                     onPressed: ()async{

    //                         //appState.sendRequest("${tour['site'].toString()}, ${tours.city.toString()}");
    //                       final origen = Location(name: '${appState.initialPosition.toString()}',latitude: appState.initialPosition.latitude,longitude: appState.initialPosition.longitude );
    //                       final destino = Location(name: '${tour['site']}',latitude: double.parse(tour['lat']) ,longitude: double.parse(tour['lng']) );
    //                       await _directions.startNavigation( origin: origen, destination: destino,mode: NavigationMode.driving,simulateRoute: false);
    //                     },
    //                   ),*/
    //                 ),
    //                 SizedBox(
    //                   width: size.width * 0.02,
    //                 ),
    //                 Container(
    //                     width: size.width * 0.3,
    //                     height: size.height * 0.04,
    //                     child: RaisedButton(
    //                       shape: StadiumBorder(),
    //                       child: Text('$verdetalle',style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 10.0),),
    //                       textTheme: ButtonTextTheme.primary,
    //                       color: Color(0xFFD62250),
    //                       onPressed: (){
    //                         Navigator.of(context).push(MaterialPageRoute(
    //                           builder: (context){
    //                             return DetalleSitio(title: detalletour['site'].toString(), image: detalletour['gallery'][0]['url'].toString(), descripcion: detalletour['description'].toString(), imagen: detalletour['gallery']);
    //                             //detallesSitio(detalletour['site'].toString(), detalletour['gallery'][0]['url'].toString(), detalletour['description'].toString(),detalletour['gallery']);
    //                           },
    //                           fullscreenDialog: true
    //                         ));
                            
    //                       },
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),

    //         ],
    //       ),
    //     ),
    //   );
    // }).toList();
    
  }

  Future<void> _acercar(double lat,double lng)async{
    final  controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, lng),
      zoom: 17.0
    )));
  }

  Future<void> _centrar(double lat, double lng,List<LatLng> puntos)async{
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, lng),
      zoom: puntos.length == 5 ? 8.4 : puntos.length == 2 ? 10.8 : puntos.length == 3 ? 10.8 : puntos.length == 4 ? 8.5 : puntos.length == 6 ? 9.0 : 14.3
    )));
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

  Future<Uint8List> getBytesCanvas(int width, int height,String text)async{
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color = Colors.transparent;
    final Radius radius = Radius.circular(20.0);
    //canvas.drawCircle(Offset(0.3, 0.5), radius.x, paint);
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
      style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 25.0, color: Colors.white),
    );
    painter.layout();
    painter.paint(
      canvas,
      Offset(
        (width * 0.5)- painter.width * 0.5,(height * 0.2) - painter.height * 0.5)
      );
    final img = await pictureRecorder.endRecording().toImage(width, height);
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data.buffer.asUint8List();
  }

  /*Widget detallesSitio(String title, String image, String descripcion,List imagen){
    final size = MediaQuery.of(context).size;
    CategoriasProvider categoriasProvider = CategoriasProvider();
    PreferenciasUsuario prefs = PreferenciasUsuario();
    String traducir = AppTranslations.of(context).text('title_traducir');
    String textoOriginal = AppTranslations.of(context).text('title_texto_original');
   
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.black,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index){
                  return SingleChildScrollView(
                    child: Column(
                      children: <Widget>[

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Flexible(child: Text(title,style: TextStyle(fontFamily: 'Point-SemiBold'),)),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: 
                                  /*Image.network(
                                    image,
                                    width: size.width * 0.5,
                                    height: size.height * 0.2,
                                    fit: BoxFit.fill,
                                    scale: 1.0,
                                  )*/
                                  CachedNetworkImage(
                                    imageUrl: "${image.toString()}",
                                    //errorWidget: (context, url, error)=>Icon(Icons.error),
                                    //cacheManager: baseCacheManager,
                                    useOldImageOnUrlChange: true,
                                    width: size.width * 0.5,
                                    height: size.height * 0.2,
                                    fit: BoxFit.fill,
                                  )
                                ),
                              ],
                            ),
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        FutureBuilder(
                          future: categoriasProvider.detectarIdioma(descripcion),
                          //initialData: InitialData,
                          builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot) {
                            if(snapshot.hasData){
                              final resp = snapshot.data;
                              return null;
                            }
                            return Container();
                          },
                        ),
                        prefs.idioma == prefs.idiomaDescripcion ? Container() :
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: <Widget>[
                              mostrarTraductor ?
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: FlatButton(
                                    onPressed: ()async{
                                      setState(() {
                                        
                                      });
                                      Map<String,dynamic> resp = await categoriasProvider.traducir(prefs.idioma == null ? 'es':prefs.idioma, descripcion);
                                      descripcionTour = resp['data']['translations'][0]['translatedText'];
                                      _ocultarBotonTraductor();
                                    }, 
                                    child: Text(
                                      traducir,
                                      style: TextStyle(
                                        fontFamily: 'Point-SemiBold',
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline
                                      ),
                                    )
                                  ),
                                ):
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: FlatButton(
                                    onPressed: ()async{
                                      setState(() {
                                        
                                      });
                                      _mostrarBotonTraductor();
                                    }, 
                                    child: Text(
                                      textoOriginal,
                                      style: TextStyle(
                                        fontFamily: 'Point-SemiBold',
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline
                                      ),
                                    )
                                  ),
                                ),
                            ],
                          ),
                        ),
                        mostrarTraductor ?
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            descripcion,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontFamily: 'Point-SemiBold'
                            ),
                          ),
                        ):
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            descripcionTour,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontFamily: 'Point-SemiBold'
                            ),
                          ),
                        )
                        
                        /*FutureBuilder(
                          future: categoriasProvider.traducir(prefs.idioma == null ? 'es' : prefs.idioma.toString(),descripcion),
                          builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot) {
                            if(snapshot.hasData){
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(
                                  snapshot.data['data']['translations'][0]['translatedText'].toString(),
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontFamily: 'Point-SemiBold'
                                  ),
                                ),
                              );
                            }else{
                              return Container();
                            }
                            
                          },
                        ),*/
                        
                      ],
                    ),
                  );
                },
                childCount: 1
              ),
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index){
                  return foto(context, imagen[index]);
                },
                childCount: imagen.length
              ),
            )
          ],
        ),
      
      
      /*Column(
        children: <Widget>[
          SafeArea(
            child: SizedBox(
              height: size.height * 0.04,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(title,style: TextStyle(fontFamily: 'Point-SemiBold'),),
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: FadeInImage(
                  image: NetworkImage(image),
                  placeholder: AssetImage('assets/loading.gif'),
                  width: size.width * 0.6,
                  height: size.height * 0.2,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(descripcion,style: TextStyle(fontFamily: 'Point-SemiBold'),textAlign: TextAlign.justify,),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          SingleChildScrollView(
            child: Container(
              height: size.height * 0.49,
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(imagen.length, (index){
                  return Card(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: FadeInImage(
                        image: NetworkImage(imagen[index]),
                        placeholder: AssetImage('assets/loading.gif'),
                        fit: BoxFit.fill,
                        width: 60.0,
                        height: 60.0,
                      ),
                    ),
                  );
                }),
              )
              
              
            
            ),
          )
        ],
      ),*/
    );
  }*/

  /*Widget foto(BuildContext context,dynamic imagen){
    return Card(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: 
        /*Image.network(
          "${imagen['url'].toString()}",
          width: 60.0,
          height: 60.0,
          fit: BoxFit.fill,
          scale: 1.0,
        )*/
        CachedNetworkImage(
          imageUrl: "${imagen['url'].toString()}",
          //errorWidget: (context, url, error)=>Icon(Icons.error),
          //cacheManager: baseCacheManager,
          useOldImageOnUrlChange: true,
          width: 60.0,
          height: 60.0,
          fit: BoxFit.fill,
        )
      ),
    );
  }*/

  /*List<Widget> fotos(BuildContext context,List imagen){
    final size = MediaQuery.of(context).size;
    return imagen.map((image){
      return Container(
        width: size.width * 0.4,
        height: size.height * 0.2,
        child: Card(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
              child: Image.network(
                image,
                fit: BoxFit.fill,
                scale: 1.0,
              )
          ),
        ),
      );
    }).toList();
  }*/

  /*Widget _crearAppBar(String title,String image){
    return SliverAppBar(
      elevation: 0.0,
      floating: false,
      expandedHeight: 200.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Point-SemiBold',
            color: Colors.white
          ),
        ),
        background: FadeInImage(
          image: NetworkImage(
            image
          ),
          placeholder: AssetImage('assets/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.fill,
        ),
      ),
    );
  }*/
}



class DetalleSitio extends StatefulWidget {

  final String title; 
  final String image; 
  final String descripcion;
  final List imagen;

  DetalleSitio({@required this.title, @required this.image, @required this.descripcion, @required this.imagen});

  @override
  _DetalleSitioState createState() => _DetalleSitioState();
}

class _DetalleSitioState extends State<DetalleSitio> {
  bool mostrarTraductor = true;
  bool mostrarOriginal = false;
  String descripcionTour = '';

  void _mostrarBotonTraductor(){
    setState(() {
      mostrarTraductor = true;
      mostrarOriginal = false;
    });
  }

  void _ocultarBotonTraductor(){
    setState(() {
      
      mostrarOriginal = true;
      mostrarTraductor = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    CategoriasProvider categoriasProvider = CategoriasProvider();
    PreferenciasUsuario prefs = PreferenciasUsuario();
    String traducir = AppTranslations.of(context).text('title_traducir');
    String textoOriginal = AppTranslations.of(context).text('title_texto_original');
   
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.black,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index){
                  return SingleChildScrollView(
                    child: Column(
                      children: <Widget>[

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Flexible(child: Text(widget.title,style: TextStyle(fontFamily: 'Point-SemiBold'),)),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: 
                                  /*Image.network(
                                    image,
                                    width: size.width * 0.5,
                                    height: size.height * 0.2,
                                    fit: BoxFit.fill,
                                    scale: 1.0,
                                  )*/
                                  CachedNetworkImage(
                                    imageUrl: "${widget.image.toString()}",
                                    //errorWidget: (context, url, error)=>Icon(Icons.error),
                                    //cacheManager: baseCacheManager,
                                    useOldImageOnUrlChange: true,
                                    width: size.width * 0.5,
                                    height: size.height * 0.2,
                                    fit: BoxFit.fill,
                                  )
                                ),
                              ],
                            ),
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        FutureBuilder(
                          future: categoriasProvider.detectarIdioma(widget.descripcion),
                          //initialData: InitialData,
                          builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot) {
                            if(snapshot.hasData){
                              final resp = snapshot.data;
                              prefs.idiomaDescripcion = Locale(resp['data']['detections'][0][0]['language']);
                              return Container();
                            }
                            return Container();
                          },
                        ),
                        prefs.idioma == prefs.idiomaDescripcion ? Container() :
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: <Widget>[
                              mostrarTraductor ?
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: FlatButton(
                                    onPressed: ()async{
                                      setState(() {
                                        
                                      });
                                      Map<String,dynamic> resp = await categoriasProvider.traducir(prefs.idioma == null ? 'es':prefs.idioma, widget.descripcion);
                                      descripcionTour = resp['data']['translations'][0]['translatedText'];
                                      _ocultarBotonTraductor();
                                    }, 
                                    child: Text(
                                      traducir,
                                      style: TextStyle(
                                        fontFamily: 'Point-SemiBold',
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline
                                      ),
                                    )
                                  ),
                                ):
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: FlatButton(
                                    onPressed: ()async{
                                      setState(() {
                                        
                                      });
                                      _mostrarBotonTraductor();
                                    }, 
                                    child: Text(
                                      textoOriginal,
                                      style: TextStyle(
                                        fontFamily: 'Point-SemiBold',
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline
                                      ),
                                    )
                                  ),
                                ),
                            ],
                          ),
                        ),
                        mostrarTraductor ?
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            widget.descripcion.replaceAll(RegExp(r'</br>'), '\n'),
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontFamily: 'Point-SemiBold'
                            ),
                          ),
                        ):
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            descripcionTour.replaceAll(RegExp(r'</br>'), '\n').replaceAll(RegExp(r"&quot;"), "''"),
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontFamily: 'Point-SemiBold'
                            ),
                          ),
                        )
                        
                        /*FutureBuilder(
                          future: categoriasProvider.traducir(prefs.idioma == null ? 'es' : prefs.idioma.toString(),descripcion),
                          builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot) {
                            if(snapshot.hasData){
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(
                                  snapshot.data['data']['translations'][0]['translatedText'].toString(),
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontFamily: 'Point-SemiBold'
                                  ),
                                ),
                              );
                            }else{
                              return Container();
                            }
                            
                          },
                        ),*/
                        
                      ],
                    ),
                  );
                },
                childCount: 1
              ),
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index){
                  return foto(context, widget.imagen[index]);
                },
                childCount: widget.imagen.length
              ),
            )
          ],
        ),
      
      
      /*Column(
        children: <Widget>[
          SafeArea(
            child: SizedBox(
              height: size.height * 0.04,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(title,style: TextStyle(fontFamily: 'Point-SemiBold'),),
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: FadeInImage(
                  image: NetworkImage(image),
                  placeholder: AssetImage('assets/loading.gif'),
                  width: size.width * 0.6,
                  height: size.height * 0.2,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(descripcion,style: TextStyle(fontFamily: 'Point-SemiBold'),textAlign: TextAlign.justify,),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          SingleChildScrollView(
            child: Container(
              height: size.height * 0.49,
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(imagen.length, (index){
                  return Card(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: FadeInImage(
                        image: NetworkImage(imagen[index]),
                        placeholder: AssetImage('assets/loading.gif'),
                        fit: BoxFit.fill,
                        width: 60.0,
                        height: 60.0,
                      ),
                    ),
                  );
                }),
              )
              
              
            
            ),
          )
        ],
      ),*/
    );
  }

  Widget foto(BuildContext context,dynamic imagen){
    return Card(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: 
        /*Image.network(
          "${imagen['url'].toString()}",
          width: 60.0,
          height: 60.0,
          fit: BoxFit.fill,
          scale: 1.0,
        )*/
        CachedNetworkImage(
          imageUrl: "${imagen['url'].toString()}",
          //errorWidget: (context, url, error)=>Icon(Icons.error),
          //cacheManager: baseCacheManager,
          useOldImageOnUrlChange: true,
          width: 60.0,
          height: 60.0,
          fit: BoxFit.fill,
        )
      ),
    );
  }
}