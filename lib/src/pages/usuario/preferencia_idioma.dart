import 'package:flutter/material.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';
import 'package:selftourapp/src/translation_class/application.dart';
//import 'package:translator/translator.dart';
//import 'package:selfttour/src/utils/utils.dart';

class PreferenciaIdioma extends StatefulWidget {
  @override
  _PreferenciaIdiomaState createState() => _PreferenciaIdiomaState();
}

class _PreferenciaIdiomaState extends State<PreferenciaIdioma> {
  static final List<String> languagesList = application.supportedLanguages;
  static final List<String> languageCodesList =
    application.supportedLanguagesCodes;
  
  final Map<dynamic, dynamic> languagesMap = {
    languagesList[0]: languageCodesList[0],
    languagesList[1]: languageCodesList[1],
    languagesList[2]: languageCodesList[2],
    languagesList[3]: languageCodesList[3]
  };



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: _buildLanguageList(),
    );
  }

  Widget _buildLanguageList(){
    return ListView.builder(
      itemCount: languagesList.length,
      itemBuilder: (context,index){
        return _buildLanguageItem(languagesList[index]);
      },
    );
  }

  Widget _buildLanguageItem(String language){
    return ListTile(
      title: Text(language),
      onTap: (){
        setState(() {
          
        });
        print(language);
        application.onLocaleChanged(Locale(languagesMap[language]));
        print(languagesMap[language]);
        _mostrarAlerta(context,language);
      },
    );
  }

 void _mostrarAlerta(BuildContext context,String mensaje){
 final size = MediaQuery.of(context).size;
    showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        //title: Text('Información incorrecta'),
        content: Container(
          width: size.width * 0.5,
          height: size.height * 0.3,
          child: Column(
            children: <Widget>[
                    Container(
                      width: size.width * 0.3,
                      height: size.height * 0.2,
                      child: Image.asset('assets/check.jpg'),
                    ),
                    Flexible(child: Text(mensaje,style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 10.0),)),
                    RaisedButton(
                      textTheme: ButtonTextTheme.primary,
                      color: Colors.green,
                      shape: StadiumBorder(),
                      child: Text(AppTranslations.of(context).text('title_accept'),style: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.white),),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
              
            ],
          ),
        ),
      );
    }
  );
  }
}