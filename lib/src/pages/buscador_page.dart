import 'package:flutter/material.dart';
import 'package:selftourapp/src/widgets/fotos_sitio.dart';

class BuscadorPage extends StatefulWidget {
  @override
  _BuscadorPageState createState() => _BuscadorPageState();
}

class _BuscadorPageState extends State<BuscadorPage>
    with SingleTickerProviderStateMixin {
  //TabController controller;

  @override
  void initState() {
    super.initState();

    // Initialize the Tab Controller
    //controller = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // Dispose of the Tab Controller
    //controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      /*appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.deepPurple[700],
        title: Text('Bienvenido',style: TextStyle(fontSize: 30.0)),
      ),*/
      body: Stack(children: <Widget>[
        Container(
          width: size.width * 1.0, //420.0
          height: size.height * 0.38, //280.0
          child: Image.asset(
            'assets/images/appbarprofile.png',
            fit: BoxFit.cover,
          ),
          //color: Colors.pink,
        ),
        Container(
          child: Stack(children: <Widget>[
            ListView(
              children: <Widget>[
                SizedBox(
                  height: size.height * 0.07
                ),
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Bienvenido',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: size.width * 0.5, //250.0
                  height: size.height * 0.33, //300.0 
                  child: _fotosSitio()
                  ),
                //_swiperTarjetas(),
                SizedBox(),
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Bahamas',
                        style: TextStyle(
                          fontSize: 30.0,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.05, //40.0
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            color: Colors.yellow[700],
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow[700],
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow[700],
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow[700],
                          ),
                          Icon(
                            Icons.star_half,
                            color: Colors.yellow[700],
                          )
                        ],
                      )
                    ],
                  ),
                  //color: Colors.red,
                ),
                SizedBox(
                  height: size.height * 0.03, //20.0
                ),
                Container(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                        'Lorem asddsdsadssasdasddadasdasdasdasd dasdsadsadsdsdsdasd dsdsaddsdasdsadsada')),
                Container(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                        'Lorem asddsdsadssasdasddadasdasdasdasd dasdsadsadsdsdsdasd dsdsaddsdasdsadsada')),
                SizedBox(
                  height: size.height * 0.03, //20.0
                ),
                Container(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                        'Lorem asddsdsadssasdasddadasdasdasdasd dasdsadsadsdsdsdasd dsdsaddsdasdsadsada')),
                Container(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                        'Lorem asddsdsadssasdasddadasdasdasdasd dasdsadsadsdsdsdasd dsdsaddsdasdsadsada')),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: size.width * 0.6, //190.0
                      padding: const EdgeInsets.all(10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: RaisedButton(
                          padding: EdgeInsets.all(10.0),
                          color: Colors.indigo,
                          textTheme: ButtonTextTheme.normal,
                          //materialTapTargetSize: MaterialTapTargetSize.padded,
                          onPressed: () {
                            //Navigator.pushNamed(context, 'slider');
                          },
                          textColor: Colors.white,
                          child: const Text('Navigate',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ]),
          //color: Colors.purple,
        ),
      ]),
    );
  }

  /*Widget _swiperTarjetas() {
    return CardSwiper(
      categorias: [1, 2, 3, 4, 5],
    );
  }*/

  Widget _fotosSitio() {
    return GaleriaPage();
  }

/*Widget _fotosSitio(){
  return Container(
       child:Column(
        children: <Widget>[
           Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  //shrinkWrap: false,
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
       )
    );
}*/

  Widget _card() {
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
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              width: 310.0,
              height: 240.0,
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
          height: 260.0,

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
              Positioned(
                  top: 210.0,
                  left: 250.0,
                  child: FloatingActionButton(
                    backgroundColor: Colors.greenAccent[400],
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ))
            ],
          ),
        ),
      ],
    );
  }

  Widget _card2() {
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
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              width: 310.0,
              height: 240.0,
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
          height: 260.0,
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
              Positioned(
                  top: 210.0,
                  left: 250.0,
                  child: FloatingActionButton(
                    backgroundColor: Colors.greenAccent[400],
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ))
            ],
          ),
        ),
      ],
    );
  }

  Widget _card3() {
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
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              width: 310.0,
              height: 240.0,
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
          height: 260.0,
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
              Positioned(
                  top: 210.0,
                  left: 250.0,
                  child: FloatingActionButton(
                    backgroundColor: Colors.greenAccent[400],
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ))
            ],
          ),
        ),
      ],
    );
  }

  Widget _card4() {
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
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              width: 310.0,
              height: 240.0,
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
          height: 260.0,
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
              Positioned(
                  top: 210.0,
                  left: 250.0,
                  child: FloatingActionButton(
                    backgroundColor: Colors.greenAccent[400],
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ))
            ],
          ),
        ),
      ],
    );
  }

  Widget _card5() {
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
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              width: 310.0,
              height: 240.0,
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
          height: 260.0,
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
              Positioned(
                  top: 210.0,
                  left: 250.0,
                  child: FloatingActionButton(
                    backgroundColor: Colors.greenAccent[400],
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ))
            ],
          ),
        ),
      ],
    );
  }

  Widget _card6() {
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
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              width: 310.0,
              height: 240.0,
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
          height: 260.0,
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
              Positioned(
                  top: 210.0,
                  left: 250.0,
                  child: FloatingActionButton(
                    backgroundColor: Colors.greenAccent[400],
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ))
            ],
          ),
        ),
      ],
    );
  }

  Widget _card7() {
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
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              width: 310.0,
              height: 240.0,
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
          height: 260.0,
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
              Positioned(
                  top: 210.0,
                  left: 250.0,
                  child: FloatingActionButton(
                    backgroundColor: Colors.greenAccent[400],
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ))
            ],
          ),
        ),
      ],
    );
  }

  Widget _card8() {
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
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              width: 310.0,
              height: 240.0,
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
          height: 260.0,
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
              Positioned(
                  top: 210.0,
                  left: 250.0,
                  child: FloatingActionButton(
                    backgroundColor: Colors.greenAccent[400],
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
