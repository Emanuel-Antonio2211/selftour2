import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:flutter_cache_manager/flutter_cache_manager.dart';
//import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:selftourapp/src/models/tour_categoria_model.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:selftourapp/src/providers/categorias_providers.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';

class ToursGeneral extends StatefulWidget {
  //final categoriasProvider = new CategoriasProvider();
  final List<InfoTour> listaTours;
  final Function siguientePagina;

  ToursGeneral({@required this.listaTours,@required this.siguientePagina});

  @override
  _ToursGeneralState createState() => _ToursGeneralState();
}

class _ToursGeneralState extends State<ToursGeneral> {
  PreferenciasUsuario prefs = PreferenciasUsuario();
  CategoriasProvider provider = CategoriasProvider();
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

  _scrollController.addListener((){
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 10){
        _scrollController.position.didEndScroll();
        //print('Cargar siguientes categorías');
        //Se ejecuta la función para mostrar la siguiente página
        //de categorías
        widget.siguientePagina();
      }
    });

    return Container(
       height: size.height * 0.8,
      child:ListView.builder(
        scrollDirection: Axis.vertical,
        controller: _scrollController,
        itemCount: widget.listaTours.length,
        itemBuilder: (context,i){
          return _tarjeta(context,widget.listaTours[i]);
        },
      )
      );
  }

  Widget _tarjeta(BuildContext context,InfoTour tour){
    var size = MediaQuery.of(context).size;
    //CategoriasProvider categoriasProvider = CategoriasProvider();
    String valoracion = AppTranslations.of(context).text('title_puntuacion');
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
                        imageUrl: "${tour.gallery.toString()}",
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
        Align(
          alignment: Alignment.bottomRight,
          heightFactor: 11.7,
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