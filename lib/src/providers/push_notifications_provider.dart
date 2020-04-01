//Se encarga de gestionar las notificaciones push de la aplicación
import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';


class PushNotificationProvider{
  //Se inicializa las notificaciones
  //Pedirle permiso al usuario de que va a recibir notificaciones
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  //Se crea un stream para las notificaciones
  final _mensajesStreamController = StreamController<String>.broadcast();

  //Se necesita escuchar lo que se emita en el streamcontroller
  //Cada vez que se reciba una notificación, la aplicación se va a actualizar
  Stream<String> get mensajes => _mensajesStreamController.stream;

  void initNotification(){
    firebaseMessaging.requestNotificationPermissions();
    firebaseMessaging.onTokenRefresh.listen(sendTokenToServer);
        //Se obtiene el token del dispositivo
        firebaseMessaging.getToken().then((token){
          //Este token se almacena en la base de datos
          print('===== FCM Token ========');
          print(token);
    
          //ei1Ip7gZWF8:APA91bE1OOsbRhVxm9l3mwkQuJmubcR_Fyc2tEuyV5Cw9zx_2PNj1GBvmo8TOD8xfwWWdxZPOlWgricxL__jBGmQZrY-WafTQduxc8f_57JBC6BnGiubHrb2Wy6-Doc8ntkLrqGRT4bY
        });
        //Se muestran las maneras de recibir una notificación
        firebaseMessaging.configure(
          //Se dispara cuando la aplicación está abierta
          onMessage: (info){
            print('===== On Message =====');
            print(info);
            String argumento = 'no-data';
            if(Platform.isAndroid){
              argumento = info['data']['mensaje'] ?? 'no-data';
            }else{
              argumento = info['mensaje'] ?? 'no-data-ios';
            }
            //El argumento se agrega al stream
            _mensajesStreamController.sink.add(argumento);
          },
          //Se dispara cuando la aplicación está terminado o cerrado
          onLaunch: (info){
            print('===== On Launch ======');
            print(info);
            String argumento = 'no-data';
            if(Platform.isAndroid){
              argumento = info['data']['mensaje'] ?? 'no-data';
            }else{
              argumento = info['mensaje'] ?? 'no-data-ios';
            }
            _mensajesStreamController.sink.add(argumento);
          },
          //Se dispara cuando la aplicación está en segundo plano
          onResume: (info){
            print('===== On Resume ======');
            print(info);
            /*final notificacion = info['data']['mensaje'];
            print(notificacion);*/
            String argumento = 'no-data';
            if(Platform.isAndroid){
              argumento = info['data']['mensaje'] ?? 'no-data';
            }else{
              argumento = info['mensaje'] ?? 'no-data-ios';
            }
            _mensajesStreamController.sink.add(argumento);
          }
        );
      }
    
      //Se cierra el stream cuando no se use
      dispose(){
        _mensajesStreamController?.close();
      }
    
    void sendTokenToServer(String fcmToken) {
      print("Token: ${fcmToken.toString()}");
  }
}