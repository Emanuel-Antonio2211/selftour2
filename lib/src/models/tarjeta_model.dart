// To parse this JSON data, do
//
//     final tarjeta = tarjetaFromJson(jsonString);

import 'dart:convert';

//import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';

TarjetaModel tarjetaFromJson(String str) => TarjetaModel.fromJson(json.decode(str));

String tarjetaToJson(TarjetaModel data) => json.encode(data.toJson());

class ListTarjeta{
  List<TarjetaModel> infoTarjeta = List();

  ListTarjeta();

  ListTarjeta.fromjsonList(List<dynamic> jsonList){
    if(jsonList == null){
      return;
    }
    for(var item in jsonList){
      final tarjeta = new TarjetaModel.fromJson(item);
      infoTarjeta.add(tarjeta);
    }
  }
}

class TarjetaModel {
    String id;
    String type;
    String brand;
    dynamic address;
    String cardNumber;
    String holderName;
    String expirationYear;
    String expirationMonth;
    bool allowsCharges;
    bool allowsPayouts;
    String creationDate;
    String bankName;
    String bankCode;
    String deviceSesionId;
    String cvv2;

    TarjetaModel({
        this.id,
        this.type,
        this.brand,
        this.address,
        this.cardNumber,
        this.holderName ,
        this.expirationYear,
        this.expirationMonth,
        this.allowsCharges=true,
        this.allowsPayouts=true,
        this.creationDate,
        this.bankName,
        this.bankCode,
        this.deviceSesionId,
        this.cvv2
    });

    factory TarjetaModel.fromJson(Map<String, dynamic> json) => TarjetaModel(
        id                : json["id"],
        type              : json["type"],
        brand             : json["brand"],
        address           : json["address"],
        cardNumber        : json["card_number"],
        holderName        : json["holder_name"],
        expirationYear    : json["expiration_year"],
        expirationMonth   : json["expiration_month"],
        allowsCharges     : json["allows_charges"],
        allowsPayouts     : json["allows_payouts"],
        creationDate      : json["creation_date"],//DateTime.parse
        bankName          : json["bank_name"],
        bankCode          : json["bank_code"],
        deviceSesionId    : json['device_session_id'],
        cvv2              : json['cvv2']
    );

    Map<String, dynamic> toJson() => {
        "id"              : id,
        "type"            : type,
        "brand"           : brand,
        "address"         : address,
        "card_number"     : cardNumber,
        "holder_name"     : holderName,
        "expiration_year" : expirationYear,
        "expiration_month": expirationMonth,
        "allows_charges"  : allowsCharges,
        "allows_payouts"  : allowsPayouts,
        "creation_date"   : creationDate,//toIso8601String
        "bank_name"       : bankName,
        "bank_code"       : bankCode,
        "device_session_id":deviceSesionId,
        "cvv2"            : cvv2
    };
}
