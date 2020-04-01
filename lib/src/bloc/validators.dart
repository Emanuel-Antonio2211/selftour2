import 'dart:async';
//import 'package:flutter/material.dart';
//import 'package:selfttour/src/translation_class/app_translations.dart'; //Para implementar los StreamTransformers

//Se encarga de las validaciones
//Se crea una clase llamada Validators
class Validators{

  
  //Se definen los StreamTransformers
  //StreamTransformer: Evalua que tipo de dato esta recibiendo
  final validarEmail = StreamTransformer<String,String>.fromHandlers(
    handleData: (mail,sink){
      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(pattern);
      
      //Evalua si hace el match el email que se recibe
      if(regExp.hasMatch(mail)){
        sink.add(mail);
      }else{
        sink.addError('El Email no es correcto');
      }
    }
  );

 //Comprobar cuando un password es válido
 //Se tiene que definir que tipo de informacion fluye en ello. <entrada,salida>
  final validarPassword = StreamTransformer<String,String>.fromHandlers(
    handleData: (pass,sink){ //Indica que informacion sigue fluyendo y cual marca error para bloquearlo
      if(pass.length >= 6){ //Si el password es mayor o igual a 6
        sink.add(pass); //Va a dejar fuir la contraseña, lo acepta
      }else{
        sink.addError('');
      }
    }
  );

  /*final confirmarPassword = StreamTransformer<String,String>.fromHandlers(
    handleData: (pass,sink){
      if(pass == confiPass){
        sink.add(pass);
      }else{
        sink.addError('Ambas contraseñas no son iguales');
      }
    }
  );*/
}