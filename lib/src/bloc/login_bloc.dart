//Este archivo va a contener todos los casos de uso de la aplicación
import 'dart:async'; //Para manejar streams
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart'; //Aplica el combinelastes
import 'package:selftourapp/src/bloc/validators.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';
//import 'package:selftourapp/src/providers/usuario_provider.dart';
//Se importa el archivo repositorio creado anteriormente
import 'package:selftourapp/src/repository/auth_repository.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';
import 'package:selftourapp/src/utils/utils.dart';

//Aquí consultamos el repositorio, la fuente de datos
//Ya que el método que se usa se está llamando desde la interfaz de usuario
//Crear streams que permitirán controlar el correo y contraseña
//Creamos una clase llamada LoginBloc
class LoginBloc with Validators implements Bloc{
  //Se crea una variable de tipo AuthRepository, es la instancia de la clase
  AuthRepository _authrepository = AuthRepository();
  //Se instancia FirebaseAuth
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //UsuarioProvider _usuarioProvider = UsuarioProvider();
  final firebaseMessaging = FirebaseMessaging();
  PreferenciasUsuario prefs = new PreferenciasUsuario();
  String tokenFCM = '';

  //Se declara el stream - Flujo de datos
  //Stream - Firebase
  //StreamController
  //Un stream a devolver
 final BehaviorSubject<User> streamFirebase = BehaviorSubject<User>();
  //Stream<FirebaseUser> streamFirebase = FirebaseAuth.instance.onAuthStateChanged;
  //Para acceder al estado del stream, nos devuelve el estado de la sesión
  Stream<User> get authStatus =>streamFirebase.stream;

//Constructor
  LoginBloc(){
    _authrepository = AuthRepository();
    //Detecta el inicio de sesión de un usuario
    // _firebaseAuth.currentUser.then((User user){
    //   streamFirebase.sink.add(user);
    // });
    // _firebaseAuth.userChanges().single.then((User user){
    //   streamFirebase.sink.add(user);
    // });
    streamFirebase.sink.add(_firebaseAuth.currentUser);
  }

  Map<String, dynamic> parseJwt(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('invalid token');
  }

  final payload = _decodeBase64(parts[1]);
  final payloadMap = json.decode(payload);
  if (payloadMap is! Map<String, dynamic>) {
    throw Exception('invalid payload');
  }

  return payloadMap;
}

 String _decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }

  return utf8.decode(base64Url.decode(output));
}
  
  //Los bloc se conectan con la interfaz de usuario
  //Casos de uso
  //1. Sign In a la aplicacion con Facebook
 Future<bool> signInFacebook(BuildContext context)async{ //Se va a llamar en la interfaz
  //String bienvenido = AppTranslations.of(context).text('title_welcome');  
  //String aceptar = AppTranslations.of(context).text('title_accept'); 
    _authrepository.signInFirebaseFacebook().then((User authUser)async{
      /*
      if(authUser.providerData[1].email == mail ){
        _authrepository.usuarioNuevo(authUser.providerData[1].displayName, authUser.providerData[1].email, null, authUser.providerData[1].phoneNumber).then((user){
          Map info = user;
          if(info['ok']){
            streamFirebase.sink.add(authUser);
            
          }else{
            mostrarAlerta(context, info['mensaje'], '', 'assets/error.png');
          }
        });
      }else{
        streamFirebase.sink.add(authUser);
        //mostrarAlerta(context, '', bienvenido, 'assets/check.jpg');
        //final size = MediaQuery.of(context).size;
      /* return  Scaffold(
          body: AlertDialog(
            titlePadding: EdgeInsets.symmetric(horizontal: size.width * 0.25),
            title: Text('$bienvenido'),
            content: Container(
              width: size.width * 0.5,
              height: size.height * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  
                  Container(
                    width: size.width * 0.3,
                    height: size.height * 0.2,
                    child: Image.asset("assets/check.jpg"),
                  ),
                  RaisedButton(
                    textTheme: ButtonTextTheme.primary,
                    color: Colors.green,
                    shape: StadiumBorder(),
                    child: Text('$aceptar',style: TextStyle(color: Colors.white),),
                    onPressed: (){
                      //Navigator.pop(context);
                      Navigator.popUntil(context, ModalRoute.withName('menuprincipal'));
                    },
                  )
                ],
              ),
            ),
          ),
        );*/
      }*/

      await _authrepository.loginUserGoogle(authUser.providerData[0].uid.toString()).then((user)async{
        final result = user;
        if(result['_dtu']['msg'] == "Login Successfully"){
          
          String token = '';
          String resultToken = '';
          for(int i = 0; i < result['_dtu']['provider']['_uit'].length; i++){
            token = token + result['_dtu']['provider']['_uit'][i].toString()+".";
            resultToken = token.substring(0,token.length-1);
          }
          print("Token: ");
          print(resultToken);
          //prefs.token = prefs.token + "${result['_dtu']['provider']['_uit'][0].toString()}" + "${result['_dtu']['provider']['_uit'][1].toString()}" + "${result['_dtu']['provider']['_uit'][2].toString()}";
          prefs.token = resultToken;
          final decodedInfoUser = parseJwt(prefs.token.toString());
          
          prefs.iduser = decodedInfoUser['id'].toString();
          prefs.name = result['_dtu']['udt']['name'].toString();
          prefs.email = authUser.providerData[1].email.toString();
          //prefs.phone = authUser.providerData[1].phoneNumber.toString();
          prefs.photoUrl = result['_dtu']['udt']['photoURL'].toString();
          if(authUser != null){
            // Check is already sign up - Checa si está logueado
            firebaseMessaging.getToken().then((token){
              //tokenFCM = token;
              prefs.tokenFCM = token;
              print("Token 1");
            });
            print(prefs.tokenFCM);
          /* Stream<String> fcmStream = firebaseMessaging.onTokenRefresh;
            fcmStream.listen((token){
              prefs.tokenFCM = token;
              print("Token Refresh");
              print(prefs.tokenFCM);
            });*/
            final QuerySnapshot result = await FirebaseFirestore.instance.collection('users').where('email',isEqualTo: prefs.email).get(); //authUser.providerData[1].email
            final List<DocumentSnapshot> documents = result.docs;
            final coleccion = FirebaseFirestore.instance.collection('users').doc('${prefs.email}').collection('tokensfcm');
            if(documents.length == 0){
              // Update data to server if new user - Actualiza los datos del servidor
              // si el usuario es nuevo myUser.providerData[1].uid
              //authUser.providerData[1].email
              FirebaseFirestore.instance.collection('users').doc(prefs.email).set(
                {
                  'tokenfcm':"${prefs.tokenFCM.toString()}",
                  'nickname': prefs.name,//authUser.providerData[1].displayName
                  'id': prefs.iduser,//authUser.providerData[1].uid
                  'email': prefs.email,//authUser.providerData[1].email
                  'photoUrl': prefs.photoUrl,//authUser.providerData[1].photoUrl
                  'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
                  'chattingWith': null
                }
              );

              FirebaseFirestore.instance.runTransaction((transaction)async{
                  transaction.set(
                    coleccion.doc(),
                    {
                      'token': prefs.tokenFCM.toString()
                    }
                  );
                }).then((result){
                  print(result);
                }).catchError((error){
                  print(error);
                });
              // Write data to local - Escribir los datos en local
            // FirebaseUser currentUser = user;
              
            }else{
              print("El usuario ya existe");
              final QuerySnapshot result = await FirebaseFirestore.instance.collection('users').where('email',isEqualTo: prefs.email).get(); //authUser.providerData[1].email
              final List<DocumentSnapshot> documents = result.docs;
              final coleccion = FirebaseFirestore.instance.collection('users').doc('${prefs.email}').collection('tokensfcm');
              //final List<DocumentSnapshot> documentColeccion = coleccion.documents;
              //documentColeccion.single.data['token'] != prefs.tokenFCM

              
              if(documents.single.data()['tokenfcm'] != prefs.tokenFCM ){
                  
                  // Firestore.instance.collection('users').document(prefs.email).setData(
                  //   {
                  //     'tokenfcm':"$tokenFCM",
                  //     'nickname': prefs.name,//authUser.providerData[1].displayName
                  //     'id': prefs.iduser,//authUser.providerData[1].uid
                  //     'idtokens': tokenFCM,
                  //     'email': prefs.email,//authUser.providerData[1].email
                  //     'photoUrl': prefs.photoUrl,//authUser.providerData[1].photoUrl
                  //     'createdAt': DateTime.now().millisecondsSinceEpoch.toString()
                  //     //'chattingWith': null
                  //   }
                  // );
                FirebaseFirestore.instance.collection('users').doc(prefs.email).update({
                  'tokenfcm': prefs.tokenFCM.toString()
                });
                print("Escribiendo datos");
                FirebaseFirestore.instance.runTransaction((transaction)async{
                  transaction.set(
                    coleccion.doc(),
                    {
                      'token': prefs.tokenFCM.toString()
                    }
                  );
                }).then((result){
                  print(result);
                }).catchError((error){
                  print(error);
                });
              }else{
                print("tiene el mismo token fcm");
              }
              /*Stream<String> fcmStream = firebaseMessaging.onTokenRefresh;
              fcmStream.listen((token){
                prefs.tokenFCM = token;
                print("Token Refresh");
                print(prefs.tokenFCM);
              });*/
            }
          }
          print("Datos del usuario decodificado");
          print(decodedInfoUser);
          streamFirebase.sink.add(authUser);
        }else{
          mostrarAlerta(context, result['_dtu']['msg'].toString() , '', 'assets/error.png'); //result['_dtu']['msg']
        }
      }).catchError((error){
        mostrarAlerta(context, error.toString(), '', 'assets/error.png');
      });
    }).catchError((error){
      String invalidCredential = AppTranslations.of(context).text('title_invalid_credential');
      String userDisabled = AppTranslations.of(context).text('title_user_disabled');
      String accountExist = AppTranslations.of(context).text('title_account_exist');
      String googleaccountsDisabled = AppTranslations.of(context).text('title_accounts_disabled');
      String invalidactionCode = AppTranslations.of(context).text('title_action_code_invalid');
      print(error);
      if(error.code == "ERROR_INVALID_CREDENTIAL"){
        mostrarAlerta(context, "$invalidCredential", '', 'assets/error.png');
      }else if(error.code == "ERROR_USER_DISABLED"){
        mostrarAlerta(context, "$userDisabled", '', 'assets/error.png');
      }else if(error.code == "ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL"){
        mostrarAlerta(context, "$accountExist", '', 'assets/error.png');
      }else if(error.code == "ERROR_OPERATION_NOT_ALLOWED"){
        mostrarAlerta(context, "$googleaccountsDisabled", '', 'assets/error.png');
      }else if(error.code == "ERROR_INVALID_ACTION_CODE"){
        mostrarAlerta(context, "$invalidactionCode", '', 'assets/error.png');
      }else{
        mostrarAlerta(context, "${error.toString()}", '', 'assets/error.png');
      }
    });

    return true;
  }
  //2. Sign In a la aplicacion con Twitter
  /*
  signInTwitter(BuildContext context) async { //Se va a llamar en la interfaz
    _authrepository.signInFirebaseTwitter().then((FirebaseUser authUser){
      
      if(authUser.providerData[1].email == mail){
        _authrepository.usuarioNuevo(authUser.providerData[1].displayName, authUser.providerData[1].email, null, authUser.providerData[1].phoneNumber).then((user){
          Map info = user;
          if(info['ok']){
            streamFirebase.sink.add(authUser);
            Navigator.pop(context);
          }else{
            mostrarAlerta(context, info['mensaje'], '', 'assets/error.png');
          }
        });
      }else{
        streamFirebase.sink.add(authUser);
      }
    }).catchError((error){
      mostrarAlerta(context, error.toString(), '', 'assets/error.png');
    });
  }
  */
  //3. Sign In a la aplicacion con Google
Future<bool> signInGoogle(BuildContext context) async { //Se va a llamar en la interfaz
  await _authrepository.signInFirebaseGoogle().then((User authUser)async{
   
   /*if(authUser == null){
    /*_authrepository.usuarioNuevo(authUser.providerData[1].displayName, authUser.providerData[1].email, null, authUser.providerData[1].phoneNumber).then((user){
      //Navigator.pop(context);
      
      Map info = user;
      if(info['ok']){
        streamFirebase.sink.add(authUser);
      }else{
        mostrarAlerta(context, info['mensaje'], '', 'assets/error.png');
      }
    }).catchError((error){
      mostrarAlerta(context, error.toString(), error.toString(), 'assets/error.png');
    });*/
    await _authrepository.loginUserGoogle(authUser.providerData[0].uid).then((user){
      final result = user;
      if(result['_dtu']['msg'] == "Login Successfully"){
        prefs.token = result['_dtu']['provider']['_uit'][0] + result['_dtu']['provider']['_uit'][1] + result['_dtu']['provider']['_uit'][2];
        final decodedInfoUser = parseJwt(prefs.token);
        print("Datos del usuario decodificado");
        print(decodedInfoUser);
        streamFirebase.sink.add(authUser);
      }else{
        mostrarAlerta(context, result['_dtu']['msg'], '', 'assets/error.png');
      }
    }).catchError((error){
      mostrarAlerta(context, error.toString(), error.toString(), 'assets/error.png');
    });
   }else{
     streamFirebase.sink.add(authUser);
   }*/
    await _authrepository.loginUserGoogle(authUser.uid.toString()).then((user)async{
      final result = user;
      if(result['_dtu']['msg'] == "Login Successfully"){
        
        String token = '';
        String resultToken = '';
        for(int i = 0; i < result['_dtu']['provider']['_uit'].length; i++){
          token = token + result['_dtu']['provider']['_uit'][i].toString()+".";
          resultToken = token.substring(0,token.length-1);
        }
        print("Token: ");
        print(resultToken);
        //prefs.token = prefs.token + "${result['_dtu']['provider']['_uit'][0].toString()}" + "${result['_dtu']['provider']['_uit'][1].toString()}" + "${result['_dtu']['provider']['_uit'][2].toString()}";
        prefs.token = resultToken;
        final decodedInfoUser = parseJwt(prefs.token.toString());
        
        prefs.iduser = decodedInfoUser['id'].toString();
        prefs.name = result['_dtu']['udt']['name'].toString();
        prefs.email = authUser.providerData[0].email.toString();
        //prefs.phone = authUser.providerData[1].phoneNumber.toString();
        prefs.photoUrl = result['_dtu']['udt']['photoURL'].toString();//result['_dtu']['udt']['photoURL'].toString()
        if(authUser != null){
          // Check is already sign up - Checa si está logueado
          firebaseMessaging.getToken().then((token){
            //tokenFCM = token;
            prefs.tokenFCM = token;
            print("Token 1");
          });
          
          //prefs.tokenFCM = tokenFCM;
          print(prefs.tokenFCM);
         /* Stream<String> fcmStream = firebaseMessaging.onTokenRefresh;
          fcmStream.listen((token){
            prefs.tokenFCM = token;
            print("Token Refresh");
            print(prefs.tokenFCM);
          });*/
          final QuerySnapshot result = await FirebaseFirestore.instance.collection('users').where('email',isEqualTo: prefs.email).get(); //authUser.providerData[1].email
          final List<DocumentSnapshot> documents = result.docs;

          final coleccion = FirebaseFirestore.instance.collection('users').doc('${prefs.email}').collection('tokensfcm');
          //final List<DocumentSnapshot> documentColeccion = coleccion.documents;
          if(documents.length == 0){
            // Update data to server if new user - Actualiza los datos del servidor
            // si el usuario es nuevo myUser.providerData[1].uid
            //authUser.providerData[1].email
            FirebaseFirestore.instance.collection('users').doc(prefs.email).set(
              {
                'tokenfcm':"${prefs.tokenFCM.toString()}",
                'nickname': prefs.name,//authUser.providerData[1].displayName
                'id': prefs.iduser,//authUser.providerData[1].uid
                'email': prefs.email,//authUser.providerData[1].email
                'photoUrl': prefs.photoUrl,//authUser.providerData[1].photoUrl
                'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
                'chattingWith': null
              }
            );

            FirebaseFirestore.instance.runTransaction((transaction)async{
                  transaction.set(
                    coleccion.doc(),
                    {
                      'token': prefs.tokenFCM.toString()
                    }
                  );
                }).then((result){
                  print(result);
                }).catchError((error){
                  print(error);
                });
            // Write data to local - Escribir los datos en local
          // FirebaseUser currentUser = user;
            
          }else{
            print("El usuario ya existe");
            final QuerySnapshot result = await FirebaseFirestore.instance.collection('users').where('email',isEqualTo: prefs.email).get(); //authUser.providerData[1].email
            final List<DocumentSnapshot> documents = result.docs;
            final  coleccion = FirebaseFirestore.instance.collection('users').doc('${prefs.email}').collection('tokensfcm');
            //final List<DocumentSnapshot> documentColeccion = coleccion.documents;
            //documentColeccion.single.data['token'] != prefs.tokenFCM

            
            if(documents.single.data()['tokenfcm'] != prefs.tokenFCM ){
                
                // Firestore.instance.collection('users').document(prefs.email).setData(
                //   {
                //     'tokenfcm':"$tokenFCM",
                //     'nickname': prefs.name,//authUser.providerData[1].displayName
                //     'id': prefs.iduser,//authUser.providerData[1].uid
                //     'idtokens': tokenFCM,
                //     'email': prefs.email,//authUser.providerData[1].email
                //     'photoUrl': prefs.photoUrl,//authUser.providerData[1].photoUrl
                //     'createdAt': DateTime.now().millisecondsSinceEpoch.toString()
                //     //'chattingWith': null
                //   }
                // );
                FirebaseFirestore.instance.collection('users').doc(prefs.email).update({
                  'tokenfcm': prefs.tokenFCM.toString()
                });
                print("Escribiendo datos");
                FirebaseFirestore.instance.runTransaction((transaction)async{
                  transaction.set(
                    coleccion.doc(),
                    {
                      'token': prefs.tokenFCM.toString()
                    }
                  );
                }).then((result){
                  print(result);
                }).catchError((error){
                  print(error);
                });
              }else{
                print("tiene el mismo token fcm");
              }
            
            /*Stream<String> fcmStream = firebaseMessaging.onTokenRefresh;
            fcmStream.listen((token){
              prefs.tokenFCM = token;
              print("Token Refresh");
              print(prefs.tokenFCM);
            });*/
            
            //Obtiene el sistema operativo
            print("Sistema operativo: ");
            print(Platform.operatingSystem);
          }
        }
        print("Datos del usuario decodificado");
        print(decodedInfoUser);

        streamFirebase.sink.add(authUser);
      }else{
        mostrarAlerta(context, result['_dtu']['msg'].toString() , '', 'assets/error.png'); //result['_dtu']['msg']
      }
    }).catchError((error){
      mostrarAlerta(context, error.toString(), '', 'assets/error.png');
    });
     //await usuarioNuevo(myUser.displayName, myUser.email, null, null);
   }).catchError((error){
     String invalidCredential = AppTranslations.of(context).text('title_invalid_credential');
     String userDisabled = AppTranslations.of(context).text('title_user_disabled');
     String accountExist = AppTranslations.of(context).text('title_account_exist');
     String googleaccountsDisabled = AppTranslations.of(context).text('title_accounts_disabled');
     String invalidactionCode = AppTranslations.of(context).text('title_action_code_invalid');
    print(error.toString());
     if(error.code == "ERROR_INVALID_CREDENTIAL"){
       mostrarAlerta(context, "$invalidCredential", '', 'assets/error.png');
     }else if(error.code == "ERROR_USER_DISABLED"){
       mostrarAlerta(context, "$userDisabled", '', 'assets/error.png');
     }else if(error.code == "ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL"){
       mostrarAlerta(context, "$accountExist", '', 'assets/error.png');
     }else if(error.code == "ERROR_OPERATION_NOT_ALLOWED"){
       mostrarAlerta(context, "$googleaccountsDisabled", '', 'assets/error.png');
     }else if(error.code == "ERROR_INVALID_ACTION_CODE"){
       mostrarAlerta(context, "$invalidactionCode", '', 'assets/error.png');
     }else{
       mostrarAlerta(context, "${error.message.toString()}", '', 'assets/error.png');
     }
   });
   return true;
  }
Future<void> signInEmail( String email,String pass, BuildContext context)async{
    //final size = MediaQuery.of(context).size;
    //String noverificado = AppTranslations.of(context).text('title_noverificado');
    await _authrepository.logEmailPassword(email, pass).then((authUser)async{
      await _authrepository.loginUserGoogle(authUser.uid).then((result)async{
        if(result['_dtu']['msg'] == "Login Successfully"){
          String token = '';
          String resultToken = '';
          for(int i = 0; i < result['_dtu']['provider']['_uit'].length; i++){
            token = token + result['_dtu']['provider']['_uit'][i].toString()+".";
            resultToken = token.substring(0,token.length-1);
          }

          print("Token: ");
          print(resultToken);
          //prefs.token = prefs.token + "${result['_dtu']['provider']['_uit'][0].toString()}" + "${result['_dtu']['provider']['_uit'][1].toString()}" + "${result['_dtu']['provider']['_uit'][2].toString()}";
          prefs.token = resultToken;
          final decodedInfoUser = parseJwt(prefs.token.toString());
          
          prefs.iduser = decodedInfoUser['id'].toString();
          prefs.name = result['_dtu']['udt']['name'].toString();
          prefs.email = authUser.providerData[0].email.toString();
          //prefs.phone = authUser.providerData[1].phoneNumber.toString();
          prefs.photoUrl = result['_dtu']['udt']['photoURL'].toString();//result['_dtu']['udt']['photoURL'].toString()
          if(authUser != null){
            // Check is already sign up - Checa si está logueado
            firebaseMessaging.getToken().then((token){
              //tokenFCM = token;
              prefs.tokenFCM = token;
              print("Token 1");
            });
            
            //prefs.tokenFCM = tokenFCM;
            print(prefs.tokenFCM);
          /* Stream<String> fcmStream = firebaseMessaging.onTokenRefresh;
            fcmStream.listen((token){
              prefs.tokenFCM = token;
              print("Token Refresh");
              print(prefs.tokenFCM);
            });*/
            final QuerySnapshot result = await FirebaseFirestore.instance.collection('users').where('email',isEqualTo: prefs.email).get(); //authUser.providerData[1].email
            final List<DocumentSnapshot> documents = result.docs;

            final coleccion = FirebaseFirestore.instance.collection('users').doc('${prefs.email}').collection('tokensfcm');
            //final List<DocumentSnapshot> documentColeccion = coleccion.documents;
            if(documents.length == 0){
              // Update data to server if new user - Actualiza los datos del servidor
              // si el usuario es nuevo myUser.providerData[1].uid
              //authUser.providerData[1].email
              FirebaseFirestore.instance.collection('users').doc(prefs.email).set(
                {
                  'tokenfcm':"${prefs.tokenFCM.toString()}",
                  'nickname': prefs.name,//authUser.providerData[1].displayName
                  'id': prefs.iduser,//authUser.providerData[1].uid
                  'email': prefs.email,//authUser.providerData[1].email
                  'photoUrl': prefs.photoUrl,//authUser.providerData[1].photoUrl
                  'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
                  'chattingWith': null
                }
              );

              FirebaseFirestore.instance.runTransaction((transaction)async{
                    transaction.set(
                      coleccion.doc(),
                      {
                        'token': prefs.tokenFCM.toString()
                      }
                    );
                  }).then((result){
                    print(result);
                  }).catchError((error){
                    print(error);
                  });
              // Write data to local - Escribir los datos en local
            // FirebaseUser currentUser = user;
              
            }else{
              print("El usuario ya existe");
              final QuerySnapshot result = await FirebaseFirestore.instance.collection('users').where('email',isEqualTo: prefs.email).get(); //authUser.providerData[1].email
              final List<DocumentSnapshot> documents = result.docs;
              final  coleccion = FirebaseFirestore.instance.collection('users').doc('${prefs.email}').collection('tokensfcm');
              //final List<DocumentSnapshot> documentColeccion = coleccion.documents;
              //documentColeccion.single.data['token'] != prefs.tokenFCM

              
              if(documents.single.data()['tokenfcm'] != prefs.tokenFCM ){
                  
                  // Firestore.instance.collection('users').document(prefs.email).setData(
                  //   {
                  //     'tokenfcm':"$tokenFCM",
                  //     'nickname': prefs.name,//authUser.providerData[1].displayName
                  //     'id': prefs.iduser,//authUser.providerData[1].uid
                  //     'idtokens': tokenFCM,
                  //     'email': prefs.email,//authUser.providerData[1].email
                  //     'photoUrl': prefs.photoUrl,//authUser.providerData[1].photoUrl
                  //     'createdAt': DateTime.now().millisecondsSinceEpoch.toString()
                  //     //'chattingWith': null
                  //   }
                  // );
                  FirebaseFirestore.instance.collection('users').doc(prefs.email).update({
                    'tokenfcm': prefs.tokenFCM.toString()
                  });
                  print("Escribiendo datos");
                  FirebaseFirestore.instance.runTransaction((transaction)async{
                    transaction.set(
                      coleccion.doc(),
                      {
                        'token': prefs.tokenFCM.toString()
                      }
                    );
                  }).then((result){
                    print(result);
                  }).catchError((error){
                    print(error);
                  });
                }else{
                  print("tiene el mismo token fcm");
                }
              
              /*Stream<String> fcmStream = firebaseMessaging.onTokenRefresh;
              fcmStream.listen((token){
                prefs.tokenFCM = token;
                print("Token Refresh");
                print(prefs.tokenFCM);
              });*/
            }
          }
          print("Datos del usuario decodificado");
          print(decodedInfoUser);
          streamFirebase.sink.add(authUser);
          Navigator.pop(context);
          
        }else{
          mostrarAlerta(context, result['_dtu']['msg'].toString() , '', 'assets/error.png'); //result['_dtu']['msg']
        }
      }).catchError((error){
        mostrarAlerta(context, "${error.toString()}", '', 'assets/error.png');
      });
      // if(authUser == null){
      //  await _authrepository.registerEmail(email, pass).then((user){
      //     if(user.isEmailVerified){

      //       mostrarAlerta(context, user.isEmailVerified.toString(), '', 'assets/error.png');
      //     }else{
      //       mostrarAlerta(context, '$noverificado', '', 'assets/error.png');
      //     }
      //   }).catchError((error){
      //     mostrarAlerta(context, error.toString(), '', 'assets/error.png');
      //   });
      // }else{
      //   streamFirebase.sink.add(authUser);
      //   Navigator.pop(context);
      // }
      
    }).catchError((error){
      String passIncorrect = AppTranslations.of(context).text('title_pass_incorrect');
      String emailNoWritten = AppTranslations.of(context).text('title_correo_no_written');
      String usernotFound = AppTranslations.of(context).text('title_user_not_found');
      String userDisabled = AppTranslations.of(context).text('title_user_disabled');
      String toomanyRequest = AppTranslations.of(context).text('title_too_many_request');
      String emailpassnoEnabled = AppTranslations.of(context).text('title_email_pass_no_enabled');

      if(error.code == "ERROR_INVALID_EMAIL"){
        mostrarAlerta(context, "$emailNoWritten",'', 'assets/error.png');
      }else if(error.code == "ERROR_WRONG_PASSWORD"){
        mostrarAlerta(context, "$passIncorrect",'', 'assets/error.png');
      }else if(error.code == "ERROR_USER_NOT_FOUND"){
        mostrarAlerta(context, "$usernotFound",'', 'assets/error.png');
      }else if(error.code == "ERROR_USER_DISABLED"){
        mostrarAlerta(context, "$userDisabled",'', 'assets/error.png');
      }else if(error.code == "ERROR_TOO_MANY_REQUESTS"){
        mostrarAlerta(context, "$toomanyRequest",'', 'assets/error.png');
      }else if(error.code == "ERROR_OPERATION_NOT_ALLOWED"){
        mostrarAlerta(context, "$emailpassnoEnabled",'', 'assets/error.png');
      }else{
        mostrarAlerta(context, "${error.message.toString()}",'', 'assets/error.png');
      }
      
    });
  }

 Future<void> createUser(BuildContext context,String nombre,String email, String password,String telefono)async{
    String errorReg = AppTranslations.of(context).text('title_errorreg');
    
    //String errorLog = AppTranslations.of(context).text('title_errorlog');
    await _authrepository.registerEmail(email, password).then((usuario)async{
     //await signInEmail(email, pass,context);
        await _authrepository.usuarioNuevo(nombre, email, password, telefono).then((result)async{
          if(result['msg'] == "Signed up "){
              await _authrepository.loginUserGoogle(usuario.uid).then((resp)async{
                if(resp['_dtu']['msg'] == "Login Successfully"){
                  String token = '';
                  String resultToken = '';
                  for(int i = 0; i < resp['_dtu']['provider']['_uit'].length; i++){
                    token = token + resp['_dtu']['provider']['_uit'][i].toString()+".";
                    resultToken = token.substring(0,token.length-1);
                  }

                  print("Token: ");
                  print(resultToken);
                  //prefs.token = prefs.token + "${result['_dtu']['provider']['_uit'][0].toString()}" + "${result['_dtu']['provider']['_uit'][1].toString()}" + "${result['_dtu']['provider']['_uit'][2].toString()}";
                  prefs.token = resultToken;
                  final decodedInfoUser = parseJwt(prefs.token.toString());
                  
                  prefs.iduser = decodedInfoUser['id'].toString();
                  prefs.name = resp['_dtu']['udt']['name'].toString();
                  prefs.email = usuario.providerData[0].email.toString();
                  //prefs.phone = authUser.providerData[1].phoneNumber.toString();
                  prefs.photoUrl = resp['_dtu']['udt']['photoURL'].toString();//result['_dtu']['udt']['photoURL'].toString()
                  if(usuario != null){
                    // Check is already sign up - Checa si está logueado
                    firebaseMessaging.getToken().then((token){
                      //tokenFCM = token;
                      prefs.tokenFCM = token;
                      print("Token 1");
                    });
                    
                    //prefs.tokenFCM = tokenFCM;
                    print(prefs.tokenFCM);
                  /* Stream<String> fcmStream = firebaseMessaging.onTokenRefresh;
                    fcmStream.listen((token){
                      prefs.tokenFCM = token;
                      print("Token Refresh");
                      print(prefs.tokenFCM);
                    });*/
                    final QuerySnapshot result = await FirebaseFirestore.instance.collection('users').where('email',isEqualTo: prefs.email).get(); //authUser.providerData[1].email
                    final List<DocumentSnapshot> documents = result.docs;

                    final coleccion = FirebaseFirestore.instance.collection('users').doc('${prefs.email}').collection('tokensfcm');
                    //final List<DocumentSnapshot> documentColeccion = coleccion.documents;
                    if(documents.length == 0){
                      // Update data to server if new user - Actualiza los datos del servidor
                      // si el usuario es nuevo myUser.providerData[1].uid
                      //authUser.providerData[1].email
                      FirebaseFirestore.instance.collection('users').doc(prefs.email).set(
                        {
                          'tokenfcm':"${prefs.tokenFCM.toString()}",
                          'nickname': prefs.name,//authUser.providerData[1].displayName
                          'id': prefs.iduser,//authUser.providerData[1].uid
                          'email': prefs.email,//authUser.providerData[1].email
                          'photoUrl': prefs.photoUrl,//authUser.providerData[1].photoUrl
                          'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
                          'chattingWith': null
                        }
                      );

                      FirebaseFirestore.instance.runTransaction((transaction)async{
                            transaction.set(
                              coleccion.doc(),
                              {
                                'token': prefs.tokenFCM.toString()
                              }
                            );
                          }).then((result){
                            print(result);
                          }).catchError((error){
                            print(error);
                          });
                      // Write data to local - Escribir los datos en local
                    // FirebaseUser currentUser = user;
                      
                    }else{
                      print("El usuario ya existe");
                      final QuerySnapshot result = await FirebaseFirestore.instance.collection('users').where('email',isEqualTo: prefs.email).get(); //authUser.providerData[1].email
                      final List<DocumentSnapshot> documents = result.docs;
                      final  coleccion = FirebaseFirestore.instance.collection('users').doc('${prefs.email}').collection('tokensfcm');
                      //final List<DocumentSnapshot> documentColeccion = coleccion.documents;
                      //documentColeccion.single.data['token'] != prefs.tokenFCM

                      
                      if(documents.single.data()['tokenfcm'] != prefs.tokenFCM ){
                          
                          // Firestore.instance.collection('users').document(prefs.email).setData(
                          //   {
                          //     'tokenfcm':"$tokenFCM",
                          //     'nickname': prefs.name,//authUser.providerData[1].displayName
                          //     'id': prefs.iduser,//authUser.providerData[1].uid
                          //     'idtokens': tokenFCM,
                          //     'email': prefs.email,//authUser.providerData[1].email
                          //     'photoUrl': prefs.photoUrl,//authUser.providerData[1].photoUrl
                          //     'createdAt': DateTime.now().millisecondsSinceEpoch.toString()
                          //     //'chattingWith': null
                          //   }
                          // );
                          FirebaseFirestore.instance.collection('users').doc(prefs.email).update({
                            'tokenfcm': prefs.tokenFCM.toString()
                          });
                          print("Escribiendo datos");
                          FirebaseFirestore.instance.runTransaction((transaction)async{
                            transaction.set(
                              coleccion.doc(),
                              {
                                'token': prefs.tokenFCM.toString()
                              }
                            );
                          }).then((result){
                            print(result);
                          }).catchError((error){
                            print(error);
                          });
                        }else{
                          print("tiene el mismo token fcm");
                        }
                      
                      /*Stream<String> fcmStream = firebaseMessaging.onTokenRefresh;
                      fcmStream.listen((token){
                        prefs.tokenFCM = token;
                        print("Token Refresh");
                        print(prefs.tokenFCM);
                      });*/
                    }
                  }
                  print("Datos del usuario decodificado");
                  print(decodedInfoUser);
                  streamFirebase.sink.add(usuario);
                  Navigator.pop(context);
                  
                }else{
                  mostrarAlerta(context, resp['_dtu']['msg'].toString() , '', 'assets/error.png'); //result['_dtu']['msg']
                }
              }).catchError((error){
                mostrarAlerta(context, "${error.toString()}", '', 'assets/error.png');
              });
          }else{
            await _authrepository.loginUserGoogle(usuario.uid).then((resp)async{
                if(resp['_dtu']['msg'] == "Login Successfully"){
                  String token = '';
                  String resultToken = '';
                  for(int i = 0; i < resp['_dtu']['provider']['_uit'].length; i++){
                    token = token + resp['_dtu']['provider']['_uit'][i].toString()+".";
                    resultToken = token.substring(0,token.length-1);
                  }

                  print("Token: ");
                  print(resultToken);
                  //prefs.token = prefs.token + "${result['_dtu']['provider']['_uit'][0].toString()}" + "${result['_dtu']['provider']['_uit'][1].toString()}" + "${result['_dtu']['provider']['_uit'][2].toString()}";
                  prefs.token = resultToken;
                  final decodedInfoUser = parseJwt(prefs.token.toString());
                  
                  prefs.iduser = decodedInfoUser['id'].toString();
                  prefs.name = resp['_dtu']['udt']['name'].toString();
                  prefs.email = usuario.providerData[0].email.toString();
                  //prefs.phone = authUser.providerData[1].phoneNumber.toString();
                  prefs.photoUrl = resp['_dtu']['udt']['photoURL'].toString();//result['_dtu']['udt']['photoURL'].toString()
                  if(usuario != null){
                    // Check is already sign up - Checa si está logueado
                    firebaseMessaging.getToken().then((token){
                      //tokenFCM = token;
                      prefs.tokenFCM = token;
                      print("Token 1");
                    });
                    
                    //prefs.tokenFCM = tokenFCM;
                    print(prefs.tokenFCM);
                  /* Stream<String> fcmStream = firebaseMessaging.onTokenRefresh;
                    fcmStream.listen((token){
                      prefs.tokenFCM = token;
                      print("Token Refresh");
                      print(prefs.tokenFCM);
                    });*/
                    final QuerySnapshot result = await FirebaseFirestore.instance.collection('users').where('email',isEqualTo: prefs.email).get(); //authUser.providerData[1].email
                    final List<DocumentSnapshot> documents = result.docs;

                    final coleccion = FirebaseFirestore.instance.collection('users').doc('${prefs.email}').collection('tokensfcm');
                    //final List<DocumentSnapshot> documentColeccion = coleccion.documents;
                    if(documents.length == 0){
                      // Update data to server if new user - Actualiza los datos del servidor
                      // si el usuario es nuevo myUser.providerData[1].uid
                      //authUser.providerData[1].email
                      FirebaseFirestore.instance.collection('users').doc(prefs.email).set(
                        {
                          'tokenfcm':"${prefs.tokenFCM.toString()}",
                          'nickname': prefs.name,//authUser.providerData[1].displayName
                          'id': prefs.iduser,//authUser.providerData[1].uid
                          'email': prefs.email,//authUser.providerData[1].email
                          'photoUrl': prefs.photoUrl,//authUser.providerData[1].photoUrl
                          'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
                          'chattingWith': null
                        }
                      );

                      FirebaseFirestore.instance.runTransaction((transaction)async{
                            transaction.set(
                              coleccion.doc(),
                              {
                                'token': prefs.tokenFCM.toString()
                              }
                            );
                          }).then((result){
                            print(result);
                          }).catchError((error){
                            print(error);
                          });
                      // Write data to local - Escribir los datos en local
                    // FirebaseUser currentUser = user;
                      
                    }else{
                      print("El usuario ya existe");
                      final QuerySnapshot result = await FirebaseFirestore.instance.collection('users').where('email',isEqualTo: prefs.email).get(); //authUser.providerData[1].email
                      final List<DocumentSnapshot> documents = result.docs;
                      final  coleccion = FirebaseFirestore.instance.collection('users').doc('${prefs.email}').collection('tokensfcm');
                      //final List<DocumentSnapshot> documentColeccion = coleccion.documents;
                      //documentColeccion.single.data['token'] != prefs.tokenFCM

                      
                      if(documents.single.data()['tokenfcm'] != prefs.tokenFCM ){
                          
                          // Firestore.instance.collection('users').document(prefs.email).setData(
                          //   {
                          //     'tokenfcm':"$tokenFCM",
                          //     'nickname': prefs.name,//authUser.providerData[1].displayName
                          //     'id': prefs.iduser,//authUser.providerData[1].uid
                          //     'idtokens': tokenFCM,
                          //     'email': prefs.email,//authUser.providerData[1].email
                          //     'photoUrl': prefs.photoUrl,//authUser.providerData[1].photoUrl
                          //     'createdAt': DateTime.now().millisecondsSinceEpoch.toString()
                          //     //'chattingWith': null
                          //   }
                          // );
                          FirebaseFirestore.instance.collection('users').doc(prefs.email).update({
                            'tokenfcm': prefs.tokenFCM.toString()
                          });
                          print("Escribiendo datos");
                          FirebaseFirestore.instance.runTransaction((transaction)async{
                            transaction.set(
                              coleccion.doc(),
                              {
                                'token': prefs.tokenFCM.toString()
                              }
                            );
                          }).then((result){
                            print(result);
                          }).catchError((error){
                            print(error);
                          });
                        }else{
                          print("tiene el mismo token fcm");
                        }
                      
                      /*Stream<String> fcmStream = firebaseMessaging.onTokenRefresh;
                      fcmStream.listen((token){
                        prefs.tokenFCM = token;
                        print("Token Refresh");
                        print(prefs.tokenFCM);
                      });*/
                    }
                  }
                  print("Datos del usuario decodificado");
                  print(decodedInfoUser);
                  streamFirebase.sink.add(usuario);
                  Navigator.pop(context);
                  
                }else{
                  mostrarAlerta(context, resp['_dtu']['msg'].toString(), '', 'assets/error.png'); //result['_dtu']['msg']
                }
              }).catchError((error){
                mostrarAlerta(context, "${error.toString()}", '', 'assets/error.png');
              });
            //mostrarAlerta(context, "${result['msg'].toString()}",'$errorReg', 'assets/error.png');
          }
        }).catchError((error){
          mostrarAlerta(context, '${error.toString()}','$errorReg', 'assets/error.png');
        });
        
    }).catchError((error){
      String passNoSecure = AppTranslations.of(context).text('title_secure_password');
      String emailNoWritten = AppTranslations.of(context).text('title_correo_no_written');
      String emailisReady = AppTranslations.of(context).text('title_email_isready');
      print("Respuesta Firebase Registro: ");
      print(error);
      if(error.code == "ERROR_WEAK_PASSWORD"){
        mostrarAlerta(context, "$passNoSecure",'', 'assets/error.png');
      }else if(error.code == "ERROR_INVALID_EMAIL"){
        mostrarAlerta(context, "$emailNoWritten",'', 'assets/error.png');
      }else if(error.code == "ERROR_EMAIL_ALREADY_IN_USE"){
        mostrarAlerta(context, "$emailisReady",'', 'assets/error.png');
      }else{
        mostrarAlerta(context, "${error.message.toString()}",'', 'assets/error.png');
      }
    });

    
   /* _authrepository.signInEmailPass(email, pass).then((usuario){
      streamFirebase.sink.add(usuario);
    }).catchError((error){
      mostrarAlerta(context, error,'$errorLog', 'assets/error.png');
      //return error;
    });*/
  }

  Future<void> resetPassword(BuildContext context, String email, String languageCode)async{
    String reseteoSuccess = AppTranslations.of(context).text('title_send_email');

    await _authrepository.resetPassword(email, languageCode).then((value){
      Navigator.pop(context);
      mostrarMensajeResetPassword(context, '$reseteoSuccess $email', '');
     
    }).catchError((error){
      String emailNoWritten = AppTranslations.of(context).text('title_correo_no_written');
      String usernotFound = AppTranslations.of(context).text('title_user_not_found');
      String errorReset = AppTranslations.of(context).text('title_error_reset');
      
      if(error.code == "ERROR_INVALID_EMAIL"){
        mostrarMensajeErrorResetPassword(context, '$emailNoWritten' , '$errorReset');
      }else if(error.code == "ERROR_USER_NOT_FOUND"){
        mostrarMensajeErrorResetPassword(context, '$usernotFound' , '$errorReset');
      }else{
        mostrarMensajeErrorResetPassword(context, '${error.message.toString()}' , '$errorReset');
      }
      
    });
  }
  //Ejecuta el cierre de sesión
  signOut() async {
    _authrepository.signOut().then(streamFirebase.sink.add);
    prefs.token = '';
    prefs.tokenFCM = '';
    prefs.iduser = '';
    prefs.name = '';
    prefs.email = '';
    prefs.photoUrl = '';
    prefs.idTarjeta = '';
    prefs.idCompra = '';
    prefs.comprado = '';
    prefs.idtour = null;
  }

  // Tendremos aquí dos controladores o streamControllers
  //Controlan todo lo que se ingrese en los inputs
  // El tipo de informacion que va a fluir en el streamcontroller es un string
  //final _emailController = StreamController<String>.broadcast(); //Permitirá escuchar varias instancias
  
  //Trabajan con los combinelates
  final _emailController = BehaviorSubject<String>();
  final _nameController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _passConfirmController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();

  // Recuperar o escuchar los datos del Stream, su salida
  //StreamTransformer: Evalua que tipo de dato esta recibiendo
  //Se incluye el streamTransformer para la validacion de los streams
  Stream<String> get nameStream => _nameController.stream;
  Stream<String> get emailStream => _emailController.stream;//.transform(validarEmail) // Fluye un String con la validacion
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);//.transform(validarPassword)
  Stream<String> get passConfirm => _passConfirmController.stream;
  Stream<String> get phoneStream => _phoneController.stream;

  //Los combinelates no trabajan con streams, no los conocen
  Stream<bool> get formValidStream => 
    //Observable.combineLatest2(emailStream, passwordStream, (e,p)=>true);
    CombineLatestStream.combine2(emailStream, passwordStream, (a, b) => true);

  Stream<bool> get formValidStreamReg =>
    //Observable.combineLatest4(nameStream, emailStream, passwordStream, phoneStream, (n,m,p,tel)=>true);
    CombineLatestStream.combine4(nameStream, emailStream, passwordStream, phoneStream, (n,m,p,tel) => true);
  
  //Get para Insertar valores al Stream
 Function(String) get changeName => _nameController.sink.add;
 Function(String) get changeEmail => _emailController.sink.add; //Esta funcion solo recibe Strings
 Function(String) get changePassword => _passwordController.sink.add;
 Function(String) get changePassConfirm => _passConfirmController.sink.add;
 Function(String) get changePhone => _phoneController.sink.add;


 // Obtener el ultimo valor ingresado a los Streams
 String get name => _nameController.value;
 String get mail => _emailController.value;
 String get pass => _passwordController.value;
 String get passConf => _passConfirmController.value;
 String get phone => _phoneController.value;

//Cerrar los controladores cuando no se necesite
  dispose(){
   _nameController?.close();
   _emailController?.close(); // '?' Evita que nos de un error cuando es nulo.
   _passwordController?.close();
   _passConfirmController?.close();
   _phoneController?.close();
   streamFirebase?.close();
 }



}