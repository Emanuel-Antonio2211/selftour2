//import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:selftourapp/src/models/categoria_model.dart';
//import 'package:selftourapp/src/models/categoria_model.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:selftourapp/src/providers/categorias_providers.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';
import 'package:selftourapp/src/widgets/categoria_vertical.dart';

class CategoriasPage extends StatefulWidget {
  @override
  _CategoriasPageState createState() => _CategoriasPageState();
}

class _CategoriasPageState extends State<CategoriasPage> {
  CategoriasProvider categoriasProvider = CategoriasProvider();
  PreferenciasUsuario prefs = PreferenciasUsuario();
  int currentIndex = 0;

  @override
  void initState() {
    categoriasProvider.categoriaPag();
    super.initState();
  }

  Future<List<Categoria>> cargarTour()async{
      //ListaToursC listaToursC;
      //Categorias result;
      // _appState.userLocation().then((value)async{
      //   state = value[1].toString();
      //   codCountry = value[5].toString();
        
      // });
      final resultado = await categoriasProvider.getCategoria();
      final result = Categorias.fromJsonList(resultado['categories']['data']);
      
      // listaToursC = new ListaToursC.fromJsonList(result['Tours']['data']);
      return result.items;
    }

  @override
  Widget build(BuildContext context) {
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
      body: llamarPaginas(currentIndex),
    );
  }

  Widget llamarPaginas(int paginaActual){
    switch(paginaActual){
      case 0: return lista();
      case 1: return grid();
      default:
       return lista();
    }
  }
  Widget lista(){
    final size = MediaQuery.of(context).size;
    String noData = AppTranslations.of(context).text('title_nodata');
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          StreamBuilder(
            stream:  categoriasProvider.categoriasStream,
            builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot){
              switch(snapshot.connectionState){
                case ConnectionState.waiting:
                  return Column(
                    children: <Widget>[
                      SizedBox(
                        height: size.height * 0.34,
                      ),
                      Center(
                        child: CircularProgressIndicator(),
                      )
                    ],
                  );
                break;
                case ConnectionState.none:
                  return Column(
                    children: <Widget>[
                      SizedBox(
                        height: size.height * 0.34,
                      ),
                      Center(
                        child: Text(
                        '$noData',
                        style: TextStyle(
                          fontFamily: 'Point-SemiBold'
                        ),
                        ),
                      )
                    ],
                  );
                break;
                case ConnectionState.done:
                  if(snapshot.hasData){
                    if(snapshot.data['categories']['data'] == null){
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
                      final categorias = new Categorias.fromJsonList(snapshot.data['categories']['data']);
                      return CategoriaVertical(categorias: categorias.items, siguientePagina: cargarTour );
                    }
                    
                  /* Container(
                      height: size.height * 0.8,
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context,i){
                          return categorias(context, snapshot.data[i]);
                        },
                      ),
                    );*/
                  }else{
                    return Column(
                      children: <Widget>[
                        SizedBox(
                          height: size.height * 0.34,
                        ),
                        Center(
                          child: CircularProgressIndicator()
                        )
                      ],
                    );
                  }
                break;
                case ConnectionState.active:
                  
                  if(snapshot.hasData){
                    if(snapshot.data['categories']['data'] == null){
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
                      final categorias = new Categorias.fromJsonList(snapshot.data['categories']['data']);
                      return CategoriaVertical(categorias: categorias.items, siguientePagina: cargarTour );
                    }
                    
                    
                  /* Container(
                      height: size.height * 0.8,
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context,i){
                          return categorias(context, snapshot.data[i]);
                        },
                      ),
                    );*/
                  }else{
                    return Column(
                      children: <Widget>[
                        SizedBox(
                          height: size.height * 0.34,
                        ),
                        Center(
                          child: CircularProgressIndicator()
                        )
                      ],
                    );
                  }
                break;
                default:
                  return Column(
                    children: <Widget>[
                      SizedBox(
                        height: size.height * 0.34,
                      ),
                      Center(
                        child: CircularProgressIndicator()
                      )
                    ],
                  );
              }
              /*if(snapshot.hasData){
                return CategoriaVertical(categorias: snapshot.data, siguientePagina: categoriasProvider.categoriaPag);
                
               /* Container(
                  height: size.height * 0.8,
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context,i){
                      return categorias(context, snapshot.data[i]);
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

  /*Widget categorias(BuildContext context,Categoria categorias){
    final size = MediaQuery.of(context).size;
    final categoria = Stack(
      children: <Widget>[
        Card(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: 
            /*Image.network(
              categorias.icon.toString(),
              scale: 1.0,
              fit: BoxFit.fill,
              width: size.width * 1.0,
              height: size.height * 0.3,
            )*/
            CachedNetworkImage(
              imageUrl: "${categorias.icon.toString()}",
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
          alignment: Alignment.bottomLeft,
          heightFactor: 10.0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  categorias.nameCategory,
                  style: TextStyle(
                    fontFamily: 'Point-SemiBold',
                    fontSize: 17.0,
                    color: Colors.white
                  ),
                ),
                /*FutureBuilder(
                  future: categoriasProvider.traducir(prefs.idioma == null ? 'es':prefs.idioma.toString(), categorias.nameCategory),
                  builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot) {
                    if(snapshot.hasData){
                      return Text(
                        snapshot.data['data']['translations'][0]['translatedText'].toString(),
                        style: TextStyle(
                          fontFamily: 'Point-SemiBold',
                          fontSize: 17.0,
                          color: Colors.white
                        ),
                      );
                    }else{
                      return Container();
                    }
                    
                  },
                ),*/

                
              ],
            ),
          ),
        )
      ],
    );

    return GestureDetector(
      child: categoria,
      onTap: (){
        Navigator.pushNamed(context, 'tours',arguments: categorias);
      },
    );
  }*/

  Widget grid(){
    final size = MediaQuery.of(context).size;
    String noData = AppTranslations.of(context).text('title_nodata');
    Future<List<Categoria>> cargarTour()async{
      //ListaToursC listaToursC;
      //Categorias result;
      // _appState.userLocation().then((value)async{
      //   state = value[1].toString();
      //   codCountry = value[5].toString();
        
      // });
      final resultado = await categoriasProvider.getCategoria();
      final result = Categorias.fromJsonList(resultado['categories']['data']);
      
      // listaToursC = new ListaToursC.fromJsonList(result['Tours']['data']);
      return result.items;
    }
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          StreamBuilder(
            stream: categoriasProvider.categoriasStream,
            builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot){
              
              if(snapshot.hasData){
                if(snapshot.data['categories']['data'] == null){
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
                  final categorias = new Categorias.fromJsonList(snapshot.data['categories']['data']);
                  return CategoriaGrid(categorias: categorias.items, siguientePagina: cargarTour );
                }
                
              }else{
                return Column(
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.34,
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    )
                  ],
                );
              }
              
              /*Container(
                height: size.height * 0.8,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context,i){
                    return categoriasGrid(context, snapshot.data[i]);
                  },
                ),
              );*/
            },
          ),
        ],
      ),
    );
  }

  /*Widget categoriasGrid(BuildContext context,Categoria categoria){
    final size = MediaQuery.of(context).size;
    final categorias = Card(
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: 
            /*Image.network(
              "${categoria.icon.toString()}",
              scale: 1.0,
              fit: BoxFit.fill,
              width: size.width * 0.5,
              height: size.height * 0.4,
            )*/
            CachedNetworkImage(
              imageUrl: "${categoria.icon.toString()}",
              //errorWidget: (context, url, error)=>Icon(Icons.error),
              //cacheManager: baseCacheManager,
              useOldImageOnUrlChange: true,
              width: size.width * 0.5,
              height: size.height * 0.4,
              fit: BoxFit.fill,
            )
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                categoria.nameCategory,
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Point-SemiBold',
                  color: Colors.white
                ),
              )
              
              
              /*FutureBuilder(
                future: categoriasProvider.traducir(prefs.idioma == null ? 'es':prefs.idioma.toString(),categoria.nameCategory),
                builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot) {
                  if(snapshot.hasData){
                    return Text(
                      '${snapshot.data['data']['translations'][0]['translatedText'].toString()}',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Point-SemiBold',
                        color: Colors.white
                      ),
                    );
                  }else{
                    return Container();
                  }
                  
                },
              ),*/
              
              
            ),
          )
        ],
      ),
    );

    return GestureDetector(
      child: categorias,
      onTap: (){
        Navigator.pushNamed(context, 'tours',arguments: categoria);
      },
    ); 
  }*/
}