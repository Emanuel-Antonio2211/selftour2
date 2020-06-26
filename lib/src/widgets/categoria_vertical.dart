import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:selftourapp/src/models/categoria_model.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:selftourapp/src/providers/categorias_providers.dart';
import 'package:translator/translator.dart';

class CategoriaVertical extends StatelessWidget {
  final List<Categoria> categorias;
  final PreferenciasUsuario prefs = PreferenciasUsuario();
  final translator = new GoogleTranslator();

  final CategoriasProvider categoriasProvider = CategoriasProvider();

  final Function siguientePagina;
  CategoriaVertical({@required this.categorias, @required this.siguientePagina});
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _scrollController.addListener((){
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 10){
        //siguientePagina();
      }
    });
    return Container(
      height: size.height * 0.8,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: categorias.length,
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (context,i){
          return categoria(context, categorias[i]);
        },
      ),
    );
  }

  Widget categoria(BuildContext context,Categoria categorias){
    final size = MediaQuery.of(context).size;
    final categoria = Stack(
      children: <Widget>[
        Card(
          child: Stack(
            children: <Widget>[
              ClipRRect(
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
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Container(
                  width: size.width * 1.0,
                  height: size.height * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        Colors.grey.withOpacity(0.1),
                        Colors.black.withOpacity(0.7)
                      ],
                      stops: [
                        0.0,
                        1.0
                      ]
                    )
                  ),
                ),
              ),
            ],
          )
        ),
        Align(
          alignment: Alignment.bottomLeft,
          heightFactor: 10.0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      categorias.nameCategory,
                      style: TextStyle(
                        fontFamily: 'Point-SemiBold',
                        fontSize: 17.0,
                        color: Colors.white
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      "(${categorias.cant.toString()} tours)",
                      style: TextStyle(
                        color: Colors.white,
                        //backgroundColor: Color(0xFF034485),
                        fontFamily: 'Point-SemiBold',
                        fontSize: 18
                      ),
                    )
                  ],
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
  }
}

class CategoriaGrid extends StatelessWidget {
  final List<Categoria> categorias;
  final PreferenciasUsuario prefs = PreferenciasUsuario();
  final translator = new GoogleTranslator();

  final CategoriasProvider categoriasProvider = CategoriasProvider();

  final Function siguientePagina;
  CategoriaGrid({@required this.categorias, @required this.siguientePagina});
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _scrollController.addListener((){
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 10){
        //siguientePagina();
      }
    });
    return Container(
      height: size.height * 0.8,
      child: GridView.builder(
        controller: _scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: categorias.length,
        itemBuilder: (context,i){
          return categoriasGrid(context, categorias[i]);
        },
      ),
    );
  }

  Widget categoriasGrid(BuildContext context,Categoria categoria){
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
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
              width: size.width * 0.5,
              height: size.height * 0.4,
              decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.grey.withOpacity(0.1),
                    Colors.black.withOpacity(0.7)
                  ],
                  stops: [
                    0.0,
                    1.0
                  ]
                )
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    categoria.nameCategory,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Point-SemiBold',
                      color: Colors.white
                    ),
                  ),
                  Text(
                    "(${categoria.cant.toString()} tours)",
                    style: TextStyle(
                      color: Colors.white,
                      //backgroundColor: Color(0xFF034485),
                      fontFamily: 'Point-SemiBold',
                      fontSize: 18
                    ),
                  )
                ],
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
  }
}