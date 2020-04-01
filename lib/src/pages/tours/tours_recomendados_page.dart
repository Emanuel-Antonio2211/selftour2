//import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:selftourapp/src/models/tour_categoria_model.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:selftourapp/src/providers/categorias_providers.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';
import 'package:selftourapp/src/widgets/recomendados_vertical.dart';

class ToursRecomendadosPage extends StatefulWidget {
  @override
  _ToursRecomendadosPageState createState() => _ToursRecomendadosPageState();
}

class _ToursRecomendadosPageState extends State<ToursRecomendadosPage> {
  CategoriasProvider categoriasProvider = CategoriasProvider();
  PreferenciasUsuario prefs = PreferenciasUsuario();
  int currentIndex = 0;

  @override
  void initState() {
    categoriasProvider.recomendadosPag();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;

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
        centerTitle: true,
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
    return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder(
              stream: categoriasProvider.recomendadoStream,
              //initialData: InitialData,
              builder: (BuildContext context, AsyncSnapshot<List<InfoTour>> snapshot) {
                switch(snapshot.connectionState){
                  case ConnectionState.waiting:
                    return Align(
                      heightFactor: 34.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    );
                  break;
                  case ConnectionState.none:
                    return Align(
                      heightFactor: 34.0,
                      alignment: Alignment.center,
                      child: Text('$noData'),
                    );
                  break;
                  case ConnectionState.done:
                    if(snapshot.hasData){
                      return RecomendadoVertical(listaRecomendados: snapshot.data, siguientePagina: categoriasProvider.recomendadosPag);
                    /* Container(
                        height: size.height * 0.8,
                        child: ListView.builder(
                          itemCount: snapshot.data.length,//snapshot.data.length
                          itemBuilder: (context,index){
                            return recomendados(context, snapshot.data[index]);
                          },
                        ),
                      );*/
                    }else{
                      return Align(
                        heightFactor: 34.0,
                        alignment: Alignment.center,
                        child: Text('$noData'),
                      );
                    }
                  break;
                  case ConnectionState.active:
                    if(snapshot.hasData){
                      return RecomendadoVertical(listaRecomendados: snapshot.data, siguientePagina: categoriasProvider.recomendadosPag);
                    /* Container(
                        height: size.height * 0.8,
                        child: ListView.builder(
                          itemCount: snapshot.data.length,//snapshot.data.length
                          itemBuilder: (context,index){
                            return recomendados(context, snapshot.data[index]);
                          },
                        ),
                      );*/
                    }else{
                      return Align(
                        heightFactor: 34.0,
                        alignment: Alignment.center,
                        child: Text('$noData'),
                      );
                    }
                  break;
                  default:
                    return Align(
                      heightFactor: 34.0,
                      alignment: Alignment.center,
                      child: Text('$noData'),
                    );
                }
                /*if(snapshot.hasData){
                  return RecomendadoVertical(listaRecomendados: snapshot.data, siguientePagina: categoriasProvider.recomendadosPag);
                 /* Container(
                    height: size.height * 0.8,
                    child: ListView.builder(
                      itemCount: snapshot.data.length,//snapshot.data.length
                      itemBuilder: (context,index){
                        return recomendados(context, snapshot.data[index]);
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

 /* Widget recomendados(BuildContext context, InfoTour tour){
    final size = MediaQuery.of(context).size;
    //PreferenciasUsuario prefs = PreferenciasUsuario();
    String valoracion = AppTranslations.of(context).text('title_puntuacion');

    final recomendado = Stack(
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
                      tour.country==null ? '' : tour.country,
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
          )
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
      child: recomendado
    );
  }*/

  Widget grid(){
    //final size = MediaQuery.of(context).size;
    String noData = AppTranslations.of(context).text('title_nodata');
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          StreamBuilder(
            stream: categoriasProvider.recomendadoStream,
            builder: (BuildContext context, AsyncSnapshot<List<InfoTour>> snapshot){
              switch(snapshot.connectionState){
                case ConnectionState.waiting:
                  return Align(
                    heightFactor: 34.0,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                break;
                case ConnectionState.none:
                  return Align(
                    heightFactor: 34.0,
                    alignment: Alignment.center,
                    child: Text('$noData'),
                  );
                break;
                case ConnectionState.done:
                  if(snapshot.hasData){
                    return RecomendadoGrid(listaRecomendados: snapshot.data, siguientePagina: categoriasProvider.recomendadosPag);
                  
                  }else{
                    return Align(
                      heightFactor: 34.0,
                      alignment: Alignment.center,
                      child: Text('$noData'),
                    );
                  }
                break;
                case ConnectionState.active:
                  if(snapshot.hasData){
                    return RecomendadoGrid(listaRecomendados: snapshot.data, siguientePagina: categoriasProvider.recomendadosPag);
                  
                  }else{
                    return Align(
                      heightFactor: 34.0,
                      alignment: Alignment.center,
                      child: Text('$noData'),
                    );
                  }
                break;
                default:
                  return Align(
                    heightFactor: 34.0,
                    alignment: Alignment.center,
                    child: Text('$noData'),
                  );
              }
              
              /*if(snapshot.hasData){
                  return RecomendadoVertical(listaRecomendados: snapshot.data, siguientePagina: categoriasProvider.recomendadosPag);
                 /* Container(
                    height: size.height * 0.8,
                    child: ListView.builder(
                      itemCount: snapshot.data.length,//snapshot.data.length
                      itemBuilder: (context,index){
                        return recomendados(context, snapshot.data[index]);
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
              //return RecomendadoGrid(listaRecomendados: snapshot.data, siguientePagina: categoriasProvider.recomendadosPag);
              /*Container(
                height: size.height * 0.8,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemCount: snapshot.data.length,//snapshot.data.length
                  itemBuilder: (context,i){
                    return recomendadoGrid(context, snapshot.data[i]);
                  },
                ),
              );*/
            },
          ),
        ],
      ),
    );
  }

 /* Widget recomendadoGrid(BuildContext context,InfoTour tour){
    final size = MediaQuery.of(context).size;
    String valoracion = AppTranslations.of(context).text('title_puntuacion');
    
    final recomendado = Card(
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
              padding: EdgeInsets.only(top: 73.0,left: 10.0),
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
      child: recomendado,
      onTap: (){
        Navigator.pushNamed(context, 'detalletour',arguments: tour);
      },
    );
  }*/
}