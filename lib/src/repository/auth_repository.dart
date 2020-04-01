//Este archivo nos permite controlar las fuentes de datos
//switchear los datos


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:selftourapp/src/bloc/login_bloc.dart';
//import 'package:flutter/widgets.dart';
//import 'package:selfttour/src/bloc/login_bloc.dart';
import 'package:selftourapp/src/providers/usuario_provider.dart';

//Logica de negocio de una aplicacion que se conecta con firebase auth
//Implementacion de authRepository
class AuthRepository{
  final _usuarioProvider = UsuarioProvider();
  //Invoca a los métodos que se encuentran en la clase usuarioprovider
  //Cada uno de los métodos que se usan para iniciar sesión
  Future<FirebaseUser> signInFirebaseFacebook() async =>_usuarioProvider.loginWithFacebook();
  Future<FirebaseUser> signInFirebaseTwitter() async => _usuarioProvider.loginWithTwitter();
  Future<FirebaseUser> signInFirebaseGoogle() async => _usuarioProvider.loginWithGoogle();
  //Future<Map<String,dynamic>> signInFirebaseEmail(String email,String pass,BuildContext context)async=>_usuarioProvider.loginIn(email, pass);
  Future<Map<String,dynamic>> usuarioNuevo(String nombre,String email, String password, String telefono)async => _usuarioProvider.usuarioNuevo(nombre,email,password,telefono);
  Future<Map<String,dynamic>> logIn(String email,String password)async =>_usuarioProvider.loginIn(email, password);
  Future<FirebaseUser> registerEmail(String email,String password)async=>_usuarioProvider.registerEmail(email, password);
  Future<FirebaseUser> logEmailPassword(String email,String pass)async => _usuarioProvider.logEmailPassword(email, pass);
  //Apuntar a la fuente de datos de donde proviene
  //Cerramos sesión en el firebase
  Future<void>signOut() async =>_usuarioProvider.signOut();
}