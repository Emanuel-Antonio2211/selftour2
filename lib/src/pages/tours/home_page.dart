import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:selftourapp/src/googlemaps/states/app_state.dart';
import 'package:selftourapp/src/models/tour_categoria_model.dart';
import 'package:selftourapp/src/pages/tours/categorias_page.dart';
import 'package:selftourapp/src/pages/tours/tours_populares_page.dart';
import 'package:selftourapp/src/pages/tours/tours_recientes_page.dart';
import 'package:selftourapp/src/pages/tours/tours_recomendados_page.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:selftourapp/src/providers/categorias_providers.dart';
import 'package:selftourapp/src/search/search_delegate.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';
import 'package:selftourapp/src/widgets/categoria_horizontal.dart';
import 'package:selftourapp/src/widgets/populares_horizontal.dart';
import 'package:selftourapp/src/widgets/recientes_horizontal.dart';
import 'package:selftourapp/src/widgets/recomendados_horizontal.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage>{

  PreferenciasUsuario prefs = PreferenciasUsuario();
  CategoriasProvider categorias = CategoriasProvider();
  ScrollController _scrollController;
  AppState appState;
  bool lastStatus = true;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();

 scrollListener(){
   setState(() {
     
   });
    if(isShrink != lastStatus){
      lastStatus = isShrink;
    }
  }

  bool get isShrink{
    return _scrollController.hasClients && _scrollController.offset > (200.0 - kToolbarHeight);
  }

@override
void initState() { 
  _scrollController = ScrollController();
  _scrollController.addListener(scrollListener);
  categorias.getCategoria();
  categorias.verPopulares();
  categorias.verRecientes();
  categorias.verRecomendados();
  //_refresh();
  /*WidgetsBinding.instance
      .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());*/
  //appState.getUserLocation();
  
  super.initState();
}

Future<void> getDatos()async{
  setState(() {
    
  });
  await categorias.getCategoria();
  await categorias.verPopulares();
  await categorias.verRecientes();
  await categorias.verRecomendados();
}

/*Future<Null> _refresh() {
  return getDatos().then((_user) {
    setState(() => user = _user);
  });
}*/

  Future<Null> _refresh()async{
    _refreshIndicatorKey.currentState?.show(atTop: false);
    _refreshIndicatorKey.currentState.initState();
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      
    });
    await categorias.getCategoria();
    await categorias.verPopulares();
    await categorias.verRecientes();
    await categorias.verRecomendados();
    print("Datos actualizados");
    return null;
  }

  
  @override
  Widget build(BuildContext context) {
    //final ThemeData theme = Theme.of(context);
    //final appBarTheme = AppBarTheme();
    /*appBarTheme.copyWith(
      color: Colors.white,
      brightness: Brightness.light
    );
    theme.copyWith(
      primaryColor: Colors.white,
    );*/
    final appState = Provider.of<AppState>(context);

    /*Future.delayed(Duration(microseconds: 1),()async{
      await appState.userLocation().then((result){
        prefs.ciudad = result[0];
        prefs.estado = result[1];
        prefs.pais = result[2];
      });
    });*/

   /* Future.sync(()async{
      await appState.userLocation().then((result){
        prefs.ciudad = result[0];
        prefs.estado = result[1];
        prefs.pais = result[2];
      });
    });*/

   /* print(prefs.ciudad);
    print(prefs.estado);
    print(prefs.pais);*/
  
    var size = MediaQuery.of(context).size;
    return Scaffold(
     appBar: AppBar(
       elevation: 0.0,
          centerTitle: false,
          backgroundColor: Colors.white,
          title: Image.asset(
            'assets/iconoapp/selftouricon.png',
            fit: BoxFit.fill,
            //width: size.width * 0.38,
            height: size.height * 0.057,
          )),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: ()async{
          _refreshIndicatorKey.currentState.show();
          await Future.delayed(Duration(seconds: 1),(){
            setState(() {
              _refresh();
            });
            
            /*categorias.getCategoria();
            categorias.verPopulares();
            categorias.verRecientes();
            categorias.verRecomendados();*/
          });
          
        },
          child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverAppBar(
              primary: true,
              pinned: true,
              elevation: 0.0,
              floating: false,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              actions: <Widget>[
                
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: _buscador2()
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children:[ 
                    _imagenFondo(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                          child: Container(
                          child: Text(AppTranslations.of(context).text('title_question'),style:TextStyle(
                                fontFamily: 'Point-SemiBoldItalic',
                                color: Colors.white,//Color(0xFF555758)
                                fontSize: 20.0,
                                )
                              ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: _buscador()
                    )
                  ]
                )
              ),
              expandedHeight: size.height * 0.3,
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    _categorias(),
                    _tourPopulares(),
                    _tourRecientes(),
                    _tourRecomendados()
                  ],
                ),
              ),
            )
          ],
        ),
      )
      
      
     /* Stack(
        children: <Widget>[
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              _imagenFondo(),
              _categorias(),
              _tourPopulares(),
              _tourRecientes(),
              _tourRecomendados()
            ],
          ),
          Positioned(
            top: size.height * 0.03,
            left: size.width * 0.086,
            child: _buscador(),
          ),
          
        ],
      ),*/
    );
  }

  Widget _buscador2() {
    var size = MediaQuery.of(context).size;
    return Card(
      color: isShrink ? Colors.transparent : Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
      elevation: 0.0,
      child: GestureDetector(
        onTap: (){
          showSearch(context: context,delegate: DataSearch(),query: '');
        },
        child: Container(
          width: size.width * 0.81,
          //color:  Colors.white70,
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: isShrink ? Colors.grey[300] : Colors.transparent,
                style: BorderStyle.solid,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Flexible(
                child: Text(AppTranslations.of(context).text('title_question'),style:TextStyle(
                          fontFamily: 'Point-SemiBoldItalic',
                          color: isShrink ? Color(0xFF555758):Colors.transparent,
                          fontSize: 14.0,
                          )
                        ),
              ),//'¿Que deserías conocer?'
              /*Container(
                width: size.width * 0.65,
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                decoration: BoxDecoration(
                    //border: Border.all(color: Color(0xFF9EFAFA)),
                    //borderRadius: BorderRadius.circular(10.0),
                    ),
                child: TextField(
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      hintText: '¿Que deserías conocer?',
                      hintStyle: TextStyle(
                        color: Color(0xFF555758),
                        fontSize: 14.0,
                        )
                      ),
                ),
              ),*/
              _botonBuscar2()
            ],
          ),
        ),
      ),
    );
  }

  Widget _botonBuscar2() {
    return IconButton(
      color: isShrink ? Color(0xFF555758):Colors.transparent,
      //tooltip: 'Presiona para Buscar',
      icon: Icon(
        Icons.search,
        size: 30.0,
      ),
      onPressed: () {
        showSearch(context: context,delegate: DataSearch());
      },
    );
  }

  Widget _buscador() {
    var size = MediaQuery.of(context).size;
    String buscar = AppTranslations.of(context).text('title_buscar');
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
      elevation: 1.0,
      child: GestureDetector(
        onTap: (){
          showSearch(context: context,delegate: DataSearch(),query: '');
        },
        child: Container(
          width: size.width * 0.81,
          //color:  Colors.white70,
          decoration: BoxDecoration(
              color: Colors.white70,
              border: Border.all(
                color: Colors.grey[300],
                style: BorderStyle.solid,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Flexible(
                child: Text(buscar,style:TextStyle(
                          fontFamily: 'Point-SemiBoldItalic',
                          color: Color(0xFF555758),
                          fontSize: 14.0,
                          )
                        ),
              ),//'¿Que deserías conocer?'
              /*Container(
                width: size.width * 0.65,
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                decoration: BoxDecoration(
                    //border: Border.all(color: Color(0xFF9EFAFA)),
                    //borderRadius: BorderRadius.circular(10.0),
                    ),
                child: TextField(
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      hintText: '¿Que deserías conocer?',
                      hintStyle: TextStyle(
                        color: Color(0xFF555758),
                        fontSize: 14.0,
                        )
                      ),
                ),
              ),*/
              SizedBox(
                width: size.width * 0.3,
              ),
              _botonBuscar()
            ],
          ),
        ),
      ),
    );
  }

  Widget _botonBuscar() {
    return IconButton(
      color: Color(0xFF555758),
      //tooltip: 'Presiona para Buscar',
      icon: Icon(
        Icons.search,
        size: 30.0,
      ),
      onPressed: () {
        showSearch(context: context,delegate: DataSearch());
      },
    );
  }


  Widget _imagenFondo(){
    //final appState = Provider.of<AppState>(context);
   //print(appState.location);
    var size = MediaQuery.of(context).size;
    //String hoy = AppTranslations.of(context).text('title_today');
    //String mes = AppTranslations.of(context).text('title_month');

    List<String> imagenes = [
      'assets/app/Imagen1.jpeg',
      'assets/app/Imagen2.jpeg',
      'assets/app/Imagen3.jpeg',
      'assets/app/Imagen4.jpeg',
      'assets/app/Imagen5.jpeg',
      'assets/app/Imagen6.jpeg'
    ];
    
    return Container(
          width: double.infinity,
          child:Stack(
            children:<Widget> [
             Container(
               width: size.width * 1.0,
               height: size.height * 0.35,
               child: Swiper(
                 autoplay: true,
                 itemCount: imagenes.length,
                 itemWidth: size.width * 0.3,
                 itemHeight: size.height * 0.2,
                 itemBuilder: (BuildContext context, i){
                  return Image.asset(
                    imagenes[i],
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    );
                 },
                 //pagination: SwiperPagination(),
                 //control: SwiperControl(),
                 layout: SwiperLayout.DEFAULT,
               ),
             ),

             Container(
                  height: 214.0,
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

            /*  Container(
                width: size.width * 1.0,
                height: size.height * 0.29,
                child: Opacity(
                  opacity: 0.9,
                  child: Image.asset('assets/tour.jpg')
                ),
              ),*/
         /* Positioned(
          top: size.height * 0.13,
          left: size.width * 0.38,
          child: Text(
            '${appState.location.toString()}',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Point',
              fontSize: 34.0,
              fontWeight: FontWeight.bold
              ),
            ),
        ),*/
       /* Positioned(
                top: size.height * 0.13,
                left: size.width * 0.36,
                child: Container(
                  width: size.width * 0.5,
                  alignment: Alignment.center,
                  child: TextField(
                    //showCursor: false,
                    autofocus: false,
                    style:TextStyle(
                      color: Colors.white,
                      fontFamily: 'Point-ExtraBold',
                      fontSize: 34.0,
                      fontWeight: FontWeight.bold
                      ),
                    //cursorColor: Colors.white,
                    controller: appState.locationController,
                    //readOnly: true,
                    decoration: InputDecoration(
                      enabled: false,
                      disabledBorder: InputBorder.none
                      ),
                  ),
                ),
              ),*/
         /* Positioned(
          top: size.height * 0.22,
          left: size.width * 0.1,
            child: Container(
              height: size.height * 0.05,
              width: size.width * 0.3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                  child: RaisedButton(
                  color: Colors.white,
                  child: Text('$hoy',style: TextStyle(fontWeight: FontWeight.bold),),
                  onPressed: (){

                  },
                ),
              ),
            ),
        ),*/
       /* Positioned(
          top: size.height * 0.22,
          left: size.width * 0.39,
            child: Container(
              padding: EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40.0)
              ),
              //color: Colors.white,
              width: size.width * 0.26,
              height: size.height * 0.04,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                child: _mes()
              ),
            ),
        ),*/
         /*Positioned(
          top: size.height * 0.22,
          left: size.width * 0.68,
            child: Container(
              height: size.height * 0.05,
              width: size.width * 0.3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                  child: RaisedButton(
                  color: Colors.white,
                  child: Icon(Icons.calendar_today),
                  onPressed: (){

                  },
                ),
              ),
            ),
        )*/
            ]
          ),
        );
  }
  /*Widget _mes(){
    String dropdownValue = 'Mes';
    return DropdownButton<String>(
        underline: Container(),
        value: dropdownValue,
        onChanged: (String newValue){
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: ['Mes','One','Two','Three','Four'].map<DropdownMenuItem<String>>((String value){
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value,style: TextStyle(fontWeight: FontWeight.bold),),
          );
        }).toList(),
      );
    
  }*/

  

  Widget _categorias(){
    var size = MediaQuery.of(context).size;
    String verMas = AppTranslations.of(context).text('title_vermas');
    //categorias.getCategoria();
    return Container(
      //color: Colors.lightGreen,
      width: double.infinity,
      height: size.height * 0.38,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10.0, left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Text(AppTranslations.of(context).text('title_category'),
                    style: TextStyle(
                      fontSize: 18.0, 
                      fontFamily: 'Point-ExtraBold',//Source Sans Pro
                      fontStyle: FontStyle.italic
                    )
                  ),
                ),
                /*SizedBox(
                  width: 18.0,
                ),*/
                FlatButton(
                  padding: EdgeInsets.zero,
                  child: Text(
                    verMas,
                    style: TextStyle(fontFamily: 'Point-SemiBold'),
                  ),
                  onPressed: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context){
                          return CategoriasPage();
                        }
                      )
                    );
                  },
                )
              ],
            )
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _categoriaImagenes()
                //_popularesTours()
              ],
            ),
          /*Expanded(
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _imagenesCategoria(),
                _imagenesCategoria(),
                _imagenesCategoria(),
                _imagenesCategoria()
              ],
            ),
          )*/
        ],
      ),
    );
  }

  Widget _categoriaImagenes(){
    
    var size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: categorias.categoriasStream,//categorias.categoriasStream //categorias.getCategoria()
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        //Aquí evalúa si tiene datos
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return Container(
              height: size.height * 0.28 ,//size.height * 0.1
              child: Center(
                child: Container()
              ),
            );
          break;
          case ConnectionState.none:
            return Container(
              height: size.height * 0.28 ,//size.height * 0.1
              child: Center(
                child: Container()
              ),
            );
          break;
          case ConnectionState.done:
            if(snapshot.hasData){
              return CategoriaHorizontal(
                categorias: snapshot.data,
                siguientePagina: categorias.getCategoria,
              );
              /*CardSwiper(
              categorias: snapshot.data,
            );*/
            }else{
              return Container(
                height: size.height * 0.28,//size.height * 0.1
                child: Center(
                  child: Container()
                ),
              );
            }
          break;
          case ConnectionState.active:
            return CategoriaHorizontal(
              categorias: snapshot.data,
              siguientePagina: categorias.getCategoria,
            );
          break;
          default:
            return Container(
              height: size.height * 0.28 ,//size.height * 0.1
              child: Center(
                child: Container()
              ),
            );
        }
        /*if(snapshot.hasData){
            return CategoriaHorizontal(
              categorias: snapshot.data,
              siguientePagina: categorias.getCategoria,
            );
            /*CardSwiper(
            categorias: snapshot.data,
          );*/
        }else{
          return Container(
            height: size.height * 0.28 ,//size.height * 0.1
            child: Center(
              child: Container()
            ),
          );
        }*/
      },
    );
  }

  Widget _tourPopulares(){
    //categorias.getTours();
    var size = MediaQuery.of(context).size;
    String verMas = AppTranslations.of(context).text('title_vermas');
    return Container(
      //color: Colors.lightGreen,
      width: double.infinity,
      height: size.height * 0.45,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 10.0, left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(AppTranslations.of(context).text('title_popular_tours'),
                      style: TextStyle(
                        fontSize: 18.0, 
                        fontFamily: 'Point-ExtraBold',
                        fontStyle: FontStyle.italic
                    )
                  ),
                  /*SizedBox(
                    width: 13.0,
                  ),*/
                  FlatButton(
                    padding: EdgeInsets.zero,
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context){
                          return ToursPopularesPage();
                        },
                       // settings: RouteSettings(arguments: )
                      ));
                    },
                    child: Text(verMas,style: TextStyle(
                      fontFamily: 'Point-SemiBold'
                  ),)
                  )
                ],
              )
            ),
         /* SizedBox(
            height: size.height * 0.01,
          ),*/
          Column(
            children: <Widget>[
             _imagenespopularesTours()
            ],
          ),
          /*Expanded(
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _imagenesCategoria(),
                _imagenesCategoria(),
                _imagenesCategoria(),
                _imagenesCategoria()
              ],
            ),
          )*/
        ],
      ),
    );
  }

  Widget _imagenespopularesTours(){
    
    var size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: categorias.popularStream,
      //initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot<List<InfoTour>> snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return Container(
              height: size.height * 0.28,//size.height * 0.1
              child: Center(
                child: Container()
              ),
            );
          break;
          case ConnectionState.none:
            return Container(
              height: size.height * 0.28,//size.height * 0.1
              child: Center(
                child: Container()
              ),
            );
          break;
          case ConnectionState.done:
            if(snapshot.hasData){
              return ToursPopulares(listaPopulares: snapshot.data,);
              /*CardSwiper(
              categorias: snapshot.data,
            );*/
            }else{
              return Container(
                height: size.height * 0.28,//size.height * 0.1
                child: Center(
                  child: Container()
                ),
              );
            }
          break;
          case ConnectionState.active:
            return ToursPopulares(listaPopulares: snapshot.data,);
          break;
          default:
            return Container(
              height: size.height * 0.28,//size.height * 0.1
              child: Center(
                child: Container()
              ),
            );

        }
        /*if(snapshot.hasData){
            return ToursPopulares(listaPopulares: snapshot.data,);
            /*CardSwiper(
            categorias: snapshot.data,
          );*/
        }else{
          return Container(
            height: size.height * 0.28,//size.height * 0.1
            child: Center(
              child: Container()
            ),
          );
        }*/
      },
    );
  }

  
  Widget _tourRecientes() {
    //categorias.getTours();
    var size = MediaQuery.of(context).size;
    String verMas = AppTranslations.of(context).text('title_vermas');
    return Container(
      //color: Colors.lightGreen,
      width: double.infinity,
      height: size.height * 0.45,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 10.0, left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(AppTranslations.of(context).text('title_recent_tours'),
                      style: TextStyle(
                        fontSize: 18.0, 
                        fontFamily: 'Point-ExtraBold',
                        fontStyle: FontStyle.italic
                    )
                  ),
                  /*SizedBox(
                    width: 25.0,
                  ),*/
                  FlatButton(
                    padding: EdgeInsets.zero,
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context){
                          return ToursRecientesPage();
                        }
                      ));
                    },
                    child: Text(verMas,style: TextStyle(fontFamily: 'Point-SemiBold'),)
                  )
                ],
              )
              ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Column(
            children: <Widget>[
              _imagenesrecientesTours()
            ],
          )
        ],
      ),
    );
  }

  Widget _imagenesrecientesTours(){
    
    var size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: categorias.recienteStream,
      //initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot<List<InfoTour>> snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return Container(
              height: size.height * 0.28,
              child: Center(
                child: Container()
              ),
            );
          break;
          case ConnectionState.none:
            return Container(
              height: size.height * 0.28,
              child: Center(
                child: Container()
              ),
            );
          break;
          case ConnectionState.done:
            if(snapshot.hasData){
              return ToursRecientes(listaRecientes: snapshot.data,);
              /*CardSwiper(
              categorias: snapshot.data,
            );*/
            }else{
              return Container(
                height: size.height * 0.28,
                child: Center(
                  child: Container()
                ),
              );
            }
          break;
          case ConnectionState.active:
            return ToursRecientes(listaRecientes: snapshot.data,);
          break;
          default:
            return Container(
              height: size.height * 0.28,
              child: Center(
                child: Container()
              ),
            );
        }
        /*if(snapshot.hasData){
            return ToursRecientes(listaRecientes: snapshot.data,);
            /*CardSwiper(
            categorias: snapshot.data,
          );*/
        }else{
          return Container(
            height: size.height * 0.28,
            child: Center(
              child: Container()
            ),
          );
        }*/
      },
    );
  }

  Widget _tourRecomendados() {
    var size = MediaQuery.of(context).size;
    String verMas = AppTranslations.of(context).text('title_vermas');
    return Container(
      //color: Colors.lightGreen,
      width: double.infinity,
      height: size.height * 0.48,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 10.0, left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(AppTranslations.of(context).text('title_recomiendes_tours'),
                            style: TextStyle(
                              fontSize: 18.0, 
                              fontFamily: 'Point-ExtraBold',
                              fontStyle: FontStyle.italic
                        )
                  ),
                  /*SizedBox(
                    width: 18.0,
                  ),*/
                  FlatButton(
                    padding: EdgeInsets.zero,
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context){
                          return ToursRecomendadosPage();
                        }
                      ));
                    },
                    child: Text(verMas,style: TextStyle(fontFamily: 'Point-SemiBold'),),
                  )
                ],
              )
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Column(
              children: <Widget>[
                _imagenesrecomendadosTours()
            ],
          )
        ],
      ),
    );
  }

  Widget _imagenesrecomendadosTours(){
    var size = MediaQuery.of(context).size;
    
    return StreamBuilder(
      stream: categorias.recomendadoStream,
      //initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot<List<InfoTour>> snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return Container(
              height: size.height * 0.28,
              child: Center(
                child: Container()
              ),
            );
          break;
          case ConnectionState.none:
            return Container(
              height: size.height * 0.28,
              child: Center(
                child: Container()
              ),
            );
          break;
          case ConnectionState.done:
            if(snapshot.hasData){
              return ToursRecomendados(listaRecomendados: snapshot.data);
            }else{
              return Container(
                height: size.height * 0.28,
                child: Center(
                  child: Container()
                ),
              );
            }
          break;
          case ConnectionState.active:
            return ToursRecomendados(listaRecomendados: snapshot.data);
          break;
          default:
            return Container(
              height: size.height * 0.28,
              child: Center(
                child: Container()
              ),
            );
        }
        /*if(snapshot.hasData){
            return ToursRecomendados(listaRecomendados: snapshot.data);
        }else{
          return Container(
            height: size.height * 0.28,
            child: Center(
              child: Container()
            ),
          );
        }*/
      },
    );
  }
 /* Widget _imagenes() {
    var size = MediaQuery.of(context).size;
    final imagen = Container(
      padding: EdgeInsets.all(6.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: FadeInImage(
              width: size.width * 0.5,
              height: size.height * 0.19,
              image: AssetImage('assets/images/beach.jpeg'),
              placeholder: AssetImage('assets/jar-loading.gif'),
              fadeInDuration: Duration(milliseconds: 100),
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: size.height * 0.01,),
          Container(
            child: Row(
              children: <Widget>[
                Text('Costo',style: TextStyle(fontFamily: 'Neue Haas Grotesk Display Pro'),),
                        SizedBox(width: size.width * 0.02,),
                        Container(
                          width: size.width * 0.3,
                          child: Row(
                            children: <Widget>[
                                Icon(Icons.star,color: Color(0xFFF7C109),size: 18.0,),
                                Icon(Icons.star,color: Color(0xFFF7C109),size: 18.0,),
                                Icon(Icons.star,color: Color(0xFFF7C109),size: 18.0,),
                                Icon(Icons.star,color: Color(0xFFF7C109),size: 18.0,),
                                Icon(Icons.star_half,color: Color(0xFFF7C109),size: 18.0,),
                            ],
                          ),
                        ),
                        Text('70 %',style: TextStyle(fontFamily: 'Neue Haas Grotesk Display Pro'),)
              ],
            ),
          )
        ],
      ),
    );
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, 'tours');
      },
          child: Column(
        children: <Widget>[
          Container(
            //color: Colors.white,
            height: size.height * 0.27,
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Card(child: imagen),
                Positioned(
                  top: size.height * 0.1,
                  left: size.width * 0.16,
                  child: Container(
                    child: Text(
                      'Título Imagen',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Point',
                        fontWeight: FontWeight.bold
                        ),
                      ),
                  ),
                ),
                /*Positioned(
                  top: size.height * 0.23,
                  left: size.width * 0.03,
                  child: Container(
                    height: 30.0,
                    color: Colors.blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Costo',style: TextStyle(fontFamily: 'Neue Haas Grotesk Display Pro'),),
                        SizedBox(width: size.width * 0.02,),
                        Container(
                          width: size.width * 0.28,
                          child: Row(
                            children: <Widget>[
                                Icon(Icons.star,color: Color(0xFFF7C109),size: 18.0,),
                                Icon(Icons.star,color: Color(0xFFF7C109),size: 18.0,),
                                Icon(Icons.star,color: Color(0xFFF7C109),size: 18.0,),
                                Icon(Icons.star,color: Color(0xFFF7C109),size: 18.0,),
                                Icon(Icons.star_half,color: Color(0xFFF7C109),size: 18.0,),
                            ],
                          ),
                        ),
                        Text('70 %',style: TextStyle(fontFamily: 'Neue Haas Grotesk Display Pro'),)
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

  
  
}
