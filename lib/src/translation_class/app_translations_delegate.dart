import 'package:flutter/material.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';
import 'package:selftourapp/src/translation_class/application.dart';

///Se encarga de checar si la región o idioma es soportado  o no
///Provee la clase AppTranslations con la nueva región o idioma seleccionado
///Recarga la clase AppTranslations siempre y cuando se elija un idioma
///
class AppTranslationsDelegate extends LocalizationsDelegate<AppTranslations>{
  final Locale newLocale;
  const AppTranslationsDelegate({this.newLocale});

  @override
  bool isSupported(Locale locale) {
    // TODO: implement isSupported
    //Reemplazado con uno de la clase Appplication
    return application.supportedLanguagesCodes.contains(locale.languageCode);
  }

  @override
  Future<AppTranslations> load(Locale locale) {
    // TODO: implement load

    return AppTranslations.load(newLocale ?? locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppTranslations> old) {
    // TODO: implement shouldReload
    return true;
  }
  
}