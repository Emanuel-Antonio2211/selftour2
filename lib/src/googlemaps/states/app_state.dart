//En este archivo se realiza las acciones del estado de la aplicación
//las acciones del mapa
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:selftourapp/src/googlemaps/requests/google_maps_requests.dart';
import 'package:selftourapp/src/models/detalle_tour_model.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart' as l;
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';
//import 'package:selftourapp/src/models/tour_categoria_model.dart';

class AppState with ChangeNotifier{
  static LatLng _initialPosition;
  LatLng _lastPosition = _initialPosition;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyLines = {};
  GoogleMapController _mapController;
  //Instancia proveniente del archivo google maps requests
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  TextEditingController locationController = TextEditingController();
  String _location;
  String get location =>_location;
  //InfoTour tour = InfoTour();
  DetalleTour detalleTour = DetalleTour();
  TextEditingController destinationController = TextEditingController();
  LatLng get initialPosition => _initialPosition;
  LatLng get lastPosition => _lastPosition;
  GoogleMapsServices get googleMapsServices => _googleMapsServices;
  GoogleMapController get mapController => _mapController;
  Set<Marker> get markers => _markers;
  Set<Polyline> get polyLines => _polyLines;

  l.Location userUbicacion = l.Location();
  bool _serviceEnabled;
  l.PermissionStatus _permissionGranted;
  l.LocationData _locationData;
  PreferenciasUsuario _prefs = PreferenciasUsuario();

  AppState() {
    //getUserLocation();
    obtenerUbicacion();
  }

// ! TO GET THE USERS LOCATION
//Se encarga de obtener la ubicación del usuario en el mapa
  void getUserLocation() async{
    Position position = await Geolocator()
    .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator()
      .placemarkFromCoordinates(position.latitude, position.longitude);
    _initialPosition = LatLng(position.latitude, position.longitude);
    print("initial position is : ${_initialPosition.toString()}");
    //Se encarga de mostrar en el campo de texto el nombre de
    // la ubicación del usuario
    //locationController.text = placemark[0].locality;
    //_location = placemark[0].locality;
    _prefs.estadoUser = placemark[0].administrativeArea;
    _prefs.countryCode = placemark[0].isoCountryCode;
    
    //print(location);
    notifyListeners();
  }

  void obtenerUbicacion()async{
    //_permissionGranted = await userUbicacion.hasPermission();
    //_serviceEnabled = await userUbicacion.serviceEnabled();

    // if (!_serviceEnabled) {
    //   _serviceEnabled = await userUbicacion.requestService();
    //   if (!_serviceEnabled) {
    //     return;
    //   }
    // }
    
      print("Permisos: ");
      _locationData = await userUbicacion.getLocation();
      _initialPosition = LatLng(_locationData.latitude, _locationData.longitude);
      final coordinates = new Coordinates(_locationData.latitude, _locationData.longitude);
      final addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      
      _prefs.estadoUser = addresses.first.adminArea;
      _prefs.countryCode = addresses.first.countryCode;
      _prefs.codPostal = addresses.first.postalCode;

    // if (_permissionGranted == l.PermissionStatus.denied) {
    //   // _permissionGranted = await userUbicacion.requestPermission();

    //   // if (_permissionGranted == l.PermissionStatus.granted) {
    //   //   _locationData = await userUbicacion.getLocation();
    //   //   // print("Ubicación del usuario: ");
    //   //   // print("${_locationData.latitude}, ${_locationData.longitude}");
    //   // }

    //   print("Permisos denegados");

    //   // _initialPosition = LatLng(_locationData.latitude, _locationData.longitude);
    //   // final coordinates = new Coordinates(_locationData.latitude, _locationData.longitude);
    //   // final addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    //   // notifyListeners();
    // }else{
    //     print("Permisos Aceptados");
    //     _locationData = await userUbicacion.getLocation();
    //     //return _locationData;

    //     // print("Ubicación del usuario: ");
    //     // print("${_locationData.latitude}, ${_locationData.longitude}");
    //     _initialPosition = LatLng(_locationData.latitude, _locationData.longitude);
    //     final coordinates = new Coordinates(_locationData.latitude, _locationData.longitude);
    //     final addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    //     _prefs.estadoUser = addresses.first.adminArea;
    //     _prefs.countryCode = addresses.first.countryCode;
    //     // print("Direcciones del usuario: ");
    //     // print(addresses.first.countryCode);
    //     // print(addresses.first.countryName);
    //     // print(addresses.first.locality);
    //     // print(addresses.first.adminArea);
    // }
    notifyListeners();
  }

  Future<List<String>> userLocation()async{
    Position position = await Geolocator()
    .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator()
      .placemarkFromCoordinates(position.latitude, position.longitude);
    _initialPosition = LatLng(position.latitude, position.longitude);
    //print("initial position is : ${_initialPosition.toString()}");
    //Se encarga de mostrar en el campo de texto el nombre de
    // la ubicación del usuario
    locationController.text = placemark[0].locality;
    //_location = placemark[0].locality;
    
    //print(location);
    List<String> ubicaciones = List();

    ubicaciones.addAll([
      placemark[0].locality,
      placemark[0].administrativeArea,
      placemark[0].country,
      placemark[0].subLocality,
      placemark[0].subAdministrativeArea,
      placemark[0].isoCountryCode,
      placemark[0].position.hashCode.toString(),
      placemark[0].postalCode,
      placemark[0].thoroughfare,
      placemark[0].subThoroughfare,
      placemark[0].name
    ]);

    //print(ubicaciones);

    notifyListeners();
    return ubicaciones;
    
  }

  

  Future<List<String>> ubicacion()async{
    List<String> datosUbicacion = List();
    _permissionGranted = await userUbicacion.hasPermission();
    if (_permissionGranted == l.PermissionStatus.denied) {
      _permissionGranted = await userUbicacion.requestPermission();
      if (_permissionGranted == l.PermissionStatus.granted) {
        _locationData = await userUbicacion.getLocation();
        // print("Ubicación del usuario: ");
        // print("${_locationData.latitude}, ${_locationData.longitude}");
      }
      final coordinates = new Coordinates(_locationData.latitude, _locationData.longitude);
      final addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
        datosUbicacion.addAll([
          addresses.first.locality,
          addresses.first.adminArea,
          addresses.first.countryName,
          addresses.first.countryCode
        ]);
        notifyListeners();
        return datosUbicacion;
    }else{
        print("Permisos Aceptados");
        _locationData = await userUbicacion.getLocation();
        //return _locationData;

        // print("Ubicación del usuario: ");
        // print("${_locationData.latitude}, ${_locationData.longitude}");

        final coordinates = new Coordinates(_locationData.latitude, _locationData.longitude);
        final addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
        // print("Direcciones del usuario: ");
        // print(addresses.first.countryCode);
        // print(addresses.first.countryName);
        // print(addresses.first.locality);
        // print(addresses.first.adminArea);
        datosUbicacion.addAll([
          addresses.first.locality,
          addresses.first.adminArea,
          addresses.first.countryName,
          addresses.first.countryCode
        ]);
        notifyListeners();
        return datosUbicacion;
    }
    // _serviceEnabled = await userUbicacion.serviceEnabled();
    // if (!_serviceEnabled) {
    //   _serviceEnabled = await userUbicacion.requestService();
    //   if (!_serviceEnabled) {
    //     return;
    //   }
    // }
    // final coordinates = new Coordinates(_initialPosition.latitude,_initialPosition.longitude);
    
    
    // for(int i = 0; i < addresses.length; i++){
    //   print(addresses[i].countryCode);
    //   print(addresses[i].countryName);
    //   print(addresses[i].locality);
    //   print(addresses[i].adminArea);
    // }
    
  }

  
// ! TO CREATE ROUTE
  //Se encarga de crear la ruta a trazar definiendo los puntos a
  //recorrer
  void createRoute(String encondedPoly){
    _polyLines.add(Polyline(
        polylineId: PolylineId(_lastPosition.toString()),
        width: 5,
        points: _convertToLatLng(_decodePoly(encondedPoly)),
        color: Colors.red
      )
    );
    notifyListeners();
  }

  void crearRuta(String encondedPoly){
    List<LatLng> puntos = [
      //_initialPosition,
      LatLng(20.9751655,-89.6212047),
      LatLng(20.974451,-89.6231728),
      LatLng(20.9717124,-89.6256245),
      LatLng(20.9713964,-89.6250387),
      LatLng(20.9631548,-89.6340831),

     /* LatLng(20.975499595061986,-89.62115537044788),
      LatLng(20.975552699999998,-89.6215679),
      LatLng(20.975552699999998,-89.6215679),
      LatLng(20.9767138,-89.6213708),
      LatLng(20.9767138,-89.6213708),
      LatLng(20.9767948,-89.6221162),
      LatLng(20.976869399999998,-89.622676599999991),
      LatLng(20.976869399999998, -89.622676599999991),
      LatLng(20.975571, -89.62289229999999),
      LatLng(20.9725978,-89.62482709999999),
      LatLng(20.9725978, -89.62482709999999),*/
      _lastPosition
    ];

    for(int i=0;i<=puntos.length;i++){
    _polyLines.add(Polyline(
        polylineId: PolylineId(_lastPosition.toString()),
        width: 5,
        points: //puntos,
        _convertToLatLng(_decodePoly(encondedPoly)),
        color: Colors.red
      )
    );
    }
    notifyListeners();
  }

  
  // ! ADD A MARKER ON THE MAO
  //Se encarga de añadir el marcador, el origen y el destino
  //Recibiendo como parámetros la ubicación del usuario
  // y la dirección de destino
  void _addMarker(LatLng location, String address){
   /* 
    //20.9751655,-89.6212047
    _markers.add(Marker(
      markerId: MarkerId('El Lucero del Alba'),
      position: LatLng(20.9751655,-89.6212047),
      infoWindow: InfoWindow(title: 'El Lucero del Alba',snippet: 'El Lucero del Alba'),
      //20.974451,-89.6231728
      icon: BitmapDescriptor.defaultMarker
    ));
    _markers.add(Marker(
      markerId: MarkerId('La negrita Cantina'),
      position: LatLng(20.974451,-89.6231728),
      infoWindow: InfoWindow(title: 'La negrita Cantina',snippet: 'La negrita Cantina'),
      //20.974451,-89.6231728
      icon: BitmapDescriptor.defaultMarker
    ));

    _markers.add(Marker(
      markerId: MarkerId('Pipiripau Bar'), //20.9717124,-89.6256245
      position: LatLng(20.9717124,-89.6256245),
      infoWindow: InfoWindow(title: 'Pipiripau Bar',snippet: 'Pipiripau Bar' ),
      icon: BitmapDescriptor.defaultMarker
    ));

    _markers.add(Marker(
      markerId: MarkerId('Malahat'),//20.9713964,-89.6250387
      position: LatLng(20.9713964,-89.6250387),
      infoWindow: InfoWindow(title: 'Malahat',snippet: 'Malahat'),
      icon: BitmapDescriptor.defaultMarker
    ));

    _markers.add(Marker(
      markerId: MarkerId('Bar la Ruina'),//20.9631548,-89.6340831
      position: LatLng(20.9631548,-89.6340831),
      infoWindow: InfoWindow(title: 'Bar la Ruina',snippet: 'Bar la Ruina'),
      icon: BitmapDescriptor.defaultMarker
    ));

    */

    /*_markers.add(Marker(
      markerId: MarkerId('La Mentecata'),
      position: LatLng(20.9713109,-89.6220388),
      infoWindow: InfoWindow(title: 'La Mentecata',snippet: 'La Mentecata'),
      icon: BitmapDescriptor.defaultMarker
    ));*/

     _markers.add(Marker(
        markerId: MarkerId(_lastPosition.toString()),
        position: location,
        infoWindow: InfoWindow(title: address, snippet: "${address.toString()}"),
        icon: BitmapDescriptor.defaultMarker
      )
    );
    notifyListeners();
  }

  void marcar(LatLng location,String address){
    /*_markers.add(Marker(
      markerId: MarkerId('La negrita Cantina'),
      position: LatLng(20.974451,-89.6231728),
      infoWindow: InfoWindow(title: 'La negrita Cantina',snippet: 'La negrita Cantina'),
      //20.974451,-89.6231728
      icon: BitmapDescriptor.defaultMarker
    ));
    _markers.add(Marker(
      markerId: MarkerId('Pipiripau Bar'), //20.9717124,-89.6256245
      position: LatLng(20.9717124,-89.6256245),
      infoWindow: InfoWindow(title: 'Pipiripau Bar',snippet: 'Pipiripau Bar' ),
      icon: BitmapDescriptor.defaultMarker
    ));
    _markers.add(Marker(
      markerId: MarkerId('Malahat'),//20.9713964,-89.6250387
      position: LatLng(20.9713964,-89.6250387),
      infoWindow: InfoWindow(title: 'Malahat',snippet: 'Malahat'),
      icon: BitmapDescriptor.defaultMarker
    ));
    _markers.add(Marker(
      markerId: MarkerId('Bar la Ruina'),//20.9631548,-89.6340831
      position: LatLng(20.9631548,-89.6340831),
      infoWindow: InfoWindow(title: 'Bar la Ruina',snippet: 'Bar la Ruina'),
      icon: BitmapDescriptor.defaultMarker
    ));
    _markers.add(Marker(
      markerId: MarkerId('La Mentecata'),
      position: LatLng(20.9713109,-89.6220388),
      infoWindow: InfoWindow(title: 'La Mentecata',snippet: 'La Mentecata'),
      icon: BitmapDescriptor.defaultMarker
    ));*/
    _markers.add(Marker(
      markerId: MarkerId(_lastPosition.toString()),
      position: location,
      infoWindow: InfoWindow(title: address,snippet: '${address.toString()}'),
      icon: BitmapDescriptor.defaultMarker
    ));
    //return _markers;
  }
  /* 
    [12.2, 312.2, 321.3, 231.4, 234.5, 2342.6, 2341.7, 1321.4]
    (0-------1------2------3------4------5-------6-------7)
    [lat,  lng,    lat,    lng,   lat,   lng,   lat,    lng]
  */
  // ! CREATE LAGLNG LIST
  //Se encarga de convertir una lista de doubles(decimales) a
  //latitudes y longitudes
  //Recibe como parámetro, una lista de puntos a recorrer
  List<LatLng> _convertToLatLng(List points){
    //Se crea una lista de tipo latitud y longitud
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++){
      if (i % 2 != 0){
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  // !DECODE POLY
  //Se encarga de mostrar la lista de los puntos trazados
  //para la ruta del mapa decodificados
  List _decodePoly(String poly){
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
    // repeating until all attributes are decoded
    do{
      var shift = 0;
      int result = 0;

      // for decoding value of one attribute
      do{
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;

      }while(c >= 32);
      /* if value is negetive then bitwise not the value */
      if (result & 1 == 1){
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);

    }while(index < len);
    /*adding to previous value as done in encoding */
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];
    print(lList.toString());
    return lList;
  }

  // ! SEND REQUEST
  //Se encarga de enviar los requerimientos para la generación
  //de la lista de marcadores de lugares
  Future<void> sendRequest(String intendedLocation) async{//String intendedLocation
    List<Placemark> placemark =
    await Geolocator().placemarkFromAddress(intendedLocation);
    double latitude = placemark[0].position.latitude;
    double longitude = placemark[0].position.longitude;
    LatLng destination = LatLng(latitude, longitude);
    _lastPosition=destination;
    _addMarker(_lastPosition, intendedLocation);
    //Se guarda en una variable de tipo String las coordenadas
    //obtenidas en el api decodificado
    String route = await _googleMapsServices.getRouteCoordinates(
        _initialPosition,_lastPosition);
      createRoute(route);

     //destinationController.text = placemark[0].name;
     notifyListeners();
    
  /* await Geolocator().placemarkFromAddress(intendedLocation).then((result){
      double latitude = result[0].position.latitude;
      double longitude = result[0].position.longitude;
      LatLng destination = LatLng(latitude, longitude);
      _lastPosition = destination;
      /*mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: destination,
        zoom: 8.0
      )));*/
      
      _addMarker(_lastPosition, intendedLocation);
    });

  
    
     notifyListeners();
*/
  }

  Future<void> enviarReq(String destinolocation)async{
    await Geolocator().placemarkFromAddress(destinolocation).then((result){
      double latitude = result[0].position.latitude;
      double longitude = result[0].position.longitude;
      LatLng destination = LatLng(latitude, longitude);
      _lastPosition = destination;
      /*mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: _lastPosition,
        zoom: 8.0
      )));*/
      
      _addMarker(_lastPosition, destinolocation);
       //marcar(_lastPosition,destinolocation);
    });

  
   
     notifyListeners();
  }

  // ! ON CAMERA MOVE
  void onCameraMove(CameraPosition position){
    _lastPosition = position.target;
    notifyListeners();
  }


  // ! ON CREATE
  void onCreated(GoogleMapController controller){
     _mapController = controller;
     _mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _lastPosition,zoom: 12.0)));
     notifyListeners();
  }

}