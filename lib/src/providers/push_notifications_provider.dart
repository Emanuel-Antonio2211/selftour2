//Se encarga de gestionar las notificaciones push de la aplicación
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:selftourapp/src/pages/usuario/chat_page.dart';


class PushNotificationProvider{
  //Se inicializa las notificaciones
  //Pedirle permiso al usuario de que va a recibir notificaciones
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final GlobalKey<NavigatorState> _navigatorKey = new GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigatorKey;

  Map<String, dynamic> informacion;

  //Se crea un stream para las notificaciones
  final _mensajesStreamController = StreamController<Map<String,dynamic>>.broadcast();

  //Se necesita escuchar lo que se emita en el streamcontroller
  //Cada vez que se reciba una notificación, la aplicación se va a actualizar
  Stream<Map<String,dynamic>> get mensajes => _mensajesStreamController.stream;

  void initNotification(){
    //@mipmap/launcher_icon
    final android = AndroidInitializationSettings(
      '@mipmap/selftouricon'
    );
    final ios = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (int id, String title, String body, String payload)async{
        print("Información");
        print(informacion);
        navigationKey.currentState.push(
          MaterialPageRoute(
            builder: (context){
              return ChatPage(userEmail: informacion['emailuser'],userName: informacion['usuario'], userAvatar: informacion['fotouser']);
            }
          )
        );
      }
    );
    final initializationSettings = InitializationSettings(android, ios);
    localNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: selectNotification
    );
    firebaseMessaging.requestNotificationPermissions(
      IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false)
    );
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
          /*onBackgroundMessage: (info)async{
            
            String usuario = 'no-data';
            String mensaje = 'no-message';
            String emailUser;
            String fotoUser;
            print('===== On BackgroundMessage =====');
            print(info);
            if (info.containsKey('data') && info.containsKey('notification')) {
              // Handle data message
              if(Platform.isAndroid){
              //argumento = info['data']['mensaje'] ?? 'no-data';
                usuario = info['notification']['title'];
                mensaje = info['notification']['body'];
                emailUser = info['data']['iduser'];
                fotoUser = info['data']['useravatar'];
              }else{
                usuario = info['notification']['title'] ?? 'no-data-ios';
                mensaje = info['notification']['body'];
                emailUser = info['data']['iduser'];
                fotoUser = info['data']['useravatar'];
              }
              informacion = {
                "usuario": "${usuario.toString()}",
                "mensaje": "${mensaje.toString()}",
                "emailuser": "${emailUser.toString()}",
                "fotouser": "${fotoUser.toString()}"
              };
            }else{
              print("No hay datos");
            }
            //El argumento se agrega al stream
            _mensajesStreamController.sink.add(informacion);
            //mostrarNotificaciones(fotoUser.toString(),usuario, mensaje);
          },*/
          //Se dispara cuando la aplicación está abierta
          onMessage: (info)async{
            /*
            {
            notification: {title: Vicente Mis, body: hola}, 
            data: {
              iduser: emanuel.antonio2211@gmail.com, 
              nickname: Vicente Mis, 
              click_action: FLUTTER_NOTIFICATION_CLICK,
              useravatar: 
            }
            }
            */
            print('===== On Message =====');
            print(info);
            //Map<String,dynamic> informacion;
            String usuario = 'no-data';
            String mensaje = 'no-message';
            String emailUser;
            String fotoUser;
            if(Platform.isAndroid){
              //argumento = info['data']['mensaje'] ?? 'no-data';
              usuario = info['notification']['title'];
              mensaje = info['notification']['body'];
              emailUser = info['data']['iduser'];
              fotoUser = info['data']['useravatar'];
            }else{
              usuario = info['notification']['title'] ?? 'no-data-ios';
              mensaje = info['notification']['body'];
              emailUser = info['data']['iduser'];
              fotoUser = info['data']['useravatar'];
            }
            informacion = {
              "usuario": "${usuario.toString()}",
              "mensaje": "${mensaje.toString()}",
              "emailuser": "${emailUser.toString()}",
              "fotouser": "${fotoUser.toString()}"
            };
            //El argumento se agrega al stream
            _mensajesStreamController.sink.add(informacion);
            mostrarNotificaciones(fotoUser.toString(),usuario, mensaje);
            /*mensajes.listen((data){
              mostrarNotificaciones(fotoUser.toString(),usuario, mensaje);
              /*navigationKey.currentState.push(
                MaterialPageRoute(
                  builder: (context){
                    return ChatPage(userEmail: informacion['emailuser'],userName: informacion['usuario'], userAvatar: informacion['fotouser']);
                  }
                )
              );*/
            });*/
          },
          //Se dispara cuando la aplicación está terminado o cerrado
          onLaunch: (info)async{
            print('===== On Launch ======');
            print(info);
            //String argumento = 'no-data';
            //Map<String,dynamic> informacion;
            String usuario = 'no-data';
            String mensaje = 'no-message';
            String emailUser;
            String fotoUser;
            if(Platform.isAndroid){
              //argumento = info['data']['mensaje'] ?? 'no-data';
              usuario = info['notification']['title'];
              mensaje = info['notification']['body'];
              emailUser = info['data']['iduser'];
              fotoUser = info['data']['useravatar'];
            }else{
              //argumento = info['mensaje'] ?? 'no-data-ios';
              usuario = info['notification']['title'] ?? 'no-data-ios';
              mensaje = info['notification']['body'];
              emailUser = info['data']['iduser'];
              fotoUser = info['data']['useravatar'];
            }
            informacion = {
              "usuario": "${usuario.toString()}",
              "mensaje": "${mensaje.toString()}",
              "emailuser": "${emailUser.toString()}",
              "fotouser": "${fotoUser.toString()}"
            };
            _mensajesStreamController.sink.add(informacion);
            //mostrarNotificaciones(fotoUser.toString(),usuario, mensaje);
            // mensajes.listen((data){
            //   //mostrarNotificaciones(fotoUser.toString(),usuario, mensaje);
            //   navigationKey.currentState.push(
            //     MaterialPageRoute(
            //       builder: (context){
            //         return ChatPage(userEmail: informacion['emailuser'],userName: informacion['usuario'], userAvatar: informacion['fotouser']);
            //       }
            //     )
            //   );
            // });
            navigationKey.currentState.push(
              MaterialPageRoute(
                builder: (context){
                  return ChatPage(userEmail: info['data']['iduser'],userName: info['data']['nickname'],userAvatar: info['data']['useravatar']);
                }
              )
            );
          },
          //Se dispara cuando la aplicación está en segundo plano
          onResume: (info)async{
            print('===== On Resume ======');
            print(info);
            /*final notificacion = info['data']['mensaje'];
            print(notificacion);*/
            //String argumento = 'no-data';
            //Map<String,dynamic> informacion;
            String usuario = 'no-data';
            String mensaje = 'no-message';
            String emailUser;
            String fotoUser;
            if(Platform.isAndroid){
              //argumento = info['data']['mensaje'] ?? 'no-data';
              usuario = info['notification']['title'];
              mensaje = info['notification']['body'];
              emailUser = info['data']['iduser'];
              fotoUser = info['data']['useravatar'];
            }else{
              //argumento = info['mensaje'] ?? 'no-data-ios';
              usuario = info['notification']['title'] ?? 'no-data-ios';
              mensaje = info['notification']['body'];
              emailUser = info['data']['iduser'];
              fotoUser = info['data']['useravatar'];
            }
            informacion = {
              "usuario": "${usuario.toString()}",
              "mensaje": "${mensaje.toString()}",
              "emailuser": "${emailUser.toString()}",
              "fotouser": "${fotoUser.toString()}"
            };
            _mensajesStreamController.sink.add(informacion);
            //mostrarNotificaciones(fotoUser.toString(),usuario, mensaje);
            
            navigationKey.currentState.push(
              MaterialPageRoute(
                builder: (context){
                  return ChatPage(userEmail: info['data']['iduser'],userName: info['data']['nickname'],userAvatar: info['data']['useravatar']);
                }
              )
            );
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

    Future selectNotification(String payload)async{
      print(payload);
      print("Información");
      print(informacion);
      navigationKey.currentState.push(
        MaterialPageRoute(
          builder: (context){
            return ChatPage(userEmail: informacion['emailuser'].toString(),userName: informacion['usuario'].toString(), userAvatar: informacion['fotouser'].toString());
          }
        )
      );
    }

    void mostrarNotificaciones(String iconUser,String nombreUsuario, String mensaje)async{
      // final largeIconPath = await _downloadAndSaveFile(
      //   'http://via.placeholder.com/48x48','largeIcon'
      // );
      final largeIconPath = await _downloadAndSaveFile(
        '$iconUser','largeIcon'
      );
      final android = AndroidNotificationDetails(
        'channelId', 
        'channelName', 
        'channelDescription',
        //icon: 'assets/iconoapp/launcher_icon.png',
        //icon: '@mipmap/launcher_icon',
        importance: Importance.Max,
        //styleInformation: ,
        //color: Color.blue,
        category: 'msg',
        largeIcon: FilePathAndroidBitmap(largeIconPath),
        ticker: 'ticker',
        priority: Priority.High
        //visibility: NotificationVisibility.Public
      );
      final iOS = IOSNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        attachments: [
          IOSNotificationAttachment(largeIconPath)
        ]
      );
      final platform = NotificationDetails(android, iOS);
      localNotificationsPlugin.show(0, nombreUsuario, mensaje, platform,payload: "Hello");
    }


    Future<String> _downloadAndSaveFile(String url, String fileName) async {
      var directory = await getApplicationDocumentsDirectory();
      var filePath = '${directory.path}/$fileName';
      var response = await http.get(url);
      var file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return filePath;
    }
}