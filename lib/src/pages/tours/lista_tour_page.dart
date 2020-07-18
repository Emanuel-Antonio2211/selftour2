//import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:selftourapp/src/googlemaps/states/app_state.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:selftourapp/src/models/categoria_model.dart';
//import 'package:selfttour/src/models/detalle_tour_model.dart';
//import 'package:selfttour/src/models/mapa_model.dart';
import 'package:selftourapp/src/models/tour_categoria_model.dart';
import 'package:selftourapp/src/providers/categorias_providers.dart';
//import 'package:selfttour/src/search/buscar_tour_principal.dart';

//import 'package:selfttour/src/search/search_delegate.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';
import 'package:selftourapp/src/widgets/lista_tours_categoria_vertical.dart';
import 'package:selftourapp/src/pages/tours/tours_mapa_page.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';

class ListaTourPage extends StatefulWidget {

  @override
  _ListaTourPageState createState() => _ListaTourPageState();
}

class _ListaTourPageState extends State<ListaTourPage> with SingleTickerProviderStateMixin{
  final List<InfoTour> listaTour=List();
  final categoriasProvider = new CategoriasProvider();
  PreferenciasUsuario prefs = PreferenciasUsuario();
  
  AppState _appState = AppState();
  String state;
  String codCountry;
  // Create a tab controller
  TabController controller;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();

    // Initialize the Tab Controller
    controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // Dispose of the Tab Controller
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Categoria categoria = ModalRoute.of(context).settings.arguments;
    
   // InfoTour tour = InfoTour();
    //var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        title: Container(
          padding: EdgeInsets.only(left: 109.0),
          height: 40.0,
          child: Image.asset(
            'assets/iconoapp/selftouricon.png',
          ),
        ), 
        centerTitle: true,
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
            icon: Icon(Icons.list,color: currentIndex == 0 ? Colors.red:Colors.grey),
          ),
          BottomNavigationBarItem(
            title: Container(),
            icon: Icon(Icons.grid_on,color: currentIndex == 1 ? Colors.red:Colors.grey)
          ),
          BottomNavigationBarItem(
            title: Container(),
            icon: Icon(Icons.map,color: currentIndex == 2 ? Colors.red:Colors.grey)
          )
        ],
      ),
     /* appBar: AppBar(
        centerTitle: false,
        
        /*TabBar(
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.list),
            ),
            Tab(
              icon: Icon(Icons.grid_on),
            ),
            Tab(
              icon: Icon(Icons.map),
            )
          ],
          // setup the controller
          controller: controller,
        ),*/
        //title:  _buscador(),
        ),*/
      body: _llamarPaginas(categoria, currentIndex)
      
     /* TabBarView(
        children: <Widget>[
          Column(
            children: <Widget>[
              _listaTourC(categoria),
            ],
          ),
          Column(
            children: <Widget>[
              _listaTourCGrid(categoria),
            ],
          ),
          _listaTourCMapa(categoria)
          /*Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _listaTourCMapa(categoria)
              //Center(child: Text('Vista de Mapa'))
            ],
          )*/
        ],
        controller: controller,
      )*/
      
     /* Column(
        children: <Widget>[
          _listaTourC(categoria),
        ],
      )*/
      
     /* Stack(children: <Widget>[
        ListView(
          shrinkWrap: true,
          children: <Widget>[
            _tour(), 
            _tour(), 
            _tour(), 
            _tour(),
            
          ],
        ),
        //ListaToursCategoriaVertical()
        /*Positioned(
          left: size.width * 0.09, //40.0
          child: _buscador(),
        )*/
      ]
      ),*/
    );
  }

  Widget _llamarPaginas(Categoria categoria,int paginaActual){
    switch(paginaActual){
      case 0: return _listaTourC(categoria);
      case 1: return _listaTourCGrid(categoria);
      case 2: return ToursMapaPage();//_listaTourCMapa(categoria)

      default:
        return _listaTourC(categoria);
    }
  }

  Widget _listaTourC(Categoria categoria){
    var size = MediaQuery.of(context).size;
    //ToursProvider toursProvider = new ToursProvider();
    final categoriasProvider = new CategoriasProvider();
    // _appState.userLocation().then((value){
    //   state = value[1].toString();
    //   codCountry = value[5].toString();
    //   categoriasProvider.getToursC(state,codCountry,categoria.ctidss.toString());
    // });

    // _appState.ubicacion().then((value){
    //   print("Datos del usuario:");
    //   print(value[1]);
    //   print(value[3]);
    //   categoriasProvider.getToursC(value[1],value[3],categoria.ctidss.toString());
    // });

    print("Datos del usuario:");
    print(prefs.estadoUser);
    print(prefs.countryCode);
    categoriasProvider.getToursC(prefs.estadoUser.toString(),prefs.countryCode.toString(),categoria.ctidss.toString());
    
    Future<List<InfoTour>> cargarTours()async{
      ListaToursC listaToursC;
      Map<String,dynamic> result;
      // _appState.userLocation().then((value)async{
      //   state = value[1].toString();
      //   codCountry = value[5].toString();
      //   result = await categoriasProvider.getToursC(state,codCountry,categoria.ctidss.toString());
      // });

      // _appState.ubicacion().then((value)async{
      //   print("Datos del usuario:");
      //   print(value[1]);
      //   print(value[3]);
      //   // categoriasProvider.recomendadosPag(value[1],value[3]);
      //   result = await categoriasProvider.getToursC(value[1],value[3],categoria.ctidss.toString());
      // });

      print("Datos del usuario:");
      print(prefs.estadoUser);
      print(prefs.countryCode);
      result = await categoriasProvider.getToursC(prefs.estadoUser.toString(),prefs.countryCode.toString(),categoria.ctidss.toString());
      
      listaToursC = new ListaToursC.fromJsonList(result['Tours']['data']);
      print("Lista C");
      print(listaToursC.itemsTours);
      return listaToursC.itemsTours;
    }
    

    return SingleChildScrollView(
          child: Column(
          children: <Widget>[
            StreamBuilder(
              stream: categoriasProvider.tourCategoryStream,//categoriasProvider.getToursC(categoria.ctidss.toString())
              builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot) {
                String noData = AppTranslations.of(context).text('title_nodata');
                print("Snapshot: ");
                print(snapshot);
              //   print("Containskey Tours: ");
              //   print(snapshot.data.containsKey('Tours'));
              //  print("Containskey dataTours: ");
              //  print(snapshot.data.containsKey('dataTours'));
                
                switch(snapshot.connectionState){
                  case ConnectionState.waiting:
                    return Column(
                      children: <Widget>[
                        SafeArea(
                          child: SizedBox(
                            height: size.height * 0.4,
                          ),
                        ),
                        // Center(
                        //   child: Text(
                        //     '$noData',
                        //     style: TextStyle(
                        //       fontFamily: 'Point-SemiBold'
                        //     ),
                        //   )
                        // ),
                        Center(
                          child: CircularProgressIndicator()
                        ),
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
                        Center(
                          child: Text(
                            '$noData',
                            style: TextStyle(
                              fontFamily: 'Point-SemiBold'
                            ),
                          )
                        ),
                      ],
                    );
                  break;
                  case ConnectionState.done:
                    if(snapshot.data.containsKey('Tours')){
                      final listaToursC = new ListaToursC.fromJsonList(snapshot.data['Tours']['data']);
                      //final ningunDato = snapshot.data['dataTours']['msg'].toString();
                      return ListaToursCategoriaVertical(
                        listaTours: listaToursC.itemsTours,
                        ctid: categoria.ctidss,
                        siguientePagina: cargarTours
                      );
                    }else if(snapshot.data.containsKey('dataTours')){
                      return Column(
                        children: <Widget>[
                          SafeArea(
                            child: SizedBox(
                              height: size.height * 0.4
                            ),
                          ),
                          Center(
                            child: Text(
                              '$noData',
                              style: TextStyle(
                                fontFamily: 'Point-SemiBold'
                              ),
                            )
                          ),
                        ],
                      );
                      //snapshot.data['dataTours']['msg'] == "Any registered"
                    }else{
                      return Column(
                        children: <Widget>[
                          SafeArea(
                            child: SizedBox(
                              height: size.height * 0.4
                            ),
                          ),
                          Center(
                            child: Text(
                              '$noData',
                              style: TextStyle(
                                fontFamily: 'Point-SemiBold'
                              ),
                            )
                          ),
                        ],
                      );
                    }
                  break;
                  case ConnectionState.active:
                    
                    if(snapshot.data.containsKey('Tours')){
                      final listaToursC = new ListaToursC.fromJsonList(snapshot.data['Tours']['data']);
                      return ListaToursCategoriaVertical(
                        listaTours: listaToursC.itemsTours,
                        ctid: categoria.ctidss,
                        siguientePagina: cargarTours
                      );
                    }else if(snapshot.data.containsKey('dataTours')){
                      return Column(
                        children: <Widget>[
                          SafeArea(
                            child: SizedBox(
                              height: size.height * 0.4
                            ),
                          ),
                          Center(
                            child: Text(
                              '$noData',
                              style: TextStyle(
                                fontFamily: 'Point-SemiBold'
                              ),
                            )
                          ),
                        ],
                      );
                    }else{
                      return Column(
                        children: <Widget>[
                          SafeArea(
                            child: SizedBox(
                              height: size.height * 0.4
                            ),
                          ),
                          Center(
                            child: Text(
                              '$noData',
                              style: TextStyle(
                                fontFamily: 'Point-SemiBold'
                              ),
                            )
                          ),
                        ],
                      );
                    }
                  break;
                  default:
                    return Column(
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
                /*if(snapshot.hasData){
                  return ListaToursCategoriaVertical(
                    listaTours: snapshot.data,siguientePagina: categoriasProvider.getToursC,
                  );
                }else{
                  return Column(
                    children: <Widget>[
                      SafeArea(
                        child: SizedBox(
                          height: size.height * 0.4,
                        ),
                      ),
                      Center(
                        child: Text(
                          '$noData',
                          style: TextStyle(
                            fontFamily: 'Point-SemiBold'
                          ),
                        )
                      ),
                    ],
                  );
                }*/
                
              },
            ),
          ],
        ),
    );
    
    
    /*return ListaToursCategoriaVertical(
      listaTours: [],
    );*/
    //Aquí recibimos los argumentos de la categoria
    //Categoria categoria = ModalRoute.of(context).settings.arguments;

    /*final size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream:  listaTourCProvider.listaToursCStream,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot){
        //Se evalúa si tiene datos
        if(snapshot.hasData){
          return Text('Informacion');//ListaToursCategoriaVertical(listaInfoTour: snapshot.data,siguientePagina: listaTourCProvider.getListaToursC);
        }else{
          return Container(
            height: size.height * 0.2,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
        }
        
      },
    );*/
  }

  Widget _listaTourCGrid(Categoria categoria){
    var size = MediaQuery.of(context).size;
    String noData = AppTranslations.of(context).text('title_nodata');
    //ToursProvider toursProvider = new ToursProvider();
    final categoriasProvider = new CategoriasProvider();

    // _appState.ubicacion().then((value)async{
    //     print("Datos del usuario:");
    //     print(value[1]);
    //     print(value[3]);
    //     categoriasProvider.getToursC(value[1],value[3],categoria.ctidss.toString());
    // });

    print("Datos del usuario:");
    print(prefs.estadoUser);
    print(prefs.countryCode);
    categoriasProvider.getToursC(prefs.estadoUser,prefs.countryCode,categoria.ctidss.toString());
    // void cargarTour()async{
    //   await categoriasProvider.getToursC(categoria.ctidss.toString());
    // }

    Future<List<InfoTour>> cargarTour()async{
      ListaToursC listaToursC;
      Map<String,dynamic> result;
      // _appState.userLocation().then((value)async{
      //   state = value[1].toString();
      //   codCountry = value[5].toString();
      //   result = await categoriasProvider.getToursC(state,codCountry,categoria.ctidss.toString());
      // });

      // _appState.ubicacion().then((value)async{
      //     print("Datos del usuario:");
      //     print(value[1]);
      //     print(value[3]);
      //     result = await categoriasProvider.getToursC(value[1],value[3],categoria.ctidss.toString());
      // });

      print("Datos del usuario:");
      print(prefs.estadoUser);
      print(prefs.countryCode);
      result = await categoriasProvider.getToursC(prefs.estadoUser,prefs.countryCode,categoria.ctidss.toString());
      
      listaToursC = new ListaToursC.fromJsonList(result['Tours']['data']);
      return listaToursC.itemsTours;
    }
    
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder(
              stream: categoriasProvider.tourCategoryStream,//categoriasProvider.getToursC(categoria.ctidss.toString())
              builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot) {
                switch(snapshot.connectionState){
                  case ConnectionState.waiting:
                    return Column(
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
                  break;
                  case ConnectionState.none:
                    return Column(
                    children: <Widget>[
                      SafeArea(
                        child: SizedBox(
                          height: size.height * 0.4,
                        ),
                      ),
                      Center(
                        child: Text(
                          '$noData',
                          style: TextStyle(
                            fontFamily: 'Point-SemiBold'
                          ),
                        )
                      ),
                    ],
                  );
                  break;
                  case ConnectionState.done:
                    if(snapshot.data.containsKey('Tours')){
                      final listaToursC = new ListaToursC.fromJsonList(snapshot.data['Tours']['data']);
                      return ListaToursCategoriaGrid(
                        listaTours: listaToursC.itemsTours,
                        ctid: categoria.ctidss,
                        siguientePagina: cargarTour
                      );
                    } else if(snapshot.data.containsKey('dataTours')){
                      return Column(
                        children: <Widget>[
                          SafeArea(
                            child: SizedBox(
                              height: size.height * 0.4,
                            ),
                          ),
                          Center(
                            child: Text(
                              '$noData',
                              style: TextStyle(
                                fontFamily: 'Point-SemiBold'
                              ),
                            )
                          ),
                        ],
                      );
                    }else{
                      return Column(
                        children: <Widget>[
                          SafeArea(
                            child: SizedBox(
                              height: size.height * 0.4,
                            ),
                          ),
                          Center(
                            child: Text(
                              '$noData',
                              style: TextStyle(
                                fontFamily: 'Point-SemiBold'
                              ),
                            )
                          ),
                        ],
                      );
                    }
                  break;
                  case ConnectionState.active:
                    if(snapshot.data.containsKey('Tours')){
                      final listaToursC = new ListaToursC.fromJsonList(snapshot.data['Tours']['data']);
                      return ListaToursCategoriaGrid(
                        listaTours: listaToursC.itemsTours,
                        ctid: categoria.ctidss,
                        siguientePagina: cargarTour
                      );
                    }else if(snapshot.data.containsKey('dataTours')){
                      return Column(
                        children: <Widget>[
                          SafeArea(
                            child: SizedBox(
                              height: size.height * 0.4,
                            ),
                          ),
                          Center(
                            child: Text(
                              '$noData',
                              style: TextStyle(
                                fontFamily: 'Point-SemiBold'
                              ),
                            )
                          ),
                        ],
                      );
                    }else{
                      return Column(
                        children: <Widget>[
                          SafeArea(
                            child: SizedBox(
                              height: size.height * 0.4,
                            ),
                          ),
                          Center(
                            child: Text(
                              '$noData',
                              style: TextStyle(
                                fontFamily: 'Point-SemiBold'
                              ),
                            )
                          ),
                        ],
                      );
                    }
                    
                  break;
                  default:
                    return Column(
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
                /*if(snapshot.hasData){
                  return ListaToursCategoriaGrid(
                    listaTours: snapshot.data,
                    siguientePagina: categoriasProvider.getToursC
                  );
                }else{
                  return Column(
                    children: <Widget>[
                      SafeArea(
                        child: SizedBox(
                          height: size.height * 0.4,
                        ),
                      ),
                      Center(
                        child: Text(
                          '$noData',
                          style: TextStyle(
                            fontFamily: 'Point-SemiBold'
                          ),
                        )
                      ),
                    ],
                  );
                }*/
                
              },
            ),
          ],
        ),
      ),
    );
    
    
    /*return ListaToursCategoriaVertical(
      listaTours: [],
    );*/
    //Aquí recibimos los argumentos de la categoria
    //Categoria categoria = ModalRoute.of(context).settings.arguments;

    /*final size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream:  listaTourCProvider.listaToursCStream,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot){
        //Se evalúa si tiene datos
        if(snapshot.hasData){
          return Text('Informacion');//ListaToursCategoriaVertical(listaInfoTour: snapshot.data,siguientePagina: listaTourCProvider.getListaToursC);
        }else{
          return Container(
            height: size.height * 0.2,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
        }
        
      },
    );*/
  }

/*
Widget _listaTourCMapa(Categoria categoria){
    var size = MediaQuery.of(context).size;
    final categoriasProvider = new CategoriasProvider();
    String noData = AppTranslations.of(context).text('title_nodata');
    //final Completer<GoogleMapController> _controller = Completer();
    categoriasProvider.getToursC(categoria.ctidss.toString());
    return StreamBuilder(
            stream: categoriasProvider.tourCStream,//categoriasProvider.getToursC(categoria.ctidss.toString())
            builder: (BuildContext context, AsyncSnapshot<List<InfoTour>> snapshot) {
              if(snapshot.hasData){
                return  ListaToursCategoriaMapa(
          listaTours: snapshot.data,
          siguientePagina: categoriasProvider.getToursC,
        );                           
        }else{
          return Column(
            children: <Widget>[
              SafeArea(
                child: SizedBox(
                  height: size.height * 0.4,
                ),
              ),
              Center(
                child: Text(
                  '$noData',
                  style: TextStyle(
                    fontFamily: 'Point-SemiBold'
                  ),
                )
              ),
            ],
          );
        }                         
    },
  );
    /*return ListaToursCategoriaVertical(
      listaTours: [],
    );*/
    //Aquí recibimos los argumentos de la categoria
    //Categoria categoria = ModalRoute.of(context).settings.arguments;

    /*final size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream:  listaTourCProvider.listaToursCStream,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot){
        //Se evalúa si tiene datos
        if(snapshot.hasData){
          return Text('Informacion');//ListaToursCategoriaVertical(listaInfoTour: snapshot.data,siguientePagina: listaTourCProvider.getListaToursC);
        }else{
          return Container(
            height: size.height * 0.2,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
        }
        
      },
    );*/
  }*/

  /*Widget _tarjeta(BuildContext context, InfoTour tour){
    final size = MediaQuery.of(context).size;
    final tarjeta = Container(
        child: Card(
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: FadeInImage(
                  image: NetworkImage(tour.gallery),
                  placeholder: AssetImage('assets/loading.gif'),
                  fit: BoxFit.cover,
                  width: size.width * 0.6,
                  height: size.height * 0.15,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    
                    child: Text(tour.title,style: TextStyle(
                                color: Colors.brown,
                                fontFamily: 'Point',
                                fontWeight: FontWeight.bold
                                ),),
                  ),
                  Container(
                    
                    child: Text('País: ${tour.country}',style: TextStyle(
                                color: Colors.brown,
                                fontFamily: 'Point',
                                fontWeight: FontWeight.bold
                                ),),
                  )
                ],
              ),
              
            ],
          ),
          
        ),
      );
    return GestureDetector(
      child: tarjeta,
      onTap: (){
        print('Tour con el id: ${tour.idtour.toString()}');
        Navigator.pushNamed(context, 'detalletour',arguments: tour);//,arguments: tour.idtour.toInt()
      },
    );
  }*/

  /*Widget _tour() {
    var size = MediaQuery.of(context).size;
    final imagentour = Container(
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: FadeInImage(
              width: size.width * 0.95,
              height: size.height * 0.25,
              image: AssetImage('assets/images/beach.jpeg'),
              placeholder: AssetImage('assets/jar-loading.gif'),
              fadeInDuration: Duration(milliseconds: 100),
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: size.height * 0.01,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Costo',
                  style:
                      TextStyle(fontFamily: 'Neue Haas Grotesk Display Pro')),
              Container(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.star,size: 23.0, color: Color(0xFFF7C109)),
                    Icon(Icons.star,size: 23.0, color: Color(0xFFF7C109)),
                    Icon(Icons.star,size: 23.0, color: Color(0xFFF7C109)),
                    Icon(Icons.star,size: 23.0, color: Color(0xFFF7C109)),
                    Icon(Icons.star_half,size: 23.0, color: Color(0xFFF7C109)),
                  ],
                ),
              ),
              Text('87',
                  style: TextStyle(fontFamily: 'Neue Haas Grotesk Display Pro'))
            ],
          )
        ],
      ),
    );
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'detalletour');
      },
      child: Column(
        children: <Widget>[
          Container(
            height: size.height * 0.34,
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Card(child: imagentour),
                Positioned(
                  top: size.height * 0.11, //105
                  left: size.width * 0.3, //120.0
                  child: Text(
                    'Título Tour',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Source Sans Pro',
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.16,
                  left: size.width * 0.3,
                  child: Text(
                    'Subtítulo Tour',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Source Sans Pro',
                    ),
                  ),
                )
              ],
            ),
          ),
          /*Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('Costo',
                  style:
                      TextStyle(fontFamily: 'Neue Haas Grotesk Display Pro')),
              Container(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.star, color: Color(0xFFF7C109)),
                    Icon(Icons.star, color: Color(0xFFF7C109)),
                    Icon(Icons.star, color: Color(0xFFF7C109)),
                    Icon(Icons.star, color: Color(0xFFF7C109)),
                    Icon(Icons.star_half, color: Color(0xFFF7C109)),
                  ],
                ),
              ),
              Text('87 %',
                  style: TextStyle(fontFamily: 'Neue Haas Grotesk Display Pro'))
            ],
          )*/
        ],
      ),
    );
  }*/

  /*Widget _buscador() {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        showSearch(context: context,delegate: DataSearch());
      },
      child: Container(
          width: size.width * 0.8,
          decoration: BoxDecoration(
            color: Colors.white12,
            border: Border.all(
            color: Color(0xFF034485)),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('Ingresa nombre de un tour',style: TextStyle(fontSize: 11.1,color: Colors.white),),
              /*Container(
                width: size.width * 0.56,
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      hintText: 'Ingresa nombre de un tour',
                      hintStyle: TextStyle(fontSize: 11.1,color: Colors.white)),
                ),
              ),*/
              _botonBuscar()
            ],
          ),
        ),
    );
  }*/

  /*Widget _botonBuscar() {
    return IconButton(
      color: Colors.white,
      icon: Icon(
        Icons.search,
        size: 30.0,
      ),
      onPressed: () {
        showSearch(context: context,delegate: BuscarTour());
      },
    );
  }*/
}
