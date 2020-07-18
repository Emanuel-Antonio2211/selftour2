import 'package:flutter/material.dart';
import 'package:selftourapp/src/models/tour_categoria_model.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:selftourapp/src/providers/categorias_providers.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';
import 'package:selftourapp/src/widgets/tours_user.dart';

class ToursUserPage extends StatefulWidget {
  @override
  _ToursUserPageState createState() => _ToursUserPageState();
}

class _ToursUserPageState extends State<ToursUserPage> {
  CategoriasProvider _categoriasProvider = CategoriasProvider();
  PreferenciasUsuario _prefs = PreferenciasUsuario();
  //String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNTk0NjYxOTAzLCJleHAiOjE1OTcyNTM5MDN9.oKP10QL24wF8_BbK-bVKcPNXEC38RBVzXvlb2CqFpBI";

  @override
  void initState() {
    super.initState();
    _categoriasProvider.toursUser(_prefs.token);
  }
  
  @override
  Widget build(BuildContext context){
    String noData = AppTranslations.of(context).text('title_nodata');
    String misTours = AppTranslations.of(context).text('title_mis_tours');
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "$misTours".toUpperCase(),
          style: TextStyle(
            fontFamily: 'Point-SemiBold',
            fontWeight: FontWeight.bold
          ),
        ),
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
        elevation: 0.0
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: _categoriasProvider.toursUserStream,
          //initialData: initialData ,
          builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot){
            // {
            //     "resp": {
            //         "title": "TOURS POR USUARIO",
            //         "succes": false,
            //         "msg": "NINGUN TOUR ENCONTRADO"
            //     }
            // }
            if(snapshot.hasData){
              if(snapshot.data['resp']['msg'] == "NINGUN TOUR ENCONTRADO"){
                return Column(
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.28,
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
                final listaToursC = new ListaToursC.fromJsonList(snapshot.data['resp']['tours']);
                return ToursUser(
                  toursUser: listaToursC.itemsTours,
                );
              }
              
            }else{
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.28,
                  ),
                  Center(
                    child: CircularProgressIndicator(),
                  )
                ],
              );
            }
            
          },
        ),
      ),
    );
  }
}