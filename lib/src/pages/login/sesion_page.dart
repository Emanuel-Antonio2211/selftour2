import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:selftourapp/src/bloc/provider.dart';
import 'package:selftourapp/src/pages/create_account/create_account_page.dart';
import 'package:selftourapp/src/pages/login/login_page.dart';
import 'package:selftourapp/src/pages/tours/TabsPage.dart';
import 'package:selftourapp/src/providers/usuario_provider.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:selftourapp/src/bloc/login_bloc.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';

class SesionPage extends StatefulWidget {
  @override
  _SesionPageState createState() => _SesionPageState();
}

class _SesionPageState extends State<SesionPage> {
  LoginBloc userBloc;
  final usuarioProvider = new UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<LoginBloc>(context);
    return _sessionActual();
  }

  Widget _sessionActual() {
    final size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        String inicioSesion = AppTranslations.of(context).text('title_login');
        String crearCuenta = AppTranslations.of(context).text('title_createaccount');
        if (!snapshot.hasData || snapshot.hasError) {
          return Scaffold(
           /* appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
            ),*/
            backgroundColor: Colors.white,
            //Color(0xFF034485)

            body: Stack(
              children:[ 
                Image.asset(
                  'assets/world-bakground.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  scale: 1.0,
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
                              //Navigator.pushReplacementNamed(context, 'login');
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                                return Login();
                              },fullscreenDialog: true));
                            },
                          ),
                      ),
                      
                      /*ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: 
                        
                        SignInButton(
                          Buttons.Email,
                          onPressed: () {
                            setState(() {
                              
                            });
                            //Navigator.pushReplacementNamed(context, 'login');
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                              return Login();
                            },fullscreenDialog: true));
                          },
                          text: '$inicioSesion Email',
                        ),
                      ),*/
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
                      /*ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: SignInButton(
                          Buttons.Google,
                          onPressed: () {
                            setState(() {
                              
                            });
                            userBloc.signOut();
                            userBloc.signInGoogle(context);
                            /*.then((FirebaseUser user) =>
                                print('El usuario es ${user.displayName}'));*/
                          },
                          text: '$inicioSesion Gmail',
                        ),
                      ),*/

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
                      
                     /* ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: SignInButton(
                          Buttons.Facebook,
                          onPressed: () {
                            setState(() {
                              
                            });
                            userBloc.signOut();
                            userBloc.signInFacebook(context);
                            
                            /*.then((FirebaseUser user) =>
                                print('El usuario es ${user.displayName}'));*/
                            //userBloc.signOut();
                            //Navigator.pushNamed(context, 'inicio');
                          },
                          text: '$inicioSesion Facebook',
                        ),
                      ),*/
                     /* RaisedButton.icon(
                          icon: Image.asset(
                            'assets/logotwitter.png',
                            width: 25.0,

                          ),
                          textTheme: ButtonTextTheme.primary,
                          color: Colors.white,
                          label: Text(
                            '$inicioSesion Twitter',
                            style: TextStyle(
                              fontFamily: 'Point-SemiBold',
                              fontSize: 19.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          ),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                          onPressed: (){
                            setState(() {
                              
                            });
                            userBloc.signOut();
                            userBloc.signInTwitter(context);
                          },
                        ),*/
                     /* ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: SignInButton(
                          Buttons.Twitter, 
                          onPressed: () {
                            setState(() {
                              
                            });
                          userBloc.signOut();
                          userBloc.signInTwitter(context);
                          /*.then((FirebaseUser user) =>
                              print('El usuario es ${user.displayName}'));*/
                        }, text: '$inicioSesion Twitter'),
                      ),*/
                      Container(
                        child: FlatButton(
                          child: Text(
                            '$crearCuenta',
                            style: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.black, fontSize: 16.0),
                          ),
                          onPressed: () {
                            setState(() {
                              
                            });
                            /*Navigator.pushReplacementNamed(
                              context, 'createaccount');*/
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
              ]
            )
          );
        } else {
           //return TabsPage();
        String bienvenido = AppTranslations.of(context).text('title_welcome');  
        String aceptar = AppTranslations.of(context).text('title_accept'); 
        return Scaffold(
          body: AlertDialog(
            titlePadding: EdgeInsets.symmetric(horizontal: size.width * 0.24),
            title: Text('$bienvenido',style: TextStyle(fontSize: 19.0,fontFamily: 'Point-SemiBold'),),
            content: Container(
              width: size.width * 0.5,
              height: size.height * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  
                  Container(
                    width: size.width * 0.3,
                    height: size.height * 0.2,
                    child: Image.asset("assets/check.jpg"),
                  ),
                  RaisedButton(
                    textTheme: ButtonTextTheme.primary,
                    color: Colors.green,
                    shape: StadiumBorder(),
                    child: Text('$aceptar',style: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.white),),
                    onPressed: (){
                      Navigator.pop(context);
                      //Navigator.of(context).pushNamedAndRemoveUntil('menuprincipal', ModalRoute.withName('s'));
                      //Navigator.popUntil(context, ModalRoute.withName('menuprincipal'));
                      Navigator.pushReplacementNamed(context, 'menuprincipal');
                    },
                  )
                ],
              ),
            ),
          ),
        );
        
         /* Scaffold.of(context).showSnackBar(
            SnackBar(
            content: Text("Bienvenido"),
            duration: Duration(seconds: 3),
          ));*/
          //TabsPage();
        }
      },
    );
  }
}

/*


Scaffold(
      backgroundColor: Colors.green[600],
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              SafeArea(
                child: Container(
                  height: 90.0,
                ),
              ),
              Container(
                child: Text('Inicio de Sesión',style: TextStyle(fontSize: 20.0,color: Colors.white, fontWeight: FontWeight.bold),),
              ),
              SizedBox(height: 60.0,),
              SignInButton(
                Buttons.Email,
                onPressed: (){
                  Navigator.pushReplacementNamed(context, 'login');
                },
                text: 'Iniciar Sesión con Email',
              ),
              SignInButton(
                Buttons.Google,
                onPressed: (){},
                text: 'Iniciar Sesión con Gmail',
              ),
              SignInButton(
                Buttons.Facebook,
                onPressed: (){
                 logInFacebook();
                  //Navigator.pushNamed(context, 'inicio');
                },
                text: 'Iniciar Sesión con Facebook',
              ),
              SignInButton(
                Buttons.Twitter,
                onPressed:(){},
                text:'Iniciar Sesión con Twitter'
              ),
              Container(
                child: FlatButton(
                  child: Text('Crear Cuenta',style: TextStyle(color: Colors.white,fontSize: 16.0),),
                  onPressed: (){
                    Navigator.pushReplacementNamed(context, 'createaccount');
                  },
                ),
              )
            ],
          )
        ],
      ),
    );


*/
