import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:selftourapp/src/providers/push_notifications_provider.dart';
import 'package:selftourapp/src/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';


//Creamos la clase UsuarioProvider
class UsuarioProvider{
  //Para hacer la petición a firebase se necesita una url
  //El cual va a permitir mandar a llamar el servicio de registro y de login

  //ApiToken o Apikey de nuestro proyecto de firebase
  final String _firebaseToken = 'AIzaSyAJbzYQ0hB74vAecuvIHwbZM5SjMegkWDM';

  PushNotificationProvider pushNotificationProvider = PushNotificationProvider();

  final firebaseMessaging = FirebaseMessaging();

  String tokenFCM = '';

  //Se crea una instancia de la clase PreferenciasUsuario
  final prefs = new PreferenciasUsuario();
  //SharedPreferences preferences;

  FirebaseAuth _auth = FirebaseAuth.instance;
  final facebookLogin = new FacebookLogin();
  bool isLogged = false;
  FirebaseUser myUser;
  //Twitter Sign in
    var twitterlogin = new TwitterLogin(
      consumerKey: '16CajoQjMsVVwX09Bwg2uommR',
      consumerSecret: 'mkxtZHEtJIe3lzDh8xD2BP9sEosVDTXr7On2nJSWjdv0o0oblK'
    );
  //Va a contener la instancia de GoogleSignin
  //Nos trae la composición de todo lo que existe en Google
  final GoogleSignIn googleSignIn = GoogleSignIn( scopes: [
    'email'
  ] );
  String _message = 'Logged out.';


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

  //Metodo iniciar sesión amazon
  Future<Map<String,dynamic>> loginIn(String mail,String pass) async{
    //FirebaseUser user;
    final authData={
      'mail'   : mail,
      'pass'   : pass
      //'token':true
    };
    print(authData);
    final resp = await http.post(
      'https://api-users.selftours.app/login',
      headers: {HttpHeaders.contentTypeHeader:'application/json'},
      body: json.encode(authData)
      );
      //print(resp.body);
    Map<String,dynamic> decodedResp=json.decode(resp.body);
    print(decodedResp);

    //Autenticacion por Firebase
    //AuthCredential credential = EmailAuthProvider.getCredential(email: mail,password:pass);
   // await preferences.setString('name',decodedResp['name']);
   // await preferences.setString('user', decodedResp['user']);

    

    if(decodedResp.containsKey('token')){
     prefs.token= decodedResp['token'];
     print("Token: ${prefs.token}");
     prefs.name = decodedResp['name'];
     prefs.email = decodedResp['user'];
     prefs.photoUrl = null;
     prefs.tokenFCM = tokenFCM;
      //print(credential);
      //myUser = await _auth.signInWithCredential(credential);
     //myUser = await logEmailPassword(mail, pass);
      print(myUser);
      
      var decoded = parseJwt(prefs.token);
      prefs.iduser = decoded['id'].toString();
      print(decoded);
     if(decodedResp != null){
       
       firebaseMessaging.getToken().then((token){
         tokenFCM = token;
       });
      // Check is already sign up - Checa si está logueado
      // id decoded['id'].toString()
      final QuerySnapshot result = await Firestore.instance.collection('users').where('email',isEqualTo: decoded['user'].toString() ).getDocuments(); //user.uid
      final List<DocumentSnapshot> documents = result.documents;
      if(documents.length == 0){
        // Update data to server if new user - Actualiza los datos del servidor
        // si el usuario es nuevo
        Firestore.instance.collection('users').document(decoded['user'].toString()).setData(
          {
            'tokenfcm': "$tokenFCM",
            'nickname':decoded['name'],
            'email': decoded['user'],
            'id': decoded['id'],
            'photoUrl': null, //user.photoUrl
            'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
            'chattingWith': null
          }
        );

        // Write data to local - Escribir los datos en local
       // FirebaseUser currentUser = user;
        
      }
    }
      return {'success':true,'token':decodedResp['token']};
    }else{
      return {'success':false,'mensaje':decodedResp['msg']};
    }
  // user = await _auth.signInWithEmailAndPassword(email: mail,password: pass);
    //user = (await _auth.createUserWithEmailAndPassword(email:mail,password: pass)) as FirebaseUser;
    //print('Usuario: ${user.displayName}, ${user.email}, ${user.photoUrl},${user.providerId}');
  }

  Future<FirebaseUser> logEmailPassword(String email,String password)async{
    try{
       myUser = await _auth.signInWithEmailAndPassword(email: email, password: password);
      assert(myUser != null);
      assert(await myUser.getIdToken() != null);
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(myUser.uid == currentUser.uid);
      return myUser;  
    }catch(e){
      print(e); 
      return null;
    }
  }

  Future<FirebaseUser> registerEmail(String email,String password)async{
    
    myUser = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
    return myUser;
      
      //assert(myUser != null);
      // assert( myUser.getIdToken() != null);
        //final FirebaseUser currentUser = await _auth.currentUser();
        //assert(myUser.uid == currentUser.uid);
      //return myUser;
  }

  Future<Map<String,dynamic>> usuarioNuevo(String nombre,String email,String pass,String telefono)async{
    final registerData = {
      "name": "$nombre",
      "mail": "$email",
      "pass": "$pass",
      "phone": "$telefono"
    };

    final resp = await http.post('https://api-users.selftours.app/users',
    headers: {HttpHeaders.contentTypeHeader:'application/json'},
    body: json.encode(registerData)
    );

    Map<String,dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);
    /*myUser = await _auth.signInWithEmailAndPassword(
      email: email,
      password: pass
    );*/
    
    //Evalua si la respuesta decodificada, si contiene el idtoken,
  //Quiere decir que la informacion proveida es un correo y contraseña valido
  //y tengo la informacion
   if(decodedResp.containsKey('token')){
     //Guardar el idtoken en el dispositivo
      prefs.token=decodedResp['token'];
      //prefs.name = decodedResp['data']['name'];
      //prefs.email = decodedResp['data']['mail'];
      prefs.phone = decodedResp['phone'];

      var decoded = parseJwt(prefs.token);
      prefs.iduser = decoded['id'].toString();
      prefs.name = decoded['name'].toString();
      prefs.email = decoded['user'].toString();
      print("Id User: "+prefs.iduser);
      if(decoded['user'] != null){
      // Check is already sign up - Checa si está logueado
      // id myUser.providerData[1].uid
      final QuerySnapshot result = await Firestore.instance.collection('users').where('email',isEqualTo: decoded['user']).getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if(documents.length == 0){
        // Update data to server if new user - Actualiza los datos del servidor
        // si el usuario es nuevo
        // id myUser.providerData[1].uid
        Firestore.instance.collection('users').document(decoded['user']).setData(
          {
            'nickname':decoded['name'],
            'id': decoded['id'],
            'email': decoded['name'],
            'photoUrl':null,
            'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
            'chattingWith': null
          }
        );

        // Write data to local - Escribir los datos en local
       // FirebaseUser currentUser = user;
        
      }
    }
     //TODO: Salvar el token en el storage
    return {'ok':true, 'token':decodedResp['token']};
   }else{
     return {'ok':false,'mensaje':decodedResp['error']['error']['sqlMessage']};
   }
   
  }

  //Iniciar sesión en facebook
  Future<FirebaseUser> loginWithFacebook() async {
    var result = await facebookLogin.logIn(['email']);
    //facebookLogin.loginBehavior = FacebookLoginBehavior.nativeWithFallback;
    debugPrint(result.status.toString());
    switch(result.status){
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken;
        
        print("token: ${token.token}");
        final AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: token.token );
        myUser =
          await _auth.signInWithCredential(credential);
        prefs.token = token.toString();
        prefs.name = myUser.providerData[1].displayName;
        prefs.email = myUser.providerData[1].email;
        prefs.phone = myUser.providerData[1].phoneNumber;
        prefs.photoUrl = myUser.providerData[1].photoUrl;
        print("Usuario: ${myUser.email}");
        break;
      case FacebookLoginStatus.cancelledByUser:
        debugPrint(result.status.toString());
        print("Cancelado por el usuario");
        break;
      case FacebookLoginStatus.error:
        debugPrint(result.errorMessage.toString());
        break;
      default:
        return myUser;
    }
    if(myUser != null){
      // Check is already sign up - Checa si está logueado
      // id myUser.providerData[1].uid
      final QuerySnapshot result = await Firestore.instance.collection('users').where('email',isEqualTo: myUser.providerData[1].email).getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if(documents.length == 0){
        // Update data to server if new user - Actualiza los datos del servidor
        // si el usuario es nuevo
        // id myUser.providerData[1].uid
        Firestore.instance.collection('users').document(myUser.providerData[1].email).setData(
          {
            'nickname':myUser.providerData[1].displayName,
            'id': myUser.providerData[1].uid,
            'email': myUser.providerData[1].email,
            'photoUrl':myUser.providerData[1].photoUrl,
            'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
            'chattingWith': null
          }
        );

        // Write data to local - Escribir los datos en local
       // FirebaseUser currentUser = user;
        
      }
    }
    print(myUser);
    return myUser;
  /* if (result.status == FacebookLoginStatus.loggedIn) {
      final token = result.accessToken;
      print("token: ${token.token}");
      final AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: token.token );
       myUser =
          await _auth.signInWithCredential(credential);
      print("Usuario: ${myUser.email}");
      return myUser;
    }
    return myUser;*/
  }

  //Iniciar sesión en Twitter
    Future<FirebaseUser> loginWithTwitter() async {
    final TwitterLoginResult twitterLoginResult = await twitterlogin.authorize();
    String newMessage;
    switch(twitterLoginResult.status){
      case TwitterLoginStatus.loggedIn:
        var session = twitterLoginResult.session;
        //final token = twitterLoginResult.session.token;
        final AuthCredential credential = TwitterAuthProvider.getCredential(
          authToken: session.token,
          authTokenSecret: session.secret
        );
        print(session.token);
          myUser = await _auth.signInWithCredential(credential);
        //return _user;
        prefs.token = session.token;
        prefs.name = myUser.providerData[1].displayName;
        prefs.email = myUser.providerData[1].email;
        prefs.phone = myUser.providerData[1].phoneNumber;
        prefs.photoUrl = myUser.providerData[1].photoUrl;
        newMessage = 'Logged in! username: ${twitterLoginResult.session.username}, ${twitterLoginResult.session.userId}';
        break;
      case TwitterLoginStatus.cancelledByUser:
        debugPrint(twitterLoginResult.status.toString());
        newMessage = 'Login cancelled by user.';
        print(newMessage);
        break;
      case TwitterLoginStatus.error:
        debugPrint(twitterLoginResult.errorMessage.toString());
        newMessage = 'Login error: ${twitterLoginResult.errorMessage}';
        print(newMessage);
        //break;
    }
    print(myUser);
    if(myUser != null){
      // Check is already sign up - Checa si está logueado
      // id myUser.providerData[1].uid
      final QuerySnapshot result = await Firestore.instance.collection('users').where('email',isEqualTo: myUser.providerData[1].email).getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if(documents.length == 0){
        // Update data to server if new user - Actualiza los datos del servidor
        // si el usuario es nuevo //myUser.providerData[1].uid
        Firestore.instance.collection('users').document(myUser.providerData[1].email).setData(
          {
            'nickname':myUser.providerData[1].displayName,
            'id': myUser.providerData[1].uid,
            'email': myUser.providerData[1].email,
            'photoUrl':myUser.providerData[1].photoUrl,
            'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
            'chattingWith': null
          }
        );

        // Write data to local - Escribir los datos en local
       // FirebaseUser currentUser = user;
        
      }
    }
    print(myUser);
    return myUser;

    /*setState(() {
      //_message = newMessage;
    });*/
  }

  //Iniciar sesión en Google
  Future<FirebaseUser> loginWithGoogle() async{
    //Se crea una instancia de GoogleSignAccount
    //Se está solicitando el cuadro de dialogo de inicio de sesion en google
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    
    //Se obtiene las credenciales de la cuenta de google
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;
    print("Access Token: "+ gSA.accessToken);
    print("Id Token: "+ gSA.idToken);

    
    var info = parseJwt(gSA.idToken);
    print("info: $info");
    //Se hace la autenticacion con firebase
    //Verifica si la cuenta existe
   myUser = await _auth.signInWithCredential(GoogleAuthProvider.getCredential(idToken: gSA.idToken,accessToken:gSA.accessToken));
   prefs.token = gSA.idToken;
   prefs.iduser = myUser.providerData[1].uid;
   prefs.name = myUser.providerData[1].displayName;
   prefs.email = myUser.providerData[1].email;
   prefs.phone = myUser.providerData[1].phoneNumber;
   prefs.photoUrl = myUser.providerData[1].photoUrl;
    if(myUser != null){
      // Check is already sign up - Checa si está logueado
      firebaseMessaging.getToken().then((token){
         tokenFCM = token;
       });
      prefs.tokenFCM = tokenFCM; //id myUser.providerData[1].uid
      final QuerySnapshot result = await Firestore.instance.collection('users').where('email',isEqualTo: myUser.providerData[1].email).getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if(documents.length == 0){
        // Update data to server if new user - Actualiza los datos del servidor
        // si el usuario es nuevo myUser.providerData[1].uid
        Firestore.instance.collection('users').document(myUser.providerData[1].email).setData(
          {
            'tokenfcm':"$tokenFCM",
            'nickname':myUser.providerData[1].displayName,
            'id': myUser.providerData[1].uid,
            'email':myUser.providerData[1].email,
            'photoUrl':myUser.providerData[1].photoUrl,
            'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
            'chattingWith': null
          }
        );

        // Write data to local - Escribir los datos en local
       // FirebaseUser currentUser = user;
        
      }
    }
    print(myUser);
    myUser.getIdToken().then((value){
      print(value);
    });
    verifGoogle(prefs.token).then((result){
      Map info = result;
      print("info: $info");
      //prefs.tokenVerif = ;
    }).catchError((error){
      print(error);
    });
    return myUser;
  }

  Future<Map<String,dynamic>> verifGoogle(String idToken)async{
    final url = "https://api-users.selftours.app/loginGoogle";

    final resp = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader:"application/x-www-form-urlencoded"
      },
      body: {
        "idtoken":idToken
      }
    );
    final decodedResp = json.decode(resp.body);
    
    return decodedResp;
  }

  //===================================================
  //Cerrar sesión en firebase
 Future<void>signOut() async {
   //Cerrar sesión en Firebase
    await _auth.signOut().then((onValue){
      facebookLogin.logOut();
      twitterlogin.logOut();
      
      //Cerrar sesión en google
      googleSignIn.signOut();
      //googleSignIn.disconnect();
      isLogged=false;
    });
    print('Sesion cerrada');
  }

  //Método para iniciar sesión
  Future<Map<String,dynamic>> login(String email,String password) async{
    final authData={
     'email': email,
     'password':password,
     'returnSecureToken': true
   };

    //Petición http POST para iniciar sesión
   final resp = await http.post(
     'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=$_firebaseToken',
     body: json.encode(authData)
   );

   Map<String,dynamic> decodedResp = json.decode(resp.body);
   print(decodedResp);

   if(decodedResp.containsKey('idToken')){
     // guardar el token en el dispositivo
     prefs.token=decodedResp['idToken'];
     //TODO: Salvar el token en el storage
    return {'ok':true, 'token':decodedResp['idToken']};
   }else{
     return {'ok':false,'mensaje':decodedResp['error']['message']};
   }
  }

//Método para crear un nuevo usuario
 Future<Map<String,dynamic>> nuevoUsuario(String mail,String pass) async{
   //Mandar la informacion a firebase
   final authData={
     'mail': mail,
     'pass':pass,
     'returnSecureToken': true
   };

  //Endpoint que permite llamar a la petición POST de crear un nuevo usuario
   final resp = await http.post(
     'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=$_firebaseToken',
     body: json.encode(authData)
   );

  //Decodificamos la informacion de la variable resp
   Map<String,dynamic> decodedResp = json.decode(resp.body);
   print(decodedResp);

  //Evalua si la respuesta decodificada, si contiene el idtoken,
  //Quiere decir que la informacion proveida es un correo y contraseña valido
  //y tengo la informacion
   if(decodedResp.containsKey('idToken')){
     //Guardar el idtoken en el dispositivo
      prefs.token=decodedResp['idToken'];

     //TODO: Salvar el token en el storage
    return {'ok':true, 'token':decodedResp['idToken']};
   }else{
     return {'ok':false,'mensaje':decodedResp['error']['message']};
   }
  }

  Future<void> enviarNoti(String tokenUser,String nombreUsuario,String userAvatar,String contenido,String dataIduser)async{
    String url = "https://fcm.googleapis.com/fcm/send";

    Map<String,dynamic> datos={
      "to": "$tokenUser",
      "notification":{
        "title":"$nombreUsuario",
        "body":"$contenido"
      },
      "data":{
        "iduser":"$dataIduser",
        "nickname": "$nombreUsuario",
        "useravatar":"$userAvatar",
        "click_action":"FLUTTER_NOTIFICATION_CLICK"
      }
    };

   final resp = await http.post(url,headers: {
     HttpHeaders.authorizationHeader: "key=AAAAZny9vYo:APA91bGunvzacVKhyBqTzKD_aHQskZYMDHhGCPKgtuaEEimTrSSx5_Pi32r7sbEJU2WaoRMdolN2RfvPig1tA7gVYI7W9XfTpb__medGYDAaHRz8b8G3CYpwSacOYIiZAr4zwPxEIrmQ",
      HttpHeaders.contentTypeHeader:"application/json",
      //HttpHeaders.allowHeader:"key=AAAAZny9vYo:APA91bGunvzacVKhyBqTzKD_aHQskZYMDHhGCPKgtuaEEimTrSSx5_Pi32r7sbEJU2WaoRMdolN2RfvPig1tA7gVYI7W9XfTpb__medGYDAaHRz8b8G3CYpwSacOYIiZAr4zwPxEIrmQ"
    },
    body: json.encode(datos),
    );
   final decodedResp = json.decode(resp.body);

    print(decodedResp);
  }
}