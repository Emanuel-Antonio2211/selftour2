import 'package:flutter/material.dart';


class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Slider'),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 20.0),
          height: 200.0,
          child: ListView(
            padding: EdgeInsets.all(10.0),
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Container(
                width: 190.0,
                color: Colors.blue
                //child: Image.asset('aseets/images/beach_palm.jpeg')
              ),
              Container(
                width: 190.0,
                color: Colors.blue
                //child: Image.asset('aseets/images/beach_palm.jpeg')
              ),
              Container(
                width: 160.0,
                //child: Image.asset('aseets/images/mountain.jpeg')
              ),
              Container(
                width: 160.0,
                //child: Image.asset('aseets/images/sunset.jpeg')
              )
            ],
          ),
        ),
      ),
    );
  }
}