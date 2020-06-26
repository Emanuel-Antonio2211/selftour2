//import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:selftourapp/src/googlemaps/states/app_state.dart';
//import 'package:material_design_icons_flutter/icon_map.dart';
import 'package:selftourapp/src/models/tour_categoria_model.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:selftourapp/src/providers/categorias_providers.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';
import 'package:selftourapp/src/widgets/populares_vertical.dart';

class ToursPopularesPage extends StatefulWidget {
  @override
  _ToursPopularesState createState() => _ToursPopularesState();
}

class _ToursPopularesState extends State<ToursPopularesPage> {
  CategoriasProvider categoriasProvider = CategoriasProvider();
  PreferenciasUsuario prefs = PreferenciasUsuario();
  AppState _appState = AppState();
  String state;
  String codCountry;
  int currentIndex = 0;

  @override
  void initState() { 
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    _appState.userLocation().then((value){
      state = value[1].toString();
      codCountry = value[5].toString();
      categoriasProvider.popularesPag(state,codCountry);
    });
    
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Container(
          padding: EdgeInsets.only(left: 109.0),
          height: 40.0,
          child: Image.asset(
            'assets/iconoapp/selftouricon.png',
          ),
        ),
        centerTitle: false,
        elevation: 0.0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            title: Container(),
            icon: Icon(
              Icons.list,
              color: currentIndex == 0 ? Colors.red:Colors.grey,
            )
          ),
          BottomNavigationBarItem(
            title: Container(),
            icon: Icon(
              Icons.grid_on,
              color: currentIndex == 1 ? Colors.red : Colors.grey,
            )
          )
        ],
      ),
      body: llamarPaginas(currentIndex)
      
      
     /* SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder(
              stream: categoriasProvider.popularStream,
              //initialData: InitialData,
              builder: (BuildContext context, AsyncSnapshot<List<InfoTour>> snapshot) {
                if(snapshot.hasData){
                  return Container(
                    height: size.height * 0.88,
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context,index){
                        return populares(context, snapshot.data[index]);
                      },
                    ),
                  );
                }else{
                  return Align(
                    heightFactor: 34.0,
                    alignment: Alignment.center,
                    child: Text('No hay datos'),
                  );
                }
                
              },
            ),
          ],
        ),
      ),*/
    );
  }

  Widget llamarPaginas(int paginaActual){
    switch(paginaActual){
      case 0 : return lista();
      case 1 : return grid();
      default:
        return lista();
    }
  }

  Widget lista(){
    //final size = MediaQuery.of(context).size;
    String noData = AppTranslations.of(context).text('title_nodata');
    Future<List<InfoTour>> cargarTour()async{
      //ListaToursC listaToursC;
      ListaToursC result;
      _appState.userLocation().then((value)async{
        state = value[1].toString();
        codCountry = value[5].toString();
        final resultado = await categoriasProvider.popularesPag(state,codCountry);
        result = ListaToursC.fromJsonList(resultado['tours'][0]['data_tour']);
      });
      
      // listaToursC = new ListaToursC.fromJsonList(result['Tours']['data']);
      return result.itemsTours;
    }
    return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder(
              stream: categoriasProvider.popularStream,
              //initialData: InitialData,
              builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot) {
                final size = MediaQuery.of(context).size;
                
                switch(snapshot.connectionState){
                  case ConnectionState.waiting:
                    return SafeArea(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: size.height * 0.4,
                          ),
                          Center(child: CircularProgressIndicator())
                        ],
                      )
                    );
                  break;
                  case ConnectionState.none:
                    return SafeArea(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: size.height * 0.4,
                          ),
                          Center(
                            child: Text('$noData'),
                          )
                        ],
                      )
                    );
                  break;
                  case ConnectionState.done:
                    if(snapshot.hasData){
                      if(snapshot.data['tours'][0]['data_tour'] == null){
                        return Column(
                          children: <Widget>[
                            SizedBox(
                              height: size.height * 0.34,
                            ),
                            Center(
                              child: Text(
                                "$noData",
                                style: TextStyle(
                                  fontFamily: 'Point-SemiBold'
                                ),
                              ),
                            )
                          ],
                        );
                      }else{
                        final populares = ListaToursC.fromJsonList(snapshot.data['tours'][0]['data_tour']);
                        return PopularVertical(listaPopulares: populares.itemsTours, siguientePagina: cargarTour);
                      }
                      
                      /*Container(
                        height: size.height * 0.8,
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context,index){
                            return populares(context, snapshot.data[index]);
                          },
                        ),
                      );*/
                    }else{
                      return SafeArea(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: size.height * 0.4,
                            ),
                            Center(
                              child: CircularProgressIndicator(),
                            )
                          ],
                        )
                      );
                    }
                  break;
                  case ConnectionState.active:
                    if(snapshot.hasData){
                      if(snapshot.data['tours'][0]['data_tour'] == null){
                        return Column(
                          children: <Widget>[
                            SizedBox(
                              height: size.height * 0.34,
                            ),
                            Center(
                              child: Text(
                                "$noData",
                                style: TextStyle(
                                  fontFamily: 'Point-SemiBold'
                                ),
                              ),
                            )
                          ],
                        );
                      }else{
                        final populares = ListaToursC.fromJsonList(snapshot.data['tours'][0]['data_tour']);
                        return PopularVertical(listaPopulares: populares.itemsTours, siguientePagina: cargarTour);
                      }
                      
                      /*Container(
                        height: size.height * 0.8,
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context,index){
                            return populares(context, snapshot.data[index]);
                          },
                        ),
                      );*/
                    }else{
                      return SafeArea(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: size.height * 0.4,
                            ),
                            Center(
                              child: CircularProgressIndicator(),
                            )
                          ],
                        )
                      );
                    }
                  break;
                  default:
                    return SafeArea(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: size.height * 0.4,
                          ),
                          Center(
                            child: CircularProgressIndicator()
                          )
                        ],
                      )
                    );
                }
                /*if(snapshot.hasData){
                  return PopularVertical(listaPopulares: snapshot.data, siguientePagina: categoriasProvider.popularesPag);
                  /*Container(
                    height: size.height * 0.8,
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context,index){
                        return populares(context, snapshot.data[index]);
                      },
                    ),
                  );*/
                }else{
                  return Align(
                    heightFactor: 34.0,
                    alignment: Alignment.center,
                    child: Text('$noData'),
                  );
                }*/
                
              },
            ),
          ],
        ),
      );
  }

  Widget grid(){
    //final size = MediaQuery.of(context).size;
    String noData = AppTranslations.of(context).text('title_nodata');

    Future<List<InfoTour>> cargarTour()async{
      //ListaToursC listaToursC;
      ListaToursC result;
      _appState.userLocation().then((value)async{
        state = value[1].toString();
        codCountry = value[5].toString();
       final resultado = await categoriasProvider.popularesPag(state,codCountry);
       result = ListaToursC.fromJsonList(resultado['tours'][0]['data_tour']);
      });
      
      // listaToursC = new ListaToursC.fromJsonList(result['Tours']['data']);
      return result.itemsTours;
    }
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          StreamBuilder(
            stream: categoriasProvider.popularStream,
            builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot){
              final size = MediaQuery.of(context).size;
              switch(snapshot.connectionState){
                case ConnectionState.waiting:
                  return SafeArea(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: size.height * 0.4
                        ),
                        Center(
                          child: CircularProgressIndicator(),
                        )
                      ],
                    )
                  );
                break;
                case ConnectionState.none:
                  return SafeArea(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: size.height * 0.4,
                        ),
                        Center(
                          child:Text(
                            '$noData',
                            style: TextStyle(
                              fontFamily: 'Point-SemiBold'
                            ),
                          )
                        )
                      ],
                    )
                  );
                break;
                case ConnectionState.done:
                  if(snapshot.hasData){
                    if(snapshot.data['tours'][0]['data_tour'] == null){
                      return Column(
                        children: <Widget>[
                          SizedBox(
                            height: size.height * 0.34,
                          ),
                          Center(
                            child: Text(
                              "$noData",
                              style: TextStyle(
                                fontFamily: 'Point-SemiBold'
                              ),
                            ),
                          )
                        ],
                      );
                    }else{
                      final populares = ListaToursC.fromJsonList(snapshot.data['tours'][0]['data_tour']);
                      return PopularGrid(listaPopulares: populares.itemsTours, siguientePagina: cargarTour);
                    }
                    
                    /*Container(
                      height: size.height * 0.8,
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context,index){
                          return populares(context, snapshot.data[index]);
                        },
                      ),
                    );*/
                  }else{
                    return SafeArea(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: size.height * 0.4,
                          ),
                          Center(
                            child: CircularProgressIndicator(),
                          )
                        ],
                      )
                    );
                  }
                break;
                case ConnectionState.active:
                  if(snapshot.hasData){
                    if(snapshot.data['tours'][0]['data_tour'] == null){
                      return Column(
                        children: <Widget>[
                          SizedBox(
                            height: size.height * 0.34,
                          ),
                          Center(
                            child: Text(
                              "$noData",
                              style: TextStyle(
                                fontFamily: 'Point-SemiBold'
                              ),
                            ),
                          )
                        ],
                      );
                    }else{
                      final populares = ListaToursC.fromJsonList(snapshot.data['tours'][0]['data_tour']);
                      return PopularGrid(listaPopulares: populares.itemsTours, siguientePagina: cargarTour);
                    }
                    
                    /*Container(
                      height: size.height * 0.8,
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context,index){
                          return populares(context, snapshot.data[index]);
                        },
                      ),
                    );*/
                  }else{
                    return SafeArea(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: size.height * 0.4,
                          ),
                          Center(
                            child: CircularProgressIndicator(),
                          )
                        ],
                      )
                    );
                  }
                break;
                default:
                  return SafeArea(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: size.height * 0.4,
                        ),
                        Center(
                          child: CircularProgressIndicator(),
                        )
                      ],
                    )
                  );
              }
              
              /*Container(
                height: size.height * 0.8,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context,i){
                    return popularGrid(context, snapshot.data[i]);
                  },
                ),
              );*/
            },
          ),
        ],
      ),
    );
  }

  /*Widget populares(BuildContext context, InfoTour tour){
    final size = MediaQuery.of(context).size;
    //PreferenciasUsuario prefs = PreferenciasUsuario();
    String valoracion = AppTranslations.of(context).text('title_puntuacion');

    final popular = Stack(
      children: <Widget>[
        Card(
          child: ClipRRect(
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
                        tour.country == null ? '' : tour.country,
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
                  tour.title == null ? '' : tour.title,
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
                )
              ],
            ),
          ),
        )
      ],
    );
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, 'detalletour',arguments: tour);
      },
      child: popular
    );
  }*/

  /*Widget popularGrid(BuildContext context,InfoTour tour){
    final size = MediaQuery.of(context).size;
    String valoracion = AppTranslations.of(context).text('title_puntuacion');
    final popularTour = Card(
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
              padding: EdgeInsets.only(top: 76.0,left: 10.0),
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
      child: popularTour,
      onTap: (){
        Navigator.pushNamed(context, 'detalletour',arguments: tour);
      },
    );
  }*/
}