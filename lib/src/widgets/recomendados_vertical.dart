import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:selftourapp/src/googlemaps/states/app_state.dart';
import 'dart:async';
import 'package:selftourapp/src/models/tour_categoria_model.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';
import 'package:selftourapp/src/providers/categorias_providers.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';

class RecomendadoVertical extends StatefulWidget {
  final List<InfoTour> listaRecomendados;
  final Function siguientePagina;
  RecomendadoVertical({@required this.listaRecomendados, @required this.siguientePagina});

  @override
  _RecomendadoVerticalState createState() => _RecomendadoVerticalState();
}

class _RecomendadoVerticalState extends State<RecomendadoVertical> {
  final _scrollController = ScrollController();
  final categoriasProvider = CategoriasProvider();
  PreferenciasUsuario prefs = PreferenciasUsuario();
  bool isloading = false;
  String state;
  String codCountry;
  AppState _appState = AppState();

  @override
  void initState() { 
    super.initState();
    _scrollController.addListener((){
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 10){
        //_scrollController.position.didEndScroll();
        //print('Cargar siguientes categorías');
        //Se ejecuta la función para mostrar la siguiente página
        //de categorías
        //widget.siguientePagina();
        //fetchData();
      }else{
        isloading = false;
      }
    });
  }

  @override
  void dispose(){
    super.dispose();
    _scrollController.dispose();
  }

  Future<Null> cargarRecomendados()async{
    final duration = Duration(seconds: 2);

    Timer(duration, ()async{
      widget.listaRecomendados.clear();
      // _appState.userLocation().then((value)async{
      //   state = value[1].toString();
      //   codCountry = value[5].toString();
      //  final result = await categoriasProvider.recomendadosPag(state,codCountry);
      //   final recomendados = ListaToursC.fromJsonList(result['tours'][0]['data_tour']);
      //   for(int i = 0; i < recomendados.itemsTours.length; i++){
      //     widget.listaRecomendados.add(recomendados.itemsTours[i]);
      //   }
      // });
      
      // _appState.ubicacion().then((value)async{
      //   print("Datos del usuario:");
      //   print(value[1]);
      //   print(value[3]);
      //   final resultado = await categoriasProvider.recomendadosPag(value[1],value[3]);
      //   final recomendados = ListaToursC.fromJsonList(resultado['tours'][0]['data_tour']);
      //   for(int i = 0; i < recomendados.itemsTours.length; i++){
      //     widget.listaRecomendados.add(recomendados.itemsTours[i]);
      //   }
      // });

      print("Datos del usuario:");
      print(prefs.estadoUser);
      print(prefs.countryCode);
      final resultado = await categoriasProvider.recomendadosPag(prefs.estadoUser,prefs.countryCode,page: '1');
      final recomendados = ListaToursC.fromJsonList(resultado['tours'][0]['data_tour']);
      for(int i = 0; i < recomendados.itemsTours.length; i++){
        widget.listaRecomendados.add(recomendados.itemsTours[i]);
      }

    });
    print("Lista Cargada");
    print(widget.listaRecomendados);
    return Future.delayed(duration);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Container(
      height: size.height * 0.8,
      child: Stack(
        children:<Widget> [ 
          RefreshIndicator(
            onRefresh: cargarRecomendados,
            child: ListView.builder(
              shrinkWrap: true,
              primary: true,
              controller: _scrollController,
              itemCount: widget.listaRecomendados.length,//snapshot.data.length
              //physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context,index){
                return recomendados(context, widget.listaRecomendados[index]);
              },
            ),
          ),
          //_crearLoading()
        ]
      ),
    );
  }

  Future fetchData()async{
    isloading = true;
    setState(() {
      
    });
    final duration = Duration(seconds: 2);
    return Timer(duration,cargar);
  }

  void cargar(){
    isloading = false;
    _scrollController.animateTo(
      _scrollController.position.pixels + 20,
      curve: Curves.fastOutSlowIn, 
      duration: Duration(milliseconds: 250)
    );
    widget.siguientePagina();
  }

  Widget _crearLoading(){
    if(isloading){
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator()
            ],
          ),
          SizedBox(
            height: 15.0
          )
        ],
      );
    }else{
      return Container();
    }
  }

  Widget recomendados(BuildContext context, InfoTour tour){
    final size = MediaQuery.of(context).size;
    //PreferenciasUsuario prefs = PreferenciasUsuario();
    String valoracion = AppTranslations.of(context).text('title_puntuacion');

    final recomendado = Stack(
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
                  height: size.height * 0.3,
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
                      tour.country==null ? '' : tour.country,
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
          )
        ),
        Align(
          alignment: Alignment.bottomLeft,
          heightFactor: 5.0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  tour.title == null ? '' : tour.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Point-SemiBold',
                    fontSize: 15.0,
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
                          ' (   )',
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
      child: recomendado
    );
  }
}

class RecomendadoGrid extends StatefulWidget {
  final List<InfoTour> listaRecomendados;
  final Function siguientePagina;
  RecomendadoGrid({@required this.listaRecomendados, @required this.siguientePagina});

  @override
  _RecomendadoGridState createState() => _RecomendadoGridState();
}

class _RecomendadoGridState extends State<RecomendadoGrid> {
  final _scrollController = ScrollController();
  bool isloading = false;
  final categoriasProvider = CategoriasProvider();
  PreferenciasUsuario prefs = PreferenciasUsuario();
  String state;
  String codCountry;
  AppState _appState = AppState();

  @override
  void initState() { 
    super.initState();
    _scrollController.addListener((){
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 10){
        //_scrollController.position.didEndScroll();
        //print('Cargar siguientes categorías');
        //Se ejecuta la función para mostrar la siguiente página
        //de categorías
        //widget.siguientePagina();
        //fetchData();
      }else{
        isloading = false;
      }
    });
  }

  @override
  void dispose(){
    super.dispose();
    _scrollController.dispose();
  }

  Future<Null> cargarRecomendados()async{
    final duration = Duration(seconds: 2);

    Timer(duration, ()async{
      widget.listaRecomendados.clear();
      //   _appState.userLocation().then((value)async{
      //   state = value[1].toString();
      //   codCountry = value[5].toString();
      //  final result = await categoriasProvider.recomendadosPag(state,codCountry);
      //   final recomendados = ListaToursC.fromJsonList(result['tours'][0]['data_tour']);
      //   for(int i = 0; i < recomendados.itemsTours.length; i++){
      //     widget.listaRecomendados.add(recomendados.itemsTours[i]);
      //   }
      // });
      
      // _appState.ubicacion().then((value)async{
      //   print("Datos del usuario:");
      //   print(value[1]);
      //   print(value[3]);
      //   final resultado = await categoriasProvider.recomendadosPag(value[1],value[3]);
      //   final recomendados = ListaToursC.fromJsonList(resultado['tours'][0]['data_tour']);
      //   for(int i = 0; i < recomendados.itemsTours.length; i++){
      //     widget.listaRecomendados.add(recomendados.itemsTours[i]);
      //   }
      // });

      print("Datos del usuario:");
      print(prefs.estadoUser);
      print(prefs.countryCode);
      final resultado = await categoriasProvider.recomendadosPag(prefs.estadoUser,prefs.countryCode,page: '1');
      final recomendados = ListaToursC.fromJsonList(resultado['tours'][0]['data_tour']);
      for(int i = 0; i < recomendados.itemsTours.length; i++){
        widget.listaRecomendados.add(recomendados.itemsTours[i]);
      }

    });
    print("Lista Cargada");
    print(widget.listaRecomendados);
    return Future.delayed(duration);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Container(
      height: size.height * 0.8,
      //color: Colors.lightBlueAccent,
      child: Stack(
        children:<Widget>[ 
          RefreshIndicator(
            onRefresh: cargarRecomendados,
            child: GridView.builder(
              shrinkWrap: true,
              primary: true,
              scrollDirection: Axis.vertical,
              controller: _scrollController,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              //physics: AlwaysScrollableScrollPhysics(),
              itemCount: widget.listaRecomendados.length,//snapshot.data.length
              itemBuilder: (context,i){
                return recomendadoGrid(context, widget.listaRecomendados[i]);
              },
            ),
          ),
          //_crearLoading()
        ]
      ),
    );
  }

  Future fetchData()async{
    isloading = true;
    setState(() {
      
    });
    final duration = Duration(seconds: 2);
    return Timer(duration,cargar);
  }

  void cargar(){
    isloading = false;
    _scrollController.animateTo(
      _scrollController.position.pixels + 20,
      curve: Curves.fastOutSlowIn, 
      duration: Duration(milliseconds: 250)
    );
    widget.siguientePagina();
  }

  Widget _crearLoading(){
    if(isloading){
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator()
            ],
          ),
          SizedBox(
            height: 15.0
          )
        ],
      );
    }else{
      return Container();
    }
  }

  Widget recomendadoGrid(BuildContext context,InfoTour tour){
    final size = MediaQuery.of(context).size;
    String valoracion = AppTranslations.of(context).text('title_puntuacion');
    
    final recomendado = Card(
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
                        tour.country == null ? '' : tour.country,
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
                        ' (   )',
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
      child: recomendado,
      onTap: (){
        Navigator.pushNamed(context, '/detalletour',arguments: tour);
      },
    );
  }
}