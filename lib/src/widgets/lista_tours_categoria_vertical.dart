
import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:selfttour/src/googlemaps/states/app_state.dart';
//import 'package:selfttour/src/models/mapa_model.dart';
import 'package:selftourapp/src/models/tour_categoria_model.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:selftourapp/src/providers/categorias_providers.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';

class ListaToursCategoriaVertical extends StatefulWidget {
  final List<InfoTour> listaTours;
  final Function siguientePagina;

  final CategoriasProvider provider = CategoriasProvider();

  final PreferenciasUsuario prefs = PreferenciasUsuario();

  ListaToursCategoriaVertical({ @required this.listaTours,@required this.siguientePagina});

  @override
  _ListaToursCategoriaVerticalState createState() => _ListaToursCategoriaVerticalState();
  final _pageController = ScrollController(
    //initialPage: 0,
    //viewportFraction: 0.3
  );
}

class _ListaToursCategoriaVerticalState extends State<ListaToursCategoriaVertical> {
  

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    widget._pageController.addListener((){
      if(widget._pageController.position.pixels >= widget._pageController.position.maxScrollExtent - 10){
        //print('Cargar siguientes tours');
       // widget._pageController.position.didEndScroll();
        widget.siguientePagina();
      }
    });
    return Container(
      //color: Colors.grey,
      height: size.height * 0.8,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        //pageSnapping: false,
        controller: widget._pageController,
        //children: _tarjetas(context)
        itemCount: widget.listaTours.length,
        itemBuilder: (context,i){
          return _tarjeta(context, widget.listaTours[i]);
        },
      )
    );
  }

  Widget _tarjeta(BuildContext context, InfoTour tour){
    final size = MediaQuery.of(context).size;
    //CategoriasProvider categoriasProvider = CategoriasProvider();
    
    //String pais = AppTranslations.of(context).text('title_country');
    String valoracion = AppTranslations.of(context).text('title_puntuacion');

    final tarjeta = Stack(
      children: <Widget>[
        Container(
          child: Card(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: 
                  /*Image.network(
                    tour.foto.toString(),
                    fit: BoxFit.fill,
                    width: size.width * 0.96,
                    height: size.height * 0.3,
                    scale: 1.0,
                  )*/
                  CachedNetworkImage(
                    imageUrl: "${tour.foto.toString()}",
                    //errorWidget: (context, url, error)=>Icon(Icons.error),
                    //cacheManager: baseCacheManager,
                    useOldImageOnUrlChange: true,
                    width: size.width * 0.96,
                    height: size.height * 0.3,
                    fit: BoxFit.fill,
                  )
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
              ]
            ),
            
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
                      tour.country==null ? '' : tour.country,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Point-ExtraBold',
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    /*FutureBuilder(
                      future: categoriasProvider.traducir("${prefs.idioma.toString()}" == null ? 'es' : "${prefs.idioma.toString()}", tour.country),
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
               /* SizedBox(
                  width: size.width * 0.6,
                ),*/
                /*IconButton(
                  color: tour.favorite == 1 ? Colors.red : Colors.white,
                  icon: Icon( tour.favorite == 1 ? Icons.favorite : Icons.favorite_border),
                  onPressed: (){
                    CategoriasProvider provider = CategoriasProvider();
                    PreferenciasUsuario prefs = PreferenciasUsuario();
                    if(tour.favorite == 1){
                      
                      provider.removerFavorito(prefs.iduser,tour.idtour.toString());
                    }else{
                      provider.marcarFavorito(tour.idtour.toString());
                    }
                    
                  },
                )*/
              ],
            ),
          ),
        ),
                  
        Align(
         alignment: Alignment.bottomLeft,
         heightFactor: 5.0,
          child: Padding(
            padding: EdgeInsets.only(left: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          tour.title==null ? '' : tour.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontFamily: 'Point-ExtraBold',
                        ),),
                      ),
                     
                      
                    ],
                  ),
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
                        ' $valoracion',
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
                  )
                ],
              ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Align(
            alignment: Alignment.bottomRight,
            heightFactor: 11.7,
            child: Padding(
              padding: EdgeInsets.only(right: size.width * 0.05),
              child: Text(
                "\$ ${tour.price == null ? 0 : tour.price}",
                style: TextStyle(
                  fontFamily: 'Point-SemiBold',
                  color: Colors.white
                ),
              ),
            ),
          ),
        )
      ],
    );
    
    
    return GestureDetector(
      child: tarjeta,
      onTap: (){
        print('Tour con el id: ${tour.idtour.toString()}');
        Navigator.pushNamed(context, 'detalletour',arguments: tour);//,arguments: tour.idtour.toInt()
      },
    );
  }

  /*List<Widget> _tarjetas(BuildContext context){
    final size = MediaQuery.of(context).size;
    return widget.listaTours.map((tour){
      return Container(
        child: Card(
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: FadeInImage(
                  image: NetworkImage(tour.getImageToursCategoria()),
                  placeholder: AssetImage('assets/no-image.jpg'),
                  fit: BoxFit.cover,
                  width: size.width * 0.96,
                  height: size.height * 0.2,
                ),
              ),
              Text(tour.title,style: TextStyle(
                          color: Colors.brown,
                          fontFamily: 'Point',
                          fontWeight: FontWeight.bold
                          ),)
            ],
          ),
          
        ),
      );
    }).toList();
  }*/

  /*Widget _imagenesListaToursCategoria(BuildContext context,InfoTour infoTour){
    final size = MediaQuery.of(context).size;

    final _informacionTour=Container(
      child: Card(
        child: Column(
          children: <Widget>[
           /*FadeInImage(
              image: NetworkImage(infoTour.cover),
              placeholder: AssetImage('assets/no-image.jpg'),
              fit: BoxFit.cover,
              width: size.width * 0.5,
              height: size.height * 0.22,
            ),*/
            //Text(infoTour.title)
          ],
        ),
      ),
    );

    return GestureDetector(
      child: _informacionTour,
      onTap: (){
        Navigator.pushNamed(context, 'tours');
      },
    );
  }*/
}

class ListaToursCategoriaGrid extends StatelessWidget {
  final List<InfoTour> listaTours;
  final CategoriasProvider categoriasProvider = CategoriasProvider();
  final PreferenciasUsuario prefs = PreferenciasUsuario();
  final Function siguientePagina;
  ListaToursCategoriaGrid({@required this.listaTours,@required this.siguientePagina});
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
      //color: Colors.grey,
      height: size.height * 0.8,
      child: GridView.builder(
        controller: _scrollController,
        itemCount: listaTours.length,
        itemBuilder: (context,i){
          return _tarjeta(context, listaTours[i]);
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      )
      
      /*ListView.builder(
        scrollDirection: Axis.vertical,
        //pageSnapping: false,
        controller: _pageController,
        //children: _tarjetas(context)
        itemCount: listaTours.length,
        itemBuilder: (context,i){
          return _tarjeta(context, listaTours[i]);
        },
      )
    );*/
    );
  }

  Widget _tarjeta(BuildContext context, InfoTour tour){
    final size = MediaQuery.of(context).size;
    //String pais = AppTranslations.of(context).text('title_country');
    String valoracion = AppTranslations.of(context).text('title_puntuacion');
    final tarjeta = Stack(
      children: <Widget>[
        Container(
          child: Card(
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Stack(
                    children:[
                      /*Image.network(
                        tour.foto.toString(),
                        fit: BoxFit.fill,
                        width: size.width * 0.5,
                        height: size.height * 0.3,
                        scale: 1.0,
                      )*/
                      CachedNetworkImage(
                        imageUrl: "${tour.foto.toString()}",
                        //errorWidget: (context, url, error)=>Icon(Icons.error),
                        //cacheManager: baseCacheManager,
                        useOldImageOnUrlChange: true,
                        width: size.width * 0.5,
                        height: size.height * 0.3,
                        fit: BoxFit.fill,
                      )
                    /* Align(
                        widthFactor: 14.0,
                        alignment: Alignment.topRight,
                        child: IconButton(
                          color: tour.favorite == 1 ? Colors.red : null,
                          icon: Icon( tour.favorite == 1 ? Icons.favorite : Icons.favorite_border),
                          onPressed: (){
                            CategoriasProvider provider = CategoriasProvider();
                            PreferenciasUsuario prefs = PreferenciasUsuario();
                            if(tour.favorite == 1){
                              provider.removerFavorito(prefs.iduser);
                            }else{
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
                    width: size.width * 0.5,
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
        ),
        /*Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Text(tour.title,style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Point-ExtraBold',
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold
                            ),),
              ),
              Container(
                alignment: Alignment.center,
                child: Text('${tour.country}',style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Point-ExtraBold',
                      fontWeight: FontWeight.bold
                      ),),
              )
            ],
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
                       future: categoriasProvider.traducir("${prefs.idioma.toString()}" == null ? 'es': "${prefs.idioma.toString()}", tour.country),
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
            padding: EdgeInsets.only(top: 65.0,left: 10.0),
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
    );
    
    
    return GestureDetector(
      child: tarjeta,
      onTap: (){
        print('Tour con el id: ${tour.idtour.toString()}');
        Navigator.pushNamed(context, 'detalletour',arguments: tour);//,arguments: tour.idtour.toInt()
      },
    );
  }

}

class ListaToursCategoriaMapa extends StatefulWidget {
  final List<InfoTour> listaTours;
  final Function siguientePagina;
  ListaToursCategoriaMapa({ this.listaTours,this.siguientePagina});

  @override
  _ListaToursCategoriaMapaState createState() => _ListaToursCategoriaMapaState();

}

class _ListaToursCategoriaMapaState extends State<ListaToursCategoriaMapa> {
  final ScrollController scrollController = ScrollController();

  final Completer<GoogleMapController> _controller = Completer();

  final List<Marker> markers = <Marker>[];

  final List<LatLng> puntos= List();

  final Set<Marker> marker = Set();

  final _pageController = new PageController(
    initialPage: 0,
    //viewportFraction: 0.3
  );

  final categoriaProvider = CategoriasProvider();

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    _pageController.addListener((){
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 10){
        _pageController.position.didEndScroll();
        //print('Cargar siguientes categorías');
        //Se ejecuta la función para mostrar la siguiente página
        //de categorías
        widget.siguientePagina();
      }
    });
    for(int i = 0; i<widget.listaTours.length; i++){
      
      puntos.addAll(
        [
          LatLng(widget.listaTours[i].latlng[0]['Lat'], widget.listaTours[i].latlng[0]['Lng'])
        ]
      );
      marker.addAll([
        Marker(
          markerId: MarkerId('${widget.listaTours[i].title}'),
          position: puntos[i],
          infoWindow: InfoWindow(title: '${widget.listaTours[i].title}'),
          icon: BitmapDescriptor.defaultMarker
        )
      ]);
    }
//print(puntos);
    
    
      return 
         Scaffold(
          body: Stack(
            children: <Widget>[
              GoogleMap(
              initialCameraPosition: CameraPosition(
                target: puntos[0],//LatLng(20.9333,-89.0167) LatLng(17.640216, -57.535211)
                zoom: 12.0
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              mapType: MapType.normal,
              markers: marker,
              compassEnabled: true,
              mapToolbarEnabled: true,
              indoorViewEnabled: false,
              rotateGesturesEnabled: true,
              scrollGesturesEnabled: true,
              zoomGesturesEnabled: true,
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    //color: Colors.white,
                    width: size.width * 1.0,
                    height: size.height * 0.3,
                    child: ListView.builder(
                      //shrinkWrap: true,
                      itemCount: widget.listaTours.length,
                     controller: scrollController,
                     physics:  AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,i){
                        return tourCategoria(context, widget.listaTours[i]);
                      },
                  ),
                )

              ),

              Align(
                widthFactor: 5.9,
                alignment: Alignment.centerRight,
                child: FloatingActionButton(
                  child: Icon(Icons.location_on),
                  onPressed: (){
                    setState(() {
                      
                    });
                    centrar(puntos[0].latitude,puntos[0].longitude);
                  },
                ),
              )
            ],
          ),

          );
  }

 Widget tourCategoria(BuildContext context,InfoTour tour){
   final size = MediaQuery.of(context).size;
   String valoracionTotal = AppTranslations.of(context).text('title_puntuacion');
  
    final tours = Container(
      width: size.width * 0.6,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0),topRight: Radius.circular(5.0)),
                child: 
                /*Image.network(
                  tour.foto.toString(),
                  width: size.width * 0.6,
                  height: size.height * 0.2,
                  fit: BoxFit.fill,
                  scale: 1.0,
                )*/
                CachedNetworkImage(
                  imageUrl: "${tour.foto.toString()}",
                  //errorWidget: (context, url, error)=>Icon(Icons.error),
                  //cacheManager: baseCacheManager,
                  useOldImageOnUrlChange: true,
                  width: size.width * 0.6,
                  height: size.height * 0.2,
                  fit: BoxFit.fill,
                )
              ),
              Padding(
                  padding: EdgeInsets.only(left: 5.0,top: 5.0),
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          tour.title == null ? '' : tour.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Point-SemiBold'),),
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      color: Colors.yellow[300]
                    ),
                    Text(
                      tour.score == null ? '' : tour.score.toString(),
                      style: TextStyle(
                        fontFamily: 'Point-SemiBold'
                      ),
                    ),
                    Text(
                      '$valoracionTotal',
                      style: TextStyle(
                        fontFamily: 'Point-SemiBold'
                      ),
                    ),
                    Text(
                      ' (  )',
                      style: TextStyle(
                        fontFamily: 'Point-SemiBold'
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        )
      );

    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, 'detalletour',arguments: tour);
      },
      child: tours
      );
  }

  Future<void> acercar(double lat,double lng)async{
    final  controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, lng),
      zoom: 20.0
    )));
  }

  Future<void> centrar(double lat,double lng)async{
    final  controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, lng),
      zoom: 7.0
    )));
  }
}