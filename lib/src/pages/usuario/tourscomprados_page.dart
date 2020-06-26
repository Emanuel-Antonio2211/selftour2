import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selftourapp/src/googlemaps/states/app_state.dart';
//import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:selftourapp/src/models/tour_categoria_model.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:selftourapp/src/providers/categorias_providers.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';

class ToursCompradosPage extends StatefulWidget {
  @override
  _ToursCompradosPageState createState() => _ToursCompradosPageState();
}

class _ToursCompradosPageState extends State<ToursCompradosPage> {
  List<InfoTour> comprados = List();
  CategoriasProvider categoriasProvider = CategoriasProvider();
  String state;
  String codCountry;
  //AppState _appState = AppState();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    categoriasProvider.toursComprados();
  }

  @override
  Widget build(BuildContext context) {
    String comprados = AppTranslations.of(context).text('title_orders');
    final size = MediaQuery.of(context).size;
    String noData = AppTranslations.of(context).text('title_nodata');
    // _appState.userLocation().then((value){
    //   state = value[1].toString();
    //   codCountry = value[5].toString();
    //   print("Estado: ");
    //   print(state);
      
    // });
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          '${comprados.toUpperCase()}',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Point-ExtraBold',
            fontWeight: FontWeight.bold
          ),
        ),
        /*actions: <Widget>[
          FlatButton(
            child: Text('Crear Tour',
              style: TextStyle(
                fontFamily: 'Point',
                color: Colors.white
              ),
            ),
            onPressed: (){},
          )
        ],*/
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: categoriasProvider.tourFavoritoStream,
         // initialData: InitialData,
          builder: (BuildContext context, AsyncSnapshot<List<InfoTour>> snapshot) {
            String errorDatos = AppTranslations.of(context).text('title_errorVacio');

            switch(snapshot.connectionState){
              case ConnectionState.waiting:
                return Column(
                  children: <Widget>[
                    SafeArea(
                      child: SizedBox(
                        height: size.height * 0.4,
                      ),
                    ),
                    Center(child: CircularProgressIndicator()),
                  ],
                );
              break;
              case ConnectionState.none:
                return Column(
                  children: <Widget>[
                    SafeArea(
                      child: SizedBox(
                        height: size.height * 0.4,
                      ),
                    ),
                    Center(child: Text('$noData')),
                  ],
                );
              break;
              case ConnectionState.done:
                if( snapshot.hasData){
                  if(snapshot.data.length > 0){
                    final listatour = snapshot.data;
                    print("Tamaño");
                    print(listatour.length);
                    return Comprados(listaComprados: listatour);
                  }else{
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SafeArea(
                          child: SizedBox(
                            height: size.height * 0.4,
                          ),
                        ),
                        Center(
                          child: Text(
                            '${noData.toString()}' //errorDatos.toString() snapshot.error.toString()
                          )
                        ),
                      ],
                    );
                  }
                  
                }else if(snapshot.hasError){
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SafeArea(
                          child: SizedBox(
                            height: size.height * 0.4,
                          ),
                        ),
                        Center(
                          child: Text(
                            '${errorDatos.toString()}' //errorDatos.toString() snapshot.error.toString()
                          )
                        ),
                      ],
                    ),
                  );
                }
                else{
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SafeArea(
                        child: SizedBox(
                          height: size.height * 0.4,
                        ),
                      ),
                      Center(
                        child: CircularProgressIndicator()
                      ),
                    ],
                  );
                }
                /*final listatour = snapshot.data;
                //loading = true;
                return Comprados(listaComprados: listatour,);*/
              break;
              case ConnectionState.active:
                if(snapshot.hasData){
                  if(snapshot.data.length > 0){
                    final listatour = snapshot.data;
                    print("Tamaño");
                    print(listatour.length);
                    return Comprados(listaComprados: listatour);
                  }else{
                   return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SafeArea(
                          child: SizedBox(
                            height: size.height * 0.4,
                          ),
                        ),
                        Center(
                          child: Text('$noData')
                        ),
                      ],
                    );
                  }
                }else if(snapshot.hasError){
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SafeArea(
                          child: SizedBox(
                            height: size.height * 0.4,
                          ),
                        ),
                        Center(
                          child: Text('${errorDatos.toString()}')
                        ),
                      ],
                    ),
                  );
                }else{
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SafeArea(
                        child: SizedBox(
                          height: size.height * 0.4,
                        ),
                      ),
                      Center(
                        child: CircularProgressIndicator()
                      ),
                    ],
                  );
                }
                //final listatour = snapshot.data;
                //loading = true;
               // return Comprados(listaComprados: listatour,);
              break;
              default:
                return Column(
                  children: <Widget>[
                    SafeArea(
                      child: SizedBox(
                        height: size.height * 0.4,
                      ),
                    ),
                    Center(child: CircularProgressIndicator() ),//Text('$noData')
                  ],
                );
              //break;
            }
            /*if(snapshot.hasData){
              final listatour = snapshot.data;
              loading = true;
              return Comprados(listaComprados: listatour,);
            }else if(snapshot.hasError){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SafeArea(
                      child: SizedBox(
                        height: size.height * 0.4,
                      ),
                    ),
                    Center(
                      child: Text('${errorDatos.toString()}')
                    ),
                  ],
                ),
              );
            }
            else{
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SafeArea(
                    child: SizedBox(
                      height: size.height * 0.4,
                    ),
                  ),
                  Center(
                    child: Text('$noData')
                  ),
                ],
              );
            }*/
            
          },
        ),
        )
    );
  }
}

class Comprados extends StatefulWidget {
  final List<InfoTour> listaComprados;
  Comprados({@required this.listaComprados});
  @override
  _CompradosState createState() => _CompradosState();
}

class _CompradosState extends State<Comprados> {
  PreferenciasUsuario prefs = PreferenciasUsuario();
  final _scrollController = ScrollController();
  CategoriasProvider _categoriasProvider = CategoriasProvider();
  bool isloading = false;
  String state;
  String codCountry;
  AppState _appState = AppState();

  Future<Null> cargarTours()async{
    final duration = Duration(seconds: 2);

    Timer(duration, (){
      widget.listaComprados.clear();
      // _appState.userLocation().then((value){
      //   state = value[1].toString();
      //   codCountry = value[5].toString();
        
      // });

      _categoriasProvider.toursComprados().then((result){
        for(int i = 0; i < result.length; i++){
          widget.listaComprados.add(result[i]);
        }
      });

    });
    print("Lista Cargada");
    print(widget.listaComprados);
    return Future.delayed(duration);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _scrollController.addListener((){
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 10){
        //_scrollController.position.didEndScroll();
        //print('Cargar siguientes categorías');
        //Se ejecuta la función para mostrar la siguiente página
        //de categorías
        //widget.siguientePagina();
        fetchData();
      }
    });
    return Container(
      height: size.height * 0.8,
      child: Stack(
        children:<Widget>[ 
          RefreshIndicator(
            onRefresh: cargarTours,
            child: ListView.builder(
              controller: _scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: widget.listaComprados.length,
              itemBuilder: (context,index){
                return _tourComprado(context, widget.listaComprados[index]);
              },
            ),
          ),
          _crearLoading()
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
    setState(() {
      
    });
    isloading = false;
    _scrollController.animateTo(
      _scrollController.position.pixels + 100,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 250)
    );
    _categoriasProvider.toursComprados().then((resp){
      setState(() {
        isloading = false;
      });
      for(int i = 0; i < resp.length; i++){
        widget.listaComprados.add(resp[i]);
      }
    });
    //widget.siguientePagina();
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

/*
  Widget _toursComprados(BuildContext context, InfoTour tour){
    final size = MediaQuery.of(context).size;
    prefs.idsell = tour.idsell.toString();
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/detalletour',arguments: tour);
      },
      child: Card(
        child: Row(
          children: <Widget>[
              ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child:
              /*Image.network(
                tour.picture[0]['url'].toString(),
                width: size.width * 0.5,
                height: size.height * 0.15,
                fit: BoxFit.fill,
                scale: 1.0,
              )*/
              CachedNetworkImage(
                imageUrl: "${tour.url}",
                //errorWidget: (context, url, error)=>Icon(Icons.error),
                //cacheManager: baseCacheManager,
                useOldImageOnUrlChange: true,
                width: size.width * 0.5,
                height: size.height * 0.15,
                fit: BoxFit.fill,
              )
            ),
            SizedBox(
              width: size.width * 0.02,
            ),
            Flexible(
              child: Text(
                tour.title,
                style: TextStyle(
                  fontFamily: 'Point-SemiBold'
                ),
              )
            )
          ],
        ),
      ),
    );
  }*/

  Widget _tourComprado(BuildContext context, InfoTour infotour){
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/detalletour',arguments: infotour);
      },
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                width: size.width * 0.92,
                height: size.height * 0.25,
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey[100],
                      offset: Offset(
                       size.width * 0.02,size.height * 0.00
                      ),
                      blurRadius: 5.0
                    )
                  ]
                ),
                child: Card(
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: size.width * 0.35,
                        top: size.height * 0.04,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: size.width * 0.5,
                              child: Text(
                                  infotour.title.toString(),
                                  style: TextStyle(
                                    fontFamily: 'Point-SemiBold',
                                    fontWeight: FontWeight.bold,
                                    //fontSize: 15.0
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                            )
                          ],
                        )
                      ),
                      Positioned(
                        top: size.height * 0.033,
                        right: size.width * 0.02,
                        child: Card(
                          color: Colors.redAccent,
                          child: Text(
                            '\$ ${double.parse(infotour.total.toString()).toString()}',
                            style: TextStyle(
                              fontFamily: 'Point-SemiBold',
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: size.width * 0.01,
            top: size.height * 0.035,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CachedNetworkImage(
                imageUrl: infotour.url == null ?
                "https://selftour-public.s3.amazonaws.com/no_gallery.jpg":
                 "${infotour.url}",
                //errorWidget: (context, url, error)=>Icon(Icons.error),
                //cacheManager: baseCacheManager,
                useOldImageOnUrlChange: true,
                width: size.width * 0.38,
                height: size.height * 0.15,
                fit: BoxFit.fill,
              )
            ),
          ),
        ],
      ),
    );
  }
}