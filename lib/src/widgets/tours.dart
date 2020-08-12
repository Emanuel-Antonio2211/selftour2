import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:selftourapp/src/googlemaps/states/app_state.dart';
import 'dart:async';
//import 'package:flutter_cache_manager/flutter_cache_manager.dart';
//import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:selftourapp/src/models/tour_categoria_model.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:selftourapp/src/providers/categorias_providers.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';

class ToursGeneral extends StatefulWidget {
  //final categoriasProvider = new CategoriasProvider();
  final List<InfoTour> listaTours;

  ToursGeneral({@required this.listaTours});

  @override
  _ToursGeneralState createState() => _ToursGeneralState();
}

class _ToursGeneralState extends State<ToursGeneral> {
  PreferenciasUsuario prefs = PreferenciasUsuario();
  CategoriasProvider provider = CategoriasProvider();
  final _scrollController = ScrollController();
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
        fetchData();
      }
    });
  }

  @override
  void dispose(){
    super.dispose();
    _scrollController.dispose();
  }

  Future<Null> cargarTours()async{
    final duration = Duration(seconds: 2);

    Timer(duration, ()async{
      widget.listaTours.clear();
      // _appState.userLocation().then((value)async{
      //   state = value[1].toString();
      //   codCountry = value[5].toString();
      //   final result = await provider.getTours(state,codCountry);
      //   final tours = new ListaToursC.fromJsonList(result['tours'][0]['data_tour']);
      //   for(int i = 0; i < tours.itemsTours.length; i++){
      //     widget.listaTours.add(tours.itemsTours[i]);
      //   }
      // });

      // _appState.ubicacion().then((value)async{
      //   print("Datos del usuario:");
      //   print(value[1]);
      //   print(value[3]);
      //   final resultado = await provider.getTours(value[1],value[3]);
      //   final tours = new ListaToursC.fromJsonList(resultado['tours'][0]['data_tour']);
      //   for(int i = 0; i < tours.itemsTours.length; i++){
      //     widget.listaTours.add(tours.itemsTours[i]);
      //   }
      // });

      print("Datos del usuario:");
      print(prefs.estadoUser);
      print(prefs.countryCode);
      final resultado = await provider.getTours(prefs.estadoUser.toString(),prefs.countryCode.toString(),page: '1');
      final tours = new ListaToursC.fromJsonList(resultado['tours'][0]['data_tour']);
      for(int i = 0; i < tours.itemsTours.length; i++){
        widget.listaTours.add(tours.itemsTours[i]);
      }

    });
    print("Lista Cargada");
    print(widget.listaTours);
    return Future.delayed(duration);
  }
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
       height: size.height * 0.8,
      child:Stack(
        children:<Widget>[ 
          RefreshIndicator(
            onRefresh: cargarTours,
            child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              scrollDirection: Axis.vertical,
              controller: _scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: widget.listaTours.length,
              itemBuilder: (context,i){
                return _tarjeta(context,widget.listaTours[i]);
              },
            ),
          ),
          _crearLoading()
        ]
      )
      );
  }

  Future fetchData()async{
    isloading = true;
    setState(() {
      
    });
    final duration = Duration(seconds: 2);
    return Timer(duration,cargar);
  }

  void cargar()async{
    // _scrollController.animateTo(
    //   _scrollController.position.pixels + 100,
    //   curve: Curves.fastOutSlowIn,
    //   duration: Duration(milliseconds: 250)
    // );
    
    //ListaToursC result;
    
      // _appState.userLocation().then((value)async{
      //   state = value[1].toString();
      //   codCountry = value[5].toString();
      //   await provider.getTours(state,codCountry).then((result){
      //     setState(() {
      //       isloading = false;
      //     });
      //     final resp = ListaToursC.fromJsonList(result['tours'][0]['data_tour']);
      //     for(int i = 0; i < resp.itemsTours.length; i++){
      //       widget.listaTours.add(resp.itemsTours[i]);
      //     }
      //   });
        
      // });

      // _appState.ubicacion().then((value)async{
      //   print("Datos del usuario:");
      //   print(value[1]);
      //   print(value[3]);
      //   await provider.getTours(value[1],value[3]).then((result){
      //     setState(() {
      //       isloading = false;
      //     });
      //     final resp = ListaToursC.fromJsonList(result['tours'][0]['data_tour']);
      //     for(int i = 0; i < resp.itemsTours.length; i++){
      //       widget.listaTours.add(resp.itemsTours[i]);
      //     }
      //   });
      // });


      print("Datos del usuario:");
      print(prefs.estadoUser);
      print(prefs.countryCode);
     final result = await provider.getTours(prefs.estadoUser.toString(),prefs.countryCode.toString());
      setState(() {
        isloading = false;
      });
      if(result['tours'][0]['data_tour'] != null){
        final resp = ListaToursC.fromJsonList(result['tours'][0]['data_tour']);
        for(int i = 0; i < resp.itemsTours.length; i++){
          widget.listaTours.add(resp.itemsTours[i]);
        }
      }else if(result['tours'][0]['total'] == "empty"){
        print("No hay datos");
        _scrollController.position.didEndScroll();
      }
      

      //_scrollController.position.didEndScroll();
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

  Widget _tarjeta(BuildContext context,InfoTour tour){
    var size = MediaQuery.of(context).size;
    //CategoriasProvider categoriasProvider = CategoriasProvider();
    String valoracion = AppTranslations.of(context).text('title_puntuacion');
    String personas = AppTranslations.of(context).text('title_cant_personas');
    String noGallery = 'https://selftour-public.s3.amazonaws.com/no_gallery.jpg';
    //final BaseCacheManager baseCacheManager = DefaultCacheManager();

    final tarjeta = Stack(
      children: <Widget>[
        Card(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Stack(
                    children:[ 
                      /*Image.network(
                        "${tour.gallery.toString()}",
                        fit: BoxFit.cover,
                        width: size.width * 0.96,
                        height: size.height * 0.3,
                        scale: 1.0,
                      )*/

                      CachedNetworkImage(
                        imageUrl: tour.gallery == null ? noGallery : "${tour.gallery.toString()}",
                        //errorWidget: (context, url, error)=>Icon(Icons.error),
                        //cacheManager: baseCacheManager,
                        useOldImageOnUrlChange: true,
                        width: size.width * 0.96,
                        height: size.height * 0.3,
                        fit: BoxFit.fill,
                      )

                      /*Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon( tour.favorite == 1 ? Icons.favorite : Icons.favorite_border),
                          color: tour.favorite == 1 ? Colors.red : null,
                          onPressed: ()async{
                            setState(() {
                              tour.favorite = tour.favorite;
                            });
                            if(tour.favorite == 1){
                              setState(() {
                                tour.favorite = null;
                              });
                             provider.removerFavorito(prefs.iduser,tour.idtour.toString());
                            }else{
                              setState(() {
                                tour.favorite = 1;
                              });
                             provider.marcarFavorito(tour.idtour.toString());
                            }
                          },
                        ),
                      )*/
                    ]
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Container(
                    width: size.width * 0.96,
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
            ),
            ],
          ),
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
                        fontFamily: 'Point-SemiBold',
                        //fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
               /* SizedBox(
                  width: size.width * 0.6,
                ),*/

              ],
            ),
          ),
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
                  tour.title == null ? '':tour.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Point-SemiBold',
                    //fontWeight: FontWeight.bold
                ),),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Text(
                      tour.score.toString(),
                      style: TextStyle(
                        fontFamily: 'Point-SemiBold',
                        color: Colors.white
                      ),
                    ),
                    Text(
                      ' $valoracion',
                      style: TextStyle(
                        fontFamily: 'Point-SemiBold',
                        color: Colors.white
                      ),
                    ),
                    tour.total_comment > 0 ?
                    Container(
                      width: size.width * 0.35,
                      child: Text(
                        ' (${tour.total_comment.toString()} $personas)',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Point-SemiBold',
                          color: Colors.white
                        ),
                      ),
                    ):Container()
                  ],
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          heightFactor: 11.9,
          child: Padding(
            padding: EdgeInsets.only(right: size.width * 0.05),
            child: Text(
              "\$ ${tour.price == null ? 0 : tour.price.toString()}",
              style: TextStyle(
                fontFamily: 'Point-SemiBold',
                color: Colors.white
              ),
            ),
          ),
        )
      ],
    );
    
    
    return GestureDetector(
      child: tarjeta,
      onTap: (){
        print(tour.idtour.toString());
        Navigator.pushNamed(context, '/detalletour',arguments: tour);
      },
    );
  }
}