import 'dart:convert';
import 'dart:io';

//import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
//import 'package:http_auth/http_auth.dart' as httpAuth;
//import 'package:openpay_flutter/model/card.dart';
//import 'package:openpay_flutter/model/merchant.dart';
import 'package:selftourapp/src/models/tarjeta_model.dart';
//import 'package:openpay_flutter/openpay_flutter.dart';

class PagosProvider{
  
  ///Credenciales OpenPay
  static String markerid = "mved55pnqueugtksu9kc";
  static String keySecret= "sk_b001f7057e294957b8c137ca416db33d";
  static String keySecretEnc = "c2tfYjAwMWY3MDU3ZTI5NDk1N2I4YzEzN2NhNDE2ZGIzM2Q6Og=="; //c2tfYjAwMWY3MDU3ZTI5NDk1N2I4YzEzN2NhNDE2ZGIzM2Q6Og==  sk_b001f7057e294957b8c137ca416db33d:
  static String publicKey = "pk_281cceb6e0bf424c9fb477510e748ad3";

  ///Credenciales PayPal Sandbox
  static String clientId = "AXIAUMr5Wvw1ArUNzexxNr_BzxecGVZhCDkKe66lXqAhw4CHRMIyr6oTXsdSiBWgcZjFFWWVlBpZJkKI";
  static String clientSecret = "EHaMIVsru_o3fMyN5vfVBRojTNC9o7ATU8xtWnIy80JzCeCJysoC1EQBnsMPDE744RiWlueJP61hYX-u";
  //String token = "A21AAF-2u8vuqPUq7k9OXE9ElaAZ9SmdFtzCpcJYBcuATSqPipDKQiAkenN2uw1SMvdYWXb2GNuN6m88F_0j3AEMJzp_S6I4g";
  static String credential = "$clientId:$clientSecret";
  static Codec<String, String> stringToBase64 = utf8.fuse(base64);
  static String encoded = stringToBase64.encode(credential);
  String decoded = stringToBase64.decode(encoded);

  

  PagosProvider();

   //OpenpayAPI openpayAPI = OpenpayAPI(markerid,publicKey,production: false);
  final platform = const MethodChannel('samples.flutter.io/deviceid');

  String deviceId = "";

/*Future<String>getDeviceId()async{
 // String deviceSesionId;

 String deviceId = await openpayAPI.deviceSessionId(markerid, keySecret);

 return deviceId;
  /*try{
    String result = await platform.invokeMethod('getDeviceId');
    deviceId = result;
    
  }on PlatformException catch(e){
    print(e.message);
  }*/
}*/

/*Future<Map<String,dynamic>> crearTokenTarjeta(Card tarjeta)async{
  

}*/

Future<Map<String, dynamic>> crearToken(TarjetaModel tarjeta)async{
  final String url = 'https://sandbox-api.openpay.mx/v1/$markerid/tokens';
  //https://sandbox-api.openpay.mx/v1/{MERCHANT_ID}/tokens

  final resp = await http.post(
    url,
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader:"Basic $keySecretEnc"
    },
    body: tarjetaToJson(tarjeta)
    );
  final decodedResp= json.decode(resp.body);

  print(decodedResp);

  return decodedResp;
}

Future<Map<String,dynamic>> obtenerToken(String tokenId)async{
  final url = 'https://sandbox-api.openpay.mx/v1/$markerid/tokens/$tokenId';
  //https://sandbox-api.openpay.mx/v1/{MERCHANT_ID}/tokens/{TOKEN_ID}
  final resp = await http.get(
    url,
    headers: {
      HttpHeaders.authorizationHeader:"Basic $keySecretEnc"
    }
  );

  final decodedData = json.decode(resp.body);
  print(decodedData);

  List lista = List();

  lista.add(
    decodedData
  );

  return decodedData;
}
  
  Future<Map<String,dynamic>> crearTarjeta(TarjetaModel tarjeta)async{
   // String username = '$keySecret';
   // String password='';
 // final credentials = '$username:$password';
//  final stringToBase64 = utf8.fuse(base64);
 // final encodedCredentials = stringToBase64.encode(credentials);
  //print(encodedCredentials);
 // final List<Tarjeta> list = List();
 /*String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$username:$password'));
  print(basicAuth);*/

    final String url = 'https://sandbox-api.openpay.mx/v1/$markerid/cards';

    //https://sandbox-api.openpay.mx/v1/mved55pnqueugtksu9kc/cards
   /* final datosTarjeta = {
      "card_numbre": numTarjeta,
      "holder_name": nombreTarjeta,
      "expiration_year": yearExp,
      "expiration_month": mesExp,
      "cvv2": codSeguridad
    };*/

    

    final resp = await http.post(url,headers: {
      HttpHeaders.contentTypeHeader:"application/json",
      HttpHeaders.authorizationHeader: "Basic $keySecretEnc",
    },
    body: tarjetaToJson(tarjeta)
    );

    final decodedResp = json.decode(resp.body);
    print(decodedResp);

   /* decodedResp.forEach((id,tarjeta){
      final tarjTemp = Tarjeta.fromJson(tarjeta);
      tarjTemp.id = id;
      list.add(tarjTemp);
    });*/
    //print(list[0].id);
    return decodedResp;
  }

  Future<List> obtenerTarjeta(String idTarjeta)async{
    final url = 'https://sandbox-api.openpay.mx/v1/$markerid/cards/$idTarjeta';//k9qucnplcdfvl3o5v6ae kohnetmcdq94ptoxic3i
    //https://sandbox-api.openpay.mx/v1/{MERCHANT_ID}/cards/{CARD_ID}
    //final List<TarjetaModel> infoTarjeta = List();


    final resp = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: "Basic $keySecretEnc"
      }
    );
    final Map<String,dynamic> decodedData = json.decode(resp.body);

   /* decodedData.forEach((id,resp){
      final temp = TarjetaModel.fromJson(resp);
      temp.id = id;
      infoTarjeta.add(temp);
    });*/
    
    print(decodedData);
    final List<dynamic> lista = List();
    lista.add(
      decodedData
    );
    return lista;
  }

  Future<Map<String,dynamic>> cargarTarjetaToken(String sourceId,String amount,String description,String name,String email,{String devicesesionId})async{
    String url = 'https://sandbox-api.openpay.mx/v1/$markerid/charges';
    //https://sandbox-api.openpay.mx/v1/{MERCHANT_ID}/charges
    final datos={
      "source_id":"$sourceId",
      "method": "card",
      "amount": "$amount",
      "currency": "USD",//MXN
      "description": "$description",
      "device_session_id" : "S/N",//kR1MiQhz2otdIuUlQkbEyitIqVMiI16f
      "customer":{
        "name":"$name",
        "email":"$email"
      }
    };
    final resp = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader:"application/json",
        HttpHeaders.authorizationHeader:"Basic $keySecretEnc"
      },
      body: json.encode(datos)
    );

    final decodedResp = json.decode(resp.body);
    print(decodedResp);
    return decodedResp;
  }

  Future<Map<String,dynamic>> crearCliente(String name,String email,bool reqaccount)async{
    String url = 'https://sandbox-api.openpay.mx/v1/$markerid/customers';
    //https://sandbox-api.openpay.mx/v1/{MERCHANT_ID}/customers

    final datoCliente = {
      "name":"",
      "email":"",
      "requires_account": ""
    };

    final resp = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader:"Basic $keySecretEnc"
      },
      body: json.encode(datoCliente)
    );
    final decodedResp = json.decode(resp.body);
    return decodedResp;
  }

  Future<Map<String,dynamic>> obtenerCliente(String idCliente)async{
    final url = 'https://sandbox-api.openpay.mx/v1/$markerid/customers/$idCliente';
    //https://sandbox-api.openpay.mx/v1/{MERCHANT_ID}/customers/{CUSTOMER_ID}

    final resp = await http.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader:"application/json",
        HttpHeaders.authorizationHeader:"Basic $keySecretEnc"
      }
    );

    final decodedResp = json.decode(resp.body);

    return decodedResp;
  }

  Future<Map<String,dynamic>> tokenPaypal()async{
    String url = "https://api.sandbox.paypal.com/v1/oauth2/token";

    
    final resp = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader:"Basic $encoded",
        HttpHeaders.contentTypeHeader: "Application/json",
      },
      body: "grant_type=client_credentials"
    );

    final decoded = json.decode(resp.body);

    print(decoded);

    return decoded;
    
  }


  Future<Map<String,dynamic>> ordenarPedido(String precio,String nombreUsuario,String emailUser,String descripcionCompra,String returnUrl)async{
    String url = "https://api.sandbox.paypal.com/v2/checkout/orders";

    final data = {
        "intent": "CAPTURE",
        "purchase_units": [
          {
          "amount": {
            "currency_code":"USD",
            "value": "$precio"
          },
         "payee":{
            "email_address": "selftour.travel@gmail.com",
            "merchant_id": "V8Z3WUJKYKD62",
          },
          "payment_instruction":{
            "disbursement_mode": "INSTANT"
          },
          "description": "$descripcionCompra"
        },
        ],
        "payer":{
          "name":{
            "given_name":"$nombreUsuario"
          },
          "email_address": "$emailUser"
        },
        "payment_method":{
          "payer_selected":"PAYPAL",
          "payee_preferred": "IMMEDIATE_PAYMENT_REQUIRED"
        },
       /* "payment_source": {
          "card":{
            "name": "$nombreTarjeta",
            "number": "$numCuenta",
            "expiry": "11/2024",
            "security_code": "330"
          }
        }*/
        "application_context":{

          //"landing_page": "LOGIN",
            "brand_name": "Selftour",
            //"locale": "es-Es",
            //"shipping_preference": "SET_PROVIDED_ADDRESS",
            "user_action": "PAY_NOW", //PAY_NOW CONTINUE
            "return_url": "$returnUrl" //https://www.selftour.travel
            //"cancel_url": "https://www.selftour.travel/tours" //https://www.selftour.travel/tours
          /*"order_application_context": {
            
          },*/
          
        }
      };

    final resp = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader:"Basic $encoded",
        HttpHeaders.contentTypeHeader: "application/json"
      },
      body: json.encode(data)
    );

    final decodedResp = json.decode(resp.body);

    return decodedResp;
  }

  Future<Map<String,dynamic>> capturarOrden(String idOrden)async{
    String url = "https://api.sandbox.paypal.com/v2/checkout/orders/$idOrden/capture";
    ///v2/checkout/orders/{order_id}/capture
    
    final resp = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Basic $encoded"
      }
    );
    final decodedInfo = json.decode(resp.body);
    print(decodedInfo);
    return decodedInfo;
  }

  Future<Map<String,dynamic>> registrarPago(String token, String idtour,String method, String amount)async{
    String url = "https://api-users.selftours.app/responseShop";

    final data = {
      "idtour": "$idtour",
      "method": "$method",
      "amount": "$amount"
    };

    final response = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": "$token"
      },
      body: json.encode(data)
    );

    final responseDecoded = json.decode(response.body);

    return responseDecoded;
  }
}