import 'dart:async';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
//import 'package:selftourapp/src/pages/tours/detalle_tour_page.dart';
import 'package:selftourapp/src/models/tour_categoria_model.dart';

class DynamicLinkProvider{
  final GlobalKey<NavigatorState> _navigatorKey = new GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigationKey => _navigatorKey;
  //final tour = InfoTour();
  Future startDynamicLink(BuildContext context)async{
    final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();

    _handledDeepLink(context,data);
    FirebaseDynamicLinks.instance.onLink(
      onSuccess: (PendingDynamicLinkData dynamicLink)async{
        _handledDeepLink(context,dynamicLink);
      },
      onError: (OnLinkErrorException e)async{
        print("Link Failed: ${e.message}");
      }
    );
  }

  void _handledDeepLink(BuildContext context,PendingDynamicLinkData data){
    final Uri deepLink = data?.link;
    if(deepLink != null){
      print("_handledDeepLink | deepLink: $deepLink");
      var isDetalleTour = deepLink.pathSegments.contains('detalletour');//single_tour.html
      //var idtour = deepLink.queryParameters['_lookup'];
      //_navigatorKey.currentState.pushNamed(deepLink.path,arguments: idtour);
     print("Es la ruta?");
     print(isDetalleTour);
     if(isDetalleTour){
        var argument = deepLink.queryParameters['_lookup'];
        
        if(argument != null){
          //_navigatorKey.currentState.pushNamed('/detalletour',arguments: infotour);
          print("Parametros");
          print(argument);
          int idtour = int.parse(argument);
          Map<String, dynamic> json = {
            "idtour": idtour
            };
          final infotour = InfoTour.fromJsonMap(json);
          print("Info");
          print(infotour.idtour);
          Navigator.pushNamed(context, deepLink.path,arguments: infotour);
        }
      }
    }
  }
}