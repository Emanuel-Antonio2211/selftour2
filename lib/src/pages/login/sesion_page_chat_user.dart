import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:selftourapp/src/bloc/provider.dart';
import 'package:selftourapp/src/models/chat_model.dart';
import 'package:selftourapp/src/pages/create_account/create_account_page.dart';
import 'package:selftourapp/src/pages/login/login_page.dart';
//import 'package:selftourapp/src/pages/pagos/pagos_page.dart';
import 'package:selftourapp/src/pages/usuario/chat_page.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:selftourapp/src/providers/usuario_provider.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:selftourapp/src/bloc/login_bloc.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';

class SesionPageChatUser extends StatefulWidget {
  @override
  _SesionPageState createState() => _SesionPageState();
}

class _SesionPageState extends State<SesionPageChatUser> {
  LoginBloc userBloc;
  final usuarioProvider = new UsuarioProvider();
  PreferenciasUsuario prefs = PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<LoginBloc>(context);
    
    return _sessionActual();
  }

  Widget _sessionActual() {
    final size = MediaQuery.of(context).size;
    Chat datosChat = ModalRoute.of(context).settings.arguments;
    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
    String inicioSesion = AppTranslations.of(context).text('title_login');
    String crearCuenta = AppTranslations.of(context).text('title_createaccount');

    if (!snapshot.hasData || snapshot.hasError) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Image.asset(
              'assets/world-bakground.png',
              fit: BoxFit.cover,
              scale: 1.0,
              width: double.infinity,
              height: double.infinity,//size.height * 0.49
            ),
            SingleChildScrollView(
              child: Column(
                    children: <Widget>[
                      SafeArea(
                        child: Container(
                          height: size.height * 0.1, //90.0
                        ),
                      ),
                      Image.asset(
                        'assets/iconoapp/Selftour1.png',
                        width: 120.0,
                      ),
                      Container(
                        child: Text(
                          '$inicioSesion',
                          style: TextStyle(
                              fontFamily: 'Point-SemiBold',
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.1,
                      ),

                      Container(
                        width: size.width * 0.8,
                        child: RaisedButton.icon(
                            icon: Image.asset(
                              'assets/logoemail.png',
                              color: Colors.white,
                              width: 25.0,

                            ),
                            textTheme: ButtonTextTheme.primary,
                            color: Colors.grey,
                            label: Text(
                              '$inicioSesion Email',
                              style: TextStyle(
                                fontFamily: 'Point-SemiBold',
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            ),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                            onPressed: (){
                              setState(() {
                                
                              });
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                                return Login();
                              },fullscreenDialog: true));
                            },
                          ),
                      ),
                      Container(
                        width: size.width * 0.8,
                        child: RaisedButton.icon(
                            icon: Image.asset(
                              'assets/google@3x.png',
                              color: Colors.white,
                              width: 25.0,

                            ),
                            textTheme: ButtonTextTheme.primary,
                            color: Colors.red,
                            label: Text(
                              '$inicioSesion Gmail',
                              style: TextStyle(
                                fontFamily: 'Point-SemiBold',
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            ),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                            onPressed: (){
                              setState(() {
                                
                              });
                              userBloc.signOut();
                              userBloc.signInGoogle(context);
                            },
                          ),
                      ),
                      Container(
                        width: size.width * 0.8,
                        child: RaisedButton.icon(
                            icon: Image.asset(
                              'assets/facebook@3x.png',
                              width: 25.0,

                            ),
                            textTheme: ButtonTextTheme.primary,
                            color: Colors.blue,
                            label: Text(
                              '$inicioSesion Facebook',
                              style: TextStyle(
                                fontFamily: 'Point-SemiBold',
                                fontSize: 16.8,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            ),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                            onPressed: (){
                              setState(() {
                                
                              });
                              userBloc.signOut();
                              userBloc.signInFacebook(context);
                            },
                          ),
                      ),
                      Container(
                        child: FlatButton(
                          child: Text(
                            '$crearCuenta',
                            style: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.black, fontSize: 16.0),
                          ),
                          onPressed: () {
                            setState(() {
                              
                            });
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context){
                                  return CreateAccountPage();
                                },
                                fullscreenDialog: true
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  heightFactor: 1.5,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            )
          );
        } else {
          return ChatPage(userEmail: datosChat.emailuser.toString(),userName: datosChat.usuario.toString(),userAvatar: datosChat.fotouser.toString());
        }
      },
    );
  }
}