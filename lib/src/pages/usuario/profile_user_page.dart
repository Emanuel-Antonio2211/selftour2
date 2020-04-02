import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:selftourapp/src/pages/usuario/profile_head.dart';

class ProfileUserPage extends StatefulWidget {
  ProfileUserPage({Key key}) : super(key: key);

  _ProfileUserPageState createState() => _ProfileUserPageState();
}

class _ProfileUserPageState extends State<ProfileUserPage> {
  //LoginBloc bloc;
  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;

    //bloc = BlocProvider.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
          /*appBar: AppBar(
            elevation: 0.0,
            centerTitle: false,
            title: Image.asset(
              'assets/iconoapp/SELTOURicono.png',
              fit: BoxFit.fill,
              width: size.width * 0.1,
              height: size.height * 0.062,
            ),
          ),*/
          body: ProfileHead()
          

         /* Stack(
            children: <Widget>[
            Container(
              width: size.width * 1.0, //420.0
              height: size.height * 0.24, //430.0
              decoration: BoxDecoration(
                  gradient: RadialGradient(
                      radius: 1.01,
                      center: Alignment.bottomRight,
                      colors: [
                    Color(0xFF0865fe),
                    Color(0xFF034485),
                  ])),
              //color: Colors.green,
            ),
            Positioned(
              top: size.height * 0.01, //30.0
              left: size.width * 0.04,
              child: Container(
                //color: Colors.indigo,
                height: size.height * 0.15, //160.0
                child: Text('Profile',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                //color: Colors.brown,
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.06, //100.0
                  ),
                  ProfileHead(),
                  _verPerfil(context),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: size.width * 0.02),
                    child: Text('Configuración de la Cuenta',style: TextStyle(
                          fontFamily: 'Source Sans Pro',
                          color: Colors.black,
                          fontStyle: FontStyle.italic
                      )
                    ),
                  ),
                  SizedBox(height: size.height * 0.02,),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              FlatButton(
                                padding: EdgeInsets.zero,
                                child: Text('Información Personal',style: TextStyle(
                                    fontFamily: 'Neue Haas Grotesk Display Pro'
                                  ),
                                ),
                                onPressed: (){
                                  Navigator.pushNamed(context, 'editarinfo');
                                },
                              ),
                              Icon(Icons.person_outline,color: Color(0xFF0865fe),)
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                            width: size.width * 0.6,
                            child: Divider(
                              color: Colors.grey,
                              )
                            ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: size.width * 0.02,right: size.width * 0.02 ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              FlatButton(
                                padding: EdgeInsets.zero,
                                //color: Colors.orange,
                                child: Text('Cerrar Sesión',style: TextStyle(
                                  fontFamily: 'Neue Haas Grotesk Display Pro'
                                  ),
                                ),
                                onPressed: (){
                                  bloc.signOut();
                                },
                              ),
                              Icon(Icons.exit_to_app,color: Color(0xFF0865fe)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  /*Container(
                padding: EdgeInsets.all(20.0),
                alignment: Alignment.topLeft,
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      maxRadius: 50.0,
                      backgroundImage: NetworkImage(
                          'https://img-cdn.hipertextual.com/files/2019/04/hipertextual-avengers-endgame-contiene-ultimo-cameo-stan-lee-2019632812.jpg?strip=all&lossy=1&quality=65&resize=740%2C490&ssl=1'),
                    ),
                    SizedBox(
                      width: size.width * 0.04, //30.0
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Nombre completo: ',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Correo: ',
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white24),
                        )
                      ],
                    ),
                  ],
                ),
              ),*/

                  /*SizedBox(
                height: size.height * 0.02,
              ),*/
                  /*Expanded(
                child: ListView(
                  shrinkWrap: true,
                  //itemBuilder: (context,index){
                  //Column(
                  children: <Widget>[
                    _card(),
                   // SizedBox(height: size.height * 0.08,),
                    _card2(),
                   // SizedBox(height: size.height * 0.08,),
                    _card3(),
                   // SizedBox(height: size.height * 0.08,),
                    _card4(),
                   // SizedBox(height: size.height * 0.08,),
                    _card5(),
                   // SizedBox(height: size.height * 0.08,),
                    _card6(),
                   // SizedBox(height: size.height * 0.08,),
                    _card7(),
                   // SizedBox(height: size.height * 0.08,),
                    _card8(),
                    //SizedBox(height: size.height * 0.08,),
                  ],
                  //),
                  //},
                ),
              )*/
                ],
              ),
            ),
            
          ]
          ),*/
        );
  }

  /*Widget _verPerfil(BuildContext context){
    return FlatButton(
      child: Text('Ver Perfil',style: TextStyle(
            color: Colors.white),),
      onPressed: (){
        Navigator.pushNamed(context, 'infousuario');
      },
    );
  }*/

/*
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
              width: size.width * 0.9, //370.0
              height: size.height * 0.33, //270.0
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
          height: size.height * 0.5, //370.0
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
                top: size.height * 0.23,
                left: size.width * 0.07,
                child: Container(
                  child: _cardTipo1(),
                ),
              ),
              Positioned(
                  top: size.height * 0.4,
                  left: size.width * 0.7,
                  child: FloatingActionButton(
                    backgroundColor: Color(0xFF00c7fc),
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
              width: size.width * 0.9,
              height: size.height * 0.33,
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
          height: size.height * 0.5,
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
                top: size.height * 0.23,
                left: size.width * 0.07,
                child: Container(
                  child: _cardTipo1(),
                ),
              ),
              Positioned(
                  top: size.height * 0.4,
                  left: size.width * 0.7,
                  child: FloatingActionButton(
                    backgroundColor: Color(0xFF00c7fc),
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
              width: size.width * 0.9,
              height: size.height * 0.33,
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
          height: size.height * 0.5,
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
                top: size.height * 0.23,
                left: size.width * 0.07,
                child: Container(
                  child: _cardTipo1(),
                ),
              ),
              Positioned(
                  top: size.height * 0.4,
                  left: size.width * 0.7,
                  child: FloatingActionButton(
                    backgroundColor: Color(0xFF00c7fc),
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
              width: size.width * 0.9,
              height: size.height * 0.33,
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
          height: size.height * 0.5,
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
                top: size.height * 0.23,
                left: size.width * 0.07,
                child: Container(
                  child: _cardTipo1(),
                ),
              ),
              Positioned(
                  top: size.height * 0.4,
                  left: size.width * 0.7,
                  child: FloatingActionButton(
                    backgroundColor: Color(0xFF00c7fc),
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
              width: size.width * 0.9,
              height: size.height * 0.33,
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
          height: size.height * 0.5,
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
                top: size.height * 0.23,
                left: size.width * 0.07,
                child: Container(
                  child: _cardTipo1(),
                ),
              ),
              Positioned(
                  top: size.height * 0.4,
                  left: size.width * 0.7,
                  child: FloatingActionButton(
                    backgroundColor: Color(0xFF00c7fc),
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
              width: size.width * 0.9,
              height: size.height * 0.33,
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
          height: size.height * 0.5,
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
                top: size.height * 0.23,
                left: size.width * 0.07,
                child: Container(
                  child: _cardTipo1(),
                ),
              ),
              Positioned(
                  top: size.height * 0.4,
                  left: size.width * 0.7,
                  child: FloatingActionButton(
                    backgroundColor: Color(0xFF00c7fc),
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
              width: size.width * 0.9,
              height: size.height * 0.33,
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
          height: size.height * 0.5,
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
                top: size.height * 0.23,
                left: size.width * 0.07,
                child: Container(
                  child: _cardTipo1(),
                ),
              ),
              Positioned(
                  top: size.height * 0.4,
                  left: size.width * 0.7,
                  child: FloatingActionButton(
                    backgroundColor: Color(0xFF00c7fc),
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
              width: size.width * 0.9,
              height: size.height * 0.33,
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
          height: size.height * 0.5,
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
                top: size.height * 0.23,
                left: size.width * 0.07,
                child: Container(
                  child: _cardTipo1(),
                ),
              ),
              /*Positioned(
                  top: size.height * 0.4,
                  left: size.width * 0.7,
                  child: FloatingActionButton(
                    backgroundColor: Color(0xFF00c7fc),
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ))*/
            ],
          ),
        ),
      ],
    );
  }

  Widget _cardTipo1() {
    final size = MediaQuery.of(context).size;
    // Retorna una tarjeta
    return Container(
      //padding: EdgeInsets.only(top: 0.0),
      //alignment: Alignment(0.0, 130.0),
      width: size.width * 0.83,
      child: Stack(children: <Widget>[
        Card(
          elevation: 1.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Snuckles Montains Range',
                    style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'Source Sans Pro',
                        fontStyle: FontStyle.italic)),
                SizedBox(
                  height: size.height * 0.03, //10.0
                ),
                Text(
                  'Hiking. Water fall hunting. Natural bath. Scenery & Photography',
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Neue Haas Grotesk Display Pro',
                    fontStyle: FontStyle.normal,
                    fontSize: 12,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  'Steps 123,123,123',
                  style: TextStyle(
                    color: Colors.orange,
                    fontFamily: 'Neue Haas Grotesk Display Pro',
                    fontStyle: FontStyle.normal,
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
            top: size.height * 0.4,
            left: size.width * 0.7,
            child: FloatingActionButton(
              backgroundColor: Color(0xFF00c7fc),
              child: Icon(
                Icons.favorite_border,
                size: 10.0,
                color: Colors.white,
              ),
              onPressed: () {},
            ))
      ]),
    );
  }*/
}
