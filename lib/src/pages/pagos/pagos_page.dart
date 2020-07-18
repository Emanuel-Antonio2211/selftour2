import 'dart:io';

import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
//import 'package:flutter_date_picker/flutter_date_picker.dart';
//import 'package:selfttour/src/models/detalle_tour_model.dart';
import 'package:selftourapp/src/models/tarjeta_model.dart';
import 'package:selftourapp/src/models/tour_categoria_model.dart';
import 'package:selftourapp/src/pages/login/sesion_page.dart';
import 'package:selftourapp/src/pages/pagos/vistapaypal_page.dart';
//import 'package:selfttour/src/pages/tours/detalle_tour_page.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:selftourapp/src/providers/categorias_providers.dart';
import 'package:selftourapp/src/providers/pagos_provider.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';
import 'package:selftourapp/src/utils/utils.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:selftourapp/src/widgets/tree_size_dot_widget.dart';
import 'package:provider/provider.dart';

class PagosPage extends StatefulWidget {
  @override
  _PagosPageState createState() => _PagosPageState();
}

class _PagosPageState extends State<PagosPage> {
  final format = DateFormat("dd-MM-yyyy"); //yyyy-MM-dd
  final timeFormat = DateFormat("h:mm a");
  DateTime date;
  TimeOfDay time;

  @override
  Widget build(BuildContext context) {
   // final DetalleTour detalleTour = ModalRoute.of(context).settings.arguments;
    final InfoTour detalleTour = ModalRoute.of(context).settings.arguments;
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Datos de Pago'),
        actions: <Widget>[
          FlatButton(
            child: Text('Iniciar Sesión',style: TextStyle(color: Colors.white),),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context){
                  return SesionPage();
                },
                fullscreenDialog: true
              ));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
              children: <Widget>[
                SafeArea(
                  child: SizedBox(
                    height: size.height * 0.04,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Nombre:',style: TextStyle(fontSize: 20.0),),
                    Container(
                      width: size.width * 0.9,
                      height: size.height * 0.04,
                      child: TextFormField(
                        keyboardType: TextInputType.text,

                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Correo:',style: TextStyle(fontSize: 20.0),),
                    Container(
                      width: size.width * 0.9,
                      height: size.height * 0.04,
                      child: TextFormField(
                        keyboardType: TextInputType.text,

                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Fecha:',style: TextStyle(fontSize: 20.0),),
                    /*Container(
                      width: size.width * 0.6,
                      height: size.height * 0.04,
                      child: TextFormField(
                        keyboardType: TextInputType.text,

                      ),
                    )*/
                    Container(
                      width: size.width * 0.9,
                      height: size.height * 0.05,
                      child: DateTimeField(
                        format: format,
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                        },
                      ),
                    ),
                  
                  ],
                ),
                SizedBox(
                  height: size.height * 0.2,
                ),
               /* Card(
                  elevation: 0.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(detalleTour.title),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image.network(
                          detalleTour.route[0]['gallery'][0]['url'],
                          width: 120.0,
                          height: 120.0,
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                ),*/
               /* SizedBox(
                  height: size.height * 0.03,
                  child: Container(
                    padding: EdgeInsets.only(left: 10.0, right: 20.0),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                ),*/
               /* GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context){
                        return MetodoPagoPage();
                      },
                      settings: RouteSettings(arguments: detalleTour),
                      fullscreenDialog: true
                    ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(Icons.add_box,color: Colors.grey,),
                      Text('Agregar método de Pago',style: TextStyle(fontSize: 18.0)),
                      Icon(Icons.navigate_next,color: Colors.grey,)
                    ],
                  ),
                ),*/
                /*SizedBox(
                  height: size.height * 0.03,
                  child: Container(
                    padding: EdgeInsets.only(left: 10.0, right: 20.0),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                ),*/
               /* Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Monto total',style: TextStyle(fontSize: 18.0)),
                    Text(detalleTour.budget)
                  ],
                ),*/
              /*  SizedBox(
                  height: size.height * 0.03,
                  child: Container(
                    padding: EdgeInsets.only(left: 10.0, right: 20.0),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),*/
                Center(
                  child: RaisedButton(
                    textTheme: ButtonTextTheme.primary,
                    shape: StadiumBorder(),
                    color: Colors.lightBlue,
                    child: Text('Siguiente',style: TextStyle(fontSize: 18.0,color: Colors.white),),
                    onPressed: (){
                      Navigator.pushNamed(context, 'detallecompra',arguments: detalleTour);
                    },
                  ),
                )
              ],
            ),
        ),
      ),
    );
  }

  

  
}

class DetalleCompraPage extends StatefulWidget {
  @override
  _DetalleCompraPageState createState() => _DetalleCompraPageState();
}

class _DetalleCompraPageState extends State<DetalleCompraPage> {
  CategoriasProvider _categoriasProvider = CategoriasProvider();
  PreferenciasUsuario _prefs = PreferenciasUsuario();

  bool botonTraductor = true;
  bool botonTextoOriginal = false;
  bool botonTraductorRecomendacion = true;
  bool botonRecomendacion = false;
  String descripcionTour = '';
  String recomendacionTour = '';

    void _mostrarTraductor(){
      setState(() {
        botonTraductor = true;
        botonTextoOriginal = false;
      });
    }

    void _ocultarTraductor(){
      setState(() {
        botonTraductor = false;
        botonTextoOriginal = true;
      });
    }

    void _mostrarTraductorRecomendaciones(){
      setState(() {
        botonTraductorRecomendacion = true;
        botonRecomendacion = false;
      });
    }
    void _ocultarTraductorRecomendacion(){
      setState(() {
        botonRecomendacion = true;
        botonTraductorRecomendacion = false;
      });
    }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String detalleCompra = AppTranslations.of(context).text('title_detallecompra');
    String revisionCompra = AppTranslations.of(context).text('title_avisocompra');
    String descripcion = AppTranslations.of(context).text('title_description');
    String recomendacion = AppTranslations.of(context).text('title_recommendation');
    String montototal = AppTranslations.of(context).text('title_montototal');
    String siguiente = AppTranslations.of(context).text('title_siguiente');
    String traducir = AppTranslations.of(context).text('title_traducir');
    String textoOriginal = AppTranslations.of(context).text('title_texto_original');
    
    //DetalleTour detalleTour = ModalRoute.of(context).settings.arguments;
    final InfoTour detalleTour = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
        elevation: 0.0,
        title: Text(
          '$detalleCompra',
          style: TextStyle(
            fontFamily: 'Point-ExtraBold',
            color: Colors.black
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SafeArea(
              child: SizedBox(
                height: size.height * 0.04,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:10.0),
              child: Center(
                child: Text(
                  '$revisionCompra',
                  style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 17.0),
                  )
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(
                    child: Text( 
                      detalleTour.title == null ? '' : detalleTour.title,
                      style: TextStyle(
                        fontFamily: 'Point-SemiBold'
                      ),
                      //overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.network(
                      detalleTour.route[0]['gallery'][0]['url'],
                      width: 120.0,
                      height: 120.0,
                      fit: BoxFit.fill,
                      scale: 1.0,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
           /* Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text('Fecha: dd - mm - AAAA')
            ),
            SizedBox(
              height: size.height * 0.04,
            ),*/
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  
                  Text('$descripcion:',style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 17.0),),
                  Container(
                    color: Colors.white,
                    width: 10.0,
                    height: 10.0,
                    child: FutureBuilder(
                      future: _categoriasProvider.detectarIdioma(detalleTour.description),
                      //initialData: InitialData,
                      builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot) {
                        if(snapshot.hasData){
                          final resp = snapshot.data;
                          _prefs.idiomaDescripcion = Locale(resp['data']['detections'][0][0]['language']);
                          return Container();
                        }else{
                          return Container(
                            color: Colors.white,
                            height: 10.0,
                          );
                        }
                        
                      },
                    ),
                  ),
                  _prefs.idioma == _prefs.idiomaDescripcion ?
                  Container():
                  Row(
                    children: <Widget>[
                      botonTraductor ? 
                      FlatButton(
                        padding: EdgeInsets.zero,
                        onPressed: ()async{
                          Map<String,dynamic> respDescripcion = await _categoriasProvider.traducir(_prefs.idioma == null ? 'es':_prefs.idioma, detalleTour.description);
                          descripcionTour = respDescripcion['data']['translations'][0]['translatedText'];
                          _ocultarTraductor();
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
                        padding: EdgeInsets.zero,
                        onPressed: ()async{
                           _mostrarTraductor();
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
                  !botonTraductor ? Text(
                    descripcionTour,
                    style: TextStyle(
                      fontFamily: 'Point-SemiBold'
                    ),
                    textAlign: TextAlign.justify
                  ):
                  Text( 
                    detalleTour.description == null ? '' : detalleTour.description,
                    style: TextStyle(
                      fontFamily: 'Point-SemiBold'
                      ),
                      textAlign: TextAlign.justify
                    ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                 
                  Text('$recomendacion:',style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 17.0),),
                  Container(
                    color: Colors.white,
                    width: 10.0,
                    height: 10.0,
                    child: FutureBuilder(
                      future: _categoriasProvider.detectarIdioma(detalleTour.requeriments),
                      //initialData: InitialData,
                      builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot) {
                        if(snapshot.hasData){
                          final resp = snapshot.data;
                          _prefs.idiomaRecomendacion = Locale(resp['data']['detections'][0][0]['language']);
                          return Container();
                        }else{
                          return Container(
                            color: Colors.white,
                            height: 10.0,
                          );
                        }
                        
                      },
                    ),
                  ),
                  _prefs.idioma == _prefs.idiomaRecomendacion ?
                  Container():
                  Row(
                    children: <Widget>[
                      botonTraductorRecomendacion ?
                      FlatButton(
                        padding: EdgeInsets.zero,
                        onPressed: ()async{
                          Map<String,dynamic> respRecomendacion = await _categoriasProvider.traducir(_prefs.idioma == null ? 'es':_prefs.idioma, detalleTour.requeriments);
                          recomendacionTour = respRecomendacion['data']['translations'][0]['translatedText'];
                          _ocultarTraductorRecomendacion();
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
                        padding: EdgeInsets.zero,
                        onPressed: ()async{
                           _mostrarTraductorRecomendaciones();
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
                  !botonTraductorRecomendacion ?
                  Text(
                    recomendacionTour,
                    style: TextStyle(
                      fontFamily: 'Point-SemiBold',
                    ),
                    textAlign: TextAlign.justify,
                  ):
                  Text( 
                    detalleTour.requeriments == null ? '' : detalleTour.requeriments,
                    style: TextStyle(
                      fontFamily: 'Point-SemiBold'
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('$montototal',style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 18.0),),

                Text( detalleTour.price == null ? '' : '\$ ${double.parse( detalleTour.price.toString()).toString()}',style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 18.0))
              ],
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            RaisedButton(
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              color: Color(0xFFD62250),
              child: Text('$siguiente',style: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.white),),
              onPressed: (){
                Navigator.pushNamed(context, 'metodopago',arguments: detalleTour);
              },
            )
          ],
        ),
      ),
    );
  }
}

class MetodoPagoPage extends StatefulWidget {
  @override
  _MetodoPagoPageState createState() => _MetodoPagoPageState();
}

class _MetodoPagoPageState extends State<MetodoPagoPage> {
  final formKey = GlobalKey<FormState>();
  //PagosProvider pagosProvider = PagosProvider();
  PreferenciasUsuario prefs = PreferenciasUsuario();

  String deviceSesionId;
  String idTarjeta;

  @override
  void initState() {
    super.initState();
    //idTarjeta = prefs.idTarjeta;
   // _getDeviceSesionId();
    
  }

 /*Future<String> _getDeviceSesionId()async{
    await pagosProvider.getDeviceId().then((result){
      deviceSesionId = result;
      setState(() {
     
     print("Device sesion id: $deviceSesionId");
      });
   }).catchError((error){
     print(error);
   });
   return deviceSesionId;
  }*/

  @override
  Widget build(BuildContext context) {
   // DetalleTour detalleTour = ModalRoute.of(context).settings.arguments;
    final InfoTour detalleTour = ModalRoute.of(context).settings.arguments;
    
    return _metodoPago(context,detalleTour);
  }

  Widget _metodoPago(BuildContext context,InfoTour detalleTour){
    final size = MediaQuery.of(context).size;
    String revisionpago = AppTranslations.of(context).text('title_revisioncompra');
    String metodopago = AppTranslations.of(context).text('title_metodopago');
    String tarjetacredito = AppTranslations.of(context).text('title_tarjetacredito');
    String cupon = AppTranslations.of(context).text('title_cupon');
    String ingresecupon = AppTranslations.of(context).text('title_ingresecupon');
    String politicacancelacion = AppTranslations.of(context).text('title_politicacancelacion');
    String termcondicion = AppTranslations.of(context).text('title_termcondicion');
    String pagar = AppTranslations.of(context).text('title_pagar');
    String exitopago = AppTranslations.of(context).text('title_exitopago');
    String pagosuccess = AppTranslations.of(context).text('title_pagosuccess');
    String addTarjeta = AppTranslations.of(context).text('title_add_tarjeta');

    PagosProvider pagosProvider = Provider.of<PagosProvider>(context);

    pagosProvider.obtenerToken(prefs.idTarjeta.toString());

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
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
        title: Text('$revisionpago',style: TextStyle(fontFamily: 'Point-ExtraBold',fontSize: 18.0),),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SafeArea(
                  child: SizedBox(
                    height: size.height * 0.04,
                ),
              ),
             /* Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(detalleTour.title,style: TextStyle(fontFamily: 'Point-SemiBold'),),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.network(
                      detalleTour.route[0]['gallery'][0]['url'],
                      width: 120.0,
                      height: 120.0,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.03,
              ),*/
             /* Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text('Fecha: dd - mm - AAAA')
              ),
              SizedBox(
                height: size.height * 0.03,
              ),*/
              Center(
                child: Text('$metodopago',style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 17.0),)
              ),
              SizedBox(
                    height: size.height * 0.02,
              ),
              /*SizedBox(
                  height: size.height * 0.03,
                  child: Container(
                    padding: EdgeInsets.only(left: 10.0, right: 20.0),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
              ),*/
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child:GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, 'ingresotarjeta',arguments: detalleTour);
                },
                child: Card(
                  child: Container(
                    width: size.width * 0.9,
                    height: size.height * 0.1,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Color(0xFFD62250),
                              child: Icon(Icons.credit_card,color: Colors.white,),
                            ),
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            Text(
                              '$addTarjeta',
                              style: TextStyle(fontFamily: 'Point-SemiBold'),
                            ),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios,color: Colors.grey,)
                      ],
                    ),
                  ),
                ),
              )
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                '$tarjetacredito',
                style: TextStyle(
                  fontFamily: 'Point-SemiBold',
                  color: Colors.grey
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            (prefs.idTarjeta == '') ?
            Card(
              elevation: 0.0,
              child: Container(
                  width: size.width * 1.0,
                  height: size.height * 0.1,//|| tarjeta['card']['card_number'] == '[]'
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(Icons.credit_card,color: Colors.grey,),
                      //tarjeta[0]['card']['card_number']
                      
                      Text('$tarjetacredito',style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 18.0)),
                      //Text('${tarjeta[0]['card']['card_number']}',style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 18.0)),
                      Icon(Icons.navigate_next,color: Colors.grey,)
                    ],
                  ),
            )
            ):
            StreamBuilder(
              stream: pagosProvider.pagosStream,//pagosProvider.obtenerToken(prefs.idTarjeta.toString())
              builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot) {
                final tieneDatos = snapshot.hasData;
                if(!tieneDatos){
                  return Card(
                    elevation: 0.0,
                    child: Container(
                        width: size.width * 1.0,
                        height: size.height * 0.1,//|| tarjeta['card']['card_number'] == '[]'
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(Icons.credit_card,color: Colors.grey,),
                            //tarjeta[0]['card']['card_number']
                            
                            Text('$tarjetacredito',style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 18.0)),
                            //Text('${tarjeta[0]['card']['card_number']}',style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 18.0)),
                            Icon(Icons.navigate_next,color: Colors.grey,)
                          ],
                        ),
                  )
                  );
                }else{
                  final tarjeta = snapshot.data;
                  if(tarjeta['error_code'] == 1005){
                    //Cuando el token no existe
                    return Card(
                      elevation: 0.0,
                      child: Container(
                        width: size.width * 1.0,
                        height: size.height * 0.1,//|| tarjeta['card']['card_number'] == '[]'
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(Icons.credit_card,color: Colors.grey,),
                            //tarjeta[0]['card']['card_number']
                            
                            Text('$tarjetacredito',style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 18.0)),
                            //Text('${tarjeta[0]['card']['card_number']}',style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 18.0)),
                            Icon(Icons.navigate_next,color: Colors.grey,)
                          ],
                        )
                      ),
                    );
                  }else{
                    return Card(
                      elevation: 0.0,
                      child: Container(
                        width: size.width * 1.0,
                        height: size.height * 0.1,//|| tarjeta['card']['card_number'] == '[]'
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(Icons.credit_card,color: Colors.grey,),
                            
                            //Text('$tarjetacredito',style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 18.0)):
                            Text('${tarjeta['card']['card_number']}',style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 18.0)),
                            Icon(Icons.navigate_next,color: Colors.grey,)
                          ],
                        ),
                      ),
                    );
                  }
                }
                // return Card(
                //       elevation: 0.0,
                //       child: Container(
                //         width: size.width * 1.0,
                //         height: size.height * 0.1,//|| tarjeta['card']['card_number'] == '[]'
                //         child: !tieneDatos || prefs.idTarjeta == '' || tarjeta['error_code'] == 1005 ? 
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //           children: <Widget>[
                //             Icon(Icons.credit_card,color: Colors.grey,),
                //             //tarjeta[0]['card']['card_number']
                            
                //             Text('$tarjetacredito',style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 18.0)),
                //             //Text('${tarjeta[0]['card']['card_number']}',style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 18.0)),
                //             Icon(Icons.navigate_next,color: Colors.grey,)
                //           ],
                //         ):  Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //           children: <Widget>[
                //             Icon(Icons.credit_card,color: Colors.grey,),
                            
                //             //Text('$tarjetacredito',style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 18.0)):
                //             Text('${tarjeta['card']['card_number']}',style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 18.0)),
                //             Icon(Icons.navigate_next,color: Colors.grey,)
                //           ],
                //         ),
                //       ),
                //     );
                
              },
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
              SizedBox(
                height: size.height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  '$cupon:',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Point-SemiBold',
                    fontSize: 17.0
                  )
                ),
              ),
             /* SizedBox(
                height: size.height * 0.03,
              ),*/
              /*Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('$ingresecupon',style: TextStyle(fontFamily: 'Point-SemiBold'),),
                      TextFormField(
                        keyboardType: TextInputType.text,
                      ),
                    ],
                  ),
              ),*/
              SizedBox(
                height: size.height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  '$politicacancelacion:',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Point-SemiBold',
                    fontSize: 17.0
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Cupidatat voluptate officia ad labore commodo do ad consectetur commodo nisi tempor. Aute voluptate magna cillum amet. Consequat proident labore duis incididunt.',
                  style: TextStyle(fontFamily: 'Point-SemiBold'),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  '$termcondicion:',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Point-SemiBold',
                    fontSize: 17.0
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Cupidatat voluptate officia ad labore commodo do ad consectetur commodo nisi tempor. Aute voluptate magna cillum amet. Consequat proident labore duis incididunt.',
                  style: TextStyle(fontFamily: 'Point-SemiBold'),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              
              Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: ProgressButton(
                    defaultWidget: Text(
                      '$pagar',
                      style: TextStyle(
                        fontFamily: 'Point-SemiBold',
                        color: Colors.white,
                        fontSize: 17.0
                      ),
                    ),
                    progressWidget: ThreeSizeDot(
                      //color_1: Colors.black54,
                      //color_2: Colors.black54,
                      //color_3: Colors.black54,
                    ),
                    color: Colors.redAccent,
                    type: ProgressButtonType.Raised,
                    width: 154,
                    height: 38,
                    borderRadius: 5.0,
                    animate: false,
                    onPressed: ()async{
                      //Duration(seconds: 2)
                      await Future.delayed(Duration(seconds: 2),()async{
                        //deviceSesionId
                        //detalleTour.budget.trimLeft().substring(2,5)
                       await pagosProvider.cargarTarjetaToken('${prefs.idTarjeta}', detalleTour.price.toString(), detalleTour.title, prefs.name, prefs.email).then((datos){
                          Map info = datos; //kp91f5gmxstvlsuiwz5r k9qucnplcdfvl3o5v6ae
                        if(info['error_code'] == 1000){
                        //Ocurrió un error en el servidor openpay
                        String errorServerOpenpay = AppTranslations.of(context).text('title_error_server_openpay');
                        //info['description']
                        mostrarAlerta(context, errorServerOpenpay, '', 'assets/error.png');
                      }else if(info['error_code']== 1001){
                        //Formato de la petición no es json.
                        //los campos no tienen el formato correcto, o la petición no tiene campos que son requeridos.
                        String formatNotJson = AppTranslations.of(context).text('title_format_no_json');
                        //info['description']
                        mostrarAlerta(context, formatNotJson, '', 'assets/error.png');
                      }else if(info['error_code'] == 1002){
                        //La llamada no esta autenticada o la autenticación es incorrecta.
                        String autenticacionIncorrect = AppTranslations.of(context).text('title_autentication_incorrect');
                        //info['description']
                        mostrarAlerta(context, autenticacionIncorrect, '', 'assets/error.png');
                      }else if(info['error_code'] == 1003){
                        //La operación no se pudo completar 
                        //por que el valor de uno o más de los parametros no es correcto.
                        String operacionNoCompleta = AppTranslations.of(context).text('title_operacion_not_complete');
                        //info['description']
                        mostrarAlerta(context, operacionNoCompleta, '', 'assets/error.png');
                      }else if(info['error_code'] == 1004){
                        //Un servicio necesario para el procesamiento de la
                        //transacción no se encuentra disponible.
                        String servicioNoDisponible = AppTranslations.of(context).text('title_service_not_enabled');
                        //info['description']
                        mostrarAlerta(context, servicioNoDisponible, '', 'assets/error.png');
                      }else if(info['error_code'] == 1005){
                        //Uno de los recursos requeridos no existe.
                        String recursoNoDisponible = AppTranslations.of(context).text('title_resource_not_disabled');
                        //info['description']
                        mostrarAlerta(context, recursoNoDisponible, '', 'assets/error.png');
                      }else if(info['error_code'] == 1006){
                        //Ya existe una transacción con el mismo ID de orden.
                        String transactionExist = AppTranslations.of(context).text('title_transaction_exist');
                        //info['description']
                        mostrarAlerta(context, transactionExist, '', 'assets/error.png');
                      }else if(info['error_code'] == 1007){
                        //La transferencia de fondos entre una cuenta de
                        //banco o tarjeta y la cuenta de Openpay no fue aceptada.
                        String transferNoAceptada = AppTranslations.of(context).text('title_transfer_not_acept');
                        //info['description']
                        mostrarAlerta(context, transferNoAceptada, '', 'assets/error.png');
                      }else if(info['error_code'] == 1008){
                        //Una de las cuentas requeridas en la petición se
                        //encuentra desactivada.
                        String cuentaDesactivada = AppTranslations.of(context).text('title_account_desactivate');
                        //info['description']
                        mostrarAlerta(context, cuentaDesactivada, '', 'assets/error.png');
                      }else if(info['error_code'] == 1009){
                        //El cuerpo de la petición es demasiado grande.
                        String bodyMoreLonger = AppTranslations.of(context).text('title_require_more_long');
                        //info['description']
                        mostrarAlerta(context, bodyMoreLonger, '', 'assets/error.png');
                      }else if(info['error_code'] == 1010){
                        //Se esta utilizando la llave pública para hacer una
                        //llamada que requiere la llave privada, o bien, se esta
                        //usando la llave privada desde JavaScript.
                        String keyPrivate = AppTranslations.of(context).text('title_key_private');
                        //info['description']
                        mostrarAlerta(context, keyPrivate,'', 'assets/error.png');
                      }else if(info['error_code'] == 2001){
                        //La cuenta de banco con esta CLABE ya se
                        //encuentra registrada en el cliente.
                        String cuentaRegistrada = AppTranslations.of(context).text('title_account_registered');
                        //info['description']
                        mostrarAlerta(context, cuentaRegistrada, '', 'assets/error.png');
                      }else if(info['error_code'] == 2002){
                        //La tarjeta con este número ya se encuentra
                        //registrada en el cliente.
                        String cardRegistered = AppTranslations.of(context).text('title_card_registered');
                        //info['description']
                        mostrarAlerta(context, cardRegistered,'', 'assets/error.png');
                      }else if(info['error_code'] == 2003){
                        //El cliente con este identificador externo (External ID)
                        //ya existe.
                        String clientExist = AppTranslations.of(context).text('title_client_exist');
                        //info['description']
                        mostrarAlerta(context, clientExist, '', 'assets/error.png');
                      }else if(info['error_code'] == 2004){
                        //El dígito verificador del número de tarjeta es inválido
                        //de acuerdo al algoritmo Luhn.
                        String digitInvalid = AppTranslations.of(context).text('title_digit_invalid');
                        //info['description']
                        mostrarAlerta(context, digitInvalid , '', 'assets/error.png');
                      }else if(info['error_code'] == 2005){
                        //La fecha de expiración de la tarjeta es anterior a la
                        //fecha actual.
                        String dateExpired = AppTranslations.of(context).text('title_date_expired');
                        //info['description']
                        mostrarAlerta(context, dateExpired , '', 'assets/error.png');
                      }else if(info['error_code'] == 2006){
                        //El código de seguridad de la tarjeta (CVV2) no fue
                        //proporcionado.
                        String codeSecurityEmpty = AppTranslations.of(context).text('title_code_security_empty');
                        //info['description']
                        mostrarAlerta(context, codeSecurityEmpty , '', 'assets/error.png');
                      }else if(info['error_code'] == 2007){
                        //El número de tarjeta es de prueba, solamente puede
                        //usarse en Sandbox.
                        String cardTest = AppTranslations.of(context).text('title_card_test');
                        //info['description']
                        mostrarAlerta(context, cardTest , '', 'assets/error.png');
                      }else if(info['error_code'] == 2008){
                        //La tarjeta consultada no es valida para puntos.
                        String cardNoPoints = AppTranslations.of(context).text('title_card_not_points');
                        //info['description']
                        mostrarAlerta(context, cardNoPoints , '', 'assets/error.png');
                      }else if(info['error_code'] == 2009){
                        //El código de seguridad de la tarjeta (CVV2) no es valido.
                        String codeSecurityNoValid = AppTranslations.of(context).text('title_card_not_valid');
                        //info['description']
                        mostrarAlerta(context, codeSecurityNoValid , '', 'assets/error.png');
                      }else if(info['error_code'] == 3001){
                        String tarjetaDeclinada = AppTranslations.of(context).text('title_card_declined');
                        //La tarjeta fue declinada.
                        //info['description']
                        mostrarAlerta(context, tarjetaDeclinada, '', 'assets/error.png');
                      }else if(info['error_code'] == 3002){
                        //La tarjeta ha expirado.
                        String tarjetaExpirada = AppTranslations.of(context).text('title_card_expired');
                        //info['description']
                        mostrarAlerta(context, tarjetaExpirada, '', 'assets/error.png');
                      }else if(info['error_code'] == 3003){
                        //La tarjeta no tiene fondos suficientes.
                        String tarjetaSinFondos = AppTranslations.of(context).text('title_card_not_funds');
                        //info['description']
                        mostrarAlerta(context, tarjetaSinFondos, '', 'assets/error.png');
                      }else if(info['error_code'] == 3004){
                        //La tarjeta ha sido identificada como una tarjeta
                        //robada.
                        String tarjetaRobada = AppTranslations.of(context).text('title_card_lost');
                        //info['description']
                        mostrarAlerta(context, tarjetaRobada, '', 'assets/error.png');
                      }else if(info['error_code'] == 3005){
                        //La tarjeta ha sido identificada como una tarjeta
                        //fraudulenta.
                        String tarjetaFraudulenta = AppTranslations.of(context).text('title_card_fraudulent');
                        //info['description']
                        mostrarAlerta(context, tarjetaFraudulenta, '', 'assets/error.png');
                      }else if(info['error_code'] == 3006){
                        //La operación no esta permitida para este cliente o
                        //esta transacción.
                        String operacionNoPermitida = AppTranslations.of(context).text('title_operation_not_allowed');
                        //info['description']
                        mostrarAlerta(context, operacionNoPermitida, '', 'assets/error.png');
                      }else if(info['error_code'] == 3008){
                        //La tarjeta no es soportada en transacciones en linea.
                        String tarjetaNoSoportadaOnline = AppTranslations.of(context).text('title_card_not_support_online');
                        //info['description']
                        mostrarAlerta(context, tarjetaNoSoportadaOnline, '', 'assets/error.png');
                      }else if(info['error_code'] == 3009){
                        //La tarjeta fue reportada como perdida.
                        String tarjetaPerdida = AppTranslations.of(context).text('title_card_lost');
                        //info['description']
                        mostrarAlerta(context, tarjetaPerdida, '', 'assets/error.png');
                      }else if(info['error_code'] == 3010){
                        //El banco ha restringido la tarjeta.
                        String bankRestrictedCard = AppTranslations.of(context).text('title_bank_restricted_card');
                        //info['description']
                        mostrarAlerta(context, bankRestrictedCard, '', 'assets/error.png');
                      }else if(info['error_code'] == 3011){
                        //El banco ha solicitado que la tarjeta sea retenida.
                        //Contacte al banco.
                        String tarjetaRetenida = AppTranslations.of(context).text('title_card_withheld');
                        //info['description']
                        mostrarAlerta(context, tarjetaRetenida, '', 'assets/error.png');
                      }else if(info['error_code'] == 3012){
                        //Se requiere solicitar al banco autorización para
                        //realizar este pago.
                        String solictarPago = AppTranslations.of(context).text('title_autorization_buy');
                        //info['description']
                        mostrarAlerta(context, solictarPago, '', 'assets/error.png');
                      }else if(info['error_code'] == 4001){
                        //La cuenta de Openpay no tiene fondos suficientes.
                        String openpayNotFunds = AppTranslations.of(context).text('title_openpay_account_not_funds');
                        //info['description']
                        mostrarAlerta(context, openpayNotFunds, '', 'assets/error.png');
                      }
                          else{
                            //prefs.comprado = 'true';
                            //prefs.idtour = detalleTour.idtour.toString();
                            
                            print("Info: ");
                            print(info);

                            /*print("Datos a enviar");
                            print(prefs.token);
                            print(detalleTour.idtour.toString());
                            print(info['method']);
                            print(info['amount'].toString());*/
                            
                            print("Respuesta pago");
                            pagosProvider.registrarPago(prefs.token, detalleTour.idtour.toString(), info['method'], info['amount'].toString()).then((result){
                              print(result);
                            });
                            mostrarConfirmacion(context, '$exitopago', '$pagosuccess', 'assets/check.jpg');
                            
                            //mostrarAlerta(context, '$exitopago', '$pagosuccess', 'assets/check.jpg');
                          }
                        }).catchError((error){
                            mostrarAlerta(context, '${error.toString()}', '', 'assets/error.png');
                        });
                        //Navigator.popUntil(context, ModalRoute.withName('detalletour'));
                        //Navigator.popAndPushNamed(context, 'detalletour',arguments: detalleTour);
                        //Navigator.popUntil(context, ModalRoute.withName('detalletour'));
                        //mostrarAlerta(context, '$exitopago', '$pagosuccess', 'assets/check.jpg');
                      });
                    },
                  ),
                )
                
               /* RaisedButton(
                  textTheme: ButtonTextTheme.primary,
                  shape: StadiumBorder(),
                  color: Colors.redAccent,
                  child: Text('$pagar',style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 17.0),),
                  onPressed: (){
                    //deviceSesionId
                    pagosProvider.cargarTarjetaToken('${prefs.idTarjeta}', detalleTour.budget.trimLeft().substring(2,5), detalleTour.title, prefs.name, prefs.email).then((datos){
                      Map info = datos; //kp91f5gmxstvlsuiwz5r k9qucnplcdfvl3o5v6ae
                    if(info['error_code'] == 1000){
                    //Ocurrió un error en el servidor openpay
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code']== 1001){
                    //Formato de la petición no es json.
                    //os campos no tienen el formato correcto, o la petición no tiene campos que son requeridos.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 1002){
                    //La llamada no esta autenticada o la autenticación es incorrecta.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 1003){
                    //La operación no se pudo completar 
                    //por que el valor de uno o más de los parametros no es correcto.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 1004){
                    //Un servicio necesario para el procesamiento de la
                    //transacción no se encuentra disponible.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 1005){
                    //Uno de los recursos requeridos no existe.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 1006){
                    //Ya existe una transacción con el mismo ID de orden.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 1007){
                    //La transferencia de fondos entre una cuenta de
                    //banco o tarjeta y la cuenta de Openpay no fue aceptada.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 1008){
                    //Una de las cuentas requeridas en la petición se
                    //encuentra desactivada.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 1009){
                    //El cuerpo de la petición es demasiado grande.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 1010){
                    //Se esta utilizando la llave pública para hacer una
                    //lamada que requiere la llave privada, o bien, se esta
                    //usando la llave privada desde JavaScript.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 2001){
                    //La cuenta de banco con esta CLABE ya se
                    //encuentra registrada en el cliente.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 2002){
                    //La tarjeta con este número ya se encuentra
                    //registrada en el cliente.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 2003){
                    //El cliente con este identificador externo (External ID)
                    //ya existe.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 2004){
                    //El dígito verificador del número de tarjeta es inválido
                    //de acuerdo al algoritmo Luhn.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 2005){
                    //La fecha de expiración de la tarjeta es anterior a la
                    //fecha actual.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 2006){
                    //El código de seguridad de la tarjeta (CVV2) no fue
                    //proporcionado.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 2007){
                    //El número de tarjeta es de prueba, solamente puede
                    //usarse en Sandbox.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 2008){
                    //La tarjeta consultada no es valida para puntos.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 2009){
                    //El código de seguridad de la tarjeta (CVV2) no no es valido.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 3001){
                    //La tarjeta fue declinada.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 3002){
                    //La tarjeta ha expirado.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 3003){
                    //La tarjeta no tiene fondos suficientes.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 3004){
                    //La tarjeta ha sido identificada como una tarjeta
                    //robada.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 3005){
                    //La tarjeta ha sido identificada como una tarjeta
                    //fraudulenta.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 3006){
                    //La operación no esta permitida para este cliente o
                    //esta transacción.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 3008){
                    //La tarjeta no es soportada en transacciones en linea.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 3009){
                    //La tarjeta fue reportada como perdida.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 3010){
                    //El banco ha restringido la tarjeta.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 3011){
                    //El banco ha solicitado que la tarjeta sea retenida.
                    //Contacte al banco.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 3012){
                    //Se requiere solicitar al banco autorización para
                    //realizar este pago.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 4001){
                    //La cuenta de Openpay no tiene fondos suficientes.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }
                      else{
                        prefs.comprado = 'true';
                        mostrarConfirmacion(context, '$exitopago', '$pagosuccess', 'assets/check.jpg');
                        //mostrarAlerta(context, '$exitopago', '$pagosuccess', 'assets/check.jpg');
                      }
                    }).catchError((error){
                        mostrarAlerta(context, '${error.toString()}', '', 'assets/error.png');
                    });
                    //Navigator.popUntil(context, ModalRoute.withName('detalletour'));
                    //Navigator.popAndPushNamed(context, 'detalletour',arguments: detalleTour);
                    //Navigator.popUntil(context, ModalRoute.withName('detalletour'));
                    //mostrarAlerta(context, '$exitopago', '$pagosuccess', 'assets/check.jpg');
                    
                  },
                ),*/
              )
            ],
          ),
        ),
      ),
    );
  }

  

  Widget tarjetaItem(BuildContext context, TarjetaModel tarjeta){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Icon(Icons.credit_card,color: Colors.grey,),
        Text('${tarjeta.cardNumber.toString()}',style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 18.0)),
        Icon(Icons.navigate_next,color: Colors.grey,)
      ],
    );
  }

}

class IngresoTarjetaPage extends StatefulWidget {
  @override
  _IngresoTarjetaPageState createState() => _IngresoTarjetaPageState();
}

class _IngresoTarjetaPageState extends State<IngresoTarjetaPage> {
  int _radioValue1 = 0;
  int _radioValue2 = 1;
  final formKey = GlobalKey<FormState>();
  String deviceSesionId;
  PreferenciasUsuario prefs = PreferenciasUsuario();
  TarjetaModel tarjeta = TarjetaModel();
  PagosProvider pagosProvider = PagosProvider();

  List resultados=List();
  List infoDato = List();
  //Clientid de la cuenta de paypal developer
  String clientId = "AXIAUMr5Wvw1ArUNzexxNr_BzxecGVZhCDkKe66lXqAhw4CHRMIyr6oTXsdSiBWgcZjFFWWVlBpZJkKI"; //clientId de paypal developer AXIAUMr5Wvw1ArUNzexxNr_BzxecGVZhCDkKe66lXqAhw4CHRMIyr6oTXsdSiBWgcZjFFWWVlBpZJkKI

  final platform = MethodChannel('paypal');
  String result = '';
  List info = List();
  List datos = List();


  @override
  void initState() {
    super.initState();
    //_getDeviceSesionId();
  }

  Future<void> payment()async{
    await platform.invokeMethod('payment',{
      "precio": 10.0,
      "descripcion": "Este es una prueba",
      "lista": datos
      //"clientid": clientId
    });
  }

  Future<List> enlistar()async{


   infoDato = await platform.invokeListMethod('listaresult');
    print(infoDato);
   return infoDato;
  }

 /*Future<String> _getDeviceSesionId()async{
    await pagosProvider.getDeviceId().then((deviceId){
      deviceSesionId = deviceId;
      print(deviceSesionId);
    }).catchError((error){
      print(error);
    });
    return deviceSesionId;
  }*/

  @override
  Widget build(BuildContext context) {
    //DetalleTour detalleTour = ModalRoute.of(context).settings.arguments;
    InfoTour detalleTour = ModalRoute.of(context).settings.arguments;

if(Platform.isAndroid){
  if(infoDato.isEmpty){
      Future.delayed(
          Duration(seconds: 3),(){
        setState(() {

        });
        enlistar();
      
      }
      );
    }else{
      print(infoDato);
    }
}
    
    return _ingresoTarjeta(detalleTour);
  }
  Widget _ingresoTarjeta(InfoTour detalleTour){
    String entertarjeta = AppTranslations.of(context).text('title_datostarjeta');
    String tarjetacredito = AppTranslations.of(context).text('title_tarjetacredito');
    String titular = AppTranslations.of(context).text('title_titular');
    String numtarjeta = AppTranslations.of(context).text('title_numtarjeta');
    String mm = AppTranslations.of(context).text('title_MM');
    String aa = AppTranslations.of(context).text('title_AA');
    String cvc = AppTranslations.of(context).text('title_CVC');
    String addcard = AppTranslations.of(context).text('title_addcard');
    String ingresar = AppTranslations.of(context).text('title_ingresar');
    final size = MediaQuery.of(context).size;
    return Platform.isAndroid ? Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.black,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              SafeArea(
                child: SizedBox(
                  height: size.height * 0.03,
                ),
              ),
              Text('$entertarjeta',style: TextStyle(fontFamily: 'Point-ExtraBold',fontSize: 20.0),),
              SizedBox(
                height: size.height * 0.04,
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 0,
                    groupValue: _radioValue1,
                    onChanged: (value){
                      setState(() {
                        _radioValue1 = value;
                        _radioValue2 = value;
                      });
                    },
                  ),
                  Text('$tarjetacredito',style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 15.0),)
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 1,
                    groupValue: _radioValue1,
                    onChanged: (value){
                      setState(() {
                        _radioValue2 = value;
                        _radioValue1 = value;
                      });
                    },
                  ),
                  Text('Paypal',style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 15.0))
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: _radioValue1 == 0 ? ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child:Container(
                    width: size.width * 0.8,
                    height: size.height * 0.5,
                    color: Colors.black12,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: size.width * 0.7,
                          child: TextFormField(
                            initialValue: prefs.name,
                            onSaved: (value){
                              prefs.name = value;
                              tarjeta.holderName = prefs.name;
                            },
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: '$titular',
                              labelStyle: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.grey)
                            ),
                          ),
                        ),
                        Container(
                          width: size.width * 0.7,
                          child: TextFormField(
                            maxLength: 16,
                            initialValue: tarjeta.cardNumber,
                            onSaved: (value){
                              tarjeta.cardNumber = value;
                            },
                            //textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: '$numtarjeta',
                              labelStyle: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.grey)
                            ),
                          ),
                        ),
                        Container(
                          width: size.width * 0.7,
                          child: TextFormField(
                            maxLength: 2,
                            initialValue: tarjeta.expirationMonth,
                            onSaved: (value){
                              tarjeta.expirationMonth = value;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: '$mm',
                              labelStyle: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.grey)
                            ),
                          ),
                        ),
                        Container(
                          width: size.width * 0.7,
                          child: TextFormField(
                            maxLength: 2,
                            initialValue: tarjeta.expirationYear,
                            onSaved: (value){
                              tarjeta.expirationYear = value;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: '$aa',
                              labelStyle: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.grey)
                            ),
                          ),
                        ),
                        Container(
                          width: size.width * 0.7,
                          child: TextFormField(
                            maxLength: 4,
                            initialValue: tarjeta.cvv2,
                            onSaved: (value){
                              tarjeta.cvv2 = value;
                            },
                            //textCapitalization: TextCapitalization.characters,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: '$cvc',
                              labelStyle: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.grey)
                            ),
                          ),
                        ),
                        Visibility(
                          visible: false,
                          child: Container(
                            //color: Colors.transparent,
                            width: size.width * 0.7,
                            height: size.height * 0.1,
                            child: TextFormField(
                              style: TextStyle(color: Colors.transparent),
                              enabled: false,
                              initialValue: deviceSesionId,
                              onSaved: (value){
                                 deviceSesionId = value;
                                tarjeta.deviceSesionId = deviceSesionId;
                              },
                              textCapitalization: TextCapitalization.characters,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                disabledBorder: InputBorder.none
                                //labelText: '$cvc',
                                //labelStyle: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.grey)
                              ),
                            ),
                          ),
                        ),
                       /* Container(
                          width: size.width * 0.7,
                          child: SwitchListTile(
                            value: tarjeta.allowsCharges,
                            activeColor: Colors.lightBlue,
                            title: Text('Allows charges'),
                            onChanged: (value){
                              setState(() {
                                tarjeta.allowsCharges = value;
                              });
                            },
                          )
                        ),*/
                      /*Container(
                          width: size.width * 0.7,
                          child: SwitchListTile(
                            value: tarjeta.allowsPayouts,
                            activeColor: Colors.lightBlue,
                            title: Text('Allows payouts'),
                            onChanged: (value){
                              setState(() {
                                tarjeta.allowsPayouts = value;
                              });
                            },
                          )
                        ),*/
                      ],
                    )
                    
                  )): RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                    color: Color(0xFFD62250),
                    child: Text("$ingresar",style: TextStyle(color: Colors.white),),
                    onPressed: (){

                      //pagosProvider.tokenPaypal();
                     Navigator.of(context).push(MaterialPageRoute(
                        builder: (context){
                          return VistaPaypalPage();
                        },
                        settings: RouteSettings(arguments: detalleTour)
                      ));
                    },
                  )
              ),
            /*  Text('Número de tarjeta',style: TextStyle(fontSize: 15.0),),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: size.width * 0.7,
                height: size.height * 0.04,
                child: TextFormField(
                  initialValue: '000 000 000',
                  keyboardType: TextInputType.number,
                ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('Válido hasta',style: TextStyle(fontSize: 15.0),),
                      Container(
                        width: size.width * 0.2,
                        height: size.height * 0.04,
                        child: TextFormField(
                          initialValue: 'MM/AA',
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text('CVV',style: TextStyle(fontSize: 15.0),),
                      Container(
                        width: size.width * 0.2,
                        height: size.height * 0.04,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text('Código Postal',style: TextStyle(fontSize: 15.0),),
                      Container(
                        width: size.width * 0.3,
                        height: size.height * 0.04,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  )
                ],
              ),*/
              SizedBox(
                height: size.height * 0.1,
              ),
              _radioValue1 == 0 ? 
              Container(
                width: 550.0,
                height: 40.0,
                child: Image.asset('assets/logoopenpay.png'),
              ):Container(),
              SizedBox(
                height: size.height * 0.01,
              ),
            _radioValue1 == 0 ? 
            Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: ProgressButton(
                defaultWidget: Text(
                  '$addcard',
                  style: TextStyle(
                    fontFamily: 'Point-SemiBold',
                    fontSize: 15.0,
                    color: Colors.white
                  ),
                ),
                progressWidget: ThreeSizeDot(
                        //color_1: Colors.black54,
                        //color_2: Colors.black54,
                        //color_3: Colors.black54,
                      ),
                color: Colors.redAccent,
                type: ProgressButtonType.Raised,
                width: 154,
                height: 38,
                borderRadius: 5.0,
                animate: false,
                onPressed: ()async{
                  setState(() {
                    
                  });
                  await Future.delayed(Duration(seconds: 2),()async{
                    if(formKey.currentState.validate()){
                      formKey.currentState.save();
                    await pagosProvider.crearToken(tarjeta).then((result)async{
                      Map info = result;
                      if(info['error_code'] == 1000){
                        //Ocurrió un error en el servidor openpay
                        String errorServerOpenpay = AppTranslations.of(context).text('title_error_server_openpay');
                        //info['description']
                        mostrarAlerta(context, errorServerOpenpay, '', 'assets/error.png');
                      }else if(info['error_code']== 1001){
                        //Formato de la petición no es json.
                        //los campos no tienen el formato correcto, o la petición no tiene campos que son requeridos.
                        String formatNotJson = AppTranslations.of(context).text('title_format_no_json');
                        //info['description']
                        mostrarAlerta(context, formatNotJson, '', 'assets/error.png');
                      }else if(info['error_code'] == 1002){
                        //La llamada no esta autenticada o la autenticación es incorrecta.
                        String autenticacionIncorrect = AppTranslations.of(context).text('title_autentication_incorrect');
                        //info['description']
                        mostrarAlerta(context, autenticacionIncorrect, '', 'assets/error.png');
                      }else if(info['error_code'] == 1003){
                        //La operación no se pudo completar 
                        //por que el valor de uno o más de los parametros no es correcto.
                        String operacionNoCompleta = AppTranslations.of(context).text('title_operacion_not_complete');
                        //info['description']
                        mostrarAlerta(context, operacionNoCompleta, '', 'assets/error.png');
                      }else if(info['error_code'] == 1004){
                        //Un servicio necesario para el procesamiento de la
                        //transacción no se encuentra disponible.
                        String servicioNoDisponible = AppTranslations.of(context).text('title_service_not_enabled');
                        //info['description']
                        mostrarAlerta(context, servicioNoDisponible, '', 'assets/error.png');
                      }else if(info['error_code'] == 1005){
                        //Uno de los recursos requeridos no existe.
                        String recursoNoDisponible = AppTranslations.of(context).text('title_resource_not_disabled');
                        //info['description']
                        mostrarAlerta(context, recursoNoDisponible, '', 'assets/error.png');
                      }else if(info['error_code'] == 1006){
                        //Ya existe una transacción con el mismo ID de orden.
                        String transactionExist = AppTranslations.of(context).text('title_transaction_exist');
                        //info['description']
                        mostrarAlerta(context, transactionExist, '', 'assets/error.png');
                      }else if(info['error_code'] == 1007){
                        //La transferencia de fondos entre una cuenta de
                        //banco o tarjeta y la cuenta de Openpay no fue aceptada.
                        String transferNoAceptada = AppTranslations.of(context).text('title_transfer_not_acept');
                        //info['description']
                        mostrarAlerta(context, transferNoAceptada, '', 'assets/error.png');
                      }else if(info['error_code'] == 1008){
                        //Una de las cuentas requeridas en la petición se
                        //encuentra desactivada.
                        String cuentaDesactivada = AppTranslations.of(context).text('title_account_desactivate');
                        //info['description']
                        mostrarAlerta(context, cuentaDesactivada, '', 'assets/error.png');
                      }else if(info['error_code'] == 1009){
                        //El cuerpo de la petición es demasiado grande.
                        String bodyMoreLonger = AppTranslations.of(context).text('title_require_more_long');
                        //info['description']
                        mostrarAlerta(context, bodyMoreLonger, '', 'assets/error.png');
                      }else if(info['error_code'] == 1010){
                        //Se esta utilizando la llave pública para hacer una
                        //llamada que requiere la llave privada, o bien, se esta
                        //usando la llave privada desde JavaScript.
                        String keyPrivate = AppTranslations.of(context).text('title_key_private');
                        //info['description']
                        mostrarAlerta(context, keyPrivate,'', 'assets/error.png');
                      }else if(info['error_code'] == 2001){
                        //La cuenta de banco con esta CLABE ya se
                        //encuentra registrada en el cliente.
                        String cuentaRegistrada = AppTranslations.of(context).text('title_account_registered');
                        //info['description']
                        mostrarAlerta(context, cuentaRegistrada, '', 'assets/error.png');
                      }else if(info['error_code'] == 2002){
                        //La tarjeta con este número ya se encuentra
                        //registrada en el cliente.
                        String cardRegistered = AppTranslations.of(context).text('title_card_registered');
                        //info['description']
                        mostrarAlerta(context, cardRegistered,'', 'assets/error.png');
                      }else if(info['error_code'] == 2003){
                        //El cliente con este identificador externo (External ID)
                        //ya existe.
                        String clientExist = AppTranslations.of(context).text('title_client_exist');
                        //info['description']
                        mostrarAlerta(context, clientExist, '', 'assets/error.png');
                      }else if(info['error_code'] == 2004){
                        //El dígito verificador del número de tarjeta es inválido
                        //de acuerdo al algoritmo Luhn.
                        String digitInvalid = AppTranslations.of(context).text('title_digit_invalid');
                        //info['description']
                        mostrarAlerta(context, digitInvalid , '', 'assets/error.png');
                      }else if(info['error_code'] == 2005){
                        //La fecha de expiración de la tarjeta es anterior a la
                        //fecha actual.
                        String dateExpired = AppTranslations.of(context).text('title_date_expired');
                        //info['description']
                        mostrarAlerta(context, dateExpired , '', 'assets/error.png');
                      }else if(info['error_code'] == 2006){
                        //El código de seguridad de la tarjeta (CVV2) no fue
                        //proporcionado.
                        String codeSecurityEmpty = AppTranslations.of(context).text('title_code_security_empty');
                        //info['description']
                        mostrarAlerta(context, codeSecurityEmpty , '', 'assets/error.png');
                      }else if(info['error_code'] == 2007){
                        //El número de tarjeta es de prueba, solamente puede
                        //usarse en Sandbox.
                        String cardTest = AppTranslations.of(context).text('title_card_test');
                        //info['description']
                        mostrarAlerta(context, cardTest , '', 'assets/error.png');
                      }else if(info['error_code'] == 2008){
                        //La tarjeta consultada no es valida para puntos.
                        String cardNoPoints = AppTranslations.of(context).text('title_card_not_points');
                        //info['description']
                        mostrarAlerta(context, cardNoPoints , '', 'assets/error.png');
                      }else if(info['error_code'] == 2009){
                        //El código de seguridad de la tarjeta (CVV2) no es valido.
                        String codeSecurityNoValid = AppTranslations.of(context).text('title_card_not_valid');
                        //info['description']
                        mostrarAlerta(context, codeSecurityNoValid , '', 'assets/error.png');
                      }else if(info['error_code'] == 3001){
                        String tarjetaDeclinada = AppTranslations.of(context).text('title_card_declined');
                        //La tarjeta fue declinada.
                        //info['description']
                        mostrarAlerta(context, tarjetaDeclinada, '', 'assets/error.png');
                      }else if(info['error_code'] == 3002){
                        //La tarjeta ha expirado.
                        String tarjetaExpirada = AppTranslations.of(context).text('title_card_expired');
                        //info['description']
                        mostrarAlerta(context, tarjetaExpirada, '', 'assets/error.png');
                      }else if(info['error_code'] == 3003){
                        //La tarjeta no tiene fondos suficientes.
                        String tarjetaSinFondos = AppTranslations.of(context).text('title_card_not_funds');
                        //info['description']
                        mostrarAlerta(context, tarjetaSinFondos, '', 'assets/error.png');
                      }else if(info['error_code'] == 3004){
                        //La tarjeta ha sido identificada como una tarjeta
                        //robada.
                        String tarjetaRobada = AppTranslations.of(context).text('title_card_lost');
                        //info['description']
                        mostrarAlerta(context, tarjetaRobada, '', 'assets/error.png');
                      }else if(info['error_code'] == 3005){
                        //La tarjeta ha sido identificada como una tarjeta
                        //fraudulenta.
                        String tarjetaFraudulenta = AppTranslations.of(context).text('title_card_fraudulent');
                        //info['description']
                        mostrarAlerta(context, tarjetaFraudulenta, '', 'assets/error.png');
                      }else if(info['error_code'] == 3006){
                        //La operación no esta permitida para este cliente o
                        //esta transacción.
                        String operacionNoPermitida = AppTranslations.of(context).text('title_operation_not_allowed');
                        //info['description']
                        mostrarAlerta(context, operacionNoPermitida, '', 'assets/error.png');
                      }else if(info['error_code'] == 3008){
                        //La tarjeta no es soportada en transacciones en linea.
                        String tarjetaNoSoportadaOnline = AppTranslations.of(context).text('title_card_not_support_online');
                        //info['description']
                        mostrarAlerta(context, tarjetaNoSoportadaOnline, '', 'assets/error.png');
                      }else if(info['error_code'] == 3009){
                        //La tarjeta fue reportada como perdida.
                        String tarjetaPerdida = AppTranslations.of(context).text('title_card_lost');
                        //info['description']
                        mostrarAlerta(context, tarjetaPerdida, '', 'assets/error.png');
                      }else if(info['error_code'] == 3010){
                        //El banco ha restringido la tarjeta.
                        String bankRestrictedCard = AppTranslations.of(context).text('title_bank_restricted_card');
                        //info['description']
                        mostrarAlerta(context, bankRestrictedCard, '', 'assets/error.png');
                      }else if(info['error_code'] == 3011){
                        //El banco ha solicitado que la tarjeta sea retenida.
                        //Contacte al banco.
                        String tarjetaRetenida = AppTranslations.of(context).text('title_card_withheld');
                        //info['description']
                        mostrarAlerta(context, tarjetaRetenida, '', 'assets/error.png');
                      }else if(info['error_code'] == 3012){
                        //Se requiere solicitar al banco autorización para
                        //realizar este pago.
                        String solictarPago = AppTranslations.of(context).text('title_autorization_buy');
                        //info['description']
                        mostrarAlerta(context, solictarPago, '', 'assets/error.png');
                      }else if(info['error_code'] == 4001){
                        //La cuenta de Openpay no tiene fondos suficientes.
                        String openpayNotFunds = AppTranslations.of(context).text('title_openpay_account_not_funds');
                        //info['description']
                        mostrarAlerta(context, openpayNotFunds, '', 'assets/error.png');
                      }
                      else{
                        //formKey.currentState.save();
                        prefs.idTarjeta = info['id'].toString();
                        await pagosProvider.obtenerToken(prefs.idTarjeta);

                        String tarjetaAgregado = AppTranslations.of(context).text('title_tarjetaAgregado');
                        
                        //Navigator.pop(context);
                        Navigator.popUntil(context, ModalRoute.withName('metodopago'));
                        //Navigator.popAndPushNamed(context,'metodopago',arguments: detalleTour);

                        // Navigator.pushAndRemoveUntil(context, 
                        // MaterialPageRoute(
                        //   builder: (context){
                        //     return MetodoPagoPage();
                        //   }
                        // ), ModalRoute.withName('metodopago') );
                        //Navigator.pushReplacementNamed(context, 'metodopago');
                        //Navigator.pushNamedAndRemoveUntil(context, 'metodopago', ModalRoute.withName('metodopago'));
                        mostrarAviso(context, '$tarjetaAgregado', '', 'assets/check.jpg');
                    }
                    
                    });
                    }else{
                      String errorValidar = AppTranslations.of(context).text('title_errorValidar');
                      mostrarAlerta(context, '$errorValidar', '', 'assets/error.png');
                    }
                  });
                },
              ),
            )
            
            
            /*RaisedButton(
                textTheme: ButtonTextTheme.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                color: Color(0xFFD62250),
                child: Text('$addcard',style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 15.0,color: Colors.white),),
                onPressed: ()async{
                  
                  //Navigator.popAndPushNamed(context, 'comprar',arguments: detalleTour);
                  /*Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    builder: (context)=>PagosPage(),
                    fullscreenDialog: true,
                    settings: RouteSettings(arguments: detalleTour)
                  ), ModalRoute.withName('ingresotarjeta'));
                  */
                 /* if(!formKey.currentState.validate()){
                    mostrarAlerta(context, 'error al agregar tarjeta', '', 'assets/error.png');
                  }else{
                  formKey.currentState.save();
                  pagosProvider.crearTarjeta(tarjeta).then((result){
                    if(result.length >= 0){
                      mostrarAlerta(context, 'Successfull', '', 'assets/check.jpg');
                    }else{
                      mostrarAlerta(context, 'No hay id', '', 'assets/error.png');
                    }
                  }).catchError((error){
                    mostrarAlerta(context, '${error.toString()}', '', 'assets/error.png');
                  });
                  /*pagosProvider.crearTarjeta(tarjeta).then((a){
                       Map info = a;
                       if(info['id'] == ''){
                         mostrarAlerta(context, '${info["id"]}', '', 'assets/check.jpg');
                       }
                     }).catchError((e){
                       print(e);
                       mostrarAlerta(context, '$e', '', 'assets/error.png');
                     });*/
                  //Navigator.pushNamed(context, 'comprar',arguments: detalleTour.comprado == true);
                  }*/

                  if(formKey.currentState.validate()){
                  formKey.currentState.save();
                  await pagosProvider.crearToken(tarjeta).then((result){
                    Map info = result;
                    if(info['error_code'] == 1000){
                    //Ocurrió un error en el servidor openpay
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code']== 1001){
                    //Formato de la petición no es json.
                    //os campos no tienen el formato correcto, o la petición no tiene campos que son requeridos.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 1002){
                    //La llamada no esta autenticada o la autenticación es incorrecta.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 1003){
                    //La operación no se pudo completar 
                    //por que el valor de uno o más de los parametros no es correcto.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 1004){
                    //Un servicio necesario para el procesamiento de la
                    //transacción no se encuentra disponible.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 1005){
                    //Uno de los recursos requeridos no existe.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 1006){
                    //Ya existe una transacción con el mismo ID de orden.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 1007){
                    //La transferencia de fondos entre una cuenta de
                    //banco o tarjeta y la cuenta de Openpay no fue aceptada.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 1008){
                    //Una de las cuentas requeridas en la petición se
                    //encuentra desactivada.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 1009){
                    //El cuerpo de la petición es demasiado grande.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 1010){
                    //Se esta utilizando la llave pública para hacer una
                    //lamada que requiere la llave privada, o bien, se esta
                    //usando la llave privada desde JavaScript.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 2001){
                    //La cuenta de banco con esta CLABE ya se
                    //encuentra registrada en el cliente.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 2002){
                    //La tarjeta con este número ya se encuentra
                    //registrada en el cliente.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 2003){
                    //El cliente con este identificador externo (External ID)
                    //ya existe.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 2004){
                    //El dígito verificador del número de tarjeta es inválido
                    //de acuerdo al algoritmo Luhn.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 2005){
                    //La fecha de expiración de la tarjeta es anterior a la
                    //fecha actual.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 2006){
                    //El código de seguridad de la tarjeta (CVV2) no fue
                    //proporcionado.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 2007){
                    //El número de tarjeta es de prueba, solamente puede
                    //usarse en Sandbox.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 2008){
                    //La tarjeta consultada no es valida para puntos.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 2009){
                    //El código de seguridad de la tarjeta (CVV2) no no es valido.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 3001){
                    //La tarjeta fue declinada.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 3002){
                    //La tarjeta ha expirado.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 3003){
                    //La tarjeta no tiene fondos suficientes.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 3004){
                    //La tarjeta ha sido identificada como una tarjeta
                    //robada.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 3005){
                    //La tarjeta ha sido identificada como una tarjeta
                    //fraudulenta.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 3006){
                    //La operación no esta permitida para este cliente o
                    //esta transacción.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 3008){
                    //La tarjeta no es soportada en transacciones en linea.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 3009){
                    //La tarjeta fue reportada como perdida.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 3010){
                    //El banco ha restringido la tarjeta.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 3011){
                    //El banco ha solicitado que la tarjeta sea retenida.
                    //Contacte al banco.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 3012){
                    //Se requiere solicitar al banco autorización para
                    //realizar este pago.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }else if(info['error_code'] == 4001){
                    //La cuenta de Openpay no tiene fondos suficientes.
                    mostrarAlerta(context, info['description'], '', 'assets/error.png');
                  }
                  else{
                    formKey.currentState.save();
                    prefs.idTarjeta = info['id'];
                    String tarjetaAgregado = AppTranslations.of(context).text('title_tarjetaAgregado');
                    
                  /*  Navigator.removeRoute(context,MaterialPageRoute(
                      builder: (context){
                        return IngresoTarjetaPage();
                      },
                      settings: RouteSettings(arguments: detalleTour)
                    ) );*/
                    //Navigator.pop(context);
                   // Navigator.popUntil(context, ModalRoute.withName('metodopago'));
                   //Navigator.popAndPushNamed(context,'metodopago',arguments: detalleTour);
                    
                     Navigator.popUntil(context, ModalRoute.withName('metodopago'));
                    mostrarAviso(context, '$tarjetaAgregado', '', 'assets/check.jpg');
                    //mostrarAlerta(context, 'Tarjeta Agregada', '', 'assets/check.jpg');
                    //Navigator.pop(context);
                  }
                  
                  });
                  }else{
                    String errorValidar = AppTranslations.of(context).text('title_errorValidar');
                  mostrarAlerta(context, '$errorValidar', '', 'assets/error.png');
                  }
                  
                },
              )*/ : Container()
            ],
          ),
        ),
      ),
    ):Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.black,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              SafeArea(
                child: SizedBox(
                  height: size.height * 0.03,
                ),
              ),
              Text('$entertarjeta',style: TextStyle(fontFamily: 'Point-ExtraBold',fontSize: 20.0),),
              SizedBox(
                height: size.height * 0.04,
              ),
             /* Row(
                children: <Widget>[
                  Radio(
                    value: 0,
                    groupValue: _radioValue1,
                    onChanged: (value){
                      setState(() {
                        _radioValue1 = value;
                        _radioValue2 = value;
                      });
                    },
                  ),
                  Text('$tarjetacredito',style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 15.0),)
                ],
              ),*/
              /*Row(
                children: <Widget>[
                  Radio(
                    value: 1,
                    groupValue: _radioValue1,
                    onChanged: (value){
                      setState(() {
                        _radioValue2 = value;
                        _radioValue1 = value;
                      });
                    },
                  ),
                  Text('Paypal',style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 15.0))
                ],
              ),*/
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child:Container(
                    width: size.width * 0.8,
                    height: size.height * 0.5,
                    color: Colors.black12,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: size.width * 0.7,
                          child: TextFormField(
                            initialValue: prefs.name,
                            onSaved: (value){
                              prefs.name = value;
                              tarjeta.holderName = prefs.name;
                            },
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: '$titular',
                              labelStyle: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.grey)
                            ),
                          ),
                        ),
                        Container(
                          width: size.width * 0.7,
                          child: TextFormField(
                            maxLength: 16,
                            initialValue: tarjeta.cardNumber,
                            onSaved: (value){
                              tarjeta.cardNumber = value;
                            },
                            //textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: '$numtarjeta',
                              labelStyle: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.grey)
                            ),
                          ),
                        ),
                        Container(
                          width: size.width * 0.7,
                          child: TextFormField(
                            maxLength: 2,
                            initialValue: tarjeta.expirationMonth,
                            onSaved: (value){
                              tarjeta.expirationMonth = value;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: '$mm',
                              labelStyle: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.grey)
                            ),
                          ),
                        ),
                        Container(
                          width: size.width * 0.7,
                          child: TextFormField(
                            maxLength: 2,
                            initialValue: tarjeta.expirationYear,
                            onSaved: (value){
                              tarjeta.expirationYear = value;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: '$aa',
                              labelStyle: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.grey)
                            ),
                          ),
                        ),
                        Container(
                          width: size.width * 0.7,
                          child: TextFormField(
                            maxLength: 4,
                            initialValue: tarjeta.cvv2,
                            onSaved: (value){
                              tarjeta.cvv2 = value;
                            },
                            //textCapitalization: TextCapitalization.characters,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: '$cvc',
                              labelStyle: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.grey)
                            ),
                          ),
                        ),
                        Visibility(
                          visible: false,
                          child: Container(
                            //color: Colors.transparent,
                            width: size.width * 0.7,
                            height: size.height * 0.1,
                            child: TextFormField(
                              style: TextStyle(color: Colors.transparent),
                              enabled: false,
                              initialValue: deviceSesionId,
                              onSaved: (value){
                                 deviceSesionId = value;
                                tarjeta.deviceSesionId = deviceSesionId;
                              },
                              textCapitalization: TextCapitalization.characters,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                disabledBorder: InputBorder.none
                                //labelText: '$cvc',
                                //labelStyle: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.grey)
                              ),
                            ),
                          ),
                        ),
                       /* Container(
                          width: size.width * 0.7,
                          child: SwitchListTile(
                            value: tarjeta.allowsCharges,
                            activeColor: Colors.lightBlue,
                            title: Text('Allows charges'),
                            onChanged: (value){
                              setState(() {
                                tarjeta.allowsCharges = value;
                              });
                            },
                          )
                        ),*/
                      /*Container(
                          width: size.width * 0.7,
                          child: SwitchListTile(
                            value: tarjeta.allowsPayouts,
                            activeColor: Colors.lightBlue,
                            title: Text('Allows payouts'),
                            onChanged: (value){
                              setState(() {
                                tarjeta.allowsPayouts = value;
                              });
                            },
                          )
                        ),*/
                      ],
                    )
                    
                  ))
              ),
            /*  Text('Número de tarjeta',style: TextStyle(fontSize: 15.0),),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: size.width * 0.7,
                height: size.height * 0.04,
                child: TextFormField(
                  initialValue: '000 000 000',
                  keyboardType: TextInputType.number,
                ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('Válido hasta',style: TextStyle(fontSize: 15.0),),
                      Container(
                        width: size.width * 0.2,
                        height: size.height * 0.04,
                        child: TextFormField(
                          initialValue: 'MM/AA',
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text('CVV',style: TextStyle(fontSize: 15.0),),
                      Container(
                        width: size.width * 0.2,
                        height: size.height * 0.04,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text('Código Postal',style: TextStyle(fontSize: 15.0),),
                      Container(
                        width: size.width * 0.3,
                        height: size.height * 0.04,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  )
                ],
              ),*/
              SizedBox(
                height: size.height * 0.1,
              ),

              ProgressButton(
                defaultWidget: Text(
                  '$addcard',
                  style: TextStyle(
                    fontFamily: 'Point-SemiBold',
                    fontSize: 15.0,
                    color: Colors.white
                  ),
                ),
                progressWidget: ThreeSizeDot(
                        //color_1: Colors.black54,
                        //color_2: Colors.black54,
                        //color_3: Colors.black54,
                      ),
                color: Colors.redAccent,
                type: ProgressButtonType.Raised,
                width: 154,
                height: 38,
                borderRadius: 5.0,
                animate: false,
                onPressed: ()async{
                  await Future.delayed(Duration(seconds: 2),()async{
                    if(formKey.currentState.validate()){
                      formKey.currentState.save();
                    await pagosProvider.crearToken(tarjeta).then((result)async{
                      Map info = result;
                      if(info['error_code'] == 1000){
                        //Ocurrió un error en el servidor openpay
                        String errorServerOpenpay = AppTranslations.of(context).text('title_error_server_openpay');
                        //info['description']
                        mostrarAlerta(context, errorServerOpenpay, '', 'assets/error.png');
                      }else if(info['error_code']== 1001){
                        //Formato de la petición no es json.
                        //los campos no tienen el formato correcto, o la petición no tiene campos que son requeridos.
                        String formatNotJson = AppTranslations.of(context).text('title_format_no_json');
                        //info['description']
                        mostrarAlerta(context, formatNotJson, '', 'assets/error.png');
                      }else if(info['error_code'] == 1002){
                        //La llamada no esta autenticada o la autenticación es incorrecta.
                        String autenticacionIncorrect = AppTranslations.of(context).text('title_autentication_incorrect');
                        //info['description']
                        mostrarAlerta(context, autenticacionIncorrect, '', 'assets/error.png');
                      }else if(info['error_code'] == 1003){
                        //La operación no se pudo completar 
                        //por que el valor de uno o más de los parametros no es correcto.
                        String operacionNoCompleta = AppTranslations.of(context).text('title_operacion_not_complete');
                        //info['description']
                        mostrarAlerta(context, operacionNoCompleta, '', 'assets/error.png');
                      }else if(info['error_code'] == 1004){
                        //Un servicio necesario para el procesamiento de la
                        //transacción no se encuentra disponible.
                        String servicioNoDisponible = AppTranslations.of(context).text('title_service_not_enabled');
                        //info['description']
                        mostrarAlerta(context, servicioNoDisponible, '', 'assets/error.png');
                      }else if(info['error_code'] == 1005){
                        //Uno de los recursos requeridos no existe.
                        String recursoNoDisponible = AppTranslations.of(context).text('title_resource_not_disabled');
                        //info['description']
                        mostrarAlerta(context, recursoNoDisponible, '', 'assets/error.png');
                      }else if(info['error_code'] == 1006){
                        //Ya existe una transacción con el mismo ID de orden.
                        String transactionExist = AppTranslations.of(context).text('title_transaction_exist');
                        //info['description']
                        mostrarAlerta(context, transactionExist, '', 'assets/error.png');
                      }else if(info['error_code'] == 1007){
                        //La transferencia de fondos entre una cuenta de
                        //banco o tarjeta y la cuenta de Openpay no fue aceptada.
                        String transferNoAceptada = AppTranslations.of(context).text('title_transfer_not_acept');
                        //info['description']
                        mostrarAlerta(context, transferNoAceptada, '', 'assets/error.png');
                      }else if(info['error_code'] == 1008){
                        //Una de las cuentas requeridas en la petición se
                        //encuentra desactivada.
                        String cuentaDesactivada = AppTranslations.of(context).text('title_account_desactivate');
                        //info['description']
                        mostrarAlerta(context, cuentaDesactivada, '', 'assets/error.png');
                      }else if(info['error_code'] == 1009){
                        //El cuerpo de la petición es demasiado grande.
                        String bodyMoreLonger = AppTranslations.of(context).text('title_require_more_long');
                        //info['description']
                        mostrarAlerta(context, bodyMoreLonger, '', 'assets/error.png');
                      }else if(info['error_code'] == 1010){
                        //Se esta utilizando la llave pública para hacer una
                        //llamada que requiere la llave privada, o bien, se esta
                        //usando la llave privada desde JavaScript.
                        String keyPrivate = AppTranslations.of(context).text('title_key_private');
                        //info['description']
                        mostrarAlerta(context, keyPrivate,'', 'assets/error.png');
                      }else if(info['error_code'] == 2001){
                        //La cuenta de banco con esta CLABE ya se
                        //encuentra registrada en el cliente.
                        String cuentaRegistrada = AppTranslations.of(context).text('title_account_registered');
                        //info['description']
                        mostrarAlerta(context, cuentaRegistrada, '', 'assets/error.png');
                      }else if(info['error_code'] == 2002){
                        //La tarjeta con este número ya se encuentra
                        //registrada en el cliente.
                        String cardRegistered = AppTranslations.of(context).text('title_card_registered');
                        //info['description']
                        mostrarAlerta(context, cardRegistered,'', 'assets/error.png');
                      }else if(info['error_code'] == 2003){
                        //El cliente con este identificador externo (External ID)
                        //ya existe.
                        String clientExist = AppTranslations.of(context).text('title_client_exist');
                        //info['description']
                        mostrarAlerta(context, clientExist, '', 'assets/error.png');
                      }else if(info['error_code'] == 2004){
                        //El dígito verificador del número de tarjeta es inválido
                        //de acuerdo al algoritmo Luhn.
                        String digitInvalid = AppTranslations.of(context).text('title_digit_invalid');
                        //info['description']
                        mostrarAlerta(context, digitInvalid , '', 'assets/error.png');
                      }else if(info['error_code'] == 2005){
                        //La fecha de expiración de la tarjeta es anterior a la
                        //fecha actual.
                        String dateExpired = AppTranslations.of(context).text('title_date_expired');
                        //info['description']
                        mostrarAlerta(context, dateExpired , '', 'assets/error.png');
                      }else if(info['error_code'] == 2006){
                        //El código de seguridad de la tarjeta (CVV2) no fue
                        //proporcionado.
                        String codeSecurityEmpty = AppTranslations.of(context).text('title_code_security_empty');
                        //info['description']
                        mostrarAlerta(context, codeSecurityEmpty , '', 'assets/error.png');
                      }else if(info['error_code'] == 2007){
                        //El número de tarjeta es de prueba, solamente puede
                        //usarse en Sandbox.
                        String cardTest = AppTranslations.of(context).text('title_card_test');
                        //info['description']
                        mostrarAlerta(context, cardTest , '', 'assets/error.png');
                      }else if(info['error_code'] == 2008){
                        //La tarjeta consultada no es valida para puntos.
                        String cardNoPoints = AppTranslations.of(context).text('title_card_not_points');
                        //info['description']
                        mostrarAlerta(context, cardNoPoints , '', 'assets/error.png');
                      }else if(info['error_code'] == 2009){
                        //El código de seguridad de la tarjeta (CVV2) no es valido.
                        String codeSecurityNoValid = AppTranslations.of(context).text('title_card_not_valid');
                        //info['description']
                        mostrarAlerta(context, codeSecurityNoValid , '', 'assets/error.png');
                      }else if(info['error_code'] == 3001){
                        String tarjetaDeclinada = AppTranslations.of(context).text('title_card_declined');
                        //La tarjeta fue declinada.
                        //info['description']
                        mostrarAlerta(context, tarjetaDeclinada, '', 'assets/error.png');
                      }else if(info['error_code'] == 3002){
                        //La tarjeta ha expirado.
                        String tarjetaExpirada = AppTranslations.of(context).text('title_card_expired');
                        //info['description']
                        mostrarAlerta(context, tarjetaExpirada, '', 'assets/error.png');
                      }else if(info['error_code'] == 3003){
                        //La tarjeta no tiene fondos suficientes.
                        String tarjetaSinFondos = AppTranslations.of(context).text('title_card_not_funds');
                        //info['description']
                        mostrarAlerta(context, tarjetaSinFondos, '', 'assets/error.png');
                      }else if(info['error_code'] == 3004){
                        //La tarjeta ha sido identificada como una tarjeta
                        //robada.
                        String tarjetaRobada = AppTranslations.of(context).text('title_card_lost');
                        //info['description']
                        mostrarAlerta(context, tarjetaRobada, '', 'assets/error.png');
                      }else if(info['error_code'] == 3005){
                        //La tarjeta ha sido identificada como una tarjeta
                        //fraudulenta.
                        String tarjetaFraudulenta = AppTranslations.of(context).text('title_card_fraudulent');
                        //info['description']
                        mostrarAlerta(context, tarjetaFraudulenta, '', 'assets/error.png');
                      }else if(info['error_code'] == 3006){
                        //La operación no esta permitida para este cliente o
                        //esta transacción.
                        String operacionNoPermitida = AppTranslations.of(context).text('title_operation_not_allowed');
                        //info['description']
                        mostrarAlerta(context, operacionNoPermitida, '', 'assets/error.png');
                      }else if(info['error_code'] == 3008){
                        //La tarjeta no es soportada en transacciones en linea.
                        String tarjetaNoSoportadaOnline = AppTranslations.of(context).text('title_card_not_support_online');
                        //info['description']
                        mostrarAlerta(context, tarjetaNoSoportadaOnline, '', 'assets/error.png');
                      }else if(info['error_code'] == 3009){
                        //La tarjeta fue reportada como perdida.
                        String tarjetaPerdida = AppTranslations.of(context).text('title_card_lost');
                        //info['description']
                        mostrarAlerta(context, tarjetaPerdida, '', 'assets/error.png');
                      }else if(info['error_code'] == 3010){
                        //El banco ha restringido la tarjeta.
                        String bankRestrictedCard = AppTranslations.of(context).text('title_bank_restricted_card');
                        //info['description']
                        mostrarAlerta(context, bankRestrictedCard, '', 'assets/error.png');
                      }else if(info['error_code'] == 3011){
                        //El banco ha solicitado que la tarjeta sea retenida.
                        //Contacte al banco.
                        String tarjetaRetenida = AppTranslations.of(context).text('title_card_withheld');
                        //info['description']
                        mostrarAlerta(context, tarjetaRetenida, '', 'assets/error.png');
                      }else if(info['error_code'] == 3012){
                        //Se requiere solicitar al banco autorización para
                        //realizar este pago.
                        String solictarPago = AppTranslations.of(context).text('title_autorization_buy');
                        //info['description']
                        mostrarAlerta(context, solictarPago, '', 'assets/error.png');
                      }else if(info['error_code'] == 4001){
                        //La cuenta de Openpay no tiene fondos suficientes.
                        String openpayNotFunds = AppTranslations.of(context).text('title_openpay_account_not_funds');
                        //info['description']
                        mostrarAlerta(context, openpayNotFunds, '', 'assets/error.png');
                      }
                      else{
                        //formKey.currentState.save();
                        prefs.idTarjeta = info['id'];
                        await pagosProvider.obtenerToken(prefs.idTarjeta.toString());
                        String tarjetaAgregado = AppTranslations.of(context).text('title_tarjetaAgregado');
                        
                      /*  Navigator.removeRoute(context,MaterialPageRoute(
                          builder: (context){
                            return IngresoTarjetaPage();
                          },
                          settings: RouteSettings(arguments: detalleTour)
                        ) );*/
                        //Navigator.pop(context);
                      // Navigator.popUntil(context, ModalRoute.withName('metodopago'));
                      //Navigator.popAndPushNamed(context,'metodopago',arguments: detalleTour);
                        
                        Navigator.popUntil(context, ModalRoute.withName('metodopago'));
                        mostrarAviso(context, '$tarjetaAgregado', '', 'assets/check.jpg');
                        //mostrarAlerta(context, 'Tarjeta Agregada', '', 'assets/check.jpg');
                        //Navigator.pop(context);
                    }
                    
                    });
                    }else{
                      String errorValidar = AppTranslations.of(context).text('title_errorValidar');
                      mostrarAlerta(context, '$errorValidar', '', 'assets/error.png');
                    }
                  });
                },
              ),
              /*RaisedButton(
                textTheme: ButtonTextTheme.primary,
                shape: StadiumBorder(),
                color: Colors.lightBlue,
                child: Text('$addcard',style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 15.0,color: Colors.white),),
                onPressed: ()async{
                  
                  //Navigator.popAndPushNamed(context, 'comprar',arguments: detalleTour);
                  /*Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    builder: (context)=>PagosPage(),
                    fullscreenDialog: true,
                    settings: RouteSettings(arguments: detalleTour)
                  ), ModalRoute.withName('ingresotarjeta'));
                  */
                 /* if(!formKey.currentState.validate()){
                    mostrarAlerta(context, 'error al agregar tarjeta', '', 'assets/error.png');
                  }else{
                  formKey.currentState.save();
                  pagosProvider.crearTarjeta(tarjeta).then((result){
                    if(result.length >= 0){
                      mostrarAlerta(context, 'Successfull', '', 'assets/check.jpg');
                    }else{
                      mostrarAlerta(context, 'No hay id', '', 'assets/error.png');
                    }
                  }).catchError((error){
                    mostrarAlerta(context, '${error.toString()}', '', 'assets/error.png');
                  });
                  /*pagosProvider.crearTarjeta(tarjeta).then((a){
                       Map info = a;
                       if(info['id'] == ''){
                         mostrarAlerta(context, '${info["id"]}', '', 'assets/check.jpg');
                       }
                     }).catchError((e){
                       print(e);
                       mostrarAlerta(context, '$e', '', 'assets/error.png');
                     });*/
                  //Navigator.pushNamed(context, 'comprar',arguments: detalleTour.comprado == true);
                  }*/

                  if(formKey.currentState.validate()){
                  formKey.currentState.save();
                    await pagosProvider.crearToken(tarjeta).then((result){
                      Map info = result;
                      if(info['error_code'] == 1000){
                        //Ocurrió un error en el servidor openpay
                        String errorServerOpenpay = AppTranslations.of(context).text('title_error_server_openpay');
                        //info['description']
                        mostrarAlerta(context, errorServerOpenpay, '', 'assets/error.png');
                      }else if(info['error_code']== 1001){
                        //Formato de la petición no es json.
                        //los campos no tienen el formato correcto, o la petición no tiene campos que son requeridos.
                        String formatNotJson = AppTranslations.of(context).text('title_format_no_json');
                        //info['description']
                        mostrarAlerta(context, formatNotJson, '', 'assets/error.png');
                      }else if(info['error_code'] == 1002){
                        //La llamada no esta autenticada o la autenticación es incorrecta.
                        String autenticacionIncorrect = AppTranslations.of(context).text('title_autentication_incorrect');
                        //info['description']
                        mostrarAlerta(context, autenticacionIncorrect, '', 'assets/error.png');
                      }else if(info['error_code'] == 1003){
                        //La operación no se pudo completar 
                        //por que el valor de uno o más de los parametros no es correcto.
                        String operacionNoCompleta = AppTranslations.of(context).text('title_operacion_not_complete');
                        //info['description']
                        mostrarAlerta(context, operacionNoCompleta, '', 'assets/error.png');
                      }else if(info['error_code'] == 1004){
                        //Un servicio necesario para el procesamiento de la
                        //transacción no se encuentra disponible.
                        String servicioNoDisponible = AppTranslations.of(context).text('title_service_not_enabled');
                        //info['description']
                        mostrarAlerta(context, servicioNoDisponible, '', 'assets/error.png');
                      }else if(info['error_code'] == 1005){
                        //Uno de los recursos requeridos no existe.
                        String recursoNoDisponible = AppTranslations.of(context).text('title_resource_not_disabled');
                        //info['description']
                        mostrarAlerta(context, recursoNoDisponible, '', 'assets/error.png');
                      }else if(info['error_code'] == 1006){
                        //Ya existe una transacción con el mismo ID de orden.
                        String transactionExist = AppTranslations.of(context).text('title_transaction_exist');
                        //info['description']
                        mostrarAlerta(context, transactionExist, '', 'assets/error.png');
                      }else if(info['error_code'] == 1007){
                        //La transferencia de fondos entre una cuenta de
                        //banco o tarjeta y la cuenta de Openpay no fue aceptada.
                        String transferNoAceptada = AppTranslations.of(context).text('title_transfer_not_acept');
                        //info['description']
                        mostrarAlerta(context, transferNoAceptada, '', 'assets/error.png');
                      }else if(info['error_code'] == 1008){
                        //Una de las cuentas requeridas en la petición se
                        //encuentra desactivada.
                        String cuentaDesactivada = AppTranslations.of(context).text('title_account_desactivate');
                        //info['description']
                        mostrarAlerta(context, cuentaDesactivada, '', 'assets/error.png');
                      }else if(info['error_code'] == 1009){
                        //El cuerpo de la petición es demasiado grande.
                        String bodyMoreLonger = AppTranslations.of(context).text('title_require_more_long');
                        //info['description']
                        mostrarAlerta(context, bodyMoreLonger, '', 'assets/error.png');
                      }else if(info['error_code'] == 1010){
                        //Se esta utilizando la llave pública para hacer una
                        //llamada que requiere la llave privada, o bien, se esta
                        //usando la llave privada desde JavaScript.
                        String keyPrivate = AppTranslations.of(context).text('title_key_private');
                        //info['description']
                        mostrarAlerta(context, keyPrivate,'', 'assets/error.png');
                      }else if(info['error_code'] == 2001){
                        //La cuenta de banco con esta CLABE ya se
                        //encuentra registrada en el cliente.
                        String cuentaRegistrada = AppTranslations.of(context).text('title_account_registered');
                        //info['description']
                        mostrarAlerta(context, cuentaRegistrada, '', 'assets/error.png');
                      }else if(info['error_code'] == 2002){
                        //La tarjeta con este número ya se encuentra
                        //registrada en el cliente.
                        String cardRegistered = AppTranslations.of(context).text('title_card_registered');
                        //info['description']
                        mostrarAlerta(context, cardRegistered,'', 'assets/error.png');
                      }else if(info['error_code'] == 2003){
                        //El cliente con este identificador externo (External ID)
                        //ya existe.
                        String clientExist = AppTranslations.of(context).text('title_client_exist');
                        //info['description']
                        mostrarAlerta(context, clientExist, '', 'assets/error.png');
                      }else if(info['error_code'] == 2004){
                        //El dígito verificador del número de tarjeta es inválido
                        //de acuerdo al algoritmo Luhn.
                        String digitInvalid = AppTranslations.of(context).text('title_digit_invalid');
                        //info['description']
                        mostrarAlerta(context, digitInvalid , '', 'assets/error.png');
                      }else if(info['error_code'] == 2005){
                        //La fecha de expiración de la tarjeta es anterior a la
                        //fecha actual.
                        String dateExpired = AppTranslations.of(context).text('title_date_expired');
                        //info['description']
                        mostrarAlerta(context, dateExpired , '', 'assets/error.png');
                      }else if(info['error_code'] == 2006){
                        //El código de seguridad de la tarjeta (CVV2) no fue
                        //proporcionado.
                        String codeSecurityEmpty = AppTranslations.of(context).text('title_code_security_empty');
                        //info['description']
                        mostrarAlerta(context, codeSecurityEmpty , '', 'assets/error.png');
                      }else if(info['error_code'] == 2007){
                        //El número de tarjeta es de prueba, solamente puede
                        //usarse en Sandbox.
                        String cardTest = AppTranslations.of(context).text('title_card_test');
                        //info['description']
                        mostrarAlerta(context, cardTest , '', 'assets/error.png');
                      }else if(info['error_code'] == 2008){
                        //La tarjeta consultada no es valida para puntos.
                        String cardNoPoints = AppTranslations.of(context).text('title_card_not_points');
                        //info['description']
                        mostrarAlerta(context, cardNoPoints , '', 'assets/error.png');
                      }else if(info['error_code'] == 2009){
                        //El código de seguridad de la tarjeta (CVV2) no es valido.
                        String codeSecurityNoValid = AppTranslations.of(context).text('title_card_not_valid');
                        //info['description']
                        mostrarAlerta(context, codeSecurityNoValid , '', 'assets/error.png');
                      }else if(info['error_code'] == 3001){
                        String tarjetaDeclinada = AppTranslations.of(context).text('title_card_declined');
                        //La tarjeta fue declinada.
                        //info['description']
                        mostrarAlerta(context, tarjetaDeclinada, '', 'assets/error.png');
                      }else if(info['error_code'] == 3002){
                        //La tarjeta ha expirado.
                        String tarjetaExpirada = AppTranslations.of(context).text('title_card_expired');
                        //info['description']
                        mostrarAlerta(context, tarjetaExpirada, '', 'assets/error.png');
                      }else if(info['error_code'] == 3003){
                        //La tarjeta no tiene fondos suficientes.
                        String tarjetaSinFondos = AppTranslations.of(context).text('title_card_not_funds');
                        //info['description']
                        mostrarAlerta(context, tarjetaSinFondos, '', 'assets/error.png');
                      }else if(info['error_code'] == 3004){
                        //La tarjeta ha sido identificada como una tarjeta
                        //robada.
                        String tarjetaRobada = AppTranslations.of(context).text('title_card_lost');
                        //info['description']
                        mostrarAlerta(context, tarjetaRobada, '', 'assets/error.png');
                      }else if(info['error_code'] == 3005){
                        //La tarjeta ha sido identificada como una tarjeta
                        //fraudulenta.
                        String tarjetaFraudulenta = AppTranslations.of(context).text('title_card_fraudulent');
                        //info['description']
                        mostrarAlerta(context, tarjetaFraudulenta, '', 'assets/error.png');
                      }else if(info['error_code'] == 3006){
                        //La operación no esta permitida para este cliente o
                        //esta transacción.
                        String operacionNoPermitida = AppTranslations.of(context).text('title_operation_not_allowed');
                        //info['description']
                        mostrarAlerta(context, operacionNoPermitida, '', 'assets/error.png');
                      }else if(info['error_code'] == 3008){
                        //La tarjeta no es soportada en transacciones en linea.
                        String tarjetaNoSoportadaOnline = AppTranslations.of(context).text('title_card_not_support_online');
                        //info['description']
                        mostrarAlerta(context, tarjetaNoSoportadaOnline, '', 'assets/error.png');
                      }else if(info['error_code'] == 3009){
                        //La tarjeta fue reportada como perdida.
                        String tarjetaPerdida = AppTranslations.of(context).text('title_card_lost');
                        //info['description']
                        mostrarAlerta(context, tarjetaPerdida, '', 'assets/error.png');
                      }else if(info['error_code'] == 3010){
                        //El banco ha restringido la tarjeta.
                        String bankRestrictedCard = AppTranslations.of(context).text('title_bank_restricted_card');
                        //info['description']
                        mostrarAlerta(context, bankRestrictedCard, '', 'assets/error.png');
                      }else if(info['error_code'] == 3011){
                        //El banco ha solicitado que la tarjeta sea retenida.
                        //Contacte al banco.
                        String tarjetaRetenida = AppTranslations.of(context).text('title_card_withheld');
                        //info['description']
                        mostrarAlerta(context, tarjetaRetenida, '', 'assets/error.png');
                      }else if(info['error_code'] == 3012){
                        //Se requiere solicitar al banco autorización para
                        //realizar este pago.
                        String solictarPago = AppTranslations.of(context).text('title_autorization_buy');
                        //info['description']
                        mostrarAlerta(context, solictarPago, '', 'assets/error.png');
                      }else if(info['error_code'] == 4001){
                        //La cuenta de Openpay no tiene fondos suficientes.
                        String openpayNotFunds = AppTranslations.of(context).text('title_openpay_account_not_funds');
                        //info['description']
                        mostrarAlerta(context, openpayNotFunds, '', 'assets/error.png');
                      }
                      else{
                        formKey.currentState.save();
                        prefs.idTarjeta = info['id'];
                        String tarjetaAgregado = AppTranslations.of(context).text('title_tarjetaAgregado');
                        
                      /*  Navigator.removeRoute(context,MaterialPageRoute(
                          builder: (context){
                            return IngresoTarjetaPage();
                          },
                          settings: RouteSettings(arguments: detalleTour)
                        ) );*/
                        //Navigator.pop(context);
                      // Navigator.popUntil(context, ModalRoute.withName('metodopago'));
                      //Navigator.popAndPushNamed(context,'metodopago',arguments: detalleTour);
                        
                        Navigator.popUntil(context, ModalRoute.withName('metodopago'));
                        mostrarAviso(context, '$tarjetaAgregado', '', 'assets/check.jpg');
                        //mostrarAlerta(context, 'Tarjeta Agregada', '', 'assets/check.jpg');
                        //Navigator.pop(context);
                    }
                    
                    });
                  }else{
                    String errorValidar = AppTranslations.of(context).text('title_errorValidar');
                  mostrarAlerta(context, '$errorValidar', '', 'assets/error.png');
                  }
                  
                },
              )*/
            ],
          ),
        ),
      ),
    );
  }

  Widget dialogo(BuildContext context,String title, String mensaje, String imagen){
    final size = MediaQuery.of(context).size;
    String aceptar = AppTranslations.of(context).text('title_accept');
    return Scaffold(
            body: AlertDialog(
          title: Text('$title'),
          content: Container(
            width: size.width * 0.5,
            height: size.height * 0.3,
            child: Column(
              children: <Widget>[
                Container(
                        width: size.width * 0.3,
                        height: size.height * 0.2,
                        child: Image.asset('$imagen'),
                      ),
                      Text(mensaje,style: TextStyle(fontSize: 6.0),),
                      RaisedButton(
                        textTheme: ButtonTextTheme.primary,
                        color: Colors.green,
                        shape: StadiumBorder(),
                        child: Text('$aceptar',style: TextStyle(color: Colors.white),),
                        onPressed: (){
                          Navigator.popUntil(context, ModalRoute.withName('/detalletour'));
                        },
                      ),
                
              ],
            ),
          ),
         /* actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: ()=>Navigator.of(context).pop(),
            )
          ],*/
        ),
     );
  }
}