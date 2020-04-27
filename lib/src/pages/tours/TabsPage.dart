//import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:selftourapp/src/models/tour_categoria_model.dart';
//import 'package:selfttour/src/bloc/provider.dart';
import 'package:selftourapp/src/pages/tours/busqueda_tour_page.dart';
import 'package:selftourapp/src/pages/tours/home_page.dart';
//import 'package:selftourapp/src/pages/tours/tours_mapa_page.dart';
import 'package:selftourapp/src/pages/usuario/profile_user_page.dart';
import 'package:selftourapp/src/pages/usuario/tourscomprados_page.dart';
import 'package:selftourapp/src/pages/usuario/toursfavoritos_page.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';
import 'package:selftourapp/src/providers/dynamic_link_provider.dart';

class TabsPage extends StatefulWidget {
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  final dynamicLinkProvider = DynamicLinkProvider();
  int currentIndex = 0;

  final List<Widget> _children = [
    IndexPage(),
    ToursCompradosPage(),
    ToursFavoritosPage(),
    BusquedaTourPage(),
    ProfileUserPage()
  ];

  //final PageStorageBucket bucket = PageStorageBucket();
  

  @override
  void initState() {
    //initDynamicLinks();
    dynamicLinkProvider.startDynamicLink(context);
    super.initState();
    
  }

  void dynamicLinkHandled()async{
    await dynamicLinkProvider.startDynamicLink(context);
  }

/*
  void initDynamicLinks()async{
    final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if(deepLink != null){

      print("DeepLink");
      print(deepLink.path);
      //print(deepLink.queryParameters['detalletour']);
      //Navigator.pushNamed(context, ruta,arguments: argument);
      final argument = deepLink.queryParameters['_lookup'];
      print(argument);
          Map<String, dynamic> json = {
          "idtour": argument.toString()
          };
       final infotour = InfoTour.fromJsonMap(json);
      Navigator.pushNamed(context, '${deepLink.path}',arguments: infotour);
      
    }
    FirebaseDynamicLinks.instance.onLink(
      onSuccess: (PendingDynamicLinkData dynamicLink)async{
        final Uri deepLink = dynamicLink?.link;

        if(deepLink != null){
          print("Ruta: ");
          print(deepLink.path);
          final argument = deepLink.queryParameters['_lookup'];
          print(argument);
          int idtour = int.parse(argument);
          Map<String, dynamic> json = {
          "idtour": idtour
          };
        final infotour = InfoTour.fromJsonMap(json);
        Navigator.pushNamed(context, '${deepLink.path}',arguments: infotour);
          var isPost = deepLink.pathSegments.contains('detalletour');
          /*if(isPost){
             final argument = deepLink.queryParameters['idtour'];
             print("Argumento");
             print(argument);
            if(argument != null){
              //navigatorKey.currentState.pushNamed('detalletour',arguments: argument);
            }
          }*/
        }
      },
      onError: (OnLinkErrorException e)async{
        print('OnLinkError');
        print(e.message);
      }
    );
  }*/

  @override
  Widget build(BuildContext context) {
    
    //final bloc = Provider.of(context);

    return Scaffold(
      body: _children[currentIndex],
      //_children[currentIndex],//_llamarPaginas(currentIndex)
      bottomNavigationBar: _crearBottomNavigationBar(),
      
    );
  }

  /*Widget _llamarPaginas(int paginaActual){
    switch(paginaActual){
      case 0: return IndexPage();
      case 1: return ToursCompradosPage();
      case 2: return ToursFavoritosPage();
      case 3: return BusquedaTourPage(); //BusquedaTourPage() ToursMapaPage()
      case 4: return ProfileUserPage();

      default:
        return IndexPage();
    }
  }*/
  Widget _crearBottomNavigationBar(){
    return BottomNavigationBar(
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
          icon: Icon(Icons.home,size: 30.0,color: currentIndex == 0 ? Colors.red:Colors.grey),
          title:Text(AppTranslations.of(context).text('title_home'),style: TextStyle(color: currentIndex == 0 ? Colors.red:Colors.grey),)
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart,size: 30.0,color: currentIndex == 1 ? Colors.red:Colors.grey,),
          title:Text(AppTranslations.of(context).text('title_orders'),style: TextStyle(color: currentIndex == 1 ? Colors.red:Colors.grey))
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite,size: 30.0,color: currentIndex == 2 ? Colors.red : Colors.grey,),
          title:Text(AppTranslations.of(context).text('title_favourites'),style: TextStyle(color: currentIndex == 2 ? Colors.red:Colors.grey))
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search,size: 30.0,color: currentIndex == 3 ? Colors.red : Colors.grey),
          title:Text(AppTranslations.of(context).text('title_search'),style: TextStyle(color: currentIndex == 3 ? Colors.red:Colors.grey))
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person,size: 30.0,color: currentIndex == 4 ? Colors.red : Colors.grey),
          title: Text(AppTranslations.of(context).text('title_profile'),style: TextStyle(color: currentIndex == 4 ? Colors.red : Colors.grey))
        )
      ],
    );
  }
}