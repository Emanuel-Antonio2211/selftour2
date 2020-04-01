//import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
//import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:selftourapp/src/models/categoria_model.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';

import 'package:selftourapp/src/providers/categorias_providers.dart';
import 'package:translator/translator.dart';
//import 'package:selfttour/src/providers/categorias_providers.dart';

class CategoriaHorizontal extends StatelessWidget {
  //final _categoriasProvider = new CategoriasProvider();

  final List<Categoria> categorias;
  final PreferenciasUsuario prefs = PreferenciasUsuario();
  final translator = new GoogleTranslator();

  final CategoriasProvider categoriasProvider = CategoriasProvider();

  final Function siguientePagina;

  CategoriaHorizontal({@required this.categorias, @required this.siguientePagina});

  final _pageController = new PageController(
    initialPage: 0,
    //cuantos elementos van a aparecer en pantalla
    viewportFraction: 0.8
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    //Hacer un listener para escuchar los cambios del controlador
    //Se va a ejecutar cada vez que se mueva el scroll
    _pageController.addListener((){
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 10){
        _pageController.position.didEndScroll();
        //print('Cargar siguientes categorías');
        //Se ejecuta la función para mostrar la siguiente página
        //de categorías
        //siguientePagina();
      }
    });
    return Container(
      height: size.height * 0.28,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: 5,
        itemBuilder: (context,i){
          return _tarjeta(context, categorias[i]);
        },
        //children: _imagenesCategoria(context),
      ),
    );
  }

  Widget _tarjeta(BuildContext context,Categoria categoria){
    final size = MediaQuery.of(context).size;
    final BaseCacheManager baseCacheManager = DefaultCacheManager();

    /*baseCacheManager.getFile("${categoria.icon.toString()}").listen((info){
      log("File: "+info.file.path);
      log("Url original: "+info.originalUrl);
    });*/
    
    final tarjeta = Container(
        //color:Colors.grey,
        child: Card(
          child: Column(
            children: <Widget>[
              Stack(
                children:<Widget>[ 
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child:
                    CachedNetworkImage(
                          imageUrl: "${categoria.icon.toString()}",
                          //errorWidget: (context, url, error)=>Icon(Icons.error),
                          //color: Colors.lightBlue.withOpacity(0.6),
                          cacheManager: baseCacheManager,
                          useOldImageOnUrlChange: true,
                          width: size.width * 0.8,
                          height: size.height * 0.268,
                          fit: BoxFit.fill,
                        ),
                   /* Image.network(
                      "${categoria.icon.toString()}",
                      scale: 1.0,
                      width: size.width * 0.8,
                      height: size.height * 0.268,
                      fit: BoxFit.fill,
                    )*/
                    
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Container(
                      width: size.width * 0.8,
                      height: size.height * 0.268,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          gradient: LinearGradient(
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                            colors: [
                              Colors.grey.withOpacity(0.1),
                              Colors.black.withOpacity(0.7),
                            ],
                            stops: [
                              0.0,
                              1.0
                            ]
                        )
                      ),
                    ),
                  ),
                  Positioned(
                    top: size.height * 0.12,
                    left: size.width * 0.18,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: size.width * 0.5,
                          //color: Colors.lightBlue,
                          child: Column(
                            children: <Widget>[
                              /*Text(
                               categoria.nameCategory == null ? '':categoria.nameCategory,//categoria.nameCategory
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 27.0,
                                  //backgroundColor: Color(0xFF034485),
                                  fontFamily: 'Point-SemiBoldItalic',
                                ),
                              ),*/
                              FutureBuilder(
                                future: categoriasProvider.traducir(prefs.idioma == null ? 'es' : prefs.idioma.toString(), categoria.nameCategory),
                                builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot) {
                                  if(snapshot.hasData){
                                    return Text(
                                      snapshot.data['data']['translations'][0]['translatedText'],//
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25.0,
                                        //backgroundColor: Color(0xFF034485),
                                        fontFamily: 'Point-SemiBoldItalic',
                                      ),
                                    );
                                  }else{
                                    return Align(
                                      heightFactor: 20.0,
                                      alignment: Alignment.bottomCenter,
                                      child: Container(),
                                    );
                                  }
                                  
                                },
                              ),
                              Text(
                                "${categoria.cant.toString()} tours",
                                style: TextStyle(
                                  color: Colors.white,
                                  //backgroundColor: Color(0xFF034485),
                                  fontFamily: 'Point-SemiBoldItalic',
                                  fontSize: 18
                                ),
                              )
                            ],
                          )
                          
                          /*FutureBuilder(
                            future: categoriasProvider.traducir(prefs.idioma == null ? 'es' : prefs.idioma.toString(), categoria.nameCategory),
                            builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot) {
                              if(snapshot.hasData){
                                return Text(
                                  snapshot.data['data']['translations'][0]['translatedText'],//
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 27.0,
                                      //backgroundColor: Color(0xFF034485),
                                      fontFamily: 'Point-SemiBoldItalic',
                                  ),
                                );
                              }else{
                                return Align(
                                  heightFactor: 20.0,
                                  alignment: Alignment.bottomCenter,
                                  child: Container(),
                                );
                              }
                              
                            },
                          ),*/

                         /*FutureBuilder(
                            future: traducir(prefs.idioma == null ? 'en' : '${prefs.idioma}', '${categoria.nameCategory}'),
                            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                              if(snapshot.hasData){
                                return Text(
                                  snapshot.data,//
                                  style: TextStyle(
                                    locale: Localizations.localeOf(context),
                                      color: Colors.white,
                                      fontSize: 27.0,
                                      //backgroundColor: Color(0xFF034485),
                                      fontFamily: 'Point-SemiBoldItalic',
                                  ),
                                );
                              }else{
                                return Align(
                                  heightFactor: 20.0,
                                  alignment: Alignment.bottomCenter,
                                  child: Image.asset('assets/loading.gif'),
                                );
                              }
                              
                            },
                          ),*/
                          
                          
                          
                        ),
                    )
                  )
                ]
              ),
              /*Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(width: size.width * 0.02,),
                  Container(
                    width: size.width * 0.3,
                    child: Row(
                      children: <Widget>[
                          Icon(Icons.star,color: Color(0xFFF7C109),size: 18.0,),
                          Icon(Icons.star,color: Color(0xFFF7C109),size: 18.0,),
                          Icon(Icons.star,color: Color(0xFFF7C109),size: 18.0,),
                          Icon(Icons.star,color: Color(0xFFF7C109),size: 18.0,),
                          Icon(Icons.star_half,color: Color(0xFFF7C109),size: 18.0,),
                      ],
                    ),
                  ),
                  Text('70',style: TextStyle(fontFamily: 'Neue Haas Grotesk Display Pro'),)
                ],
              ),
            )*/
            ],
          ),
        ),
      );
    return GestureDetector(
      child: tarjeta,
      onTap: (){
        print('id de la categoria: ${categoria.ctidss}');
        Navigator.pushNamed(context, 'tours',arguments: categoria);
      },
    );
  }

  /*List<Widget> _imagenesCategoria(BuildContext context){
    final size = MediaQuery.of(context).size;
    return categorias.map((categoria){
      return Container(
        //color:Colors.grey,
        child: Card(
                  child: Column(
            children: <Widget>[
              Stack(
                children:<Widget>[ 
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: FadeInImage(
                      image: NetworkImage(categoria.getImageCategorias()),
                      placeholder: AssetImage('assets/no-image.jpg'),
                      fit: BoxFit.cover,
                      width: size.width * 0.5,
                      height: size.height * 0.22,
                    ),
                  ),
                
                  Positioned(
                    top: size.height * 0.1,
                    left: size.width * 0.15,
                    child: Text(categoria.nameCategory,style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Point',
                          fontWeight: FontWeight.bold
                          ),
                        )
                  )
                ]
              ),
              Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(width: size.width * 0.02,),
                  Container(
                    width: size.width * 0.3,
                    child: Row(
                      children: <Widget>[
                          Icon(Icons.star,color: Color(0xFFF7C109),size: 18.0,),
                          Icon(Icons.star,color: Color(0xFFF7C109),size: 18.0,),
                          Icon(Icons.star,color: Color(0xFFF7C109),size: 18.0,),
                          Icon(Icons.star,color: Color(0xFFF7C109),size: 18.0,),
                          Icon(Icons.star_half,color: Color(0xFFF7C109),size: 18.0,),
                      ],
                    ),
                  ),
                  Text('70',style: TextStyle(fontFamily: 'Neue Haas Grotesk Display Pro'),)
                ],
              ),
            )
            ],
          ),
        ),
      );
    }).toList();
  }*/

  Widget _imagenCategoria(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final imagen = Container(
      padding: EdgeInsets.all(6.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: FadeInImage(
              width: size.width * 0.5,
              height: size.height * 0.19,
              image: AssetImage('assets/images/beach.jpeg'),
              placeholder: AssetImage('assets/jar-loading.gif'),
              fadeInDuration: Duration(milliseconds: 100),
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: size.height * 0.01,),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                
                        SizedBox(width: size.width * 0.02,),
                        Container(
                          width: size.width * 0.3,
                          child: Row(
                            children: <Widget>[
                                Icon(Icons.star,color: Color(0xFFF7C109),size: 18.0,),
                                Icon(Icons.star,color: Color(0xFFF7C109),size: 18.0,),
                                Icon(Icons.star,color: Color(0xFFF7C109),size: 18.0,),
                                Icon(Icons.star,color: Color(0xFFF7C109),size: 18.0,),
                                Icon(Icons.star_half,color: Color(0xFFF7C109),size: 18.0,),
                            ],
                          ),
                        ),
                        Text('70',style: TextStyle(fontFamily: 'Neue Haas Grotesk Display Pro'),)
              ],
            ),
          )
        ],
      ),
    );
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, 'tours');
      },
          child: Column(
        children: <Widget>[
          Container(
            //color: Colors.white,
            height: size.height * 0.27,
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Card(child: imagen),
                Positioned(
                  top: size.height * 0.1,
                  left: size.width * 0.16,
                  child: Container(
                    child: Text(
                      'Título Imagen',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Point',
                        fontWeight: FontWeight.bold
                        ),
                      ),
                  ),
                ),
                /*Positioned(
                  top: size.height * 0.23,
                  left: size.width * 0.03,
                  child: Container(
                    height: 30.0,
                    color: Colors.blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Costo',style: TextStyle(fontFamily: 'Neue Haas Grotesk Display Pro'),),
                        SizedBox(width: size.width * 0.02,),
                        Container(
                          width: size.width * 0.28,
                          child: Row(
                            children: <Widget>[
                                Icon(Icons.star,color: Color(0xFFF7C109),size: 18.0,),
                                Icon(Icons.star,color: Color(0xFFF7C109),size: 18.0,),
                                Icon(Icons.star,color: Color(0xFFF7C109),size: 18.0,),
                                Icon(Icons.star,color: Color(0xFFF7C109),size: 18.0,),
                                Icon(Icons.star_half,color: Color(0xFFF7C109),size: 18.0,),
                            ],
                          ),
                        ),
                        Text('70 %',style: TextStyle(fontFamily: 'Neue Haas Grotesk Display Pro'),)
                      ],
                    ),
                  ),
                ),*/
              ],
            ),
          )
        ],
      ),
    );
  }
}