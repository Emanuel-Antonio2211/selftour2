import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppThemePage extends StatefulWidget {
  @override
  _AppThemePageState createState() => _AppThemePageState();
}

class _AppThemePageState extends State<AppThemePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF034485),//Colors.greenAccent,
      body: Stack(
        children:<Widget>[ 
          Column(
          children: <Widget>[
            SizedBox(height: size.height * 0.1),//60.0
            Container(
              alignment: Alignment.center,
              child: Text('3 of 3',style:TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: size.height * 0.1,),
            Container(
              child: _iconoSonido(),
            ),
            SizedBox(height: size.height * 0.1,),
            Container(
              width: size.width * 0.7,//230.0
              alignment: Alignment.center,
              child: Text('Get going with the Flutter Flat App Theme',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 20.0),)
            ),
            SizedBox(height: size.height * 0.1,),
            Container(
              height: size.height * 0.06,//40.0
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: _continuar(),
            )
          ],
        ),
        ]
      ),
    );
  }
  Widget _iconoSonido(){
    return Icon(Icons.volume_up,size: 130.0,color: Colors.white,);
  }
  Widget _continuar(){
    //final size = MediaQuery.of(context).size;
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
      child: Text('Ir a la aplicación',style: TextStyle(color: Colors.white),),
      color: Color(0xFF0865fe),
      onPressed: (){
       Navigator.pushReplacementNamed(context, 'menuprincipal');
      },
    );
  }
}