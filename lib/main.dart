import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:provider/provider.dart';
import 'Dart:ui' as ui;

import 'package:selftourapp/src/bloc/login_bloc.dart';
//import 'package:selfttour/src/mapbox/screen_map.dart';
import 'package:selftourapp/src/googlemaps/screen_mapa/mapa.dart';
import 'package:selftourapp/src/googlemaps/states/app_state.dart';
//import 'package:selfttour/src/models/categoria_model.dart';
//import 'package:selfttour/src/models/tour_categoria_model.dart';
//import 'package:selfttour/src/googlemaps/states/app_state.dart';

import 'package:selftourapp/src/pages/options_aditional/intro_page.dart';
import 'package:selftourapp/src/pages/pagos/pagado_page.dart';
import 'package:selftourapp/src/pages/pagos/pagos_page.dart';
import 'package:selftourapp/src/pages/tours/TabsPage.dart';
import 'package:selftourapp/src/pages/buscador_page.dart';
import 'package:selftourapp/src/pages/create_account/create_account_page.dart';
import 'package:selftourapp/src/pages/home.dart';

//Archivos creados
import 'package:selftourapp/src/pages/login/forget_password_page.dart';
import 'package:selftourapp/src/pages/login/login_page.dart';
import 'package:selftourapp/src/pages/login/sesion_page.dart';
import 'package:selftourapp/src/pages/login_page.dart';
import 'package:selftourapp/src/pages/news/news_page.dart';
import 'package:selftourapp/src/pages/news/slider_image.dart';
import 'package:selftourapp/src/pages/options_aditional/app_theme_page.dart';
import 'package:selftourapp/src/pages/options_aditional/news_device_page.dart';
import 'package:selftourapp/src/pages/options_aditional/news_domains_place.dart';
import 'package:selftourapp/src/pages/options_aditional/slider_page.dart';
import 'package:selftourapp/src/pages/tours/busqueda_tour_page.dart';

import 'package:selftourapp/src/pages/tours/detalle_tour_page.dart';
import 'package:selftourapp/src/pages/tours/home_page.dart';
import 'package:selftourapp/src/pages/tours/lista_tour_page.dart';
import 'package:selftourapp/src/pages/usuario/edicion_informacion_page.dart';
import 'package:selftourapp/src/pages/usuario/infousuario_page.dart';
import 'package:selftourapp/src/pages/usuario/preferencia_idioma.dart';
import 'package:selftourapp/src/pages/usuario/profile_user_page.dart';
import 'package:selftourapp/src/pages/registro_page.dart';

import 'package:selftourapp/src/pages/usuario/Inicio_page.dart';
import 'package:selftourapp/src/pages/usuario/tours_user_page.dart';
import 'package:selftourapp/src/pages/usuario/tourscomprados_page.dart';
//import 'package:selftourapp/src/pages/usuario/usuarios_chat_page.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:selftourapp/src/providers/pagos_provider.dart';
import 'package:selftourapp/src/providers/push_notifications_provider.dart';
import 'package:selftourapp/src/translation_class/app_translations_delegate.dart';
import 'package:selftourapp/src/translation_class/application.dart';
//import 'package:selfttour/src/utils/utils.dart';
import 'package:selftourapp/src/widgets/fotos_sitio.dart';
import 'package:selftourapp/src/widgets/galeria_fotos_tour.dart';
// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

void main() async{
  //Crea una instancia de la clase PreferenciasUsuario
  
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
 final prefs = new PreferenciasUsuario();
 await prefs.initPrefs();
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]
    ).then((_){
      
          runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: AppState(),),
            ChangeNotifierProvider.value(value: PagosProvider())
          ],
          child: MyApp(),
        )
        //MyApp()
      );
    });
  }


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  //Se maneja el estado de la navegación de la aplicación
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  PreferenciasUsuario prefs = PreferenciasUsuario();

  FlutterLocalNotificationsPlugin localNotificationsPlugin;
    
  AppTranslationsDelegate _newLocaleDelegate;
  PushNotificationProvider pushProvider;

  Locale locale;

  @override
  void initState() {
    super.initState();
    /*localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final android = AndroidInitializationSettings(
      "@mipmap/ic_launcher"
    );
    final ios = IOSInitializationSettings();
    final initializationSettings = InitializationSettings(android, ios);
    localNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String payload){

      }
    );*/
    //Aquí se inicializa las notificaciones
    pushProvider = new PushNotificationProvider();
    pushProvider.initNotification();
    //Se escucha el mensaje de la notificación
    //Y se navega a otra pantalla o a la pantalla en donde se encuentre
    //El contenido del mensaje
    /*pushProvider.mensajes.listen((data){
      print('Argumento del push');
      print(data);
      //mostrarAlerta(context, data, data, 'assets/check.png');
      //navigatorKey.currentState.pushNamed('busquedatour');
      navigatorKey.currentState.push(MaterialPageRoute(
        builder: (context){
          return ChatUsuariosPage();
        }
      ));
    });*/
    prefs.idioma = Locale(ui.window.locale.languageCode);
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: prefs.idioma == null ? Locale('es'):Locale(prefs.idioma));
    application.onLocaleChanged = onLocaleChange;
    
  }
  
  void onLocaleChange(Locale locale){
    setState(() {
     _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
     prefs.idioma = _newLocaleDelegate.newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
     statusBarColor: Colors.white,
     //systemNavigationBarColor: Colors.white, //Color de la bottom app bar del sistema
     //systemNavigationBarDividerColor: Colors.white,
     //statusBarIconBrightness: Brightness.light,//Color del fondo del bottom app bar del sistema
     //systemNavigationBarIconBrightness: Brightness.dark //Color de los íconos del bottom app bar del sistema
   ));

   
    final prefs = new PreferenciasUsuario();
    print(prefs.token);

    return BlocProvider(
      child: MaterialApp(
        /*supportedLocales: [
          const Locale('en',''),
          const Locale('es',''),
          const Locale('fr',''),
          const Locale('zh','')
        ],*/
        //showPerformanceOverlay: true,
        supportedLocales: application.supportedLocales(),
        localizationsDelegates: [
          _newLocaleDelegate,
          const AppTranslationsDelegate(),
          //provides localised strings
          GlobalMaterialLocalizations.delegate,
          //provides RTL support, traduce los elementos a los idiomas
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          /*for(var supportedLocale in supportedLocales){
            if(supportedLocale.languageCode == locale.languageCode && supportedLocale.countryCode == locale.countryCode){
              return supportedLocale;
            }
          }*/
          //locale = supportedLocales.first;
          //locale = locale;
          //prefs.idioma = supportedLocales.first;
          
          //return supportedLocales.first;
          
          //prefs.idioma = Locale(locale.languageCode);
            /*print("Preferencia de idioma");
            print(prefs.idioma);*/
         return locale;
       },
       
        debugShowCheckedModeBanner: false,
        //Se maneja el estado del material app
        navigatorKey: pushProvider.navigationKey,//navigatorKey
        title: 'SelfTour',
        initialRoute: 'menuprincipal',
        routes: {
          '/'              : (BuildContext context)=>IndexPage(),
          'tours'          : (BuildContext context)=>ListaTourPage(),
          'busquedatour'   : (BuildContext context)=>BusquedaTourPage(),
          '/detalletour'    : (BuildContext context)=>DetalleTourPage(),
          'galeriatour'    : (BuildContext context)=>GaleriaTourPage(),
          'googlemap'      : (BuildContext context)=>Mapa(),
          'comprar'        : (BuildContext context)=>PagosPage(),
          'detallecompra'  : (BuildContext context)=>DetalleCompraPage(),
          'metodopago'     : (BuildContext context)=>MetodoPagoPage(),
          'ingresotarjeta' : (BuildContext context)=>IngresoTarjetaPage(),
          'pagado'         : (BuildContext context)=>PagadoPage(),
          //'mapbox'         : (BuildContext context)=>MapaBox(),
          'tourcomprado'   : (BuildContext context)=>ToursCompradosPage(),
          'sesionpage'     : (BuildContext context)=>SesionPage(),
          'login'          : (BuildContext context)=>Login(),
          'perfil'         : (BuildContext context)=>ProfileUserPage(),
          'prefidioma'     : (BuildContext context)=>PreferenciaIdioma(),
          'infousuario'    : (BuildContext context)=>InfoUsuarioPage(),
          'dialogo'        : (BuildContext context)=>Dialog(),
          'editarinfo'     : (BuildContext context)=>EditInformationPage(),
          'forgetpassword' : (BuildContext context)=>ForgetPasswordPage(),
          'createaccount'  : (BuildContext context)=>CreateAccountPage(),
          'inicio'         : (BuildContext context)=>InicioPage(),
          'newsdevice'     : (BuildContext context)=>NewsDevicePage(),
          'newsdomains'    : (BuildContext context)=>NewsDomainsPlacePage(),
          'apptheme'       : (BuildContext context)=>AppThemePage(),
          'news'           : (BuildContext context)=>NewsPage(),
          'slider'         : (BuildContext context)=>SliderImage(),
          'intro'          : (BuildContext context)=>IntroPage(),
          'slidepage'      : (BuildContext context)=>SliderOptionsPage(),
          'menuprincipal'  : (BuildContext context)=>TabsPage(),
          'toursuser'      : (BuildContext context)=>ToursUserPage(),

          'loginusuario'   : (BuildContext context)=>LoginPage(),
          'registro'       : (BuildContext context)=>RegistroPage(),
          'galeria'        : (BuildContext context)=>GaleriaPage(),
          //'/'   : (BuildContext context) => BuscadorPage(),
          'index'          : (BuildContext context)=>Home(),
          'buscarTour'     : (BuildContext context)=>BuscadorPage(),
          
          
          //'home'   : (BuildContext context) => HomePage(),
          //'galeria'   : (BuildContext context) => GaleriaPage(),
          //'slider' : (BuildContext context) => SliderPage(),
        },
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColorLight: Colors.white,
          //primaryColorDark: Colors.black, //Color del fondo de un widget
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.white, //Color(0xFF034485)
          hintColor: Colors.white24,
          //cursorColor: Colors.white70,
        ),
      ),
      bloc: LoginBloc(),
    );
  }
  
}