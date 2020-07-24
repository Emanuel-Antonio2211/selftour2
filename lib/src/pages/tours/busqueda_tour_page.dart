import 'package:flutter/material.dart';
import 'package:selftourapp/src/googlemaps/states/app_state.dart';
import 'package:selftourapp/src/models/tour_categoria_model.dart';
import 'package:selftourapp/src/providers/categorias_providers.dart';
import 'package:selftourapp/src/search/search_delegate.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';
import 'package:selftourapp/src/widgets/tours.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';

class BusquedaTourPage extends StatefulWidget {
  @override
  _BusquedaTourPageState createState() => _BusquedaTourPageState();
}

class _BusquedaTourPageState extends State<BusquedaTourPage> with AutomaticKeepAliveClientMixin {
  CategoriasProvider categoriasProvider = CategoriasProvider();
  String codPais;
  String state;
  AppState _appState = AppState();
  PreferenciasUsuario prefs = PreferenciasUsuario();
  
  @override
  void initState() {
    super.initState();
    // _appState.userLocation().then((value){
    //   codPais = value[5].toString();
    //   state = value[1].toString();
    //   print("Estado: ");
    //   print(state);
    //   print("Pais: ");
    //   print(codPais);
    //   categoriasProvider.getTours(state,codPais);
    // });

    // _appState.ubicacion().then((value){
    //   print("Datos del usuario:");
    //   print(value[1]);
    //   print(value[3]);
    //   categoriasProvider.getTours(value[1],value[3]);
    // });

    print("Datos del usuario:");
    print(prefs.estadoUser);
    print(prefs.countryCode);
    categoriasProvider.getTours(prefs.estadoUser.toString(),prefs.countryCode.toString());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: _buscador()
      ),
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _crearTarjetaTour()
            ],
          ),
      ),
      
      /*Stack(
        children:<Widget> [
          ListView(
          shrinkWrap: true,
          children: <Widget>[
            _tour(),
            _tour(),
            _tour(),
            _tour()
          ],
        ),
       /* Positioned(
          left: size.width * 0.09,
          child: _buscador(),
        )*/
              ]
      ),*/
    );
  }
  Widget _crearTarjetaTour(){
    var size = MediaQuery.of(context).size;
    //CategoriasProvider categoriasProvider = new CategoriasProvider();
    String noDatos = AppTranslations.of(context).text('title_nodata');
    Future<List<InfoTour>> cargarTour()async{
      //ListaToursC listaToursC;
      ListaToursC result;
      // _appState.userLocation().then((value)async{
      //   state = value[1].toString();
      //   codPais = value[5].toString();
      //   final resultado = await categoriasProvider.getTours(state,codPais);
      //   result = new ListaToursC.fromJsonList(resultado['tours'][0]['data_tour']);
      // });

      // _appState.ubicacion().then((value)async{
      //   print("Datos del usuario:");
      //   print(value[1]);
      //   print(value[3]);
      //   final resultado = await categoriasProvider.getTours(value[1],value[3]);
      //   result = new ListaToursC.fromJsonList(resultado['tours'][0]['data_tour']);
      // });

      print("Datos del usuario:");
      print(prefs.estadoUser);
      print(prefs.countryCode);
      final resultado = await categoriasProvider.getTours(prefs.estadoUser.toString(),prefs.countryCode.toString());
      result = new ListaToursC.fromJsonList(resultado['tours'][0]['data_tour']);
      
      // listaToursC = new ListaToursC.fromJsonList(result['Tours']['data']);
      return result.itemsTours;
    }
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          StreamBuilder(
            stream: categoriasProvider.popularStream,//
            builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot) {
              //Se evalúa si tiene datos
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
                        '$noDatos',
                        style: TextStyle(
                          fontFamily: 'Point-SemiBold'
                        ),
                        )
                      ),
                    ],
                  );
                
                case ConnectionState.done:
                //snapshot.data['tours']['total'] == "empty"
                  if(snapshot.hasData){
                    if(snapshot.data['tours'][0]['data_tour'] != null){
                      final tours = new ListaToursC.fromJsonList(snapshot.data['tours'][0]['data_tour']);
                      return ToursGeneral(listaTours: tours.itemsTours);
                      
                    }else if(snapshot.data['tours']['total'] == "empty"){
                      return Column(
                        children: <Widget>[
                          SafeArea(
                            child: SizedBox(
                              height: size.height * 0.4,
                            ),
                          ),
                          Center(
                            child: Text(
                              '$noDatos',
                              style: TextStyle(
                                fontFamily: 'Point-SemiBold'
                              ),
                            )
                          ),
                        ],
                      );
                    }
                  }else{
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
                  //return ToursGeneral(listaTours:snapshot.data,siguientePagina: categoriasProvider.getTours);
                break;
                case ConnectionState.active:
                  if(snapshot.hasData){
                    if(snapshot.data['tours'][0]['data_tour'] != null){
                      final tours = new ListaToursC.fromJsonList(snapshot.data['tours'][0]['data_tour']);
                      return ToursGeneral(listaTours: tours.itemsTours);
                    }else if(snapshot.data['tours']['total'] == "empty"){
                      return Column(
                        children: <Widget>[
                          SafeArea(
                            child: SizedBox(
                              height: size.height * 0.4,
                            ),
                          ),
                          Center(
                            child: Text(
                              '$noDatos',
                              style: TextStyle(
                                fontFamily: 'Point-SemiBold'
                              ),
                            )
                          ),
                        ],
                      );
                    }
                  }else{
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
                  //return ToursGeneral(listaTours:snapshot.data,siguientePagina: categoriasProvider.getTours);
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
                return ToursGeneral(listaTours:snapshot.data,siguientePagina: categoriasProvider.getTours);
              }else{
                return Column(
                  children: <Widget>[
                    SafeArea(
                      child: SizedBox(
                        height: size.height * 0.4,
                      ),
                    ),
                    Center(child: Text('$noDatos')),
                  ],
                );
              }*/
            },
          ),
        ],
      ),
    );

  }
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

  Widget _buscador() {
    var size = MediaQuery.of(context).size;
    String buscar = AppTranslations.of(context).text('title_question');
    return GestureDetector(
          onTap: (){
            showSearch(context: context,delegate: DataSearch(),query: '');
          },
          child: Container(
          width: size.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.white12,
            border: Border.all(
            color: Color(0xFF034485)),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Flexible(
                child: Text('$buscar',style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 14.1,color: Colors.black),)
              ),
              /*Container(
                width: size.width * 0.7,
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
  }
  Widget _botonBuscar(){
    return IconButton(
      color: Colors.grey,
      icon: Icon(
        Icons.search,
        size: 30.0,
      ),
      onPressed: (){
        showSearch(context: context,delegate: DataSearch(),query: '');
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}