import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
//import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:selftourapp/src/models/tour_categoria_model.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:selftourapp/src/providers/categorias_providers.dart';
import 'package:translator/translator.dart';

class ToursRecientes extends StatefulWidget {
  final List<InfoTour> listaRecientes;

  ToursRecientes({@required this.listaRecientes});
  @override
  _ToursRecientesState createState() => _ToursRecientesState();
}

class _ToursRecientesState extends State<ToursRecientes> {
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
      height: size.height * 0.32,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: 4,//widget.listaRecientes.length
        itemBuilder: (context,i){
          return recientes(context, widget.listaRecientes[i]);
        },
      ),
    );
  }

  Widget recientes (BuildContext context,InfoTour tourReciente){
    final size = MediaQuery.of(context).size;
    //CategoriasProvider categoriasProvider = CategoriasProvider();
    PreferenciasUsuario prefs = PreferenciasUsuario();
    final BaseCacheManager baseCacheManager = DefaultCacheManager();

    final tarjeta = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: 
                /*Image.network(
                  "${tourReciente.gallery}",
                  scale: 1.0,
                  fit: BoxFit.fill,
                  width: size.width * 0.8,
                  height: size.height * 0.24,
                )*/

                CachedNetworkImage(
                  imageUrl: "${tourReciente.gallery}",
                  //errorWidget: (context, url, error)=>Icon(Icons.error),
                  //cacheManager: baseCacheManager,
                  useOldImageOnUrlChange: true,
                  width: size.width * 0.8,
                  height: size.height * 0.24,
                  fit: BoxFit.fill,
                )
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    tourReciente.title == null ? '':tourReciente.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontFamily: 'Point-SemiBold'),
                  ),
                  Text(
                    tourReciente.country == null ? '':tourReciente.country,//
                    style: TextStyle(fontFamily: 'Point-SemiBold'),
                  ),
                  /*FutureBuilder(
                    future: translator.translate(tourReciente.country,to: prefs.idioma == null ? 'es':prefs.idioma.toString()),
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
            ),
          ],
        ),
    );

    return GestureDetector(
      child: tarjeta,
      onTap: (){
        Navigator.pushNamed(context, 'detalletour',arguments: tourReciente);
      },
    );
  }
}