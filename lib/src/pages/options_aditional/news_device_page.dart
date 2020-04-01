import 'package:flutter/material.dart';

class NewsDevicePage extends StatefulWidget {
  @override
  _NewsDevicePageState createState() => _NewsDevicePageState();
}

class _NewsDevicePageState extends State<NewsDevicePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF034485), //Colors.greenAccent,
      body: Stack(
        children:<Widget>[ 
          Column(
          children: <Widget>[
            SizedBox(height: size.height * 0.1),
            Container(
              alignment: Alignment.center,
              child: Text('1 of 3',textAlign: TextAlign.center,style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.white),),
            ),
            SizedBox(height: size.height * 0.1,),
            
            Container(
              child: _iconoLista(),
            ),
            SizedBox(height: size.height * 0.1,),
            Container(
              width: size.width * 0.7,
              alignment: Alignment.center,
              child: Text('Explore the latest news from your mobile device',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 20.0),),
            ),
            SizedBox(height: size.height * 0.1,),
            Container(
              height: size.height * 0.06,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(40.0)
              ),
             child: _omitir(),
            )
          ],
        ),
        Positioned(
          top: size.height * 0.5,
          left: size.width * 0.9,
          child: Icon(Icons.keyboard_arrow_right,color: Colors.white,size: 50.0,),
        )
        ]
      ),
    );
  }


  Widget _iconoLista(){
    return Icon(Icons.list,size: 130.0,color: Colors.white,);
  }
  Widget _omitir(){
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
      child: Text('Ir a la Aplicación',style: TextStyle(color: Colors.white),),
      color: Color(0xFF0865fe),
      onPressed: (){
        Navigator.pushReplacementNamed(context, 'menuprincipal');
      },
    );
  }
}