import 'dart:async';
import 'dart:convert';
//import 'dart:io';
import 'package:rxdart/rxdart.dart';
//import 'package:selftourapp/src/models/categoria_model.dart';
import 'package:http/http.dart' as http;
//import 'package:selftourapp/src/models/comentario_model.dart';
import 'package:selftourapp/src/models/creartour_model.dart';
import 'package:selftourapp/src/models/mapa_model.dart';
import 'package:selftourapp/src/models/tour_categoria_model.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';

class CategoriasProvider{
  //Categoria dato = new Categoria();
  //UsuarioProvider usuarioProvider = UsuarioProvider();
  PreferenciasUsuario prefs = PreferenciasUsuario();

  String _url = 'api-users.selftours.app';
  String urltour = 'https://api-users.selftours.app';

 // int _categoriasPage = 0;
 // int _tourlistPage = 0;
   int _toursPage = 0;
 // bool _cargando = false;

  // List<Categoria> _categorias=new List();

  // List<InfoTour> _toursC = new List();

  // List<InfoTour> _tourBuscar = new List();

  List<InfoTour> popularesTours = new List();
  List<InfoTour> recientesTours = new List();
  List<InfoTour> recomendadosTours = new List();

  final _tourBuscarStreamController = StreamController<List<InfoTour>>.broadcast();
  //Insertamos contenido al stream
 Function(List<InfoTour>) get tourBuscarSink => _tourBuscarStreamController.sink.add;
 Stream<List<InfoTour>> get tourBuscarstream => _tourBuscarStreamController.stream;

  //Creamos una tubería llamada stream para el flujo de datos
  final _categoriaStreamController               = BehaviorSubject<Map<String,dynamic>>();
  final _popularesStreamController               = StreamController<Map<String,dynamic>>.broadcast();
  final _recientesStreamController               = StreamController<Map<String,dynamic>>.broadcast();
  final _recomendadosStreamController            = BehaviorSubject<Map<String,dynamic>>();
  final _tourCStreamController                   = StreamController<List<InfoTour>>.broadcast();
  final _tourCategoryStreamController            = StreamController<Map<String,dynamic>>.broadcast();
  final _tourFavoritosStreamController           = StreamController<Map<String,dynamic>>.broadcast();
  final _tourUserStreamController                = StreamController<Map<String,dynamic>>.broadcast();
  final _tourCompradoStreamController            = StreamController<Map<String,dynamic>>.broadcast();

  //Lo agregamos a la tubería
  Function(Map<String,dynamic>) get categoriasSink => _categoriaStreamController.sink.add;
  Function(Map<String,dynamic>) get popularSink => _popularesStreamController.sink.add;
  Function(Map<String,dynamic>) get recienteSink => _recientesStreamController.sink.add;
  Function(Map<String,dynamic>) get recomendadosSink => _recomendadosStreamController.sink.add;
  Function(List<InfoTour>) get tourCSink => _tourCStreamController.sink.add;
  Function(Map<String,dynamic>) get tourFavoritoSink => _tourFavoritosStreamController.sink.add;
  Function(Map<String,dynamic>) get toursUserSink => _tourUserStreamController.sink.add;
  Function(Map<String,dynamic>) get tourCompradoSink => _tourCompradoStreamController.sink.add;

  Function(Map<String,dynamic>) get tourCategorySink => _tourCategoryStreamController.sink.add;
  
  //Escuchamos a los elementos que se están emitiendo
  Stream<Map<String,dynamic>> get categoriasStream => _categoriaStreamController.stream;
  Stream<Map<String,dynamic>> get popularStream => _popularesStreamController.stream;
  Stream<Map<String,dynamic>> get recienteStream => _recientesStreamController.stream;
  Stream<Map<String,dynamic>> get recomendadoStream => _recomendadosStreamController.stream;
  Stream<List<InfoTour>> get tourCStream => _tourCStreamController.stream;
  Stream<Map<String,dynamic>> get tourFavoritoStream => _tourFavoritosStreamController.stream;
  Stream<Map<String,dynamic>> get toursUserStream => _tourUserStreamController.stream;
  Stream<Map<String,dynamic>> get tourCompradoStream => _tourCompradoStreamController.stream;

  Stream<Map<String,dynamic>> get tourCategoryStream => _tourCategoryStreamController.stream;

  //Cerramos el stream cuando ya no se necesite
  void disposeStream(){
    _categoriaStreamController?.close();
    _tourBuscarStreamController?.close();
    _popularesStreamController?.close();
    _recientesStreamController?.close();
    _recomendadosStreamController?.close();
    _tourCStreamController?.close();
    _tourFavoritosStreamController?.close();
    _tourUserStreamController?.close();
    _tourCompradoStreamController?.close();

    _tourCategoryStreamController?.close();
  }

  Future<Map<String,dynamic>> getToursC(String state,String country,String ctidss,{String page = ''}) async{
   String _url = 'api-users.selftours.app';
    _toursPage++;
    final url = Uri.https(
      _url,
     '/tours/category/$ctidss',{
        'page': page == '' ? '${_toursPage.toString()}' : '$page',
        'items': '12',
        'state': '$state',
        'country': '$country'
     });
    //a6151c55-8897-434a-acc9-a82c16efbd48
    final respuestaTourC = await _procesarRespuestaToursC(url);
    //_toursC.addAll(respuestaTourC);
    
    //tourCSink(_toursC);
    
    tourCategorySink(respuestaTourC);
    
    //listTourCSink(_toursC);
    //_cargando = false;
    return respuestaTourC;
  }

  /* 

    Future<List<InfoTour>> getToursC(String ctidss) async{
   String _url = 'api-users.selftours.app';
    /*if(_cargando){
      return [];
    }else{
      _cargando = true;
    }*/
    _toursPage++;
    //print('Cargando siguientes...');
    final url = Uri.https(
      _url,
     '/tours/category/$ctidss',{
       'pages': _toursPage.toString()
     });
    //a6151c55-8897-434a-acc9-a82c16efbd48
    final respuestaTourC = await _procesarRespuestaToursC(url);
    _toursC.addAll(respuestaTourC);
    
    tourCSink(_toursC);
    //listTourCSink(_toursC);
    //_cargando = false;
    return respuestaTourC;
  }
  
   */
  Future<Map<String,dynamic>> _procesarRespuestaToursC(Uri url) async{
    final respuestaTC = await http.get(
      url,
      headers: {
        "token": prefs.token.toString()
      }
    );
    final decodedDataTC = json.decode(respuestaTC.body);
    
    //final listaToursC = new ListaToursC.fromJsonList(decodedDataTC['Tours']['data']);
    //print(respuestaTourC['Tours']['data']);
    //print(decodedDataTC);
    //print(listaToursC.itemsTours);
    return decodedDataTC; //[];
    //listaToursC.itemsTours;
  }

  /*

    Future<List<InfoTour>> _procesarRespuestaToursC(Uri url) async{
    final respuestaTC = await http.get(url);
    final decodedDataTC = json.decode(respuestaTC.body);
    print(decodedDataTC['Tours']['data']);
    final listaToursC = new ListaToursC.fromJsonList(decodedDataTC['Tours']['data']);
    //print(listaToursC.itemsTours);
    return //[];
    listaToursC.itemsTours;
  }


  */

  Future<Map<String,dynamic>> categoriaPag()async{
    _toursPage++;
    final url = Uri.https(
      _url, 
      '/categories',{
        "page": _toursPage.toString(),
        "items": "5"
      }
    );
    final respuesta = await procesarRespuesta(url);
    //Agregamos a la lista de categorias el contenido decodificado
    //_categorias.addAll(respuesta);
    //Aquí agregamos a la tubería de datos nuestra lista de categorías
    //categoriasSink(respuesta);
    
    //Aquí ya no se está cargando nada, los datos están listos
    //para mostrarse
   // _cargando = false;
    return respuesta;
  } 

  Future<Map<String,dynamic>> getCategoria() async {
    //Aquí evaluamos si estamos cargando datos
   /* if(_cargando) return [];
    //En caso de que no esté cargando
    _cargando = true;

    //Aumenta en uno las categorias a mostrar cuando se llega al final
    //de la lista a mostrar
    _categoriasPage++;
    */
    //Definimos la url del proveedor de las categorias
    final url = Uri.https(
      _url, 
      '/categories',
      {
        'page': '1',
        'items': '5'
      }
    );
    /*final url = Uri.https(_url, '/categories',{
      "api_key": ""
    });*/

    final respuesta = await procesarRespuesta(url);
    //print(decodedData['categories']['data'][1]);
    //Convertir la respuesta en formato json en una lista de categorias
    /*final categorias = new Categorias.fromJsonList(decodedData['categories']);
    print(categorias.items[0].title);*/

    //Agregamos a la lista de categorias el contenido decodificado
    //_categorias.addAll(respuesta);
    //Aquí agregamos a la tubería de datos nuestra lista de categorías
    //categoriasSink(respuesta);
    
    //Aquí ya no se está cargando nada, los datos están listos
    //para mostrarse
   // _cargando = false;
    return respuesta;
    
  }

  Future<Map<String,dynamic>> procesarRespuesta(Uri url) async {
    //Hacemos la petición http
    final respuesta = await http.get(url);
    //Aquí recibimos los datos decodificados del json
    Map<String,dynamic> decodedData = json.decode(respuesta.body);
    //print(decodedData);
    // final categorias = new Categorias.fromJsonList(decodedData['categories']['data']);
    //print(categorias.items);
    categoriasSink(decodedData);
    //print(categorias.items[1].icon);
    return decodedData;
  }

  Future<Map<String,dynamic>> getTours(String state, String country,{String page = ''}) async{
    //Se evalúa si se está cargando datos
   /* if(_cargando){
      return [];
    }
    //En caso de que no esté cargando
    _cargando = true;
    //Aumenta en uno los tours a mostrar en la pantalla
    _toursPage++;
*/
  _toursPage++;
    //Se define la url del proveedor de la lista de tours
    //?page=${_toursPage.toString()}&items=3
    final url = Uri.https(
      _url, 
      '/tours',
      {
        'page': page == '' ? '${_toursPage.toString()}': '${page.toString()}',
        'items': '5',
        'state': '$state',
        'country': '$country'
      }
    );
    //Guardamos la petición http en una variable
    final respuestaTours = await procesarRespuestaTours(url);
   //popularesTours.addAll(respuestaTours);
   popularSink(respuestaTours);
    //Significa que ya no se está cargando nada
   // _cargando = false;
    
    return respuestaTours;
  }

  Future<Map<String,dynamic>> procesarRespuestaTours(Uri url) async{
    //Se hace la petición http para los tours
    final respuestaTours = await http.get(
      url,
      headers: {
        "token": prefs.token
      }
      );
    //Se recibe los datos decodificados del json
    final decodedDataTours = json.decode(respuestaTours.body);
    print("Tours: ");
    print(decodedDataTours);
    //print(decodedDataTours['tours'][0]['data_tour']);
    // final tours = new ListaToursC.fromJsonList(decodedDataTours['tours'][0]['data_tour']);
    //print(tours.itemsTours);
    return decodedDataTours;
  }

  Future<Map<String,dynamic>> buscarTours(String query) async{
    //Se evalúa si se está cargando datos
   /* if(_cargando){
      return [];
    }*/
    //En caso de que no esté cargando
   // _cargando = true;
    //Aumenta en uno los tours a mostrar en la pantalla
    _toursPage++;
    //Se define la url del proveedor de la lista de tours
    final url = Uri.https(
      _url, 
      '/search/$query',{
        'page': _toursPage.toString(),
        'items': '5'
      }
    );//${query.toString()}
    //Guardamos la petición http en una variable
    final respuesta = await procesarRespuestaBusquedaTours(url);

    //_tourBuscar.addAll(respuesta);
    //tourBuscarSink(_tourBuscar);

    //Significa que ya no se está cargando nada
    //_cargando = false;
    return respuesta;
  }
  Future<Map<String,dynamic>> procesarRespuestaBusquedaTours(Uri url) async{
    //Se hace la petición http para los tours
    final respuestaTours = await http.get(url);
    //Se recibe los datos decodificados del json
    Map<String,dynamic> decodedDataTours = json.decode(respuestaTours.body);
    //print(decodedDataTours['tour']);
    //final tours = new ListaToursC.fromJsonList(decodedDataTours['tour']);
    //print(tours.itemsTours);
    return decodedDataTours;
    
  }

  Future<List<InfoTour>> verTours(String state, String country) async{
    //Se evalúa si se está cargando datos
  /*  if(_cargando){
      return [];
    }*/
    //En caso de que no esté cargando
    //_cargando = true;
    //Aumenta en uno los tours a mostrar en la pantalla
    _toursPage++;
    //Se define la url del proveedor de la lista de tours

    final url = Uri.https(
      _url, 
      '/search',{
        'page': _toursPage.toString(),
        'items': '5',
        'state': '$state',
        'country': '$country'
      }
    );//${query.toString()}
    //Guardamos la petición http en una variable
    final respuesta = await procesarRespuestaverTours(url);
    //popularesTours.addAll(respuesta);
    //tourFavoritoSink(popularesTours);
    //Significa que ya no se está cargando nada
   // _cargando = false;
    return respuesta;
  }
  Future<List<InfoTour>> procesarRespuestaverTours(Uri url) async{
    //Se hace la petición http para los tours
    final respuestaTours = await http.get(url);
    //Se recibe los datos decodificados del json
    Map<String,dynamic> decodedDataTours = json.decode(respuestaTours.body);
    //print(decodedDataTours['tours']);
    final tours = new ListaToursC.fromJsonList(decodedDataTours['tours']);
    //print(tours.itemsTours);
    return //[];
    tours.itemsTours;
  }


  Future<List<InfoTour>> getToursId(int idtour,String token)async{
   //final id = String.fromCharCode(idtour);
    /*if(_cargando){
      return [];
    }else{
      _cargando = true;
    }*/
    //_tourlistPage++;
    //print('Cargando siguientes...');
    final url = Uri.https(
      _url,
      '/tours/${idtour.toInt()}'
    ); //${idtour.toInt()}
    final respuestaDetalleTour = await _procesarRespuestaToursId(url,token);
    //popularesTours.addAll(respuestaDetalleTour);
    //popularSink(popularesTours);
    //_cargando = false;
    return respuestaDetalleTour;
  }

  Future<List<InfoTour>> _procesarRespuestaToursId(Uri url,String token) async{
    final respuestaTC = await http.get(
      url,
      headers: {
        "token": "$token"
      }
    );
    final decodedDataTC = json.decode(respuestaTC.body);
    // print("Detalles del tour: ");
    // print(decodedDataTC['rows']);
    final detallerTour = new ListaToursC.fromJsonList(decodedDataTC['rows']);
    return 
    detallerTour.itemsTours;
  }

  Future<Map<String,dynamic>> marcarFavorito(String token,String idTour)async{
    final String url = "https://api-users.selftours.app/addFavorite/$idTour";
    //print("token: "+prefs.token);
    final resp = await http.post(
      url,
      headers: {
        'token': token
      }
      
      );

    final  decodedResp = json.decode(resp.body);

    print(decodedResp);
    return decodedResp;
  }

  Future<Map<String,dynamic>> removerFavorito(String token,String idUser,String idTour)async{
    final String url = "https://api-users.selftours.app/removeFavorite/$idTour";

    final resp = await http.delete(
      url,
      headers: {
        'token': token
      }
    );

    final Map decodedResp = json.decode(resp.body);
    print(decodedResp);
    return decodedResp;
  }

  Future<Map<String,dynamic>> verFavoritos({String page = ''})async{
    //final String url = "https://api-users.selftours.app/favoritesTours";
    final String url = "api-users.selftours.app";
    _toursPage++;
    final _url = Uri.https(
      url, 
      'favoritesTours',{
        'page': page == '' ? _toursPage.toString():page
        //'items': '5',
        //'state': '$state',
        //'country': '$country'
      }
    );
    final resp = await http.get(
      _url,
      headers: {
        "token": prefs.token,
      }
    );

    Map<String,dynamic> decodedResp = json.decode(resp.body);
    // print("Favoritos: ");
    // print(decodedResp);
    // final favoritos = new ListaToursC.fromJsonList(decodedResp['resp']['tours']);
    //popularesTours.addAll(favoritos.itemsTours);
    tourFavoritoSink(decodedResp);
    
    //print(favoritos.itemsTours);
    return decodedResp;
  }

  Future<Map<String,dynamic>> toursComprados({String page = ''})async{
    //String url = "https://api-users.selftours.app/shoppingTours";
    final String url = "api-users.selftours.app";
    _toursPage++;
    final _url = Uri.https(
      url, 
      'shoppingTours',
      {
        'page': page == '' ? '${_toursPage.toString()}':page
        //'items': '5',
        //'state': '$state',
        //'country': '$country'
      }
    );
    final resp = await http.get(
      _url,
      headers: {
        "token": prefs.token,
      }
    );
    final decodedResp = json.decode(resp.body);
    // print(decodedResp['shopping']);
    //final comprados = ListaToursC.fromJsonList(decodedResp['shopping']['tours']);

    //popularesTours.addAll(comprados.itemsTours);
    //tourFavoritoSink(comprados.itemsTours);
    tourCompradoSink(decodedResp);

    return decodedResp;

  }
  Future<Map<String,dynamic>> popularesPag(String state, String country, {String page = ''})async{
    final String url = "api-users.selftours.app";
    _toursPage++;
    final _url = Uri.https(
      url, 
      'popularTours',{
        'page': page == '' ? _toursPage.toString():page,
        'items': '5',
        'state': '$state',
        'country': '$country'
      }
    );
    final resp = await http.get(
      _url
    );
    final decodedResp = json.decode(resp.body);
    //print(decodedResp);
    //final populares = ListaToursC.fromJsonList(decodedResp['tours'][0]['data_tour']);
    //popularesTours.addAll(populares.itemsTours);
    popularSink(decodedResp);

    return decodedResp;
  }
  Future<Map<String,dynamic>> verPopulares(String state, String country)async{
    String base = 'api-users.selftours.app';
    //String url = "https://api-users.selftours.app/popularTours";
    final url = Uri.https(
      base, 
      'popularTours',{
        'page': '1',
        'items': '5',
        'state': '$state',
        'country': '$country'
      }
    );
    final resp = await http.get(
      url
    );

    final decodedResp = json.decode(resp.body);
    //print(decodedResp);
    // final populares = ListaToursC.fromJsonList(decodedResp['tours'][0]['data_tour']);
    //popularesTours.addAll(populares.itemsTours);
    popularSink(decodedResp);

    return decodedResp;
  }

  Future<Map<String,dynamic>> recientesPag(String state, String country, {String page = ''})async{
    final String url = "api-users.selftours.app";
    _toursPage++;
    final _url = Uri.https(
      url, 
      'recentTours',{
        'page': page == '' ? _toursPage.toString():page,
        'items': '5',
        'state': '$state',
        'country': '$country'
      }
    );
    final resp = await http.get(_url);
    final decodedResp = json.decode(resp.body);
    //print(decodedResp);

    //final recientes = ListaToursC.fromJsonList(decodedResp['tours'][0]['data_tour']);
    //recientesTours.addAll(recientes.itemsTours);
    recienteSink(decodedResp);

    return decodedResp;
  }

  Future<Map<String,dynamic>> verRecientes(String state, String country)async{
    String base = 'api-users.selftours.app';
    //String url = "https://api-users.selftours.app/recentTours";
    //_toursPage++;
    final url = Uri.https(
      base, 
      'recentTours',{
        'page': '1',
        'items': '5',
        'state': '$state',
        'country': '$country'
      }
    );
    final resp = await http.get(url);

    final decodedResp = json.decode(resp.body);
    //print(decodedResp);

    // final recientes = ListaToursC.fromJsonList(decodedResp['tours'][0]['data_tour']);
    //recientesTours.addAll(recientes.itemsTours);
    recienteSink(decodedResp);

    return decodedResp;
    
  }

  Future<Map<String,dynamic>> recomendadosPag(String state, String country,{String page = ''})async{
    final String url = "api-users.selftours.app";
    _toursPage++;
    final _url = Uri.https(
      url, 
      'recommendTours',{
        'page': page == '' ? _toursPage.toString():page,
        'items': '5',
        'state': '$state',
        'country': '$country'
      }
    );
    final resp = await http.get(_url);
    final decodedResp = json.decode(resp.body);
    //print(decodedResp);
    //final recomendados = ListaToursC.fromJsonList(decodedResp['tours'][0]['data_tour']);
    //recomendadosTours.addAll(recomendados.itemsTours);
    recomendadosSink(decodedResp);

    //print("Registro 1 : ${recomendados.itemsTours[0].title}");

    return decodedResp;
  }

  Future<Map<String,dynamic>> verRecomendados(String state, String country)async{
    String base = 'api-users.selftours.app';
    //String url = "https://api-users.selftours.app/recommendTours";
    //_toursPage++;
    final url = Uri.https(
      base, 
      'recommendTours',{
        'page': '1',
        'items': '5',
        'state': '$state',
        'country': '$country'
      }
    );
    final resp = await http.get(url);

    final decodedResp = json.decode(resp.body);
    //print(decodedResp);
    // final recomendados = ListaToursC.fromJsonList(decodedResp['tours'][0]['data_tour']);
    //recomendadosTours.addAll(recomendados.itemsTours);
    recomendadosSink(decodedResp);

    //print("Registro 1 : ${recomendados.itemsTours[0].title}");

    return decodedResp;
  }

  Future<Map<String,dynamic>> toursUser(String token)async{
    _toursPage++;
    String base = 'api-users.selftours.app';
    final url = Uri.https(
      base, 
      'tours/user',
      {
        'page': _toursPage.toString()
      }
    );

    final resp = await http.get(
      url,
      headers: {
        "token": "$token"
      }
    );
    final decodedResp = json.decode(resp.body);
    print("Tours del usuario: ");
    print(decodedResp);
    toursUserSink(decodedResp);
    return decodedResp;
  }

  Future<List<InfoTour>> nearBySearch(double lat,double lng,double radius)async{
    String url = 'https://api-users.selftours.app/nearBySearch?lat=$lat&lng=$lng&radius=$radius';

    final response = await http.get(
      url,
      
    );

    final decodedResp = json.decode(response.body);
    print("Sitios Cercanos: $decodedResp"); //['sites']['near_tours']

    final sitios = ListaToursC.fromJsonList(decodedResp['sites']['near_tours']);

    return sitios.itemsTours;
  }

  Future<Map<String,dynamic>> comentar(String idtour, String comentario,int value)async{
    String url = 'https://api-users.selftours.app/comments/$idtour';

    /*Map<String,dynamic> datos = {
      "comment": "$comentario"
    };*/

    final resp = await http.post(
      url,
      headers: {
        //HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
        "token": prefs.token
      },
      body: {
        "comment": comentario,
        "value": value.toString()
      }
    );

    final decodedResp = json.decode(resp.body);

    print(decodedResp);

    return decodedResp;
  }

  Future<Map<String,dynamic>> verComentarios(String idtour)async{
    String url = 'https://api-users.selftours.app/commentsTour/$idtour';
    _toursPage++;
    final resp = await http.get(
      url,
      headers: {
        'page': _toursPage.toString(),
        'items': '5'
      }
    );

    final decodedResp = json.decode(resp.body);
    print(decodedResp['comments']);

    //final comentarios = Comentario.fromJsonList(decodedResp['comments']);

    return decodedResp;
  }

  Future<Map<String,dynamic>> verTodoComentarios(String idtour)async{
    String url = 'https://api-users.selftours.app/commentsTour/$idtour?all=1';
    _toursPage++;
    final resp = await http.get(
      url
      // headers: {
      //   //'page': _toursPage.toString(),
      //   //'items': '5'
      // }
    );

    final decodedResp = json.decode(resp.body);
    print(decodedResp['comments']);

    //final comentarios = Comentario.fromJsonList(decodedResp['comments']);

    return decodedResp;
  }

  /*Future<Map<String,dynamic>> traducir(String codeLanguage,String texto)async{
    String url = 'https://translation.googleapis.com/language/translate/v2';

    //?target=$codeLanguage&key=AIzaSyAAw4woNIssZ0P5Lonws9W-9LTRHRCMyqc&q=$texto

    final response = await http.post(
      url,
      body: {
        "key" : "AIzaSyAAw4woNIssZ0P5Lonws9W-9LTRHRCMyqc",
        "q" : "$texto",
        "target" : "$codeLanguage"
      }
    );
    final decodedResp = json.decode(response.body);
    //print(decodedResp['data']['translations'][0]['translatedText']);
    //String traductor = decodedResp['data']['translations'][0]['translatedText'].toString();

    return decodedResp;

  }*/

  Future<Map<String,dynamic>> traducir(String codeLanguage,String texto)async{
   // String url = 'https://translation.googleapis.com/language/translate/v2';
   String url = 'translation.googleapis.com';
   var response;

    //?target=$codeLanguage&key=AIzaSyAAw4woNIssZ0P5Lonws9W-9LTRHRCMyqc&q=$texto
    response = Uri.https(
      url, 
      '/language/translate/v2',
      {
        "key" : "AIzaSyAAw4woNIssZ0P5Lonws9W-9LTRHRCMyqc",
        "q" : "$texto",
        "target" : "$codeLanguage"
      }
    );

    /*final response = await http.post(
      url,
      body: {
        "key" : "AIzaSyAAw4woNIssZ0P5Lonws9W-9LTRHRCMyqc",
        "q" : "$texto",
        "target" : "$codeLanguage"
      }
    );*/
    // try{
      
    // }catch(error){
      
    //   return error;
    // }
    //final respuesta = await http.get(response);
    //final decodedResp = json.decode(respuesta.body);
   // print("Traducción: $decodedResp");
    //print(decodedResp['data']['translations'][0]['translatedText']);
    //String traductor = decodedResp['data']['translations'][0]['translatedText'].toString();

    //return decodedResp;
    final respuesta = await http.get(response);
    final decodedResp = json.decode(respuesta.body);
    //print("Traducción: $decodedResp");

    return decodedResp;

  }

  Future<Map<String,dynamic>> traducirFull(String codeLanguage,String texto)async{
    String url = 'translation.googleapis.com';
    var response;
    response = Uri.https(
      url, 
      '/language/translate/v2',
      {
        "key" : "AIzaSyAAw4woNIssZ0P5Lonws9W-9LTRHRCMyqc"
      }
    );

    final respuesta = await http.post(
      response,
      body: {
        "q" : "$texto",
        "model": "base",
        "target": "$codeLanguage"
      }
    );

    final decodedResp = json.decode(respuesta.body);
    //print(decodedResp);
    return decodedResp;

  }

  Future<Map<String,dynamic>> detectarIdioma(String texto)async{
    final urlBase = 'translation.googleapis.com';
    //final url = 'https://translation.googleapis.com/language/translate/v2/detect?q=hello&key=AIzaSyAAw4woNIssZ0P5Lonws9W-9LTRHRCMyqc';
    final response = Uri.https(
      urlBase, 
      '/language/translate/v2/detect',{
        "key" : "AIzaSyAAw4woNIssZ0P5Lonws9W-9LTRHRCMyqc",
        "q": texto
      }
    );
    final respuesta = await http.get(response);
    final decodedResp = json.decode(respuesta.body);
    return decodedResp;
  }

  /*Future<Map<String,dynamic>> traducir(String codeLanguage,String texto)async{
    String url = 'https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20200103T211303Z.02d93e9546c4e0db.c439f4b22a7cf9595067c1ac8434e3854ecdddc6&text=$texto&lang=$codeLanguage';

    //?target=$codeLanguage&key=AIzaSyAAw4woNIssZ0P5Lonws9W-9LTRHRCMyqc&q=$texto

    final response = await http.post(
      url,
    );
    final decodedResp = json.decode(response.body);
    print(decodedResp);
    //print(decodedResp['data']['translations'][0]['translatedText']);
    //String traductor = decodedResp['data']['translations'][0]['translatedText'].toString();

    return decodedResp;

  }*/

  Future<List<AddressComponentes>> localizar(String direccion)async{
    String _apikey = 'AIzaSyAAw4woNIssZ0P5Lonws9W-9LTRHRCMyqc';
    String _url = 'https://maps.googleapis.com';
    final url = '$_url/maps/api/geocode/json?address=$direccion&key=$_apikey';
    final respuestaLocalizacion = await procesarRespuestaLocalizar(url);
    return respuestaLocalizacion;
  }

  Future<List<AddressComponentes>> procesarRespuestaLocalizar(String url)async{
    final respuestaLocalizar = await http.get(url);
    final decodedData = json.decode(respuestaLocalizar.body);
    //print(decodedData['results']);
    final localizacion = new ListAddressComponent.fromJsonList(decodedData['results']);
    //print(localizacion.componentes[0].geometry['location']);
    return localizacion.componentes;
  }


 /* Future<List<InfoTour>> buscarToursC(String ctidss,String query) async{
    /*if(_cargando){
      return [];
    }else{
      _cargando = true;
    }*/
    //_tourlistPage++;
    //print('Cargando siguientes...');
    final url = Uri.https(_url, '/tours/$ctidss');
    //a6151c55-8897-434a-acc9-a82c16efbd48
    final respuestaTourC = await _procesarRespuestaBusquedaToursC(url);
    //_toursC.addAll(respuestaTourC);
    //listTourCSink(_toursC);
    //_cargando = false;
    return respuestaTourC;
  }*/

  /*Future<List<InfoTour>> _procesarRespuestaBusquedaToursC(Uri url) async{
    final respuestaTC = await http.get(url);
    final decodedDataTC = json.decode(respuestaTC.body);
    print(decodedDataTC['dataTours']['data']);
    final listaToursC = new ListaToursC.fromJsonList(decodedDataTC['dataTours']['data']);
    //print(listaToursC.itemsTours[1].title);
    return listaToursC.itemsTours;
  }*/

 Future<bool> crearTour(TourModel tour)async{
   String _url = '$urltour/tours/createTour?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiVmljZW50ZSBNaXMiLCJ1c2VyIjoidmluY2VtaXM2MTBAZ21haWwuY29tIiwiaWQiOjEsImlhdCI6MTU3MTMzMTM2OSwiZXhwIjoxNTcxNDE3NzY5fQ.H4n7f-2BvRtT4662uXNWooV-myrDhRbWkbvpv9X6zI0'; //${usuarioProvider.prefs.token}

    /*Map<String, dynamic> datos = {
      "title": "${tour.titulo}",
      "description": "${tour.description}",
      "duration":"${tour.duration}",
      "budget":"${tour.budget}",
      "recommendations":"${tour.recommendations}",
      "idcategory":"${tour.idcategory}",
      "idcountry":"${tour.idcountry}",
      "idstate":"${tour.idstate}",
      "idcity":"${tour.idcity}"
    };*/

    final resp = await http.post(_url,body: tourModelToJson(tour));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  Future<Map<String,dynamic>> waypoints(String lista)async{
    final url = 'https://roads.googleapis.com/v1/snapToRoads?path=$lista&interpolate=true&key=AIzaSyAAw4woNIssZ0P5Lonws9W-9LTRHRCMyqc';
    //https://roads.googleapis.com/v1/snapToRoads?path=-35.27801,149.12958|-35.28032,149.12907|-35.28099,149.12929|-35.28144,149.12984|-35.28194,149.13003|-35.28282,149.12956|-35.28302,149.12881|-35.28473,149.12836&interpolate=true&key=YOUR_API_KEY'
    final resp = await http.get(url);
    final decodedResp = json.decode(resp.body);
    //print("Waypoints: ");
    //print(decodedResp['snappedPoints']);
    return decodedResp;
  }

  Future<Map<String,dynamic>> ruta(String origen,String destino,String puntos)async{
    final url = 'https://maps.googleapis.com/maps/api/directions/json?origin=$origen&destination=$destino&waypoints=$puntos&mode=walking&key=AIzaSyAAw4woNIssZ0P5Lonws9W-9LTRHRCMyqc';
    //optimize:true%7C
    //driving, walking
    //&avoid=highways
    final resp = await http.get(url);
    final decodedResp = json.decode(resp.body);
    //print(decodedResp);
    return decodedResp;
  }

}