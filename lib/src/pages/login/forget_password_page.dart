import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:selftourapp/src/bloc/provider.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:selftourapp/src/providers/usuario_provider.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';
import 'package:selftourapp/src/widgets/tree_size_dot_widget.dart';

class ForgetPasswordPage extends StatefulWidget {
  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final usuarioProvider = new UsuarioProvider();
  PreferenciasUsuario prefs = PreferenciasUsuario();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String correo;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = BlocProvider.of<LoginBloc>(context);
    String forgetPass = AppTranslations.of(context).text('title_forgetpass');
    String enterEmail = AppTranslations.of(context).text('title_enter_email');

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: size.height * 0.09,),
              Container(
                alignment: Alignment.center,
                child: Text('$forgetPass',style: TextStyle(color: Colors.black,fontSize: 26.0),),
              ),
              SizedBox(height: size.height * 0.1,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                child: Center(
                  child: Text(
                    '$enterEmail',
                    style: TextStyle(
                      fontFamily: 'Point-SemiBold'
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Container(
                child: _email(),
                //color: Colors.black12,
              ),
              SizedBox(height: size.height * 0.04,),
              _botonEnviar(bloc),
              SizedBox(height: size.height * 0.3,),
              Container(
                child: _backLogin(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _email(){
    final size = MediaQuery.of(context).size;
    String email = AppTranslations.of(context).text('title_email');
    return Container(
      height: size.height * 0.10,
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.black,),
          icon: Icon(Icons.mail_outline,color: Colors.grey,),
          labelText: '$email',
          hintStyle: TextStyle(color: Colors.grey),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 0.0)
          )
          //hintText: 'Correo',
          //counterText: snapshot.data,
          //errorText: snapshot.error
        ),
        onSaved: (String mail){
          correo = mail;
        },
        onChanged: (value){
          print(value);
        }, //Coloca informacion en el Stream del input
      ),
      );
}

  Widget _botonEnviar(LoginBloc bloc){
    final size = MediaQuery.of(context).size;
    String enviar = AppTranslations.of(context).text('title_send');

    return ProgressButton(
      defaultWidget: Text(
        '$enviar',
        style: TextStyle(
          fontFamily: 'Point-SemiBold',
          fontSize: 15.0,
          color: Colors.white
        ),
      ),
      width: size.width * 0.7,
      height: size.height * 0.07,
      borderRadius: 5.0,
      progressWidget: ThreeSizeDot(),
      color: Color(0xFFD62250),
      type: ProgressButtonType.Raised,
      animate: false,
      onPressed: ()async{
        setState(() {
          
        });
        formKey.currentState.save();
        print(correo);
        await Future.delayed(Duration(seconds: 2),()async{
          await bloc.resetPassword(context, correo, prefs.idioma.toString());
        });
      },
    );
  //   return RaisedButton(
  //   child: Container(
  //     width: size.width * 0.7,
  //     padding: EdgeInsets.all(20.0),
  //     child: Text('SEND EMAIL',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15.0),),
  //   ),
  //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
  //   color: Color(0xFFD62250),
  //   onPressed: (){

  //   },
  // );
}
Widget _backLogin(){
  String backLogin = AppTranslations.of(context).text('title_back_login');

  return FlatButton(
    child: Text(
      '$backLogin',
      style: TextStyle(
        fontFamily: 'Point-SemiBold',
        color: Colors.white,
        fontSize: 18.0
      ),
    ),
    onPressed: (){
      // Navigator.pushReplacementNamed(context, 'login');
      Navigator.pop(context);
    },
  );
}
}