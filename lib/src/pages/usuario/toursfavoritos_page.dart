import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:selftourapp/src/models/tour_categoria_model.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:selftourapp/src/providers/categorias_providers.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';

class ToursFavoritosPage extends StatefulWidget {
  @override
  _ToursFavoritosPageState createState() => _ToursFavoritosPageState();
}

class _ToursFavoritosPageState extends State<ToursFavoritosPage> {
  Set<InfoTour> listaGuardado = Set<InfoTour>();
  PreferenciasUsuario prefs = PreferenciasUsuario();
  CategoriasProvider categoriasProvider = CategoriasProvider();
  List<InfoTour> listaFavoritos = List();

  @override
  Widget build(BuildContext context) {
    String favoritos = AppTranslations.of(context).text('title_favourites');
    String noData = AppTranslations.of(context).text('title_nodata');
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          '${favoritos.toUpperCase()}',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Point-ExtraBold',
            fontWeight: FontWeight.bold
          ),
        ),
       /* actions: <Widget>[
          FlatButton(
            child: Text('Crear Tour',
              style: TextStyle(
                fontFamily: 'Point',
                color: Colors.white
              ),
            ),
            onPressed: (){
              Navigator.pushNamed(context, 'creartour');
            },
          )
        ],*/
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: categoriasProvider.verFavoritos(),
         // initialData: InitialData,
          builder: (BuildContext context, AsyncSnapshot<List<InfoTour>> snapshot) {
            String errorDatos = AppTranslations.of(context).text('title_errorDatos');
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
                if(snapshot.hasData && snapshot.data.length > 0){
                  final listatour = snapshot.data;
                  return Favoritos(listaFavoritos: listatour,);
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
                        child: Text('$noData')
                      ),
                    ],
                  );
                }
              break;
              case ConnectionState.active:
                if(snapshot.hasData){
                  final listatour = snapshot.data;
                  return Favoritos(listaFavoritos: listatour,);
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
                        child: Text('$noData')
                      ),
                    ],
                  );
                }
              break;
              default:
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
          },
        ),
        ),
    );
  }

  /*Widget _toursFavoritos(BuildContext context, InfoTour tour){
    final size = MediaQuery.of(context).size;
    
    
    GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, 'detalletour',arguments: tour);
      },
          child: Card(
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: FadeInImage(
                    image: NetworkImage(tour.picture[0]['url'].toString()),
                    placeholder: AssetImage('assets/loading.gif'),
                    width: size.width * 0.3,
                    height: size.height * 0.1,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.02,
                ),
                Text(tour.title,style: TextStyle(fontFamily: 'Point-SemiBold'),)
              ],
            ),
          ),
    );
  }*/
  /*Widget _tourFavorito(){
    final size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, 'detalletour');
        },
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image(
                        width: size.width * 0.4,
                        height: size.height * 0.2,
                        image: AssetImage('assets/images/beach.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: size.width * 0.03,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Título Tour',
                          style: TextStyle(
                            fontFamily: 'Point',
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text('Mérida, Yucatán')
                      ],
                    )
                  ],
                ),
              ),
            ),
            /*SizedBox(
              height: size.height * 0.01,
            )*/
          ],
        ),
    );
  }*/
}


class Favoritos extends StatefulWidget {
 final List<InfoTour> listaFavoritos;
  Favoritos({@required this.listaFavoritos});
  @override
  _FavoritosState createState() => _FavoritosState();
}

class _FavoritosState extends State<Favoritos> {
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.8,
      child: ListView.builder(
        itemCount: widget.listaFavoritos.length,
        itemBuilder: (context,index){
          return _toursFavoritos(context, widget.listaFavoritos[index]);
        },
      ),
    );
  }

  Widget _toursFavoritos(BuildContext context, InfoTour tour){
    final size = MediaQuery.of(context).size;
    
    
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, 'detalletour',arguments: tour);
      },
          child: Stack(
            children:[ 
              Card(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.0),
                child: Container(
                  width: size.width * 1.0,
                  height: size.height * 0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Stack(
                        children:[ 
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: 
                            /*Image.network(
                              tour.picture[0]['url'].toString(),
                              width: size.width * 0.35,
                              height: size.height * 0.15,
                              fit: BoxFit.fill,
                              scale: 1.0,
                            )*/
                            CachedNetworkImage(
                              imageUrl: "${tour.picture[0]['url'].toString()}",
                              //errorWidget: (context, url, error)=>Icon(Icons.error),
                              //cacheManager: baseCacheManager,
                              useOldImageOnUrlChange: true,
                              width: size.width * 0.35,
                              height: size.height * 0.15,
                              fit: BoxFit.fill,
                            )
                          ),
                         
                        ]
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
              ),
            ),
           /* Align(
              widthFactor: 7.7,
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(tour.favorite == 1 ? Icons.favorite:Icons.favorite_border),
                color: tour.favorite == 1 ? Colors.red:null,
                onPressed: (){
                  CategoriasProvider provider = CategoriasProvider();
                  PreferenciasUsuario prefs = PreferenciasUsuario();
                  if(tour.favorite == 1){
                    provider.removerFavorito(prefs.iduser,tour.idtour.toString());
                  }else{
                    provider.marcarFavorito(tour.idtour.toString());
                }
              },
            ),
          )*/
        ]
      ),
    );
  }
}