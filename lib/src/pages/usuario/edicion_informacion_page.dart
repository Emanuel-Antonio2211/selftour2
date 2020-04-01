import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';

class EditInformationPage extends StatefulWidget {
  @override
  _EditInformationPageState createState() => _EditInformationPageState();
}

class _EditInformationPageState extends State<EditInformationPage> {
  PreferenciasUsuario prefs = PreferenciasUsuario();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    String guardar = AppTranslations.of(context).text('title_guardar');
    String editainfo = AppTranslations.of(context).text('title_editainfo');
    String nombre = AppTranslations.of(context).text('title_name');
    String correo = AppTranslations.of(context).text('title_email');
    String telefono = AppTranslations.of(context).text('title_telefono');
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
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
        actions: <Widget>[
          FlatButton(
            child: Text('$guardar',style: TextStyle(color: Colors.red),),
            onPressed: (){},
          )
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.02),
                child: Text('$editainfo',style: TextStyle(
                  fontFamily: 'Point-SemiBold',
                  fontSize: 25.0
                )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: CircleAvatar(
                  radius: 50.0,
                  child: Stack(
                    children:[ 
                      ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: FadeInImage(
                        image: prefs.photoUrl.toString() == 'null' ? AssetImage('assets/iconoapp/Selftour1.png') : NetworkImage(prefs.photoUrl.toString()),
                          placeholder: AssetImage('assets/loading.gif'),
                        )
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          backgroundColor: Color(0xFFD62250),
                          child: IconButton(
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                            onPressed: (){

                            },
                          ),
                        ),
                      )
                    ]
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: '$nombre',
                    labelStyle: TextStyle(
                      fontFamily: 'Point-SemiBold',
                      color: Colors.black
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.04,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: '$correo',
                    labelStyle: TextStyle(
                      fontFamily: 'Point-SemiBold',
                      color: Colors.black
                    )
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.04,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                child: TextField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: '$telefono',
                    labelStyle: TextStyle(
                      fontFamily: 'Point-SemiBold',
                      color: Colors.black
                    )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}