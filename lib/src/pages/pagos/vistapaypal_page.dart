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
  //List info = List();
  List infoDato = List();
  List datos = List();

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
    //print(infoDato);
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

  Future.delayed(
    Duration(seconds: 3),(){
    setState(() {

    });
    enlistar();
      
    }
  );
    
    
   /* pr = new ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true,showLogs: true);
    pr.style(
      message: 'Procesando Pago',
      progressWidget: CircularProgressIndicator()
    );*/

//prefs.idtour != detalleTour.idtour.toString()
//detalleTour.title != infoDato[4]
    /*if(infoDato.isEmpty || detalleTour.title != infoDato[4]){
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(detalleTour.title,style: TextStyle(fontFamily: 'Point-SemiBold'),),
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
                SizedBox(
                  height: size.height * 0.04,
                ),
                /*Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Tipo de Moneda: ',style: TextStyle(fontFamily: 'Point-SemiBold'),),
                    DropdownButton<String>(
                      value: value,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      underline:Container(
                        height: 2,
                        color: Colors.white,
                      ),
                      onChanged: (String newValue){
                        setState(() {
                          value = newValue;
                        });
                      },
                      items: <String>['Selecciona uno','AUD','BRL','CAD','CZK','DKK','EUR','HKD','HUF','INR','ILS','JPY','MYR','MXN','TWD','NZD','NOK','PHP','PLN','GBP','RUB','SGD','SEK','CHF','THB','USD']
                      .map<DropdownMenuItem<String>>((String value){
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,style: TextStyle(fontFamily: 'Point-SemiBold'),),
                        );
                      }).toList(),
                    ),
                  ],
                ),*/
                SizedBox(
                  height: size.height * 0.06,
                ),
                RaisedButton.icon(
                  shape: StadiumBorder(),
                  color: Color(0xFF034485),
                  label: Text(comprar,style: TextStyle(color:Colors.white,fontFamily: 'Point-SemiBold'),),
                  icon: Icon(Icons.check,color: Colors.white,),
                  onPressed: ()async{
                    
                    payment(double.tryParse(detalleTour.price.toString()),detalleTour.title);
                    enlistar();
                    if(detalleTour.title == infoDato[4]){
                      String pagosuccess = AppTranslations.of(context).text('title_pagosuccess');
                      String exitopago = AppTranslations.of(context).text('title_exitopago');
                      prefs.idtour = detalleTour.idtour.toString();
                      mostrarConfirmacion(context, pagosuccess, exitopago, 'assets/check.jpg');
                    }
//detalleTour.budget.trimLeft().substring(2,5)
                /*  _scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        content: Text('Procesando Pago'),
                        duration: Duration(seconds: 2),
                      )
                    );*/
                // Map info = await pagosProvider.ordenarPedido(detalleTour.budget.trimLeft().substring(2,5), detalleTour.name, detalleTour.user, detalleTour.title,'https://www.selftour.travel');
                  // await launch(info['links'][1]['href'].toString());
                  
                /* if(info['status'] == 'CREATED'){
                    print(info);

                    prefs.idCompra = info['id'];
                    
                  //await launch(info['links'][1]['href'].toString());
                /*  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context){
                      return PaypalPage(info['links'][1]['href']);
                    }
                  ));*/

              /*  await Future.delayed(Duration(minutes: 2),(){
                    setState(() {
                      
                    });
                    Navigator.pushNamed(context, 'pagado');
                    //pagosProvider.capturarOrden(info['id']);
                  });*/
                  
                  }else{
                    mostrarAlerta(context, 'Te falta completar un campo', '', 'assets/error.png');
                  }*/
                  
                /*   pagosProvider.ordenarPedido(value, detalleTour.budget.trimLeft().substring(2,5), detalleTour.name, detalleTour.user, detalleTour.title).then((result){
                      //print(result['links'][1]['href'].toString());
                      if(result["status"] == "CREATED"){
                        //print(result);

                        //mostrarAlerta(context, 'Orden creado', '', 'assets/check.jpg');
                        launch(result['links'][1]['href'].toString());
                        /*pagosProvider.capturarOrden(result['id']).then((result){
                          if(result['status'] == 'COMPLETED'){
                            mostrarAlerta(context, 'Se capturó correctamente', '', 'assets/check.jpg');
                          }
                        }).catchError((error){
                          mostrarAlerta(context, error.toString(), '', 'assets/error.png');
                        });*/
                      }else{
                        mostrarAlerta(context, 'Te falta completar un campo', '', 'assets/error.png');
                      }
                      print(result);
                      
                      //launch('${result['links'][1]['href']}');
                    }).catchError((error){
                      print(error.toString());
                      mostrarAlerta(context, error, '', 'assets/error.png');
                    });*/

                  },
                )
              ],
            ),
          ),
        ),
      );
    }else{
      String pagosuccess = AppTranslations.of(context).text('title_pagosuccess');
      String exitopago = AppTranslations.of(context).text('title_exitopago');
      prefs.idtour = detalleTour.idtour.toString();
      
      return dialogo(context,pagosuccess,exitopago,'assets/check.jpg');
    }*/

   if(infoDato.isNotEmpty && detalleTour.title == infoDato[4].toString()){
      String pagosuccess = AppTranslations.of(context).text('title_pagosuccess');
      String exitopago = AppTranslations.of(context).text('title_exitopago');
      //prefs.idtour = detalleTour.idtour.toString();
      //[PAYID-LZ4PYLI7BG87718955180447, 9X708941B95684058, 5.99, USD, Beer Tour Downtown Mérida, approved, 2020-03-23T18:13:00Z]
      print("Respuesta registro pago");
      // print(prefs.token);
      // print(detalleTour.idtour.toString());
      // print(infoDato[2].toString());
      _pagosProvider.registrarPago(prefs.token, detalleTour.idtour.toString(), 'paypal', infoDato[2].toString()).then((result){
        print(result);
      }).catchError((error){
        print("Error:");
        print(error);
      });
      
      return dialogo(context,pagosuccess,exitopago,'assets/check.jpg');
     
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
                /*Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Tipo de Moneda: ',style: TextStyle(fontFamily: 'Point-SemiBold'),),
                    DropdownButton<String>(
                      value: value,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      underline:Container(
                        height: 2,
                        color: Colors.white,
                      ),
                      onChanged: (String newValue){
                        setState(() {
                          value = newValue;
                        });
                      },
                      items: <String>['Selecciona uno','AUD','BRL','CAD','CZK','DKK','EUR','HKD','HUF','INR','ILS','JPY','MYR','MXN','TWD','NZD','NOK','PHP','PLN','GBP','RUB','SGD','SEK','CHF','THB','USD']
                      .map<DropdownMenuItem<String>>((String value){
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,style: TextStyle(fontFamily: 'Point-SemiBold'),),
                        );
                      }).toList(),
                    ),
                  ],
                ),*/
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
                     
                    //final lista = await enlistar();
                    /*print("Respuesta");
                    print(infoDato);
                    if(infoDato.isNotEmpty){
                      String pagosuccess = AppTranslations.of(context).text('title_pagosuccess');
                      String exitopago = AppTranslations.of(context).text('title_exitopago');
                      prefs.idtour = detalleTour.idtour.toString();
                      mostrarConfirmacion(context, pagosuccess, exitopago, 'assets/check.jpg');
                    }*/
//detalleTour.budget.trimLeft().substring(2,5)
                /*  _scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        content: Text('Procesando Pago'),
                        duration: Duration(seconds: 2),
                      )
                    );*/
                // Map info = await pagosProvider.ordenarPedido(detalleTour.budget.trimLeft().substring(2,5), detalleTour.name, detalleTour.user, detalleTour.title,'https://www.selftour.travel');
                  // await launch(info['links'][1]['href'].toString());
                  
                /* if(info['status'] == 'CREATED'){
                    print(info);

                    prefs.idCompra = info['id'];
                    
                  //await launch(info['links'][1]['href'].toString());
                /*  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context){
                      return PaypalPage(info['links'][1]['href']);
                    }
                  ));*/

              /*  await Future.delayed(Duration(minutes: 2),(){
                    setState(() {
                      
                    });
                    Navigator.pushNamed(context, 'pagado');
                    //pagosProvider.capturarOrden(info['id']);
                  });*/
                  
                  }else{
                    mostrarAlerta(context, 'Te falta completar un campo', '', 'assets/error.png');
                  }*/
                  
                /*   pagosProvider.ordenarPedido(value, detalleTour.budget.trimLeft().substring(2,5), detalleTour.name, detalleTour.user, detalleTour.title).then((result){
                      //print(result['links'][1]['href'].toString());
                      if(result["status"] == "CREATED"){
                        //print(result);

                        //mostrarAlerta(context, 'Orden creado', '', 'assets/check.jpg');
                        launch(result['links'][1]['href'].toString());
                        /*pagosProvider.capturarOrden(result['id']).then((result){
                          if(result['status'] == 'COMPLETED'){
                            mostrarAlerta(context, 'Se capturó correctamente', '', 'assets/check.jpg');
                          }
                        }).catchError((error){
                          mostrarAlerta(context, error.toString(), '', 'assets/error.png');
                        });*/
                      }else{
                        mostrarAlerta(context, 'Te falta completar un campo', '', 'assets/error.png');
                      }
                      print(result);
                      
                      //launch('${result['links'][1]['href']}');
                    }).catchError((error){
                      print(error.toString());
                      mostrarAlerta(context, error, '', 'assets/error.png');
                    });*/

                  },
                ),
                
              ],
            ),
          ),
        ),
      );
   }
    
    
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
                      Flexible(
                        child: Text(mensaje,style: TextStyle(fontSize: 12.0),)
                      ),
                      RaisedButton(
                        textTheme: ButtonTextTheme.primary,
                        color: Colors.green,
                        shape: StadiumBorder(),
                        child: Text(aceptar,style: TextStyle(color: Colors.white),),
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