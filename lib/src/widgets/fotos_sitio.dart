import 'package:flutter/material.dart';


class GaleriaPage extends StatefulWidget {
  //final List<dynamic> peliculas;

  //@required this.peliculas

  GaleriaPage({Key key,}) : super(key: key);

  _GaleriaPageState createState() => _GaleriaPageState();
}

class _GaleriaPageState extends State<GaleriaPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Column(
         children: <Widget>[
           Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  //itemBuilder: (context,index){
                  //Column(
                  children: <Widget>[
                    _card(),
                    _card2(),
                    _card3(),
                    _card4(),
                    _card5(),
                    _card6(),
                    _card7(),
                    _card8(),
                    SizedBox()
                  ],
                  //),
                  //},
                ),
              )
         ],
       ),
    );
  }

  Widget _card() {
    final size = MediaQuery.of(context).size;
    final card = Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          /*ClipRRect(
              borderRadius: BorderRadius.circular(0.0),
              child: Image.asset('assets/images/beach.jpeg',width: 370.0,height: 350.0,)
              //Image.network('https://www.tiendacanon.com.mx/wcsstore/CMEXCatalogAssetStore/01_academy_tienda_xl_paisaje_noviembre.jpg')
              ),*/
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: FadeInImage(
              width: size.width * 0.66,//310
              height: size.height * 0.3,//240
              image: AssetImage('assets/images/beach.jpeg'),
              //NetworkImage('https://www.tiendacanon.com.mx/wcsstore/CMEXCatalogAssetStore/01_academy_tienda_xl_paisaje_noviembre.jpg'),
              placeholder: AssetImage('assets/jar-loading.gif'),
              fadeInDuration: Duration(milliseconds: 100),
              //height: 300.0,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
    return Column(
      children: <Widget>[
        Container(
          height: size.height * 0.34,//260
          /*decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                //offset: Offset(2.0, 40.0)
              )
            ],
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.white,
          ),*/
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              card,

              /*Positioned(
                  top: 210.0,
                  left: 250.0,
                  child: FloatingActionButton(
                    backgroundColor: Colors.greenAccent[400],
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  )
                )*/
            ],
          ),
        ),
      ],
    );
  }

  Widget _card2() {
    final size=MediaQuery.of(context).size;
    final card = Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          /*ClipRRect(
              borderRadius: BorderRadius.circular(0.0),
              child: Image.asset('assets/images/beach.jpeg',width: 370.0,height: 350.0,)
              //Image.network('https://www.tiendacanon.com.mx/wcsstore/CMEXCatalogAssetStore/01_academy_tienda_xl_paisaje_noviembre.jpg')
              ),*/
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: FadeInImage(
              width: size.width * 0.66,
              height: size.height * 0.3,
              image: AssetImage('assets/images/beach_palm.jpeg'),
              //NetworkImage('https://www.tiendacanon.com.mx/wcsstore/CMEXCatalogAssetStore/01_academy_tienda_xl_paisaje_noviembre.jpg'),
              placeholder: AssetImage('assets/jar-loading.gif'),
              fadeInDuration: Duration(milliseconds: 200),
              //height: 300.0,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
    return Column(
      children: <Widget>[
        Container(
          height: size.height * 0.34,
          /*decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                //offset: Offset(2.0, 40.0)
              )
            ],
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.white,
          ),*/
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              card,
              /*Positioned(
                  top: 210.0,
                  left: 250.0,
                  child: FloatingActionButton(
                    backgroundColor: Colors.greenAccent[400],
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  )
                )*/
            ],
          ),
        ),
      ],
    );
  }

  Widget _card3() {
    final size = MediaQuery.of(context).size;
    final card = Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          /*ClipRRect(
              borderRadius: BorderRadius.circular(0.0),
              child: Image.asset('assets/images/beach.jpeg',width: 370.0,height: 350.0,)
              //Image.network('https://www.tiendacanon.com.mx/wcsstore/CMEXCatalogAssetStore/01_academy_tienda_xl_paisaje_noviembre.jpg')
              ),*/
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: FadeInImage(
              width: size.width * 0.66,
              height: size.height * 0.3,
              image: AssetImage('assets/images/mountain_stars.jpeg'),
              //NetworkImage('https://www.tiendacanon.com.mx/wcsstore/CMEXCatalogAssetStore/01_academy_tienda_xl_paisaje_noviembre.jpg'),
              placeholder: AssetImage('assets/jar-loading.gif'),
              fadeInDuration: Duration(milliseconds: 200),
              //height: 300.0,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
    return Column(
      children: <Widget>[
        Container(
          height: size.height * 0.34,
          /*decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                //offset: Offset(2.0, 40.0)
              )
            ],
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.white,
          ),*/
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              card,
              /*Positioned(
                  top: 210.0,
                  left: 250.0,
                  child: FloatingActionButton(
                    backgroundColor: Colors.greenAccent[400],
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  )
                )*/
            ],
          ),
        ),
      ],
    );
  }

  Widget _card4() {
    final size = MediaQuery.of(context).size;
    final card = Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          /*ClipRRect(
              borderRadius: BorderRadius.circular(0.0),
              child: Image.asset('assets/images/beach.jpeg',width: 370.0,height: 350.0,)
              //Image.network('https://www.tiendacanon.com.mx/wcsstore/CMEXCatalogAssetStore/01_academy_tienda_xl_paisaje_noviembre.jpg')
              ),*/
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: FadeInImage(
              width: size.width * 0.66,
              height: size.height * 0.3,
              image: AssetImage('assets/images/mountain.jpeg'),
              //NetworkImage('https://www.tiendacanon.com.mx/wcsstore/CMEXCatalogAssetStore/01_academy_tienda_xl_paisaje_noviembre.jpg'),
              placeholder: AssetImage('assets/jar-loading.gif'),
              fadeInDuration: Duration(milliseconds: 200),
              //height: 300.0,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
    return Column(
      children: <Widget>[
        Container(
          height: size.height * 0.34,
          /*decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                //offset: Offset(2.0, 40.0)
              )
            ],
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.white,
          ),*/
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              card,
              /*Positioned(
                  top: 210.0,
                  left: 250.0,
                  child: FloatingActionButton(
                    backgroundColor: Colors.greenAccent[400],
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  )
                )*/
            ],
          ),
        ),
      ],
    );
  }

  Widget _card5() {
    final size = MediaQuery.of(context).size;
    final card = Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          /*ClipRRect(
              borderRadius: BorderRadius.circular(0.0),
              child: Image.asset('assets/images/beach.jpeg',width: 370.0,height: 350.0,)
              //Image.network('https://www.tiendacanon.com.mx/wcsstore/CMEXCatalogAssetStore/01_academy_tienda_xl_paisaje_noviembre.jpg')
              ),*/
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: FadeInImage(
              width: size.width * 0.66,
              height: size.height * 0.3,
              image: AssetImage('assets/images/river.jpeg'),
              //NetworkImage('https://www.tiendacanon.com.mx/wcsstore/CMEXCatalogAssetStore/01_academy_tienda_xl_paisaje_noviembre.jpg'),
              placeholder: AssetImage('assets/jar-loading.gif'),
              fadeInDuration: Duration(milliseconds: 200),
              //height: 300.0,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
    return Column(
      children: <Widget>[
        Container(
          height: size.height * 0.34,
          /*decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                //offset: Offset(2.0, 40.0)
              )
            ],
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.white,
          ),*/
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              card,
              /*Positioned(
                  top: 210.0,
                  left: 250.0,
                  child: FloatingActionButton(
                    backgroundColor: Colors.greenAccent[400],
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  )
                )*/
            ],
          ),
        ),
      ],
    );
  }

  Widget _card6() {
    final size = MediaQuery.of(context).size;
    final card = Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          /*ClipRRect(
              borderRadius: BorderRadius.circular(0.0),
              child: Image.asset('assets/images/beach.jpeg',width: 370.0,height: 350.0,)
              //Image.network('https://www.tiendacanon.com.mx/wcsstore/CMEXCatalogAssetStore/01_academy_tienda_xl_paisaje_noviembre.jpg')
              ),*/
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: FadeInImage(
              width: size.width * 0.66,
              height: size.height * 0.3,
              image: AssetImage('assets/images/sisal-01.jpg'),
              //NetworkImage('https://www.tiendacanon.com.mx/wcsstore/CMEXCatalogAssetStore/01_academy_tienda_xl_paisaje_noviembre.jpg'),
              placeholder: AssetImage('assets/jar-loading.gif'),
              fadeInDuration: Duration(milliseconds: 200),
              //height: 300.0,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
    return Column(
      children: <Widget>[
        Container(
          height: size.height * 0.34,
          /*decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                //offset: Offset(2.0, 40.0)
              )
            ],
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.white,
          ),*/
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              card,
              /*Positioned(
                  top: 210.0,
                  left: 250.0,
                  child: FloatingActionButton(
                    backgroundColor: Colors.greenAccent[400],
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  )
                )*/
            ],
          ),
        ),
      ],
    );
  }

  Widget _card7() {
    final size = MediaQuery.of(context).size;
    final card = Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          /*ClipRRect(
              borderRadius: BorderRadius.circular(0.0),
              child: Image.asset('assets/images/beach.jpeg',width: 370.0,height: 350.0,)
              //Image.network('https://www.tiendacanon.com.mx/wcsstore/CMEXCatalogAssetStore/01_academy_tienda_xl_paisaje_noviembre.jpg')
              ),*/
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: FadeInImage(
              width: size.width * 0.66,
              height: size.height * 0.3,
              image: AssetImage('assets/images/sunset.jpeg'),
              //NetworkImage('https://www.tiendacanon.com.mx/wcsstore/CMEXCatalogAssetStore/01_academy_tienda_xl_paisaje_noviembre.jpg'),
              placeholder: AssetImage('assets/jar-loading.gif'),
              fadeInDuration: Duration(milliseconds: 200),
              //height: 300.0,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
    return Column(
      children: <Widget>[
        Container(
          height: size.height * 0.34,
          /*decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                //offset: Offset(2.0, 40.0)
              )
            ],
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.white,
          ),*/
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              card,
              /*Positioned(
                  top: 210.0,
                  left: 250.0,
                  child: FloatingActionButton(
                    backgroundColor: Colors.greenAccent[400],
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  )
                )*/
            ],
          ),
        ),
      ],
    );
  }

  Widget _card8() {
    final size = MediaQuery.of(context).size;
    final card = Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          /*ClipRRect(
              borderRadius: BorderRadius.circular(0.0),
              child: Image.asset('assets/images/beach.jpeg',width: 370.0,height: 350.0,)
              //Image.network('https://www.tiendacanon.com.mx/wcsstore/CMEXCatalogAssetStore/01_academy_tienda_xl_paisaje_noviembre.jpg')
              ),*/
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: FadeInImage(
              width: size.width * 0.66,
              height: size.height * 0.3,
              image: AssetImage('assets/images/travelguy.jpg'),
              //NetworkImage('https://www.tiendacanon.com.mx/wcsstore/CMEXCatalogAssetStore/01_academy_tienda_xl_paisaje_noviembre.jpg'),
              placeholder: AssetImage('assets/jar-loading.gif'),
              fadeInDuration: Duration(milliseconds: 200),
              //height: 300.0,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
    return Column(
      children: <Widget>[
        Container(
          height: size.height * 0.34,
          /*decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                //offset: Offset(2.0, 40.0)
              )
            ],
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.white,
          ),*/
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              card,
              /*Positioned(
                  top: 210.0,
                  left: 250.0,
                  child: FloatingActionButton(
                    backgroundColor: Colors.greenAccent[400],
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  )
                )*/
            ],
          ),
        ),
      ],
    );
  }

  Widget _cardTipo1() {
    // Retorna una tarjeta
    return Container(
      //padding: EdgeInsets.only(top: 0.0),
      //alignment: Alignment(0.0, 130.0),
      width: 330.0,
      child: Card(
        elevation: 10.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Snuckles Montains Range',
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Hiking. Water fall hunting. Natural bath. Scenery & Photography',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Steps 123,123,123',
                style: TextStyle(
                  color: Colors.orange,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}