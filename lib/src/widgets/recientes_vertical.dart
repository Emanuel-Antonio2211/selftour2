import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:selftourapp/src/models/tour_categoria_model.dart';
import 'package:selftourapp/src/providers/categorias_providers.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';

class RecienteVertical extends StatelessWidget {
  final List<InfoTour> listaRecientes;
  final Function siguientePagina;

  RecienteVertical({@required this.listaRecientes, @required this.siguientePagina});
  final _scrollController = ScrollController();
  final categoriaProvider = CategoriasProvider();

  Future<Null> cargarRecientes()async{
    final duration = Duration(seconds: 2);

    Timer(duration, (){
      listaRecientes.clear();
      categoriaProvider.popularesPag().then((result){
        for(int i = 0; i < result.length; i++){
          listaRecientes.add(result[i]);
        }
      });

    });
    print("Lista Cargada");
    print(listaRecientes);
    return Future.delayed(duration);
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _scrollController.addListener((){
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 10){
        _scrollController.position.didEndScroll();
        //print('Cargar siguientes categorías');
        //Se ejecuta la función para mostrar la siguiente página
        //de categorías
        siguientePagina();
      }
    });
    return Container(
      height: size.height * 0.8,
      child: RefreshIndicator(
        onRefresh: cargarRecientes,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: listaRecientes.length,//snapshot.data.length
          itemBuilder: (context,index){
            return recientes(context, listaRecientes[index]);
          },
        ),
      ),
    );
  }
  Widget recientes(BuildContext context, InfoTour tour){
    final size = MediaQuery.of(context).size;
    //PreferenciasUsuario prefs = PreferenciasUsuario();
    String valoracion = AppTranslations.of(context).text('title_puntuacion');

    final recientes = Stack(
      children: <Widget>[
        Card(
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: 
                /*Image.network(
                  "${tour.gallery}",
                  scale: 1.0,
                  fit: BoxFit.fill,
                  width: size.width * 1.0,
                  height: size.height * 0.3
                )*/
                CachedNetworkImage(
                  imageUrl: "${tour.gallery}",
                  //errorWidget: (context, url, error)=>Icon(Icons.error),
                  //cacheManager: baseCacheManager,
                  useOldImageOnUrlChange: true,
                  width: size.width * 1.0,
                  height: size.height * 0.3,
                  fit: BoxFit.fill,
                )
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Container(
                  width: size.width * 1.0,
                  height: size.height * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        Colors.grey.withOpacity(0.1),
                        Colors.black.withOpacity(0.7)
                      ],
                      stops: [
                        0.0,
                        1.0
                      ]
                    )
                  ),
                ),
              ),
            ],
          )
          
        ),
        Align(
           alignment: Alignment.topCenter,
           child: Padding(
             padding: EdgeInsets.symmetric(horizontal: size.width * 0.02,vertical: size.width * 0.02),
             child: Row(
               children: <Widget>[
                 Row(
                   children: <Widget>[
                     Icon(Icons.place,color: Colors.white,),
                     Text(
                        tour.country==null ? '':tour.country,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Point-ExtraBold',
                          fontWeight: FontWeight.bold
                        ),
                      ),
                     /*FutureBuilder(
                       future: categoriasProvider.traducir(prefs.idioma == null ? 'es' : prefs.idioma.toString(), tour.country),
                       builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot) {
                         if(snapshot.hasData){
                           return Text(
                              snapshot.data['data']['translations'][0]['translatedText'].toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Point-ExtraBold',
                                fontWeight: FontWeight.bold
                            ),
                          );
                         }else{
                           return Container();
                         }
                         
                       },
                     ),*/
                     
                   ],
                 ),
                 /*SizedBox(
                  width: size.width * 0.6,
                ),*/
               ],
             ),
           ),
        ),
        Align(
          heightFactor: 5.0,
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  tour.title==null?'':tour.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Point-SemiBold',
                    fontSize: 14.0,
                    color: Colors.white
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Text(
                          tour.score == null ? '': tour.score.toString(),
                          style: TextStyle(
                            fontFamily: 'Point-SemiBold',
                            color: Colors.white
                          ),
                        ),
                        Text(
                          '$valoracion',
                          style: TextStyle(
                            fontFamily: 'Point-SemiBold',
                            color: Colors.white
                          ),
                        ),
                        Text(
                          ' (  )',
                          style: TextStyle(
                            fontFamily: 'Point-SemiBold',
                            color: Colors.white
                          ),
                        )
                      ],
                    ),
                    
                    Text(
                      '\$ ${tour.price == null ? 0 : tour.price}',
                      style: TextStyle(
                        fontFamily: 'Point-SemiBold',
                        color: Colors.white
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/detalletour',arguments: tour);
      },
      child: recientes
    );
  }
}

class RecienteGrid extends StatelessWidget {
  final List<InfoTour> listaRecientes;
  final Function siguientePagina;

  RecienteGrid({@required this.listaRecientes, @required this.siguientePagina});
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _scrollController.addListener((){
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 10){
        _scrollController.position.didEndScroll();
        //print('Cargar siguientes categorías');
        //Se ejecuta la función para mostrar la siguiente página
        //de categorías
        siguientePagina();
      }
    });
    return Container(
      height: size.height * 0.8,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: listaRecientes.length,//snapshot.data.length
        itemBuilder: (context,i){
          return recienteGrid(context, listaRecientes[i]);
        },
      ),
    );
  }
  Widget recienteGrid(BuildContext context,InfoTour tour){
    final size = MediaQuery.of(context).size;
    String valoracion = AppTranslations.of(context).text('title_puntuacion');
    final recienteTour = Card(
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: 
            /*Image.network(
              "${tour.gallery}",
              scale: 1.0,
              fit: BoxFit.fill,
              width: size.width * 0.5,
              height: size.height * 0.4,
            )*/
            CachedNetworkImage(
              imageUrl: "${tour.gallery}",
              //errorWidget: (context, url, error)=>Icon(Icons.error),
              //cacheManager: baseCacheManager,
              useOldImageOnUrlChange: true,
              width: size.width * 0.5,
              height: size.height * 0.4,
              fit: BoxFit.fill,
            )
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
              width: size.width * 0.5,
              height: size.height * 0.4,
              decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.grey.withOpacity(0.1),
                    Colors.black.withOpacity(0.7)
                  ],
                  stops: [
                    0.0,
                    1.0
                  ]
                )
              ),
            ),
          ),
          /*Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                '${tour.title}',
                style: TextStyle(
                  fontFamily: 'Point-SemiBold',
                  color: Colors.white
                ),
              ),
            ),
          )*/
          Align(
           alignment: Alignment.topLeft,
           child: Padding(
             padding: EdgeInsets.symmetric(horizontal: size.width * 0.02,vertical: size.width * 0.02),
             child: Row(
               children: <Widget>[
                 Row(
                   children: <Widget>[
                     Icon(Icons.place,color: Colors.white,),
                     Text(
                        tour.country==null ? '' : tour.country,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Point-ExtraBold',
                          fontWeight: FontWeight.bold
                        ),
                      ),
                     /*FutureBuilder(
                       future: categoriasProvider.traducir(prefs.idioma == null ? 'es': prefs.idioma.toString(), tour.country),
                       builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot) {
                         if(snapshot.hasData){
                           return Text(
                            snapshot.data['data']['translations'][0]['translatedText'].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Point-ExtraBold',
                              fontWeight: FontWeight.bold
                            ),
                          );
                         }else{
                           return Container();
                         }
                         
                       },
                     ),*/
                     
                   ],
                 ),
                 /*SizedBox(
                  width: size.width * 0.6,
                ),*/
               ],
             ),
           ),
        ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: 73.0,left: 10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      tour.title == null ? '' : tour.title,
                      style: TextStyle(
                        fontFamily: 'Point-SemiBold',
                        fontSize: 15.0,
                        color: Colors.white
                      ),
                    ),
                    
                  ],
                ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 10.0,right: 10.0,bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Text(
                        tour.score == null ? '' : tour.score.toString(),
                        style: TextStyle(
                          fontFamily: 'Point-SemiBold',
                          color: Colors.white
                        ),
                      ),
                      Text(
                        '$valoracion',
                        style: TextStyle(
                          fontFamily: 'Point-SemiBold',
                          color: Colors.white
                        ),
                      ),
                      Text(
                        ' (  )',
                        style: TextStyle(
                          fontFamily: 'Point-SemiBold',
                          color: Colors.white
                        ),
                      )
                    ],
                  ),
                  
                  Text(
                    '\$ ${tour.price == null ? 0 : tour.price}',
                    style: TextStyle(
                      fontFamily: 'Point-SemiBold',
                      color: Colors.white
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );

    return GestureDetector(
      child: recienteTour,
      onTap: (){
        Navigator.pushNamed(context, '/detalletour',arguments: tour);
      },
    );
  }
}