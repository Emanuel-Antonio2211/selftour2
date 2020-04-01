//En este archivo se hace el llamado a la petición http
//para la generación de la rutas por medio de un api de google maps
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:selftourapp/src/models/mapa_model.dart';

const apiKey = "AIzaSyAAw4woNIssZ0P5Lonws9W-9LTRHRCMyqc";

class GoogleMapsServices{
  //Se encarga de obtener las coordenadas de las rutas
  //para el mapa
  //Reciben como parámetros la latitud y longitud del origen y destino
  Future<String> getRouteCoordinates(LatLng l1, LatLng l2)async{

    //Se define la url del api a usar para la generación de rutas
    String url = "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$apiKey";
    //Se hace la petición http
    http.Response response = await http.get(url);
    //Se hace la conversión a una mapa la respuesta a la
    //petición http
    Map<String,dynamic> values = jsonDecode(response.body);
    print(values['routes'][0]['overview_polyline']['points']);
    //Va a retornar una lista de rutas, con los puntos a trazar
    return values["routes"][0]["overview_polyline"]["points"];
    
  }

}