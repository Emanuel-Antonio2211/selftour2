import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF034485),//Colors.greenAccent,
        leading: Icon(Icons.menu),
        actions: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 10.0),
                //color: Colors.white,
                width: 370.0,
                child: FlutterLogo(
                  size: 40.0,
                ),
              ),
            ],
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          
          ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top:20.0,bottom:20.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12)
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                         margin: EdgeInsets.only(right: 10.0,left: 10.0),
                         padding: EdgeInsets.all(10.0),
                          width: 390.0,
                          child: Text('Flat App is focused on a minimal use of simple elements, typography and flat colors.',style: TextStyle(fontWeight: FontWeight.bold),)
                          )
                      ],
                    ),
                    //SizedBox(height: 10.0,),
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 10.0,left: 10.0),
                          //width: 380.0,
                          padding: EdgeInsets.all(10.0),
                          child: Text('CDC')
                          ),
                        SizedBox(width: 10.0,),
                        Icon(Icons.access_time),
                        SizedBox(width: 10.0,),
                        Container(
                          child: Text('1h ago'),
                        ),
                        SizedBox(width: 120.0,),
                        Container(
                          padding: EdgeInsets.only(bottom: 5.0),
                          decoration: BoxDecoration(
                           border: Border(
                             bottom: BorderSide(color: Colors.black,width: 0.5)
                           )
                          ),
                          child: Text('ENVIRONMENT'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20.0,bottom: 20.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12)
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10.0,right: 10.0),
                          padding: EdgeInsets.all(10.0),
                          width: 390.0,
                          child: Text('Highly customizable widgets are part of you our never ending mission.',style: TextStyle(fontWeight: FontWeight.bold),),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10.0,right: 10.0),
                          padding: EdgeInsets.all(10.0),
                          child: Text('SPACE.com'),
                        ),
                        SizedBox(width: 10.0,),
                        Icon(Icons.access_time),
                        SizedBox(width: 10.0,),
                        Container(
                          child: Text('5h ago'),
                        ),
                        SizedBox(width: 120.0,),
                        Container(
                          padding: EdgeInsets.only(bottom: 5.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.black,width: 0.5)
                            )
                          ),
                          child: Text('SCIENCE'),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20.0,bottom: 20.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12)
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10.0,right: 10.0),
                          padding: EdgeInsets.all(10.0),
                          width: 390.0,
                          child: Text('Highly customizable widgets are part of you our never ending mission.',style: TextStyle(fontWeight: FontWeight.bold),),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10.0,right: 10.0),
                          padding: EdgeInsets.all(10.0),
                          child: Text('SPACE.com'),
                        ),
                        SizedBox(width: 10.0,),
                        Icon(Icons.access_time),
                        SizedBox(width: 10.0,),
                        Container(
                          child: Text('5h ago'),
                        ),
                        SizedBox(width: 120.0,),
                        Container(
                          padding: EdgeInsets.only(bottom: 5.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.black,width: 0.5)
                            )
                          ),
                          child: Text('SCIENCE'),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20.0,bottom: 20.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12)
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10.0,right: 10.0),
                          padding: EdgeInsets.all(10.0),
                          width: 390.0,
                          child: Text('Highly customizable widgets are part of you our never ending mission.',style: TextStyle(fontWeight: FontWeight.bold),),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10.0,right: 10.0),
                          padding: EdgeInsets.all(10.0),
                          child: Text('SPACE.com'),
                        ),
                        SizedBox(width: 10.0,),
                        Icon(Icons.access_time),
                        SizedBox(width: 10.0,),
                        Container(
                          child: Text('5h ago'),
                        ),
                        SizedBox(width: 120.0,),
                        Container(
                          padding: EdgeInsets.only(bottom: 5.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.black,width: 0.5)
                            )
                          ),
                          child: Text('SCIENCE'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}