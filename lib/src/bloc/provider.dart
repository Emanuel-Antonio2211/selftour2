import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:selftourapp/src/bloc/login_bloc.dart';
export 'package:selftourapp/src/bloc/login_bloc.dart';

//Este es el InheritedWidget Personalizado
//Se crea una clase llamada Provider
//Se encarga de controlar el estado del Widget hijo
class Provider extends InheritedWidget{ //Hereda de un Widget, es decir, se convierte en un widget
  //Se crea una propiedad estática
  static Provider _instancia;

  // Crear factory
  //Ayuda a determinar si se necesita regresar una nueva instancia de la clase
  //o utilizar la existente (_instancia)
  factory Provider({Key key,Widget child}){
    if(_instancia == null){
      _instancia = new Provider._internal(key: key,child: child);
    }
    //Si ya se tiene informacion, regresa la instancia
    return _instancia;
  }

   //Constructor privado
  Provider._internal({Key key, Widget child})
  : super(key: key,child: child); // Recibe tanto la clave como el hijo del Widget padre


  //Crear instancia que manejará la información del formulario en todas partes
  // Aqui se pierde la informacion cuando se restaura la aplicacion
  final loginBloc = LoginBloc();

  //Al actualizarse se debe notificar a sus hijos
   @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  //Va a regresar el estado de la instancia del loginBloc
  //Va a buscar en el arbol de Widgets y va a regresar la instancia de loginBloc
  static LoginBloc of (BuildContext context){
    //Va a buscar la instancia de la Clase Provider
    return (context.dependOnInheritedWidgetOfExactType() as Provider).loginBloc; // Va a retornar la instanciade tipo loginBloc
  }

}