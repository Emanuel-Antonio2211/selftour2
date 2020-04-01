import 'package:flutter/material.dart';
import 'package:selftourapp/src/bloc/provider.dart';
//import 'package:selfttour/src/pages/login/sesion_page.dart';
import 'package:selftourapp/src/bloc/login_bloc.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:selftourapp/src/providers/usuario_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InicioPage extends StatefulWidget {
  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  LoginBloc userBloc = LoginBloc();
  FirebaseUser user;

  final usuarioProvider = new UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);
    return StreamBuilder(
      stream: userBloc.streamFirebase,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        print(snapshot.connectionState);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _waiting();
        } else if (snapshot.connectionState == ConnectionState.none) {
          return CircularProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.active) {
          return _showProfile(snapshot);
        }else if(snapshot.connectionState == ConnectionState.done){
          return _showProfile(snapshot);
        }
        
      },
    );
  }

  Widget _showProfile(AsyncSnapshot<FirebaseUser> snapshot) {
    if (!snapshot.hasData || snapshot.hasError) {
      print('El usuario no está logueado');
      return Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              CircularProgressIndicator(),
              //Container()
              //Text('No se pudo cargar la informacion')
            ],
          ),
        ),
      );
    } else {
      print('Usuario logueado');
      print('Email: ${snapshot.data.providerData.map((pro)=>pro.email).toString()}');
      print(snapshot.data.photoUrl.toString());
      //print('${user.providerData.map((pro)=>pro.email).toString()}');
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(snapshot.data.photoUrl.toString()),
              Text(snapshot.data.displayName.toString()),
              //Text('${snapshot.data.providerData.map((pro)=>pro.email).toString()}'),
              Text(snapshot.data.email.toString()),
              OutlineButton(
                child: Text('Cerrar Sesión'),
                onPressed: () {
                  setState(() {});
                  userBloc.signOut();
                  //usuarioProvider.signOut();
                  Navigator.pushReplacementNamed(context, 'sesionpage');
                },
              )
            ],
          ),
        ),
      );
    }
  }

  Widget _waiting() {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Cargando Datos'),
        CircularProgressIndicator(),
      ],
    )));
  }
}

/*

if(usuarioProvider.isLogged){
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(usuarioProvider.myUser.photoUrl),
            Text(usuarioProvider.myUser.displayName),
            OutlineButton(
              child: Text('Cerrar Sesión'),
              onPressed: (){
                usuarioProvider.signOut();
              },
            )
          ],
        ),
      );
    }

*/
