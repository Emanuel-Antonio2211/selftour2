import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:selftourapp/src/models/tour_categoria_model.dart';
//import 'package:selfttour/src/pages/pagos/paypal_page.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:selftourapp/src/providers/pagos_provider.dart';
//import 'package:selfttour/src/providers/pagos_provider.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';
//import 'package:selfttour/src/utils/utils.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:selftourapp/src/utils/utils.dart';
//import 'package:selftourapp/src/utils/utils.dart';
//import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
//import 'package:url_launcher/url_launcher.dart';

class VistaPaypalPage extends StatefulWidget {
  @override
  _VistaPaypalPageState createState() => _VistaPaypalPageState();
}

class _VistaPaypalPageState extends State<VistaPaypalPage> {
  PreferenciasUsuario prefs = PreferenciasUsuario();
  PagosProvider _pagosProvider = PagosProvider();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String value = "Selecciona uno";
  ProgressDialog pr;

  String clientId = "AXIAUMr5Wvw1ArUNzexxNr_BzxecGVZhCDkKe66lXqAhw4CHRMIyr6oTXsdSiBWgcZjFFWWVlBpZJkKI"; //clientId de paypal developer AXIAUMr5Wvw1ArUNzexxNr_BzxecGVZhCDkKe66lXqAhw4CHRMIyr6oTXsdSiBWgcZjFFWWVlBpZJkKI

  final platform = MethodChannel('paypal');
  String result = '';
  List infoDato = List();
  List datos = List();

  @override
  void initState() {
    super.initState();
  }

  Future<void> payment(double precio, String descripcion)async{
    
    await platform.invokeMethod('payment',{
      "precio": precio,//10.0
      "descripcion": descripcion,
      "lista": datos
      //"clientid": clientId
    });
    /*Future.delayed(Duration(seconds: 1),()async{
       lista = await enlistar();
    
    
    });*/
  }
  Future<List> enlistar()async{


    infoDato = await platform.invokeListMethod('listaresult');
    //infoDato.toSet();
    // print("Lista de compra: ");
    // print(infoDato);
    return infoDato;
  }

  @override
  Widget build(BuildContext context) {
    InfoTour detalleTour = ModalRoute.of(context).settings.arguments;
    final size = MediaQuery.of(context).size;
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    //PagosProvider pagosProvider = PagosProvider();
    String comprar = AppTranslations.of(context).text('title_buy');
    String vistaPreviaPago = AppTranslations.of(context).text('title_preview_pay');

    if(infoDato.isEmpty){
      Future.delayed(
        Duration(seconds: 3),()async{
        setState(() {

        });
        await enlistar();
          
        }
      );
    }else{
      print(infoDato);
    }

   if(infoDato.isNotEmpty && detalleTour.title == infoDato[4].toString()){
      String pagosuccess = AppTranslations.of(context).text('title_pagosuccess');
      String exitopago = AppTranslations.of(context).text('title_exitopago');
      
      //prefs.idtour = detalleTour.idtour.toString();
      //[PAYID-LZ4PYLI7BG87718955180447, 9X708941B95684058, 5.99, USD, Beer Tour Downtown Mérida, approved, 2020-03-23T18:13:00Z]
      print("Respuesta registro pago");
      // print(prefs.token);
      // print(detalleTour.idtour.toString());
      // print(infoDato[2].toString());
      final infoDatoSet = infoDato.toSet();
      print("lista nueva: ");
      print(infoDatoSet);
      // _pagosProvider.registrarPago(prefs.token, detalleTour.idtour.toString(), 'paypal', infoDato[2].toString()).then((result){
      //   print(result);
      // }).catchError((error){
      //   print("Error:");
      //   print(error);
      // });
      
      return dialogo(context,prefs.token,detalleTour.idtour.toString(),'paypal',infoDato[2].toString(),pagosuccess,exitopago,'assets/check.jpg');
     
   }else{
     return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0.0,
          title: Text(vistaPreviaPago,style: TextStyle(fontFamily: 'Point-SemiBold'),),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                SafeArea(
                  child: SizedBox(
                    height: size.height * 0.04,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0 ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Flexible(child: Text(detalleTour.title,style: TextStyle(fontFamily: 'Point-SemiBold'),)),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: FadeInImage(
                          image: NetworkImage(detalleTour.route[0]['gallery'][0]['url']),
                          placeholder: AssetImage('assets/loading.gif'),
                          width: size.width * 0.35,
                          height: size.height * 0.1,
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                SizedBox(
                  height: size.height * 0.06,
                ),
                RaisedButton.icon(
                  shape: StadiumBorder(),
                  color: Color(0xFF034485),
                  label: Text(comprar,style: TextStyle(color:Colors.white,fontFamily: 'Point-SemiBold'),),
                  icon: Icon(Icons.check,color: Colors.white,),
                  onPressed: ()async{

                    await payment(double.tryParse(detalleTour.price.toString()),detalleTour.title);

                  },
                ),
                
              ],
            ),
          ),
        ),
      );
   }
    
  }

  Widget dialogo(BuildContext context,String token,String idtour,String methodpago,preciotour,String title, String mensaje, String imagen){
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
                      Flexible(
                        child: Text(mensaje,style: TextStyle(fontSize: 12.0),)
                      ),
                      RaisedButton(
                        textTheme: ButtonTextTheme.primary,
                        color: Colors.green,
                        shape: StadiumBorder(),
                        child: Text(aceptar,style: TextStyle(color: Colors.white),),
                        onPressed: (){
                          _pagosProvider.registrarPago(token, idtour, methodpago,preciotour).then((result){
                            print(result);
                          }).catchError((error){
                            print("Error:");
                            print(error);
                          });
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