import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:selftourapp/src/models/tour_categoria_model.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:selftourapp/src/providers/categorias_providers.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';

class ToursCompradosPage extends StatefulWidget {
  @override
  _ToursCompradosPageState createState() => _ToursCompradosPageState();
}

class _ToursCompradosPageState extends State<ToursCompradosPage> {
  List<InfoTour> comprados = List();
  CategoriasProvider categoriasProvider = CategoriasProvider();
  PreferenciasUsuario prefs = PreferenciasUsuario();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    String comprados = AppTranslations.of(context).text('title_orders');
    final size = MediaQuery.of(context).size;
    String noData = AppTranslations.of(context).text('title_nodata');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          '${comprados.toUpperCase()}',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Point-ExtraBold',
            fontWeight: FontWeight.bold
          ),
        ),
        /*actions: <Widget>[
          FlatButton(
            child: Text('Crear Tour',
              style: TextStyle(
                fontFamily: 'Point',
                color: Colors.white
              ),
            ),
            onPressed: (){},
          )
        ],*/
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: categoriasProvider.toursComprados(),
         // initialData: InitialData,
          builder: (BuildContext context, AsyncSnapshot<List<InfoTour>> snapshot) {
            String errorDatos = AppTranslations.of(context).text('title_errorVacio');

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
                if( snapshot.hasData && snapshot.data.length > 0){
                  final listatour = snapshot.data;
                  print("Tamaño");
                  print(listatour.length);
                  return Comprados(listaComprados: listatour,);
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
                          child: Text(
                            '${errorDatos.toString()}' //errorDatos.toString() snapshot.error.toString()
                          )
                        ),
                      ],
                    ),
                  );
                }
                else{
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
                /*final listatour = snapshot.data;
                //loading = true;
                return Comprados(listaComprados: listatour,);*/
              break;
              case ConnectionState.active:
                if(snapshot.hasData){
                  
                  final listatour = snapshot.data;
                  print("Tamaño");
                  print(listatour.length);
                  return Comprados(listaComprados: listatour,);
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
                }
                else{
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
                //final listatour = snapshot.data;
                //loading = true;
               // return Comprados(listaComprados: listatour,);
              break;
              default:
                return Column(
                  children: <Widget>[
                    SafeArea(
                      child: SizedBox(
                        height: size.height * 0.4,
                      ),
                    ),
                    Center(child: CircularProgressIndicator() ),//Text('$noData')
                  ],
                );
              //break;
            }
            /*if(snapshot.hasData){
              final listatour = snapshot.data;
              loading = true;
              return Comprados(listaComprados: listatour,);
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
            }
            else{
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
            }*/
            
          },
        ),
        )
    );
  }
}

class Comprados extends StatefulWidget {
  final List<InfoTour> listaComprados;
  Comprados({@required this.listaComprados});
  @override
  _CompradosState createState() => _CompradosState();
}

class _CompradosState extends State<Comprados> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.8,
      child: ListView.builder(
        itemCount: widget.listaComprados.length,
        itemBuilder: (context,index){
          return _toursComprados(context, widget.listaComprados[index]);
        },
      ),
    );
  }

  Widget _toursComprados(BuildContext context, InfoTour tour){
    final size = MediaQuery.of(context).size;
    return Card(
      child: Row(
        children: <Widget>[
            ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child:
            /*Image.network(
              tour.picture[0]['url'].toString(),
              width: size.width * 0.5,
              height: size.height * 0.15,
              fit: BoxFit.fill,
              scale: 1.0,
            )*/
            CachedNetworkImage(
              imageUrl: "${tour.url}",
              //errorWidget: (context, url, error)=>Icon(Icons.error),
              //cacheManager: baseCacheManager,
              useOldImageOnUrlChange: true,
              width: size.width * 0.5,
              height: size.height * 0.15,
              fit: BoxFit.fill,
            )
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
    );
  }
}