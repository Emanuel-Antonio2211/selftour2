import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
//import 'package:selfttour/src/bloc/provider.dart';
import 'package:selftourapp/src/bloc/login_bloc.dart';
import 'package:selftourapp/src/providers/usuario_provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  LoginBloc userbloc;

   final usuarioProvider = new UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: (){
              usuarioProvider.signOut();
              Navigator.pushReplacementNamed(context, 'sesionpage');
              
            },
          )
        ],
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Email: ${bloc.mail}'),
            Divider(),
            Text('Password ${bloc.pass}'),
          ],
        ),
    );
  }
}