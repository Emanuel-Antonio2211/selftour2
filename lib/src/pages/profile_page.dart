import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         centerTitle: false,
         title: Text('Profile',style: TextStyle(fontSize: 30.0),),
       ),
       body: ListView(
         padding: EdgeInsets.all(10.0),
         children: <Widget>[
           Container(
             alignment: Alignment.topLeft,
             child: Row(
               children: <Widget>[
                 CircleAvatar(
                   maxRadius: 50.0,
                   backgroundImage: NetworkImage('https://img-cdn.hipertextual.com/files/2019/04/hipertextual-avengers-endgame-contiene-ultimo-cameo-stan-lee-2019632812.jpg?strip=all&lossy=1&quality=65&resize=740%2C490&ssl=1'),
                 ),
                 SizedBox(width: 30.0,),
                 Column(
                   children: <Widget>[
                     Text('Nombre completo'),
                     Text('usuario@gmail.com')
                   ],
                 ),
               ],
             ),
           ),
           Container(
             padding: EdgeInsets.only(top: 20.0),
             alignment: Alignment.topLeft,
             child: Row(
               children: <Widget>[
                 SizedBox(width: 20.0,),
                 CircleAvatar(
                   backgroundColor: Colors.white,
                  child: IconButton(
                    padding: EdgeInsets.only(left: 10.0),
                    color: Colors.blue,
                    iconSize: 30.0,
                    icon: Icon(Icons.share),
                    tooltip: 'Tocar',
                    onPressed: (){},
                        ),
                 ),
                 SizedBox(width: 30.0,),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      padding: EdgeInsets.only(left: 10.0),
                      color: Colors.blue,
                      iconSize: 30.0,
                      icon: Icon(Icons.shop),
                      tooltip: 'Tocar',
                      onPressed: (){},
                          ),
                      ),
                      SizedBox(width: 30.0,),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                          child: IconButton(
                          padding: EdgeInsets.only(left: 10.0),
                          color: Colors.blue,
                          iconSize: 30.0,
                          icon: Icon(Icons.add),
                          tooltip: 'Tocar',
                          onPressed: (){},
                              ),
                      ),
                      SizedBox(width: 30.0,),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                          child: IconButton(
                            padding: EdgeInsets.only(left: 10.0),
                            color: Colors.blue,
                            iconSize: 30.0,
                            icon: Icon(Icons.email),
                            tooltip: 'Tocar',
                            onPressed: (){},
                              ),
                      ),
                       SizedBox(width: 30.0,),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                          child: IconButton(
                            padding: EdgeInsets.only(left: 10.0),
                            color: Colors.blue,
                            iconSize: 30.0,
                            icon: Icon(Icons.account_circle),
                            tooltip: 'Tocar',
                            onPressed: (){},
                              ),
                      ),
               ],
             ),
           ),
           SizedBox(height: 40.0,),
           Column(
             children: <Widget>[
               Container(
                 child: Stack(
                   overflow: Overflow.visible,
                   children: <Widget>[
                    Container(
                      child: _card(),
                    ),
                    Positioned(
                      top: 190.0,
                      left: 28.0,
                      child: Container(
                        child: _cardTipo1(),
                      ),
                    ),
                    Positioned(
                      top: 300.0,
                      left: 270.0,
                      child: FloatingActionButton(
                        backgroundColor: Colors.lightGreen[300],
                        child: Icon(Icons.favorite_border,color: Colors.white,),
                        onPressed: (){},
                      )
                    )
                   ],
                 ),
               ),
               SizedBox(height: 40.0,)
             ],
           )
         ],
       ),
    );
  }

  Widget _card(){
  final card = Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network('https://www.tiendacanon.com.mx/wcsstore/CMEXCatalogAssetStore/01_academy_tienda_xl_paisaje_noviembre.jpg')
              ),
          /*ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage('https://www.tiendacanon.com.mx/wcsstore/CMEXCatalogAssetStore/01_academy_tienda_xl_paisaje_noviembre.jpg'),
              placeholder: AssetImage('assets/jar-loading.gif'),
              fadeInDuration: Duration(milliseconds: 200),
              //height: 300.0,
              fit: BoxFit.fill,
            ),
          ),*/
        ],
      ),
    );
    return Container(
      //height: 430.0,
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            //offset: Offset(2.0, 40.0)
          )
        ],
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.red,
      ),
      child: Column(
        children: <Widget>[
          card,
        ],
      ),
    );
  }


  Widget _cardTipo1(){
    // Retorna una tarjeta
    return Container(
      //padding: EdgeInsets.only(top: 0.0),
      //alignment: Alignment(0.0, 130.0),
      width: 330.0,
      child: Card(
        elevation: 10.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Snuckles Montains Range',style: TextStyle(fontSize: 20.0),),
              SizedBox(height: 10.0,),
              Text('Hiking. Water fall hunting. Natural bath. Scenery & Photography',style: TextStyle(color: Colors.grey),),
              SizedBox(height: 10.0,),
              Text('Steps 123,123,123',style: TextStyle(color: Colors.orange,),)
            ],
          ),
        ),
      ),
    );
  }
}