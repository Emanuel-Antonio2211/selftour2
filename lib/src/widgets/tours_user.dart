import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:selftourapp/src/models/tour_categoria_model.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:selftourapp/src/providers/categorias_providers.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';

class ToursUser extends StatefulWidget {
  final List<InfoTour> toursUser;

  ToursUser({@required this.toursUser});
  @override
  _ToursUserState createState() => _ToursUserState();
}

class _ToursUserState extends State<ToursUser> {
  final CategoriasProvider provider = CategoriasProvider();
  final PreferenciasUsuario prefs = PreferenciasUsuario();
  final _pageController = ScrollController();
  bool isloading = false;

  Future<Null> cargarTours()async{
    final duration = Duration(seconds: 2);
    Timer(duration,()async{
      widget.toursUser.clear();
      await provider.toursUser(prefs.token).then((resp){

        final listaToursC = new ListaToursC.fromJsonList(resp['resp']['tours']);
        for(int i = 0; i < listaToursC.itemsTours.length; i++){
          widget.toursUser.add(listaToursC.itemsTours[i]);
        }
      });
    });

    return Future.delayed(duration);
  }
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _pageController.addListener(() { 
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 10){
        fetchData();
      }
    });
    return Container(
      height: size.height * 0.9,
      child: Stack(
        children: <Widget>[
          RefreshIndicator(
            onRefresh: cargarTours,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              controller: _pageController,
              itemCount: widget.toursUser.length,
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context,i){
                return tarjetaTour(widget.toursUser[i],widget.toursUser[i].idt);
              }
            ), 
          ),
          _crearLoading()
        ],
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
  void cargar()async{
    setState(() {
      
    });
    _pageController.animateTo(
      _pageController.position.pixels + 100,
      curve: Curves.fastOutSlowIn, 
      duration: Duration(milliseconds: 250)
    );
    await provider.toursUser(prefs.token).then((resp){
      setState(() {
        isloading = false;
      });
      final listaToursC = new ListaToursC.fromJsonList(resp['resp']['tours']);
      for(int i = 0; i < listaToursC.itemsTours.length; i++){
        widget.toursUser.add(listaToursC.itemsTours[i]);
      }
    });
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

  Widget tarjetaTour(InfoTour tour,int idtour){
    final size = MediaQuery.of(context).size;
    String created = AppTranslations.of(context).text('title_created');
    Map<String,dynamic> info={
      "idtour": idtour
    };
    final infotour = InfoTour.fromJsonMap(info);
    final fechaCreacion = DateTime.parse(tour.creation_date.toString());
    String dia = fechaCreacion.day.toString();
    String mes = fechaCreacion.month.toString();
    String anio = fechaCreacion.year.toString();

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
                              width: size.width * 0.4,
                              child: Text(
                                  tour.title.toString(),
                                  style: TextStyle(
                                    fontFamily: 'Point-SemiBold',
                                    fontWeight: FontWeight.bold,
                                    //fontSize: 15.0
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                            ),
                            Container(
                              width: size.width * 0.4,
                              child: Text(
                                "$created $dia/$mes/$anio",
                                style: TextStyle(
                                  fontFamily: 'Point-SemiBold',
                                  fontSize: 10.0
                                ),
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
                            '\$ ${double.parse(tour.price.toString()).toString()}',
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
                imageUrl: tour.gallery == null ?
                "https://selftour-public.s3.amazonaws.com/no_gallery.jpg":
                 "${tour.gallery}",
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