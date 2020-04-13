import 'package:flutter/material.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';


bool isNumeric(String s){
  if(s.isEmpty){
    return false;
  }

  final n = num.tryParse(s);

  return (n==null) ? false : true;
}

void mostrarAlerta(BuildContext context,String mensaje,String title,String imagen){
  final size = MediaQuery.of(context).size;
  String aceptar = AppTranslations.of(context).text('title_accept');
  showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title: Text(
          '$title',
          style: TextStyle(
            fontFamily: 'Point-SemiBold'
          ),
        ),
        content: Container(
          width: size.width * 0.5,
          height: size.height * 0.35,
          child: Column(
            children: <Widget>[
              Container(
                width: size.width * 0.3,
                height: size.height * 0.2,
                child: Image.asset('$imagen'),
              ),
              Flexible(
                child: Text(
                  mensaje,
                  style: TextStyle(
                    fontFamily: 'Point-SemiBold',
                    fontSize: 12.0
                    ),
                  )
                ),
              RaisedButton(
                textTheme: ButtonTextTheme.primary,
                color: Colors.green,
                shape: StadiumBorder(),
                child: Text(
                  '$aceptar',
                style: TextStyle(
                  fontFamily: 'Point-SemiBold',
                  color: Colors.white
                  ),
                ),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
              
            ],
          ),
        ),
       /* actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: ()=>Navigator.of(context).pop(),
          )
        ],*/
      );
    }
  );
}

void mostrarMensaje(BuildContext context,String mensaje,String title){
  final size = MediaQuery.of(context).size;
  String aceptar = AppTranslations.of(context).text('title_accept');
  showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title: Text(
          '$title',
          style: TextStyle(
            fontFamily: 'Point-SemiBold'
          ),
        ),
        content: Container(
          width: size.width * 0.5,
          height: size.height * 0.2,
          child: Column(
            children: <Widget>[
              Flexible(
                child: Text(
                  mensaje,
                  style: TextStyle(
                    fontSize: 12.0
                    ),
                  )
                ),
              RaisedButton(
                textTheme: ButtonTextTheme.primary,
                color: Colors.green,
                shape: StadiumBorder(),
                child: Text(
                  '$aceptar',
                  style: TextStyle(
                    fontFamily: 'Point-SemiBold',
                    color: Colors.white
                  ),
                ),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
              
            ],
          ),
        ),
       /* actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: ()=>Navigator.of(context).pop(),
          )
        ],*/
      );
    }
  );
}

void mostrarAviso(BuildContext context,String mensaje,String title,String imagen){
 final size = MediaQuery.of(context).size;
 String aceptar = AppTranslations.of(context).text('title_accept');
 showDialog(
   context: context,
   builder: (context){
     return Scaffold(
            body: AlertDialog(
          title: Text(
            '$title',
            style: TextStyle(
              fontFamily: 'Point-SemiBold'
            ),
          ),
          content: Container(
            width: size.width * 0.5,
            height: size.height * 0.3,
            child: Column(
              children: <Widget>[
                Container(
                        width: size.width * 0.3,
                        height: size.height * 0.2,
                        child: Image.asset('$imagen'),
                      ),
                      Flexible(
                        child: Text(
                          mensaje,
                          style: TextStyle(
                            fontFamily: 'Point-SemiBold',
                            fontSize: 10.0
                          ),
                        ),
                      ),
                      RaisedButton(
                        textTheme: ButtonTextTheme.primary,
                        color: Colors.green,
                        shape: StadiumBorder(),
                        child: Text(
                          '$aceptar',
                          style: TextStyle(
                            fontFamily: 'Point-SemiBold',
                            color: Colors.white
                          ),
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                
              ],
            ),
          ),
         /* actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: ()=>Navigator.of(context).pop(),
            )
          ],*/
        ),
     );
   }
 );
  
}

void mostrarConfirmacion(BuildContext context,String mensaje,String title,String imagen){
 final size = MediaQuery.of(context).size;
 String aceptar = AppTranslations.of(context).text('title_accept');
 showDialog(
   context: context,
   builder: (context){
     return Scaffold(
            body: AlertDialog(
          title: Text(
            '$title',
            style: TextStyle(
              fontFamily: 'Point-SemiBold'
            ),
          ),
          content: Container(
            width: size.width * 0.5,
            height: size.height * 0.3,
            child: Column(
              children: <Widget>[
                Container(
                        width: size.width * 0.3,
                        height: size.height * 0.2,
                        child: Image.asset('$imagen'),
                      ),
                      Flexible(
                        child: Text(
                        mensaje,
                        style: TextStyle(
                          fontSize: 10.0,
                          fontFamily: 'Point-SemiBold'
                          ),
                        )
                      ),
                      RaisedButton(
                        textTheme: ButtonTextTheme.primary,
                        color: Colors.green,
                        shape: StadiumBorder(),
                        child: Text('$aceptar',style: TextStyle(color: Colors.white),),
                        onPressed: (){
                          Navigator.popUntil(context, ModalRoute.withName('/detalletour'));
                          //Navigator.popAndPushNamed(context, 'detalletour');
                          //Navigator.pop(context);
                        },
                      ),
                
              ],
            ),
          ),
         /* actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: ()=>Navigator.of(context).pop(),
            )
          ],*/
        ),
     );
   }
 );
  
}