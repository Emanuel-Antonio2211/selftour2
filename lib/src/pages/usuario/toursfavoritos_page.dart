import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selftourapp/src/googlemaps/states/app_state.dart';
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
  String state;
  String codCountry;
  AppState _appState = AppState();

  @override
  void initState() {
    super.initState();
    categoriasProvider.verFavoritos();
  }
  
  @override
  Widget build(BuildContext context) {
    String favoritos = AppTranslations.of(context).text('title_favourites');
    String noData = AppTranslations.of(context).text('title_nodata');
    final size = MediaQuery.of(context).size;
    // _appState.userLocation().then((value){
    //   state = value[1].toString();
    //   codCountry = value[5].toString();
      
    // });

    Future<List<InfoTour>> cargarTour()async{
      //ListaToursC listaToursC;
      List<InfoTour> result;
      _appState.userLocation().then((value)async{
        state = value[1].toString();
        codCountry = value[5].toString();
        result = await categoriasProvider.verFavoritos();
      });
      
      // listaToursC = new ListaToursC.fromJsonList(result['Tours']['data']);
      return result;
    }
    
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
        child: StreamBuilder(
          stream: categoriasProvider.tourFavoritoStream,
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
                  return Favoritos(listaFavoritos: listatour);
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
                if(snapshot.hasData && snapshot.data.length > 0){
                  final listatour = snapshot.data;
                  return Favoritos(listaFavoritos: listatour );
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
                      child: CircularProgressIndicator()
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
  CategoriasProvider provider = CategoriasProvider();
  final _scrollController = ScrollController();
  bool isloading = false;
  String state;
  String codCountry;
  AppState _appState = AppState();

  Future<Null> cargarTours()async{
    final duration = Duration(seconds: 2);

    Timer(duration, (){
      widget.listaFavoritos.clear();
      // _appState.userLocation().then((value){
      //   state = value[1].toString();
      //   codCountry = value[5].toString();
        
      // });
      provider.verFavoritos().then((result){
        for(int i = 0; i < result.length; i++){
          widget.listaFavoritos.add(result[i]);
        }
      });

    });
    print("Lista Cargada");
    print(widget.listaFavoritos);
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
              itemCount: widget.listaFavoritos.length,
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context,index){
                return _toursFavoritos(context, widget.listaFavoritos[index]);
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
  void cargar()async{
    setState(() {
      
    });
    _scrollController.animateTo(
      _scrollController.position.pixels + 100,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 250)
    );
    await _appState.userLocation().then((value)async{
        state = value[1].toString();
        codCountry = value[5].toString();
        await provider.verFavoritos().then((resp){
          setState(() {
            isloading = false;
          });
          for(int i = 0; i < resp.length; i++){
            widget.listaFavoritos.add(resp[i]);
          }
        });

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

  Widget _toursFavoritos(BuildContext context, InfoTour tour){
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/detalletour',arguments: tour);
      },
          child: Stack(
            children:<Widget>[ 
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
                                    tour.title,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: 'Point-SemiBold'
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ),
              Positioned(
                left: size.width * 0.01,
                top: size.height * 0.035,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    imageUrl: tour.picture == null ? 
                    'https://selftour-public.s3.amazonaws.com/no_gallery.jpg' : 
                    "${tour.picture.toString()}",
                    //errorWidget: (context, url, error)=>Icon(Icons.error),
                    //cacheManager: baseCacheManager,
                    useOldImageOnUrlChange: true,
                    width: size.width * 0.38,
                    height: size.height * 0.15,
                    fit: BoxFit.fill,
                  )
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