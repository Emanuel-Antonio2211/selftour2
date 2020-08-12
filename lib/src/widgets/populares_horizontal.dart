import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_cache_manager/flutter_cache_manager.dart';
//import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:selftourapp/src/models/tour_categoria_model.dart';
//import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';
//import 'package:selftourapp/src/providers/categorias_providers.dart';
import 'package:translator/translator.dart';

class ToursPopulares extends StatefulWidget {
  final List<InfoTour> listaPopulares;
  
  ToursPopulares({@required this.listaPopulares});

  @override
  _ToursPopularesState createState() => _ToursPopularesState();
}

class _ToursPopularesState extends State<ToursPopulares> {
  final translator = new GoogleTranslator();
  final _pageController = new PageController(
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
      height: size.height * 0.33,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: 6,//widget.listaPopulares.length
        itemBuilder: (context,i){
          return tourPopulares(context, widget.listaPopulares[i]);
        },
        //children: _imagenesCategoria(context),
      ),
    );
  }

  Widget tourPopulares(BuildContext context,InfoTour tourPopular){
    final size = MediaQuery.of(context).size;
    String noGallery = 'https://selftour-public.s3.amazonaws.com/no_gallery.jpg';
    //CategoriasProvider categoriasProvider = CategoriasProvider();
    //PreferenciasUsuario prefs = PreferenciasUsuario();
    //final BaseCacheManager baseCacheManager = DefaultCacheManager();

    final tarjeta = Container(
        //color:Colors.grey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child:
                  /*Image.network(
                    "${tourPopular.gallery}",
                    scale: 1.0,
                    fit: BoxFit.fill,
                    width: size.width * 0.8,
                    height: size.height * 0.23,
                  )*/
                  CachedNetworkImage(
                    imageUrl: tourPopular.gallery == null ? noGallery : "${tourPopular.gallery}",
                    //errorWidget: (context, url, error)=>Icon(Icons.error),
                    //cacheManager: baseCacheManager,
                    useOldImageOnUrlChange: true,
                    width: size.width * 0.8,
                    height: size.height * 0.23,
                    fit: BoxFit.fill,
                  )
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 3.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      tourPopular.title==null ? '':tourPopular.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Point-SemiBold',
                        color: Colors.black
                      ),
                    ),
                    Text(
                      tourPopular.country==null ? '':tourPopular.country,//
                      style: TextStyle(fontFamily: 'Point-SemiBold'),
                    )
                    /*FutureBuilder(
                      future: translator.translate(tourPopular.country,to: prefs.idioma == null ? 'es':prefs.idioma.toString()),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if(snapshot.hasData){
                          return Text(
                            snapshot.data.toString(),//
                            style: TextStyle(fontFamily: 'Point-SemiBold'),
                          );
                        }else{
                          return Container();
                        }
                        
                      },
                    ),*/
                    
                  ],
                ),
              )
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
      );
    return GestureDetector(
      child: tarjeta,
      onTap: (){
        print('id de la categoria: ${tourPopular.idtour}');
        Navigator.pushNamed(context, '/detalletour',arguments: tourPopular);
      },
    );
  }
}