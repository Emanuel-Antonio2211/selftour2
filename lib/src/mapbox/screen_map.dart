import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:selftourapp/src/models/tour_categoria_model.dart';

class MapaBox extends StatefulWidget {
  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<MapaBox> {
 
  static LatLng _initialPosition;
  LatLng _lastPosition = _initialPosition;
  final Set<Marker> _markers = {};
  LatLng get initialPosition => _initialPosition;
  LatLng get lastPosition => _lastPosition;
  Set<Marker> get markers => _markers;
  final mapController = new MapController();

 @override
  void initState() {
    super.initState();
    _getUserLocation();
    
  }


  void _getUserLocation() async{
    Position position = await Geolocator()
    .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator()
    .placemarkFromCoordinates(position.latitude, position.longitude);
    _initialPosition = LatLng(position.latitude, position.longitude);
    print("initial position is : ${_initialPosition.toString()}");
    //Se encarga de mostrar en el campo de texto el nombre de
    // la ubicación del usuario
    //locationController.text = placemark[0].name;
     mapController.move(lastPosition, 8.0);
  }

  Future<void> sendRequest(String intendedLocation)async{
    List<Placemark> placemark =
    await Geolocator().placemarkFromAddress(intendedLocation);
    double latitude = placemark[0].position.latitude;
    double longitude = placemark[0].position.longitude;
    LatLng destination = LatLng(latitude, longitude);
    _lastPosition = destination;
  }

  

  @override
  Widget build(BuildContext context) {
    
    InfoTour tour = ModalRoute.of(context).settings.arguments;
    final size = MediaQuery.of(context).size;
    MapboxNavigation directions;
    
    setState(() {
      
    });
    //sendRequest('${tour.city.toString()},${tour.country.toString()}');
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Vista en el mapa'),
      ),
      body: FutureBuilder(
        future: sendRequest('${tour.city.toString()},${tour.country.toString()}'),
        
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(lastPosition == null){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Stack(
            children: <Widget>[
              
              FlutterMap(
                options: MapOptions(
                  center: lastPosition,//20.9345, -89.0182
                  zoom: 3.9,
                ),
                mapController: mapController,
                layers: [
                  TileLayerOptions(
                    urlTemplate: "https://api.mapbox.com/v4/"
                    "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                    additionalOptions: {
                      'accessToken': 'pk.eyJ1Ijoic2VsZnRvdXIiLCJhIjoiY2sxMTZvaWh0MDRvNTNjbzZma2twMXByMCJ9._95Qax19-QO1rQZqWuWuLQ',
                      'id': 'mapbox.streets'
                    }
                  ),
                  MarkerLayerOptions(
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: lastPosition,
                        builder: (context){
                          return Container(
                            child: Icon( 
                            Icons.location_on,
                            color: Colors.red, 
                            size: 30.0,
                          )
                          );
                        }
                      )
                    ]
                  )
                ],
              ),
              Positioned(
                top: size.height * 0.8,
                left: size.width * 0.37,
                child: RaisedButton(
                  child: Text('Navegar'),
                  shape: StadiumBorder(),
                  textTheme: ButtonTextTheme.primary,
                  color: Colors.blue,
                  onPressed: ()async{
                    final origen = Location(name: '${tour.city.toString()},${tour.country.toString()}',latitude: initialPosition.latitude,longitude: initialPosition.longitude );
                    final destino = Location(name: '${tour.city.toString()},${tour.country.toString()}',latitude: lastPosition.latitude,longitude: lastPosition.longitude);
                    await directions.startNavigation(origin:origen,destination: destino,mode: NavigationMode.driving,simulateRoute: false);
                  },
                ),
              )
            ],
          );
        },
      ),
      
      
    );
  }

  
}