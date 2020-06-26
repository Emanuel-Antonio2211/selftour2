import 'package:flutter/material.dart';
import 'package:selftourapp/src/models/comentario_model.dart';
import 'package:selftourapp/src/models/tour_categoria_model.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:selftourapp/src/providers/categorias_providers.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';

class ComentariosPage extends StatefulWidget {
  @override
  _ComentariosPageState createState() => _ComentariosPageState();
}

class _ComentariosPageState extends State<ComentariosPage> {
  CategoriasProvider categoriasProvider = CategoriasProvider();
  @override
  Widget build(BuildContext context) {
    InfoTour infoTour = ModalRoute.of(context).settings.arguments;
    final size = MediaQuery.of(context).size;
    String noComments = AppTranslations.of(context).text('title_nocomments');
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: categoriasProvider.verTodoComentarios(infoTour.idtour.toString()),
              builder: (context, AsyncSnapshot<Map<String,dynamic>> snapshot){
                final resp = snapshot.data;
                if(snapshot.hasData){
                  //final listaComentarios = snapshot.data;
                  if(resp['comments'] == "SIN COMENTARIOS"){
                    return Column(
                      children: <Widget>[
                        SizedBox(
                          height: size.height * 0.30,
                        ),
                        Center(
                          child: Text(
                            "$noComments",
                            style: TextStyle(
                              fontFamily: 'Point-SemiBold'
                            ),
                          ),
                        )
                      ],
                    );
                  }else{
                    final comentarios = Comentario.fromJsonList(resp['comments']);
                    return Comentarios(
                      comentarios: comentarios.comments
                    );
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
              }
            )
          ],
        ),
      ),
    );
  }

  
}

class Comentarios extends StatefulWidget {
  final List<Comment> comentarios;

  Comentarios({
   @required this.comentarios
  });
  @override
  _ComentariosState createState() => _ComentariosState();
}

class _ComentariosState extends State<Comentarios> {
  CategoriasProvider categoriasProvider = CategoriasProvider();
  PreferenciasUsuario prefs = PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 1.0,
      height: size.height * 0.88,
      child: ListView.builder(
        itemCount: widget.comentarios.length,
        itemBuilder: (context,i){
          return comentario(widget.comentarios[i]);
        }
      ),
    );
  }

  Widget _estrellas(int valoraciones){
    if(valoraciones == 5){
      return Row(
        children: <Widget>[
          Icon(
            Icons.star,
            color: Colors.yellow[700],
          ),
          Icon(
            Icons.star,
            color: Colors.yellow[700],
          ),
          Icon(
            Icons.star,
            color: Colors.yellow[700],
          ),
          Icon(
            Icons.star,
            color: Colors.yellow[700],
          ),
          Icon(
            Icons.star,
            color: Colors.yellow[700],
          ),
        ],
      );
    }else if(valoraciones == 4 ){
      return Row(
        children: <Widget>[
          Icon(
            Icons.star,
            color: Colors.yellow[700],
          ),
          Icon(
            Icons.star,
            color: Colors.yellow[700],
          ),
          Icon(
            Icons.star,
            color: Colors.yellow[700],
          ),
          Icon(
            Icons.star,
            color: Colors.yellow[700],
          ),
          Icon(
            Icons.star_border,
            color: Colors.yellow[700],
          ),
        ],
      ); 
    }else if(valoraciones == 3){
      return Row(
        children: <Widget>[
          Icon(
            Icons.star,
            color: Colors.yellow[700],
          ),
          Icon(
            Icons.star,
            color: Colors.yellow[700],
          ),
          Icon(
            Icons.star,
            color: Colors.yellow[700],
          ),
          Icon(
            Icons.star_border,
            color: Colors.yellow[700],
          ),
          Icon(
            Icons.star_border,
            color: Colors.yellow[700],
          ),
        ],
      );
    }else if(valoraciones == 2){
      return Row(
        children: <Widget>[
          Icon(
            Icons.star,
            color: Colors.yellow[700],
          ),
          Icon(
            Icons.star,
            color: Colors.yellow[700],
          ),
          Icon(
            Icons.star_border,
            color: Colors.yellow[700],
          ),
          Icon(
            Icons.star_border,
            color: Colors.yellow[700],
          ),
          Icon(
            Icons.star_border,
            color: Colors.yellow[700],
          ),
        ],
      );
    }else if(valoraciones == 1 ){
      return Row(
        children: <Widget>[
          Icon(
            Icons.star,
            color: Colors.yellow[700],
          ),
          Icon(
            Icons.star_border,
            color: Colors.yellow[700],
          ),
          Icon(
            Icons.star_border,
            color: Colors.yellow[700],
          ),
          Icon(
            Icons.star_border,
            color: Colors.yellow[700],
          ),
          Icon(
            Icons.star_border,
            color: Colors.yellow[700],
          ),
        ],
      );
    }else{
      return Row(
        children: <Widget>[
          Icon(
            Icons.star_border,
            color: Colors.yellow[700],
          ),
          Icon(
            Icons.star_border,
            color: Colors.yellow[700],
          ),
          Icon(
            Icons.star_border,
            color: Colors.yellow[700],
          ),
          Icon(
            Icons.star_border,
            color: Colors.yellow[700],
          ),
          Icon(
            Icons.star_border,
            color: Colors.yellow[700],
          ),
        ],
      );
    }
  }

  Widget comentario(Comment coment){
    final size = MediaQuery.of(context).size;
    String dia = DateTime.parse(coment.dateComment).toLocal().day.toString();
    String mes = DateTime.parse(coment.dateComment).toLocal().month.toString();
    String anio = DateTime.parse(coment.dateComment).toLocal().year.toString();
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Visibility(
              visible: false,
              child: FutureBuilder(
                future: categoriasProvider.detectarIdioma(coment.commentary),
                //initialData: InitialData,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  final resp = snapshot.data;
                  if(snapshot.hasData){
                    prefs.idiomaComentario = Locale(resp['data']['detections'][0][0]['language']);
                    return null;
                  }else{
                    return Container();
                  }
                  
                },
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  width: size.width * 0.2,
                  height: size.height * 0.1,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        "${coment.imgProfile}"
                      )
                    )
                  ),
                ),
                // CachedNetworkImage(
                //   imageUrl: "${coment.imgProfile}",
                //   //errorWidget: (context, url, error)=>Icon(Icons.error),
                //   //cacheManager: baseCacheManager,
                //   useOldImageOnUrlChange: true,
                //   //width: size.width * 0.2,
                //   fit: BoxFit.fill,
                // ),
                SizedBox(width: size.width * 0.03,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('${coment.name}',
                            style: TextStyle(
                              fontFamily: 'Point-SemiBold',
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold
                          )
                        ),
                        
                      /*prefs.idiomaComentario == prefs.idioma ? Container() : Row(
                          children: <Widget>[
                            botonComments ? FlatButton(
                              onPressed: ()async{
                                /*Map<String,dynamic> respComentarios = await categoriasProvider.traducir(prefs.idioma == null ? 'es':prefs.idioma, comment.dateComment);
                                  comentarios = respComentarios['data']['translations'][0]['translatedText'];*/
                                //_ocultarBotonTraductorComments();
                                setState(() {
                                  
                                });
                                botonComments = false;
                              }, 
                              child: Text(
                                'Traducir',
                                style: TextStyle(
                                  fontFamily: 'Point-SemiBold',
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline
                                ),
                              )
                            ):
                            FlatButton(
                              onPressed: ()async{
                                //_mostrarBotonTraductorComments();
                                setState(() {
                                  
                                });
                                botonComments = true;
                              }, 
                              child: Text(
                                'Idioma original',
                                style: TextStyle(
                                  fontFamily: 'Point-SemiBold',
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline
                                ),
                              )
                            )
                          ],
                        ),
                        */
                      ],
                    ),
                    Text(
                      '$dia/$mes/$anio',
                      style: TextStyle(
                        fontFamily: 'Point-SemiBold',
                        color: Colors.grey[800],
                        fontSize: 12.0
                        ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            _estrellas(coment.value),
            /* Row(
              children: <Widget>[
                Icon(
                  Icons.star,
                  size: 20.0,
                  color: Colors.yellow[700],
                ),
                Icon(
                  Icons.star,
                  size: 20.0,
                  color: Colors.yellow[700],
                ),
                Icon(
                  Icons.star,
                  size: 20.0,
                  color: Colors.yellow[700],
                ),
                Icon(
                  Icons.star,
                  size: 20.0,
                  color: Colors.yellow[700],
                ),
                Icon(
                  Icons.star_half,
                  size: 20.0,
                  color: Colors.yellow[700],
                ),
              ],
            ),*/
            SizedBox(
              height: size.height * 0.01,
            ),
            // Text(
            //   coment.commentary,
            //   style: TextStyle(
            //     fontFamily: 'Point-SemiBold'
            //   )
            // ),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                text:coment.commentary,
              ),
              
              // strutStyle: StrutStyle(
              //   fontFamily: 'Point-SemiBold'
              // ),
            )
            /*FutureBuilder(
              future: categoriasProvider.traducir(prefs.idioma == null ? 'es' : prefs.idioma.toString(), comment.commentary),
              builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot) {
                if(snapshot.hasData){
                  return Text(
                    snapshot.data['data']['translations'][0]['translatedText'].toString(),
                    style: TextStyle(fontFamily: 'Neue Haas Grotesk Display Pro')
                  );
                }else{
                  return Container();
                }
                
              },
            ),*/
            
          ],
        ),
      ),
    );
  }
}