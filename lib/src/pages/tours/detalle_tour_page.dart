import 'dart:io';
//import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
//import 'dart:math' as math;
//import 'package:cached_network_image/cached_network_image.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
//import 'package:flutter/services.dart';
//import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
//import 'package:flutter_polyline_points/flutter_polyline_points.dart';
//import 'package:flutter_cache_manager/flutter_cache_manager.dart';
//import 'package:flutter_advanced_networkimage/provider.dart';
//import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
//import 'package:flutter_share/flutter_share.dart';
//import 'package:intro_views_flutter/UI/pager_indicator.dart';
//import 'package:native_share/native_share.dart';
//import 'package:flutter_share_content/flutter_share_content.dart';
import 'package:selftourapp/src/models/comentario_model.dart';
import 'package:selftourapp/src/pages/login/sesion_page_chat.dart';
import 'package:selftourapp/src/pages/login/sesion_page_comentario.dart';
//import 'package:selfttour/src/pages/login/sesion_page.dart';
import 'package:selftourapp/src/pages/login/sesion_page_compra.dart';
import 'package:selftourapp/src/pages/login/sesion_page_favorito.dart';
//import 'package:selfttour/src/pages/pagos/pagos_page.dart';
import 'package:selftourapp/src/pages/usuario/comentario_form_page.dart';
import 'package:selftourapp/src/pages/usuario/usuarios_chat_page.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:share/share.dart';
//import 'package:selfttour/src/googlemaps/states/app_state.dart';
//import 'package:selfttour/src/models/detalle_tour_model.dart';
import 'package:selftourapp/src/models/tour_categoria_model.dart';
import 'package:selftourapp/src/providers/categorias_providers.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';
import 'package:selftourapp/src/widgets/informacion_tour.dart';

class DetalleTourPage extends StatefulWidget {
  @override
  _DetalleTourPageState createState() => _DetalleTourPageState();
}

class _DetalleTourPageState extends State<DetalleTourPage> with SingleTickerProviderStateMixin{
    //with SingleTickerProviderStateMixin
  final prefs = new PreferenciasUsuario();
  CategoriasProvider categoriasProvider = CategoriasProvider();
  TabController controller;
  //bool loading = false;

  ScrollController _scrollController;
  double offset = 0.0 ;
  Key sliver1;
  Key sliver2;
  //Color colorBlanco;
  bool lastStatus = true;
  //bool _innerListIsScrolled = false;


  scrollListener(){
    if(isShrink != lastStatus){
      setState(() {
        lastStatus = isShrink;
        
      });
    }
    /*setState(() {
      offset = _scrollController.offset;
    });*/
    
  }

  bool get isShrink{
    if (!_scrollController.hasClients || _scrollController.positions.length > 1){
      return false;
    }
        
    return _scrollController.hasClients && _scrollController.offset > (200.0 - kToolbarHeight);
  }
  

  @override
  void initState() {
    
    super.initState();
    
    _scrollController = ScrollController();
    //_scrollController.animateTo(_scrollController.position.minScrollExtent, duration: Duration(milliseconds: 1000) , curve: Curves.decelerate);
    //_scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    _scrollController.addListener(scrollListener);
   // _scrollController.addListener(_updateScrollPosition);
    // Initialize the Tab Controller
    controller = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // Dispose of the Tab Controller
    controller.dispose();
    //_scrollController.dispose();
    _scrollController.removeListener(scrollListener);
    //_scrollController.removeListener(_updateScrollPosition);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    InfoTour tour = ModalRoute.of(context).settings.arguments;
    //InfoTour tour = new InfoTour();
    final size = MediaQuery.of(context).size;
    
    //categoriasProvider.getToursId(tour.idtour);
    // bool guardado = listaTourGuardado.contains(tour);

    String detalles = AppTranslations.of(context).text('title_details');
    String opiniones = AppTranslations.of(context).text('title_opinions');
    String ubicacion = AppTranslations.of(context).text('title_location');
    //final _kTabs = [detalles, opiniones,ubicacion];
    /*final Widget tabBar = TabBar(
        tabs: _kTabs.map<Widget>((String name) => Tab(text: name)).toList());*/
    
    return Scaffold(
      body: 
      
      /*Stack(
        children: <Widget>[
        /*Container(
          width: size.width * 1.0, //420.0
          height: size.height * 0.33, //280.0
          child:
              Image.asset('assets/images/appbarprofile.png', fit: BoxFit.fill),
          //color: Colors.pink,
        ),*/
        
      ]),*/
      FutureBuilder(
          future: categoriasProvider.getToursId(tour.idtour),//categoriasProvider.getToursId(tour.idtour)
          builder: (BuildContext context, AsyncSnapshot<List<InfoTour>> snapshot) {
            //String redSocial = AppTranslations.of(context).text('title_red_social');
            //String noData = AppTranslations.of(context).text('title_nodata');
            
            if(snapshot.hasData){
              return Scaffold(
                backgroundColor: Colors.white,
                body: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
                    return <Widget>[
                      SliverAppBar(
                        leading: IconButton(
                          color: isShrink ? Colors.black:Colors.white, //Colors.black
                            icon: Icon(Icons.arrow_back),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                        ),
                        
                        automaticallyImplyLeading: false,
                        elevation: 0.0,
                        //key: sliver1,
                        //automaticallyImplyLeading: false,
                        backgroundColor: Colors.white,
                        //snap: true,
                        primary: true,
                        floating: false,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          titlePadding: EdgeInsets.symmetric(horizontal: 70.0),
                          collapseMode: CollapseMode.parallax,
                          centerTitle: true,
                          title: Container(
                            width: size.width * 1.0,
                            height: isShrink ? size.height * 0.08 :  size.height * 0.25,
                            //color: Colors.grey,
                            child: Stack(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.center,
                                  //heightFactor: 14.0,
                                  child: Text(
                                    snapshot.data.single.title,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: isShrink ? Colors.black : Colors.white,
                                        fontSize: 13.0,
                                        fontFamily: 'Point-SemiBold',
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    snapshot.data.single.price == null ? 'N / A': ' \$ ${double.parse(snapshot.data.single.price.toString()).toString()}',
                                    style: TextStyle(
                                      fontFamily: 'Point-SemiBold',
                                      fontSize: 13.0,
                                      color: isShrink ? Colors.transparent: Colors.white
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                          
                          /*Stack(
                            children: [

                             /* Container(
                                color: Colors.grey,
                                padding: EdgeInsets.only(top: 5.0,left: 10.0),
                                width: size.width * 0.8,
                                height: size.height * 0.15,
                                child: 
                              ),*/
                              Align(
                                alignment: Alignment.bottomCenter,
                                heightFactor: 14.0,
                                child: Text(
                                  snapshot.data.single.title,
                                  style: TextStyle(
                                    color: isShrink ? Colors.black : Colors.white,
                                      fontSize: 13.0,
                                      fontFamily: 'Point-SemiBold',
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  snapshot.data.single.price == null ? 'N / A': ' \$ ${snapshot.data.single.price.toString()} .00',
                                  style: TextStyle(
                                    fontFamily: 'Point-SemiBold',
                                    fontSize: 13.0,
                                    color: isShrink ? Colors.transparent: Colors.white
                                  ),
                                ),
                              ),
                            ]
                          ),*/,
                          background: Container(
                              width: size.width * 1.0, //250.0
                              height: size.height * 0.34, //300.0
                              child: _fotosSitio(context,snapshot.data.single)
                          ),
                        ),
                        
                        expandedHeight: size.height * 0.35,//size.height * 0.35
                        actions: <Widget>[
                          
                          IconButton(
                            icon: Platform.isIOS ? Icon(Icons.open_in_browser,color: isShrink ? Colors.black:Colors.white,):Icon(Icons.share,color: isShrink ? Colors.black:Colors.white,),
                            onPressed: ()async{
                              final DynamicLinkParameters parameters = DynamicLinkParameters(
                                uriPrefix: 'https://selftourtravel.page.link',//https://selftourtravel.page.link    https://selftour.travel
                                /*navigationInfoParameters: NavigationInfoParameters(
                                  forcedRedirectEnabled: true
                                ),*/
                                /*googleAnalyticsParameters: GoogleAnalyticsParameters(

                                ),*/ // ?${snapshot.data.single.idtour.toString()}
                                link: Uri.parse('https://selftourtravel.page.link/detalletour/?${snapshot.data.single.idtour.toString()}'),//https://www.selftour.travel
                                androidParameters: AndroidParameters(
                                  //fallbackUrl: Uri.parse('https://www.selftour.travel'),
                                  //fallbackUrl: Uri.parse('https://selftourtravel.page.link/detalletour/?${snapshot.data.single.idtour.toString()}'),
                                  packageName: 'travel.selftour.selftour',
                                  minimumVersion: 21
                                ),
                                iosParameters: IosParameters ( 
                                    //fallbackUrl: Uri.parse('https://selftourtravel.page.link/detalletour?${snapshot.data.single.idtour.toString()}'),
                                    bundleId: 'travel.selftour.selftour',
                                    minimumVersion: '1.0.1',
                                    appStoreId: '1489659850',
                                ),
                                socialMetaTagParameters:  SocialMetaTagParameters(
                                  title: snapshot.data.single.title,
                                  description: snapshot.data.single.description,
                                  imageUrl: Uri.parse(snapshot.data.single.route[0]['gallery'][0]['url'])
                                ), 
                              );

                              //final Uri dynamicUrl = await parameters.buildUrl();
                              final ShortDynamicLink shortDynamicLink = await parameters.buildShortLink();
                              final Uri shortUrl = shortDynamicLink.shortUrl;
                              Share.share(
                                shortUrl.toString(),
                                subject: '${tour.title}'
                              );

                            /*  await FlutterShare.share(
                                  title: '${snapshot.data.single.description}',
                                  text: '${snapshot.data.single.description}',
                                  linkUrl: '$dynamicUrl',
                                  //chooserTitle: '${snapshot.data.single.title}'
                                );*/

                             // NativeShare.share({'title':'${snapshot.data.single.description}','url':'$dynamicUrl','image':null}); //'image':'${snapshot.data.single.route[0]['gallery'][0]['url']}'
                              //Share.share('check out my website https://example.com');
                            },
                          ),
                          /*IconButtonFavorite(
                            icon: snapshot.data.single.favorite == 1 ? Icons.favorite : Icons.favorite_border,
                            select: snapshot.data.single.favorite,
                            onClick: ()async{
                              if(prefs.iduser == ''){
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context){
                                    return SesionPageFavorito();
                                  }
                                ));
                              }else{
                                setState(() {
                                  snapshot.data.single.favorite = snapshot.data.single.favorite;
                                });
                                
                                if(snapshot.data.single.favorite == 1){
                                  categoriasProvider.removerFavorito(prefs.iduser,snapshot.data.single.idtour.toString());
                                  setState(() {
                                    
                                  });
                                 
                                }else{
                                  categoriasProvider.marcarFavorito(snapshot.data.single.idtour.toString());
                                  setState(() {
                                    
                                  });
                                 
                                }
                              }
                            },
                          )*/
                        IconButton(
                            iconSize: 30.0,
                            color: (snapshot.data.single.favorite == 1 && ( prefs.iduser != "")) ? Colors.red : null,
                            icon: Icon((snapshot.data.single.favorite == 1 && ( prefs.iduser != "")) ? Icons.favorite : Icons.favorite_border,color: (snapshot.data.single.favorite == 1 && ( prefs.iduser != null && prefs.iduser != "") || isShrink) ? Colors.red : Colors.white,),
                            onPressed: () async {
                              
                            if( prefs.email == '' || prefs.iduser == '' || prefs.token == ''){
                              
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context){
                                  return SesionPageFavorito();
                                }
                              ));
                              
                            }else{
                              
                              if(snapshot.data.single.favorite == 1){
                                
                                await categoriasProvider.removerFavorito(prefs.iduser,snapshot.data.single.idtour.toString());
                                }else{
                                  
                                 await categoriasProvider.marcarFavorito(snapshot.data.single.idtour.toString());
                                }
                              }
                              setState(() {
                                snapshot.data.single.favorite = snapshot.data.single.favorite;
                              });
                            },
                          )
                        ],
                       // forceElevated: innerBoxIsScrolled
                      ),
                      SliverToBoxAdapter(
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: size.width * 0.7,
                                    height: size.height * 0.35,
                                    child: _detalleTour(context, snapshot.data.single)
                                  ),
                                  Container(
                                    width: size.width * 0.3,
                                    height: size.height * 0.2,
                                    child: _datosCreadorTour(context, snapshot.data.single),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.03,
                                child: Container(
                                  padding: EdgeInsets.only(left: 10.0, right: 20.0),
                                  child: Divider(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  _botonesOpcionesUsuario(context,snapshot.data.single)
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                                child: Container(
                                  padding: EdgeInsets.only(left: 10.0, right: 20.0),
                                  child: Divider(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),//prefs.iduser != snapshot.data.single.iduser.toString()
                              prefs.email != snapshot.data.single.userData['mail']  && prefs.comprado != 'true' ? Column(
                              children: <Widget>[
                                //_botonesOpcionesUsuario(context,snapshot.data.single),
                                SizedBox(),
                               _botonEnlace(context),
                              ],
                            ) :Container(),
                               
                              /* SizedBox(
                                height: size.height * 0.03,
                                child: Container(
                                  padding: EdgeInsets.only(left: 10.0, right: 20.0),
                                  child: Divider(
                                    color: Colors.grey,
                                    ),
                                  ),
                              ),*/
                              
                             /*   _tituloInformacion(),
                              SizedBox(
                                height: size.height * 0.03,
                              ),*/
                             /* _parrafoInformacion(context,snapshot.data.single),
                              SizedBox(
                                height: size.height * 0.04,
                                child: Container(
                                  padding: EdgeInsets.only(left: 10.0, right: 20.0),
                                  child: Divider(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),*/
                             /* _ubicacionTour(context,snapshot.data.single),
                              SizedBox(
                                height: size.height * 0.04,
                                child: Container(
                                  padding: EdgeInsets.only(left: 10.0, right: 20.0),
                                  child: Divider(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),*/
                             /* _opiniones(context),
                              SizedBox(
                                height: size.height * 0.06,
                                child: Container(
                                  padding: EdgeInsets.only(left: 10.0, right: 20.0),
                                  child: Divider(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              _comentarios(context),*/
                            ],
                          ),
                          
                          /*Container(
                              height: 50, child: Center(child: Text('I\'m a regular widget'))),*/
                        ),
                        SliverAppBar(
                          backgroundColor: Colors.white,
                          automaticallyImplyLeading: false,
                          //titleSpacing: NavigationToolbar.kMiddleSpacing,
                         // key: sliver2,
                          //title: Text('I\'m a sticky app bar'),
                          floating: false,
                          snap: false,
                          pinned: false,
                          primary: false,
                          bottom: TabBar(
                            labelColor: Colors.grey,
                            controller: controller,
                            tabs: <Widget>[
                              Tab(
                                //text: '$detalles',
                                child: Text(detalles,style: TextStyle(fontFamily: 'Point-SemiBold'),),
                                //icon: Icon(Icons.map),
                              ),
                              Tab(
                                //text: '$opiniones',
                                child: Text(opiniones,style: TextStyle(fontFamily: 'Point-SemiBold'),),
                                //icon: Icon(Icons.markunread),
                              ),
                              Tab(
                                //text: '$ubicacion',
                                child: Text(ubicacion,style: TextStyle(fontFamily: 'Point-SemiBold'),),
                                //icon: Icon(Icons.markunread),
                              ),
                            ],
                          ),
                         // forceElevated: innerBoxIsScrolled
                        ),
                    ];
                  },
                  body: TabBarView(
                            physics: ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                            controller: controller,
                            children:<Widget>[ 
                              /*SingleChildScrollView(
                                
                                child: Column(
                                  children: <Widget>[
                                    
                                  ],
                                ),
                              ),*/

                              _parrafoInformacion(context, snapshot.data.single),
                              
                              /*SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    _opiniones(context),
                                    _comentariosUsuarios(context,snapshot.data.single)
                                  ],
                                ),
                              ),*/
                              _comentariosUsuarios(context,snapshot.data.single),
                             
                              SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    _ubicacionTour(context, snapshot.data.single)
                                  ],
                                ),
                              )
                            ]
                          ),
                  
                  /*SliverFillRemaining(
                          fillOverscroll: true,
                          hasScrollBody: true,
                          child: 
                        ),*/
                  scrollDirection: Axis.vertical,
                   /* slivers: <Widget>[
                      
                     /* SliverList(
                        delegate: SliverChildDelegate(

                        ),
                      )*/
                      /* SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context,index)=>Container(
                              color: getRandomColor(),
                            ),
                            childCount: 99
                          ),
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 50,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0,
                          ),
                        ),*/
                        
                        
                        
                  ],*/
            ),
            bottomSheet: isShrink ? Container(
        color: Colors.white,
        width: size.width * 1.0,
        height: size.height * 0.07,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: botonEnviarMensaje(context, snapshot.data.single)
            ),
            botonComprar(context, snapshot.data.single )
          ],
        )
      ):null,
              );
            }else{
              return Column(
                  children: <Widget>[
                    SafeArea(
                      child: SizedBox(
                        height: size.height * 0.4,
                      ),
                    ),
                    Center(child: CircularProgressIndicator())
                  ],
              );
              
            }
          },
        ),
    );
  }


   Widget _fotosSitio(BuildContext context,InfoTour detalle){
    var size = MediaQuery.of(context).size;
    //final BaseCacheManager baseCacheManager = DefaultCacheManager();
    //InfoTour tour = ModalRoute.of(context).settings.arguments;
    //DetalleTour tour = new DetalleTour();

    List<String> imagenes = List();
    for(int i = 0; i < detalle.route.length; i++){
      for(int j = 0; j<detalle.route[i]['gallery'].length;j++){
        imagenes.addAll([
          detalle.route[i]['gallery'][j]['url']
        ]);
      }
      //print(imagenes);
    }
    return Container(
        child: Swiper(
        autoplay: false,
       // pageSnapping: false,
       /* controller: PageController(
          viewportFraction: 1.0,
        ),*/
        itemCount: imagenes.length,
        itemBuilder: (BuildContext context,i){
          //tour.gallery[i] = '${tour.gallery[i]}-tarjeta';
          return GestureDetector(
            onTap: (){
             //Navigator.pushNamed(context, 'galeriatour');
             /* Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                return GaleriaTourPage();
              },fullscreenDialog: true));*/
            },
            child: Card(
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: 
                    /*Image.network(
                      "${imagenes[i]}",
                      scale: 1.0,
                      fit: BoxFit.fill
                    )*/

                    CachedNetworkImage(
                      imageUrl: "${imagenes[i]}",
                      //errorWidget: (context, url, error)=>Icon(Icons.error),
                      //cacheManager: baseCacheManager,
                      useOldImageOnUrlChange: true,
                      width: size.width * 1.0,//size.width * 0.8,
                      height: size.height * 0.5, //size.height * 0.23
                      fit: BoxFit.fill
                    )
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Container(
                      height: size.height * 0.5,
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
          );
        },
        /*pagination: SwiperPagination(
          margin: EdgeInsets.only(top: 10.0,left: 10.0,bottom: 5.0),
          alignment: Alignment.bottomLeft,
          builder: SwiperPagination.fraction
        ),*/
        control: SwiperControl(
          size: 20.0,
          color: Colors.white
        ),
      ),
    );
    
   /* ListView.builder(
      scrollDirection: Axis.horizontal,
      
      itemCount: tour.gallery.length,
      itemBuilder: (BuildContext context,i){
        return Card(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: FadeInImage(
              image: NetworkImage(tour.gallery[i]),
              placeholder: AssetImage('assets/jar-loading.gif'),
              fit: BoxFit.fill,
              width: size.width * 0.5,
              height: size.height * 0.2,
            ),
          ),
        );
      }
    );*/
  }

  bool mostrarTraductor = true;
  bool mostrarOriginal = false;
  bool mostrarTraduccion = false;
  String activity='';
  String category = '';
  String dificulty = '';
  String duration = '';
  String dayDisp = '';
  String clasif = '';

  void _mostrarElemento(){
    setState(() {
      mostrarTraductor = true;
      mostrarOriginal = false;
      mostrarTraduccion = false;
    });
  }

  void _ocultarElemento(){
    setState(() {
      mostrarTraductor = false;
      mostrarOriginal = true;
      mostrarTraduccion = true;
    });
  }

  Widget _detalleTour(BuildContext context,InfoTour detalle){
  final size = MediaQuery.of(context).size;
  //String valoracion = AppTranslations.of(context).text('title_valoracion');
  String duracion = AppTranslations.of(context).text('title_duration');
  String categoria = AppTranslations.of(context).text('title_categori');
  String mainActivity = AppTranslations.of(context).text('title_mainactivity');
  String dificultad = AppTranslations.of(context).text('title_dificultad');
  String diadisp = AppTranslations.of(context).text('title_diasdisponibles');
  String clasificacion = AppTranslations.of(context).text('title_clasificacion');
  //String temporada = AppTranslations.of(context).text('title_temporada');
  String traducir = AppTranslations.of(context).text('title_traducir');
  String textoOriginal = AppTranslations.of(context).text('title_texto_original');
  
  return Padding(
    padding: EdgeInsets.only(left: 10.0),
    child: Column(
      children: <Widget>[
        FutureBuilder(
            future: categoriasProvider.detectarIdioma('${detalle.characteristics['main_activity']}'.toLowerCase()),
            //initialData: InitialData,
            builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot) {
              
              if(snapshot.hasData){
                final resp = snapshot.data;
                //print(resp);
                prefs.idiomaDetalle = Locale(resp['data']['detections'][0][0]['language']);
                //print("Idioma detalle");
                //print(prefs.idiomaDetalle);
                //print(prefs.idioma);
                return Container();
              }else{
                return Container();
              }
              
            },
          ),
        prefs.idioma == prefs.idiomaDetalle ? Container(
          height: 30.0
        ) :
        Row(
          children: <Widget>[
            Visibility(
              visible: mostrarTraductor,
              child: Container(
                alignment: Alignment.centerLeft,
                child: FlatButton(
                  onPressed: ()async{
                    Map<String,dynamic> resp = await categoriasProvider.traducir(prefs.idioma == null ? 'es':prefs.idioma, detalle.characteristics['main_activity']);
                    activity = resp['data']['translations'][0]['translatedText'];
                    Map<String,dynamic> respCategory = await categoriasProvider.traducir(prefs.idioma == null ? 'es':prefs.idioma, detalle.characteristics['category']);
                    category = respCategory['data']['translations'][0]['translatedText'];
                    Map<String,dynamic> respDificulty = await categoriasProvider.traducir(prefs.idioma == null ? 'es':prefs.idioma, detalle.characteristics['difficulty']);
                    dificulty = respDificulty['data']['translations'][0]['translatedText'];
                    Map<String,dynamic> respDuration = await categoriasProvider.traducir(prefs.idioma == null ? 'es' : prefs.idioma, detalle.duration['duration']);
                    duration = respDuration['data']['translations'][0]['translatedText'];
                    Map<String,dynamic> respDayDisp = await categoriasProvider.traducir(prefs.idioma == null ? 'es':prefs.idioma, (detalle.temporada['days'].length < 54 ? detalle.temporada['days'] : 'All-Week'));
                    //print("Dias disponibles");
                    //print(respDayDisp);
                    dayDisp = respDayDisp['data']['translations'][0]['translatedText'];
                    Map<String,dynamic> respClasif=await categoriasProvider.traducir(prefs.idioma == null ? 'es' : prefs.idioma, detalle.characteristics['appropiate_to']);
                    clasif = respClasif['data']['translations'][0]['translatedText'];
                    _ocultarElemento();
                  }, 
                  child: Text(
                    traducir,
                    style: TextStyle(
                      fontFamily: 'Point-SemiBold',
                      color: Colors.blue,
                      decoration: TextDecoration.underline
                    ),
                  )
                ),
              ),
            ),
            Visibility(
              visible: mostrarOriginal,
              child: Container(
                alignment: Alignment.centerLeft,
                child: FlatButton(
                  onPressed: ()async{
                    _mostrarElemento();
                  }, 
                  child: Text(
                    textoOriginal,
                    style: TextStyle(
                      fontFamily: 'Point-SemiBold',
                      color: Colors.blue,
                      decoration: TextDecoration.underline
                    ),
                  )
                ),
              ),
            ),
          ],
        ),
        
        Row(
          children: <Widget>[
            Icon(
              Icons.place,
              color: Color(0xFFD62250),
            ),
            SizedBox(
              width: size.width * 0.02,
            ),
            Flexible(
              child: Text(
                '${detalle.city.toString()}',//${detalle.state.toString()} ${detalle.country.toString()}
                style: TextStyle(
                    fontSize: 13.0,
                    fontFamily: 'Point-SemiBold',
                ),
              ),
            )
          ],
        ),
        
        Row(
          children: <Widget>[
            Icon(
              Icons.accessibility,
              color: Color(0xFFD62250),
            ),
            SizedBox(
              width: size.width * 0.02,
            ),
            Text(
              '$mainActivity: ',
              style: TextStyle(
                fontFamily: 'Point-SemiBold'
              )
            ),
            mostrarTraduccion ? Text(
              '$activity'.toLowerCase(),
              style: TextStyle(
                fontFamily: 'Point-SemiBold',
                fontSize: 12.5,
                color: Colors.grey[700]),
            ):
            Text(
              '${detalle.characteristics['main_activity']}'.toLowerCase(),
              style: TextStyle(
                fontFamily: 'Point-SemiBold',
                fontSize: 12.5,
                color: Colors.grey[700]),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Icon(
              Icons.category,
              color: Color(0xFFD62250),
            ),
            SizedBox(
              width: size.width * 0.02,
            ),
            Text('$categoria: ', style: TextStyle(fontFamily: 'Point-SemiBold'),),
            mostrarTraduccion ? Text(
              category,
              style: TextStyle(
                fontFamily: 'Point-SemiBold',
                fontSize: 12.5
              ),
            ) :Text(
              detalle.characteristics['category'],
              style: TextStyle(
                fontFamily: 'Point-SemiBold',
                fontSize: 12.5
              ),
            ),
            /*FutureBuilder(
              future: categoriasProvider.traducir(prefs.idioma == null ? 'es' : prefs.idioma.toString(), detalle.category),
              builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot) {
                if(snapshot.hasData){
                  return Text(
                    snapshot.data['data']['translations'][0]['translatedText'].toString(),
                    style: TextStyle(fontFamily: 'Point-SemiBold'),);
                }else{
                  return Container();
                }
                
              },
            ),*/
            
          ],
        ),
        Row(
          children: <Widget>[
            Icon(
              Icons.fitness_center,
              color: Color(0xFFD62250),
            ),
            SizedBox(
              width: size.width * 0.02,
            ),
            Text(
              '$dificultad: ',
              style: TextStyle(
                fontFamily: 'Point-SemiBold'
              )
            ),
            mostrarTraduccion ? Text(
              dificulty,
              style: TextStyle(
                  fontFamily: 'Point-SemiBold',
                  fontSize: 12.5,
                  color: Colors.grey[700]
                ),
              ) : Text(
              '${detalle.characteristics['difficulty']}',
              style: TextStyle(
                  fontFamily: 'Point-SemiBold',
                  fontSize: 12.5,
                  color: Colors.grey[700]),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Icon(
              Icons.schedule,
              color: Color(0xFFD62250),
            ),
            SizedBox(
              width: size.width * 0.02,
            ),
            Text(
              '$duracion: ',
              style: TextStyle(
                fontFamily: 'Point-SemiBold'
              )
            ),
            mostrarTraduccion ? Text(
              duration,
              style: TextStyle(
                fontFamily: 'Point-SemiBold',
                fontSize: 12.5,
                color: Colors.grey[700]),
            ):Text(
              detalle.duration['duration'],
              style: TextStyle(
                  fontFamily: 'Point-SemiBold',
                  fontSize: 12.5,
                  color: Colors.grey[700]),
            )
          ],
        ),
        Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.calendar_today,
                  color: Color(0xFFD62250),
                ),
                SizedBox(
                  width: size.width * 0.02,
                ),
                Text(
                  '$diadisp: ',
                  style: TextStyle(
                    fontFamily: 'Point-SemiBold'
                  )
                ),
              ],
            ),
            mostrarTraduccion ? Text(  
              dayDisp,
              style: TextStyle(
                fontFamily: 'Point-SemiBold',
                fontSize: 12.5,
                color: Colors.grey[700]
              ),
            ) : Text(  
              detalle.temporada['days'].length < 54 ? '${detalle.temporada['days']}' : 'All-Week',
              style: TextStyle(
                fontFamily: 'Point-SemiBold',
                fontSize: 12.5,
                color: Colors.grey[700]
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Icon(
              Icons.person,
              color: Color(0xFFD62250),
            ),
            SizedBox(
              width: size.width * 0.02,
            ),
            Text(
              '$clasificacion: ',
              style: TextStyle(
                fontFamily: 'Point-SemiBold'
              )
            ),
            mostrarTraduccion ? Text(
              clasif,
              style: TextStyle(
                  fontFamily: 'Point-SemiBold',
                  fontSize: 12.5,
                  color: Colors.grey[700]),
            ) : Text(
              '${detalle.characteristics['appropiate_to']}',
              style: TextStyle(
                  fontFamily: 'Point-SemiBold',
                  fontSize: 12.5,
                  color: Colors.grey[700]),
            )
          ],
        ),
      ],
    ),
  );
}

  Widget _datosCreadorTour(BuildContext context, InfoTour detalle){
    //final size = MediaQuery.of(context).size;
    //String enviarMensaje = AppTranslations.of(context).text('title_send_message');
    //String verMensaje = AppTranslations.of(context).text('title_show_message');
    //prefs.iduser = '';
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CircleAvatar(
          radius: 30.0,
          backgroundImage: detalle.userData['img_profile'] == null ? NetworkImage('https://fotos00.levante-emv.com/mmp/2018/11/20/328x206/errores-sacar-fotos.jpg'):NetworkImage(detalle.userData['img_profile'])
        ),
        Container(
          child: Text(
            detalle.userData['name'] == null ? 'N / A':detalle.userData['name'],
            textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily:
                      'Point-ExtraBold',//Neue Haas Grotesk Display Pro
                      fontSize: 12.0
            )
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 6.0),
          child: Text(
            'Tour Maker',
            style: TextStyle(
            fontSize: 12.0,
            color: Colors.black,
            fontFamily: 'Point-SemiBold',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30.0),//prefs.iduser != detalle.iduser.toString()
          child: prefs.email != detalle.userData['mail'] && prefs.idtour != detalle.idtour.toString() ? 
          Row(
            children: <Widget>[
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  width: 25.0,
                  height: 17.0,
                  child: Image.asset(
                    'assets/facebook@3x.png',
                    color: Colors.grey,
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  width: 25.0,
                  height: 17.0,
                  child: Image.asset(
                    'assets/logotwitter.png',
                    color: Colors.grey,
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  width: 25.0,
                  height: 17.0,
                  child: Image.asset(
                    'assets/google@3x.png',
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          ) : Row(
            children: <Widget>[
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  width: 25.0,
                  height: 17.0,
                  child: Image.asset(
                    'assets/facebook@3x.png',
                    color: Colors.blue,
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  width: 25.0,
                  height: 17.0,
                  child: Image.asset('assets/logotwitter.png'),
                ),
              ),
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  width: 25.0,
                  height: 17.0,
                  child: Image.asset('assets/google@3x.png'),
                ),
              )
            ],
          ),
        )
       /* SizedBox(
          height: size.height * 0.02,
        ),*/
       /* prefs.iduser != detalle.iduser.toString() ?
        Container(
          width: size.width * 0.3,
          height: size.height * 0.04,
          child: RaisedButton(
              color: Color(0xFFD62250),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              textTheme: ButtonTextTheme.accent,
              child: Text('$enviarMensaje',
              style: TextStyle(
                fontFamily: 'Point-SemiBold',
                fontSize: 9.0,
                color: Colors.white)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context){
                      return SesionPageChat();
                    },
                    settings: RouteSettings(arguments: detalle),
                    //fullscreenDialog: true
                  ));
                },
          ),
        ) : Container(
          width: size.width * 0.3,
          height: size.height * 0.04,
          child: RaisedButton(
            color: Color(0xFFD62250),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            textTheme: ButtonTextTheme.accent,
            child: Text(
              '$verMensaje',
              style: TextStyle(
                fontFamily: 'Point-SemiBold',
                fontSize: 9.0,
                color: Colors.white
              ),
            ),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context){
                  return ChatUsuariosPage();
                },
              //settings: RouteSettings(arguments: prefs)
              ));
            },
          ),
        ),*/
      ],
    );
  }

Widget botonEnviarMensaje(BuildContext context, InfoTour tour){
  final size = MediaQuery.of(context).size;
  String enviarMensaje = AppTranslations.of(context).text('title_send_message');
  String verMensaje = AppTranslations.of(context).text('title_show_message'); //prefs.iduser != tour.iduser.toString()
 return prefs.email != tour.userData['mail'] ?
    Container(
      width: size.width * 0.45,
      height: size.height * 0.05,
      child: RaisedButton(
          color: Colors.white,//Color(0xFF055EEE) Color(0xFFD62250)
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          textTheme: ButtonTextTheme.accent,
          child: Text('$enviarMensaje',
          style: TextStyle(
            fontFamily: 'Point-SemiBold',
            fontSize: 14.0,
            color: Colors.black)),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context){
                  return SesionPageChat();
                },
                settings: RouteSettings(arguments: tour),
                //fullscreenDialog: true
              ));
            },
      ),
    ) : Container(
      width: size.width * 0.45,
      height: size.height * 0.05,
      child: RaisedButton(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        textTheme: ButtonTextTheme.accent,
        child: Text(
          '$verMensaje',
          style: TextStyle(
            fontFamily: 'Point-SemiBold',
            fontSize: 14.0,
            color: Colors.black
          ),
        ),
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context){
              return ChatUsuariosPage();
            },
          //settings: RouteSettings(arguments: prefs)
          ));
        },
      ),
    );
}

Widget botonComprar(BuildContext context, InfoTour tour){
  final size = MediaQuery.of(context).size;
  String comprar = AppTranslations.of(context).text('title_buy');
  String navegar = AppTranslations.of(context).text('title_navegar');
  return Container(
    width: size.width * 0.45,
    height: size.height * 0.05, //prefs.iduser != tour.iduser.toString()
    child: prefs.email != tour.userData['mail'] && prefs.idtour != tour.idtour.toString() ? RaisedButton(
      color: Color(0xFF055EEE), //Color(0xFFD62250) Color(0xFFfc5cc8)
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      textTheme: ButtonTextTheme.primary,
      child: Text('$comprar',
          style: TextStyle(
              fontFamily: 'Point-SemiBold',
              fontSize: 14.0,
              color: Colors.white)),
      onPressed: () {
        /* Navigator.of(context).push(MaterialPageRoute(
          builder: (context){
            return PagosPage();
          },
          settings: RouteSettings(arguments: detalleTour)
        ));*/
        //Navigator.pushNamed(context, 'comprar',arguments: detalleTour);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context){
            return SesionPageCompra();
          },
          settings: RouteSettings(arguments: tour),
          fullscreenDialog: true
        ));
        //Navigator.pushNamed(context, 'comprar',arguments: detalleTour);
      },
    ):RaisedButton(
      color: Color(0xFF055EEE), //Color(0xFFD62250) Color(0xFFfc5cc8)
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      textTheme: ButtonTextTheme.primary,
      child: Text('$navegar',
          style: TextStyle(
              fontFamily: 'Point-SemiBold',
              fontSize: 14.0,
              color: Colors.white)),
      onPressed: () {
        Navigator.pushNamed(context, 'googlemap',arguments: tour);
      },
    ),
  );
}

/*Widget _redesSociales(BuildContext context,InfoTour detalle){
  final size = MediaQuery.of(context).size;
  return Padding(
          padding: EdgeInsets.symmetric(horizontal: 127.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 30.0,
                height: 30.0,
                child: SignInButton(
                  Buttons.Facebook,
                  onPressed: (){},
                  mini: true,
                ),
              ),
              SizedBox(width: size.width * 0.02,),
              Container(
                width: 30.0,
                height: 30.0,
                child: SignInButton(
                  Buttons.Twitter,
                  onPressed: (){},
                  mini: true,
                ),
              ),
              SizedBox(width: size.width * 0.02,),
              Container(
                width: 30.0,
                height: 30.0,
                child: SignInButton(
                  Buttons.Google,
                  onPressed: (){},
                  mini: true,
                ),
              )
            ],
          ),
        );
}*/

  Widget _botonEnlace(BuildContext context){
    String pregunta = AppTranslations.of(context).text('title_question_buy_tour');
    return FlatButton(
      child: Text('$pregunta',style: TextStyle(fontFamily: 'Point-SemiBold',decoration: TextDecoration.underline,fontStyle: FontStyle.italic),),
      onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return InfoCompra();
        },fullscreenDialog: true));
      },
    );
  }

 /*Widget _tituloInformacion() {
   String infoGeneral = AppTranslations.of(context).text('title_general_information');
    return Center(
        child: Text(
      '$infoGeneral',
      style: TextStyle(
        fontSize: 25.0,
        fontFamily: 'Point-SemiBold',
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
      ),
    ));
  }*/

  bool traduccionParrafoDescripcion = false;
  bool botonTraductorDescripcion = true;
  bool botonDescripcionOriginal = false;
  bool botonTraducirRecorrido = true;
  String descripcion = '';
  String fullDescription = '';
  String recorridoTour = '';
  List<String> sitiosTraducidos = List();

  void _mostrarBotonTraductorDescripcion(){
    setState(() {
      botonTraductorDescripcion = true;
      botonDescripcionOriginal = false;
      traduccionParrafoDescripcion = false;
    });
  }

  void _ocultarBotonTraductorDescripcion(){
    setState(() {
      botonTraductorDescripcion = false;
      botonDescripcionOriginal = true;
      traduccionParrafoDescripcion = true;
    });
  }

  void _mostrarTraductorRecorrido(){
    setState(() {
      botonTraducirRecorrido = true;
    });
    
  }

  void _ocultarTraductorRecorrido(){
    setState(() {
      botonTraducirRecorrido = false;
    });
  }

Widget _parrafoInformacion(BuildContext context,InfoTour detalle) {
    //InfoTour _tour = ModalRoute.of(context).settings.arguments;
    final size = MediaQuery.of(context).size;
    //final scrollController = ScrollController();
    String recorrido = AppTranslations.of(context).text('title_recorrido');
    String traducir = AppTranslations.of(context).text('title_traducir');
    String textoOriginal = AppTranslations.of(context).text('title_texto_original');
    List<String> sitios = List();
    //List<String> sitiosTraducidos = List();
    List<String> galeriaFotos = List();
    for(int i = 0; i < detalle.route.length; i++){
      sitios.add("${(i+1)}. "+ "${detalle.route[i]['site']}: " + detalle.route[i]['description']);

    }
    for(int i = 0 ; i < detalle.route.length; i++){
      galeriaFotos.add(detalle.route[i]['gallery'][0]['url'].toString());
    }

    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index){
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    FutureBuilder(
                      future: categoriasProvider.detectarIdioma(detalle.description),
                      //initialData: InitialData,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        final respuesta = snapshot.data;
                        if(snapshot.hasData){
                          /*print("Idioma detectado");
                          print(respuesta['data']['detections'][0][0]['language']);*/
                          prefs.idiomaOriginal = Locale(respuesta['data']['detections'][0][0]['language']);
                          return Container();
                        }else{
                          return Container();
                        }
                        
                      },
                    ),
                    prefs.idiomaOriginal == prefs.idioma ? Container():
                    Row(
                      children: <Widget>[
                        botonTraductorDescripcion ? FlatButton(
                          onPressed: ()async{
                            Map<String,dynamic> respDescripcion = await categoriasProvider.traducir(prefs.idioma == null ? 'es':prefs.idioma, detalle.description);
                            descripcion = respDescripcion['data']['translations'][0]['translatedText'];
                            Map<String,dynamic> respFullDecription = await categoriasProvider.traducir(prefs.idioma == null ? 'es':prefs.idioma, detalle.fulldescription);
                            fullDescription = respFullDecription['data']['translations'][0]['translatedText'];
                            _ocultarBotonTraductorDescripcion();
                          }, 
                          child: Text(
                            traducir,
                            style: TextStyle(
                              fontFamily: 'Point-SemiBold',
                              color: Colors.blue,
                              decoration: TextDecoration.underline
                            ),
                          )
                        ):
                        FlatButton(
                          onPressed: ()async{
                            _mostrarBotonTraductorDescripcion();
                          }, 
                          child: Text(
                            textoOriginal,
                            style: TextStyle(
                              fontFamily: 'Point-SemiBold',
                              color: Colors.blue,
                              decoration: TextDecoration.underline
                            ),
                          )
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: traduccionParrafoDescripcion ? Text(
                      descripcion,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontFamily: 'Point-SemiBold',
                          fontStyle: FontStyle.normal
                        )
                      ) : Text(
                          detalle.description,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontFamily: 'Point-SemiBold',
                              fontStyle: FontStyle.normal
                            )
                          )
                    ),
                  ],
                ),
              );
            },
            childCount: 1
          )
        ),
//prefs.iduser.toString() != detalle.iduser.toString() 
       prefs.email != detalle.userData['mail'] && (prefs.idtour != detalle.idtour.toString()) ? SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index){
              return Container();
            },
            childCount: 1
          )
        ):
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index){
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: traduccionParrafoDescripcion ? Text(
                        fullDescription,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontFamily: 'Point-SemiBold',
                            fontStyle: FontStyle.normal
                        )
                      ) :Text(
                        detalle.fulldescription,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontFamily: 'Point-SemiBold',
                            fontStyle: FontStyle.normal
                        )
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        '$recorrido:',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontFamily: 'Point-SemiBold',
                            fontStyle: FontStyle.normal
                        )
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: <Widget>[
                          botonTraducirRecorrido ?
                          FlatButton(
                            onPressed: ()async{
                              for(int i = 0; i < detalle.route.length;i++){
                                Map<String,dynamic> respRecorrido = await categoriasProvider.traducir(prefs.idioma == null ? 'es':prefs.idioma,detalle.route[i]['description'] );
                                recorridoTour = respRecorrido['data']['translations'][0]['translatedText'];
                                //sitios.add("$i. "+ "${detalle.route[i]['site']}: " + detalle.route[i]['description']);
                                sitiosTraducidos.add("${(i+1)}. "+ "${detalle.route[i]['site']}: " + recorridoTour);
                                
                              }
                              //print("sitios traducidos");
                              //print(sitiosTraducidos);
                              _ocultarTraductorRecorrido();
                            }, 
                            child: Text(
                              traducir,
                              style: TextStyle(
                                fontFamily: 'Point-SemiBold',
                                decoration: TextDecoration.underline,
                                color: Colors.blue
                              ),
                            )
                          ):
                          FlatButton(
                            onPressed: ()async{
                              _mostrarTraductorRecorrido();
                            }, 
                            child: Text(
                              textoOriginal,
                              style: TextStyle(
                                fontFamily: 'Point-SemiBold',
                                decoration: TextDecoration.underline,
                                color: Colors.blue
                              ),
                            )
                          ),
                        ],
                      ),
                    ),
                    botonTraducirRecorrido ?
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: sitios.map((sitio){
                          return Column(
                            children: <Widget>[
                              Text(
                                sitio,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontFamily: 'Point-SemiBold',
                                    fontStyle: FontStyle.normal
                                )
                              ), 
                              SizedBox(
                                height: size.height * 0.01,
                              )
                            ],
                          );
                        }).toList()
                      ),
                    ):
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: sitiosTraducidos.map((sitioT){
                          //print(sitioT);
                          return Column(
                            children: <Widget>[
                              Text(
                                "${sitioT.toString()}",
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontFamily: 'Point-SemiBold',
                                    fontStyle: FontStyle.normal
                                )
                              ), 
                              SizedBox(
                                height: size.height * 0.01,
                              )
                            ],
                          );
                        }).toList()
                        
                      ),
                    )
                  ],
                ),
              );
            },
            childCount: 1
          )
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index){
              //prefs.iduser != detalle.iduser.toString()
              return prefs.email != detalle.userData['mail'] && (prefs.idtour != detalle.idtour.toString()) ? Container() : Card(
                child:
                /*Image.network(
                  galeriaFotos[index],
                  width: size.width * 0.4,
                  height: size.height * 0.1,
                  fit: BoxFit.fill,
                ),*/
                CachedNetworkImage(
                  imageUrl: "${galeriaFotos[index]}",
                  //errorWidget: (context, url, error)=>Icon(Icons.error),
                  //cacheManager: baseCacheManager,
                  useOldImageOnUrlChange: true,
                  width: size.width * 0.8,
                  height: size.height * 0.23,
                  fit: BoxFit.fill,
                )
              );
            },
            childCount: galeriaFotos.length
          )
        )
      ],
    );
    
    /*Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
          detalle.description,
          textAlign: TextAlign.justify,
          style: TextStyle(
              fontFamily: 'Point-SemiBold',
              fontStyle: FontStyle.normal
            )
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        prefs.iduser.toString() != detalle.iduser.toString() ? Container() : Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            '$recorrido:',
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontFamily: 'Point-SemiBold',
                fontStyle: FontStyle.normal
            )
          ),
        ),
        prefs.iduser.toString() != detalle.iduser.toString() ? Container() : Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: sitios.map((sitio){
              return Column(
                children: <Widget>[
                  Text(
                    sitio,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontFamily: 'Point-SemiBold',
                        fontStyle: FontStyle.normal
                    )
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  )
                ],
              );
            }).toList()
          ),
        ),
        prefs.iduser.toString() != detalle.iduser.toString() ? Container() :  Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
          child: Column(
            children: galeriaFotos.map((f){
              return Card(child: Image.network(f));
            }).toList()
          )
        )
        /*FutureBuilder(
          future: categoriasProvider.traducir(prefs.idioma == null ? 'es' : prefs.idioma.toString(), detalle.description),
          builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot) {
            if(snapshot.hasData){
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                snapshot.data['data']['translations'][0]['translatedText'].toString(),
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontFamily: 'Point-SemiBold',
                    fontStyle: FontStyle.normal
                  )
                ),
              );
            }else{
              return Container();
            }
            
          },
        ),*/
        
      ],
    );*/
}

/*Widget _imagenGrid(InfoTour tour){
  for(int i = 0; i < tour.route.length; i++){
    
  }
  return Card(
    child: Image.network(tour.route[]),
  );
}*/

Widget _botonesOpcionesUsuario(BuildContext context,InfoTour detalleTour){
    final size = MediaQuery.of(context).size;
    String comprar = AppTranslations.of(context).text('title_buy');
    String iniciar = AppTranslations.of(context).text('title_navegar');
    
    return Column(
      children: <Widget>[
        Container(
          width: size.width * 0.56,
          height: size.height * 0.07, //prefs.iduser != detalleTour.iduser.toString()
          child: prefs.email != detalleTour.userData['mail'] && (prefs.idtour != detalleTour.idtour.toString()) ? RaisedButton(
            color: Color(0xFF055EEE), //Color(0xFFD62250) Color(0xFFfc5cc8)
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            textTheme: ButtonTextTheme.primary,
            child: Text('$comprar',
              style: TextStyle(
                fontFamily: 'Point-SemiBold',
                fontSize: 15.0,
                color: Colors.white)
            ),
            onPressed: () {
             /* Navigator.of(context).push(MaterialPageRoute(
                builder: (context){
                  return PagosPage();
                },
                settings: RouteSettings(arguments: detalleTour)
              ));*/
              //Navigator.pushNamed(context, 'comprar',arguments: detalleTour);
             Navigator.of(context).push(MaterialPageRoute(
                builder: (context){
                  return SesionPageCompra();
                },
                settings: RouteSettings(arguments: detalleTour),
                fullscreenDialog: true
              ));
              //Navigator.pushNamed(context, 'comprar',arguments: detalleTour);
            },
          ):RaisedButton(
            color: Color(0xFF055EEE), //Color(0xFFD62250) Color(0xFFfc5cc8)
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            textTheme: ButtonTextTheme.primary,
            child: Text('$iniciar',
                style: TextStyle(
                    fontFamily: 'Point-SemiBold',
                    fontSize: 15.0,
                    color: Colors.white)),
            onPressed: () {
              Navigator.pushNamed(context, 'googlemap',arguments: detalleTour);
             
            },
          ),
        ),
        
        /* Container(
            width: size.width * 0.49,
            child: RaisedButton(
              color: Colors.lightBlue,
              shape: StadiumBorder(),
              textTheme: ButtonTextTheme.primary,
              child: Text('Enviar Mensaje',style: TextStyle(fontFamily: 'Source Sans Pro',fontSize: 15.0,color: Colors.white)),
              onPressed: (){},
            ),
          ),*/
      ],
    );
  }

  Future<Uint8List> getBytesCanvas(int width, int height,String text)async{
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color = Colors.transparent;
    final Radius radius = Radius.circular(20.0);
    //canvas.drawCircle(Offset(0.3, 0.5), radius.x, paint);
    canvas.drawRRect(
      RRect.fromRectAndCorners(Rect.fromLTWH(0.0, 0.0, width.toDouble(), height.toDouble()),
      topLeft: radius,
      topRight: radius,
      bottomLeft: radius,
      bottomRight: radius,
      ),
      paint
    );
    TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
    painter.text = TextSpan(
      text: '$text',
      style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 25.0, color: Colors.white),
    );
    painter.layout();
    painter.paint(
      canvas,
      Offset(
        (width * 0.5)- painter.width * 0.5,(height * 0.2) - painter.height * 0.5)
      );
    final img = await pictureRecorder.endRecording().toImage(width, height);
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data.buffer.asUint8List();
  }

  Widget _ubicacionTour(BuildContext context,InfoTour detalle){
   // DetalleTour tour = new DetalleTour();
   //final appState = new AppState();
    //final appState =Provider.of<AppState>(context);
    String navegar = AppTranslations.of(context).text('title_navegar');
    String invitacionComentar = AppTranslations.of(context).text('title_invitacion_comentar');
    String comentar = AppTranslations.of(context).text('title_comentar');
    final size = MediaQuery.of(context).size;
    

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
       /* Container(
          padding: EdgeInsets.only(left: 10.0),
            child: Text(
              'Ubicación del Tour',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontFamily: 'Source Sans Pro',
                fontStyle: FontStyle.italic),
          ),
        ),
        SizedBox(height: size.height * 0.02),
        */
        Container(
          width: size.width * 1.0,
          height: size.height * 0.5,
          child: CachedNetworkImage(
            imageUrl: detalle.map_tour,
            useOldImageOnUrlChange: true,
            fit: BoxFit.fill,
          )
          
          //Image.asset('assets/iconomapa.png',fit: BoxFit.fill,)
        ),//prefs.iduser == detalle.iduser.toString() 
        Center(
          child: prefs.email == detalle.userData['mail'] && prefs.idtour == detalle.idtour.toString() ? RaisedButton(
            child: Text('$navegar',style: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.white),),
            onPressed: (){
              //GoogleMapsServices services = new GoogleMapsServices();
              //services.navegar();
              Navigator.pushNamed(context, 'googlemap',arguments: detalle);
            },
            color: Color(0xFF055EEE),//Color(0xFF055EEE) Color(0xFFD62250)
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          ) : Container()
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Center(
          child: Text(
            invitacionComentar,
            style: TextStyle(fontFamily: 'Point-SemiBold')),
        ),
        Center(
          child: RaisedButton(
            child: Text(comentar,style: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.white)),
            onPressed: (){
              //prefs.iduser == ''
              if(prefs.email == ''){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context){
                      return SesionPageComentario();
                    },
                  )
                );
              }else{
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context){
                    return FormComentarioPage();
                  },
                  settings: RouteSettings(
                    arguments: detalle
                  )
                ));
              }
              
            },
            color: Color(0xFF055EEE), //Color(0xFFD62250)
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))
          ),
        )
      ],
    );
  }

  Widget _opiniones(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String opiniones = AppTranslations.of(context).text('title_opinions');
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Container(
          padding: EdgeInsets.only(left: size.width * 0.03),
          child: Text(
            '$opiniones',
            style: TextStyle(
                fontFamily: 'Point-ExtraBold',
                color: Colors.black,
                fontStyle: FontStyle.italic,
                fontSize: 15.0),
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: size.width * 0.02,
            ),
            Row(
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
            ),
            SizedBox(
              width: size.width * 0.02,
            ),
            Text(
              '(50)',
              style: TextStyle(
                fontFamily: 'Neue Haas Grotesk Display Pro',
              ),
            ),
            SizedBox(
              width: size.width * 0.11,
            ),
            Text(
              '4.8 de 5 estrellas',
              style: TextStyle(
                fontFamily: 'Neue Haas Grotesk Display Pro',
              ),
            )
          ],
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: size.width * 0.03,
            ),
            Text(
              '5 estrellas',
              style: TextStyle(
                fontFamily: 'Neue Haas Grotesk Display Pro',
              ),
            ),
            SizedBox(
              width: size.width * 0.04,
            ),
            Container(
                width: size.width * 0.5,
                height: size.height * 0.025,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(30.0)
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.yellow[700],
                        borderRadius: BorderRadius.circular(30.0)
                      ),
                      width: size.width * 0.4,
                      height: size.height * 0.03,
                    )
                  ],
                )),
            SizedBox(
              width: size.width * 0.06,
            ),
            Text(
              '35',
              style: TextStyle(
                fontFamily: 'Neue Haas Grotesk Display Pro',
              ),
            )
          ],
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: size.width * 0.03,
            ),
            Text(
              '4 estrellas',
              style: TextStyle(
                fontFamily: 'Neue Haas Grotesk Display Pro',
              ),
            ),
            SizedBox(
              width: size.width * 0.04,
            ),
            Container(
                width: size.width * 0.5,
                height: size.height * 0.025,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(30.0)
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.yellow[700],
                          borderRadius: BorderRadius.circular(30.0)),
                      width: size.width * 0.3,
                      height: size.height * 0.03,
                    )
                  ],
                )),
            SizedBox(
              width: size.width * 0.08,
            ),
            Text(
              '6',
              style: TextStyle(
                fontFamily: 'Neue Haas Grotesk Display Pro',
              ),
            )
          ],
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: size.width * 0.03,
            ),
            Text(
              '3 estrellas',
              style: TextStyle(
                fontFamily: 'Neue Haas Grotesk Display Pro',
              ),
            ),
            SizedBox(
              width: size.width * 0.04,
            ),
            Container(
                width: size.width * 0.5,
                height: size.height * 0.025,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(30.0)),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.yellow[700],
                          borderRadius: BorderRadius.circular(30.0)),
                      width: size.width * 0.2,
                      height: size.height * 0.03,
                    )
                  ],
                )),
            SizedBox(
              width: size.width * 0.08,
            ),
            Text(
              '5',
              style: TextStyle(
                fontFamily: 'Neue Haas Grotesk Display Pro',
              ),
            )
          ],
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: size.width * 0.03,
            ),
            Text(
              '2 estrellas',
              style: TextStyle(
                fontFamily: 'Neue Haas Grotesk Display Pro',
              ),
            ),
            SizedBox(
              width: size.width * 0.04,
            ),
            Container(
                width: size.width * 0.5,
                height: size.height * 0.025,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(30.0)),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.yellow[700],
                          borderRadius: BorderRadius.circular(30.0)),
                      width: size.width * 0.1,
                      height: size.height * 0.03,
                    )
                  ],
                )),
            SizedBox(
              width: size.width * 0.08,
            ),
            Text(
              '2',
              style: TextStyle(
                fontFamily: 'Neue Haas Grotesk Display Pro',
              ),
            )
          ],
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: size.width * 0.03,
            ),
            Text(
              '1 estrella',
              style: TextStyle(
                fontFamily: 'Neue Haas Grotesk Display Pro',
              ),
            ),
            SizedBox(
              width: size.width * 0.067,
            ),
            Container(
                width: size.width * 0.5,
                height: size.height * 0.025,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(30.0)
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.yellow[700],
                          borderRadius: BorderRadius.circular(30.0)),
                      width: size.width * 0.1,
                      height: size.height * 0.03,
                    )
                  ],
                )),
            SizedBox(
              width: size.width * 0.07,
            ),
            Text(
              '2',
              style: TextStyle(
                fontFamily: 'Neue Haas Grotesk Display Pro',
              ),
            )
          ],
        ),
      ],
    );
  }

Widget _comentariosUsuarios(BuildContext context,InfoTour tour) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: categoriasProvider.verComentarios(tour.idtour.toString()),
        //initialData: InitialData,
        builder: (BuildContext context, AsyncSnapshot<List<Comment>> snapshot) {
          final comentario = snapshot.data;

          if(snapshot.hasData){
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _opiniones(context),
                  Container(
                    width: size.width * 1.0,
                    height: size.height * 0.53,
                    child: ListView.builder(
                      itemCount: comentario.length,
                      itemBuilder: (context,index){
                        return _comentarioUsuario(comentario[index]);
                      },
                    ),
                  ),
                ],
              ),
            );
          }else{
            return Align(
              heightFactor: 34.0,
              alignment: Alignment.center,
              child: Text('No hay comentarios'),
            );
          }
          
        },
      );
  }

  bool botonComments = true;
  bool botonCommentsOriginal = false;
  String comentarios = '';

  void _mostrarBotonTraductorComments(){
    setState(() {
      botonComments = true;
      botonDescripcionOriginal = false;
      //traduccionParrafoDescripcion = false;
    });
  }

  void _ocultarBotonTraductorComments(){
    setState(() {
      botonComments = false;
      botonCommentsOriginal = true;
      //traduccionParrafoDescripcion = true;
    });
  }

Widget _comentarioUsuario(Comment comment){
  final size = MediaQuery.of(context).size;

  return Card(
      child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Visibility(
            visible: false,
            child: FutureBuilder(
              future: categoriasProvider.detectarIdioma(comment.commentary),
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
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: 
                /*FadeInImage(
                  width: size.width * 0.2,
                  image: NetworkImage(comment.imgProfile),
                  placeholder: AssetImage('assets/loading.gif'),
                  fit: BoxFit.fill,
                ),*/
                CachedNetworkImage(
                  imageUrl: "${comment.imgProfile}",
                  //errorWidget: (context, url, error)=>Icon(Icons.error),
                  //cacheManager: baseCacheManager,
                  useOldImageOnUrlChange: true,
                  width: size.width * 0.2,
                  fit: BoxFit.fill,
                )
              ),
              SizedBox(width: size.width * 0.03,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('${comment.name}',
                          style: TextStyle(
                            fontFamily: 'Source Sans Pro',
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
                    '${comment.dateComment}',
                    style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      color: Colors.grey[800],
                      fontSize: 12.0
                      ),
                  ),
                ],
              ),
            ],
          ),
          /*SizedBox(
            height: size.height * 0.01,
          ),*/
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
          Text(
            comment.commentary,
            style: TextStyle(fontFamily: 'Neue Haas Grotesk Display Pro')
          ),
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

 /* Widget _sitiosCercanos() {
    var size = MediaQuery.of(context).size;
    return Container(
      //color: Colors.lightGreen,
      width: double.infinity,
      height: size.height * 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 10.0, left: 10.0),
              child: Text('Sitios de Interés cercanos al tour',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontFamily: 'Source Sans Pro',
                      fontStyle: FontStyle.italic))),
          SizedBox(
            height: size.height * 0.01,
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _imagenes(),
                _imagenes(),
                _imagenes(),
                _imagenes()
              ],
            ),
          )
        ],
      ),
    );
  }*/

 /* Widget _imagenes() {
    var size = MediaQuery.of(context).size;
    final imagen = Container(
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: FadeInImage(
              width: size.width * 0.5,
              height: size.height * 0.2,
              image: AssetImage('assets/images/beach.jpeg'),
              placeholder: AssetImage('assets/jar-loading.gif'),
              fadeInDuration: Duration(milliseconds: 100),
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Costo',
                  style:
                      TextStyle(fontFamily: 'Neue Haas Grotesk Display Pro')),
              SizedBox(
                width: size.width * 0.02,
              ),
              Container(
                width: size.width * 0.28,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      color: Color(0xFFF7C109),
                      size: 14.0,
                    ),
                    Icon(
                      Icons.star,
                      color: Color(0xFFF7C109),
                      size: 14.0,
                    ),
                    Icon(
                      Icons.star,
                      color: Color(0xFFF7C109),
                      size: 14.0,
                    ),
                    Icon(
                      Icons.star,
                      color: Color(0xFFF7C109),
                      size: 14.0,
                    ),
                    Icon(
                      Icons.star_half,
                      color: Color(0xFFF7C109),
                      size: 14.0,
                    ),
                  ],
                ),
              ),
              Text('88',
                  style: TextStyle(fontFamily: 'Neue Haas Grotesk Display Pro'))
            ],
          ),
        ],
      ),
    );
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'tours');
      },
      child: Column(
        children: <Widget>[
          Container(
            //color: Colors.lightBlue,
            height: size.height * 0.28,
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Card(child: imagen),
                Positioned(
                  top: size.height * 0.1,
                  left: size.width * 0.16,
                  child: Text(
                    'Título Imagen',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Point',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                /*Positioned(
                  top: size.height * 0.23,
                  left: size.width * 0.03,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Costo',
                            style: TextStyle(
                                fontFamily: 'Neue Haas Grotesk Display Pro')),
                        SizedBox(
                          width: size.width * 0.02,
                        ),
                        Container(
                          width: size.width * 0.28,
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.star, color: Color(0xFFF7C109),size: 18.0,),
                              Icon(Icons.star, color: Color(0xFFF7C109),size: 18.0,),
                              Icon(Icons.star, color: Color(0xFFF7C109),size: 18.0,),
                              Icon(Icons.star, color: Color(0xFFF7C109),size: 18.0,),
                              Icon(Icons.star_half, color: Color(0xFFF7C109),size: 18.0,),
                            ],
                          ),
                        ),
                        Text('88 %',
                            style: TextStyle(
                                fontFamily: 'Neue Haas Grotesk Display Pro'))
                      ],
                    ),
                  ),
                ),*/
              ],
            ),
          )
        ],
      ),
    );
  }*/

 /* Widget _swiperTarjetas() {
    return CardSwiper(
      categorias: [1, 2, 3, 4, 5],
    );
  }*/
    
   /* ListView.builder(
      scrollDirection: Axis.horizontal,
      
      itemCount: tour.gallery.length,
      itemBuilder: (BuildContext context,i){
        return Card(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: FadeInImage(
              image: NetworkImage(tour.gallery[i]),
              placeholder: AssetImage('assets/jar-loading.gif'),
              fit: BoxFit.fill,
              width: size.width * 0.5,
              height: size.height * 0.2,
            ),
          ),
        );
      }
    );*/
  }

  class IconButtonFavorite extends StatelessWidget {
    final VoidCallback onClick;
    final IconData icon;
    final int select;
    final Color selectColor = Colors.red;

    IconButtonFavorite({@required this.onClick,@required this.icon,this.select});
    @override
    Widget build(BuildContext context) {
      return InkResponse(
        onTap: onClick,
        child: Icon(icon,color: select == 1 ? selectColor : null),
      );
    }
  }

