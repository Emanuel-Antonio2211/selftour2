import 'package:flutter/material.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:selftourapp/src/providers/categorias_providers.dart';
import 'package:selftourapp/src/providers/usuario_provider.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';

class TermServPage extends StatefulWidget {
  @override
  _TermServPageState createState() => _TermServPageState();
}

class _TermServPageState extends State<TermServPage> {
  UsuarioProvider _usuarioProvider = UsuarioProvider();
  CategoriasProvider _categoriasProvider = CategoriasProvider();
  PreferenciasUsuario _prefs = PreferenciasUsuario();

  bool mostrarTraductor = true;
  bool mostrarOriginal = false;
  String terminos = '';

  void _mostrarBotonTraductor(){
    setState(() {
      mostrarTraductor = true;
      mostrarOriginal = false;
    });
  }

  void _ocultarBotonTraductor(){
    setState(() {
      
      mostrarOriginal = true;
      mostrarTraductor = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String termserv = AppTranslations.of(context).text('title_termserv');
    String traducir = AppTranslations.of(context).text('title_traducir');
    String textoOriginal = AppTranslations.of(context).text('title_texto_original');
    
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "$termserv".toUpperCase(),
          style: TextStyle(
            fontFamily: 'Point-SemiBold'
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: _usuarioProvider.termConditions(),
          builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if(snapshot.hasData){
              final texto = snapshot.data[0]['terms'].replaceAll(RegExp(r'</br>'),'\n');
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04,vertical: size.width * 0.02),
                child: Column(
                  children: <Widget>[
                    FutureBuilder(
                      future: _categoriasProvider.detectarIdioma(texto.toString()),
                      //initialData: InitialData,
                      builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot) {
                        if(snapshot.hasData){
                          final resp = snapshot.data;
                          _prefs.idiomaTerms = Locale(resp['data']['detections'][0][0]['language']);
                          return Container();
                        }
                        return Container();
                      },
                    ),
                    _prefs.idioma == _prefs.idiomaTerms ? Container():
                    Container(
                      child: Row(
                        children: <Widget>[
                          Visibility(
                            visible: mostrarTraductor,
                            child: FlatButton(
                              padding: EdgeInsets.zero,
                              onPressed: ()async{
                                setState(() {
                                          
                                });
                                Map<String,dynamic> resp = await _categoriasProvider.traducirFull(_prefs.idioma == null ? 'en':_prefs.idioma,snapshot.data[0]['terms'].toString() );
                                terminos = resp['data']['translations'][0]['translatedText'].replaceAll(RegExp(r'</br>'),'\n').toString();
                                _ocultarBotonTraductor();
                              }, 
                              child: Text(
                                "$traducir",
                                style: TextStyle(
                                  fontFamily: 'SourceSansPro-Light',
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline
                                ),
                              )
                            ),
                          ),
                          Visibility(
                            visible: !mostrarTraductor,
                            child: FlatButton(
                              padding: EdgeInsets.zero,
                              onPressed: (){
                                setState(() {
                                          
                                });
                                _mostrarBotonTraductor();
                              }, 
                              child: Text(
                                "$textoOriginal",
                                style: TextStyle(
                                  fontFamily: 'SourceSansPro-Light',
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline
                                ),
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: mostrarTraductor ? "${texto.toString()}":terminos,//mostrarTraductor ? "${texto.toString()}":terminos
                        style: TextStyle(
                          fontFamily: 'SourceSansPro-Light',
                          color: Colors.black
                        )
                      ),
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),
              );
            }else if(snapshot.hasError){
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.34,
                  ),
                  Center(
                    child: Text(
                      "${snapshot.error.toString()}",
                      style: TextStyle(
                        fontFamily: 'Point-SemiBold'
                      ),
                    )
                  )
                ],
              );
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
          },
        ),
      ),
    );
  }
}