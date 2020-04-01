//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:selftourapp/src/bloc/login_bloc.dart';
import 'package:selftourapp/src/pages/create_account/create_account_page.dart';
import 'package:selftourapp/src/pages/login/login_page.dart';
//import 'package:selfttour/src/pages/login/sesion_page.dart';
import 'package:selftourapp/src/pages/usuario/term_serv_page.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';

class ProfileHead extends StatefulWidget {
  @override
  _ProfileHeadState createState() => _ProfileHeadState();
}

class _ProfileHeadState extends State<ProfileHead> {
  LoginBloc userBloc;
  PreferenciasUsuario prefs = new PreferenciasUsuario();
  String name;
  String email;
  String photoUrl;

  @override
  void initState() {
    super.initState();
    setState(() {
      
    });
    leerDatos();
  }

  void leerDatos(){
    
    name = prefs.name.toString();
    email = prefs.email.toString();
    photoUrl = prefs.photoUrl.toString();
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<LoginBloc>(context);
    //final size = MediaQuery.of(context).size;

    return //_showData(userBloc);
    
    StreamBuilder(
      stream: userBloc.streamFirebase,
      //initialData: initialData ,
      builder: (BuildContext context, AsyncSnapshot snapshot) { //<FirebaseUser>
        switch (snapshot.connectionState) {
          
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          case ConnectionState.none:
            return CircularProgressIndicator();
          case ConnectionState.active:
            return _showData(snapshot);
          case ConnectionState.done:
            return _showData(snapshot);
          default:
            return CircularProgressIndicator();
        }
        /*return Container(
          child: child,
        );*/
       // return _showData(snapshot);
      },
      
    );
  }

  Widget _showData(AsyncSnapshot snapshot) {
    final size = MediaQuery.of(context).size;
    if ( !snapshot.hasData || snapshot.hasError) { //!snapshot.hasData || snapshot.hasError
      //String sesion = AppTranslations.of(context).text('title_login');
      //String idioma = AppTranslations.of(context).text('title_preflang');
      String inicioSesion = AppTranslations.of(context).text('title_login');
      String crearCuenta = AppTranslations.of(context).text('title_createaccount');
      return 

      /*
      Container(
        alignment: Alignment.center,
        //padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SafeArea(
              child: SizedBox(
                height: size.height * 0.2,
              ),
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              color: Color(0xFFD62250),
              textTheme: ButtonTextTheme.primary,
              child: Text('$sesion',style: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.white),),
              onPressed: (){
                Navigator.pushNamed(context, 'sesionpage');
                //Navigator.pushReplacementNamed(context, 'sesionpage');
               /* Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                  return SesionPage();
                },fullscreenDialog: true));*/
              },
            ),
            
            SizedBox(
              height: size.height * 0.2,
            ),
            SizedBox(
              height: size.height * 0.02,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                width: size.width * 1.0,
                child: Divider(
                  color: Colors.grey,
                  )
                ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, 'prefidioma');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Container(
                        color: Colors.deepPurple,
                        width: 30.0,
                        height: 30.0,
                        child: Icon(
                          Icons.language,
                          color: Colors.white
                        )
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    FlatButton(
                      padding: EdgeInsets.zero,
                      //color: Colors.orange,
                      child: Text('$idioma',style: TextStyle(
                        fontFamily: 'Point-SemiBold'
                        ),
                      ),
                      onPressed: (){
                        Navigator.pushNamed(context, 'prefidioma');
                      },
                    ),
                    SizedBox(
                      width: size.width * 0.3,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16.0,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );*/

      Stack(
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
        ]
      );

    } else {
      //print("${snapshot.data.displayName.toString()}");
     // print("${snapshot.data.email.toString()}");
     // print("${snapshot.data.providerData[0].toString()}");
      String nombre = AppTranslations.of(context).text('title_name');
      //String correo = AppTranslations.of(context).text('title_email');
      String infoPers = AppTranslations.of(context).text('title_infoper');
      //String paycollections = AppTranslations.of(context).text('title_paycollections');
      //String notifications = AppTranslations.of(context).text('title_notifications');
      String termserv = AppTranslations.of(context).text('title_termserv');
      String preflang = AppTranslations.of(context).text('title_preflang');
      String logout = AppTranslations.of(context).text('title_logout');
      String confaccount = AppTranslations.of(context).text('title_confaccount');
      return Stack(
            children: <Widget>[
           /* Container(
              width: size.width * 1.0, //420.0
              height: size.height * 0.24, //430.0
              decoration: BoxDecoration(
                  gradient: RadialGradient(
                      radius: 1.01,
                      center: Alignment.bottomRight,
                      colors: [
                    Color(0xFF0865fe),
                    Color(0xFF034485),
                  ])),
              //color: Colors.green,
            ),*/
            Positioned(
              top: size.height * 0.01, //30.0
              left: size.width * 0.04,
              child: Container(
                //color: Colors.indigo,
                height: size.height * 0.15, //160.0
                child: Text(AppTranslations.of(context).text('title_profile'),
                    style: TextStyle(
                        fontFamily: 'Point-SemiBold',
                        fontSize: 20.0,
                        color: Colors.black,
                        )),
                //color: Colors.brown,
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.06, //100.0
                  ),
                  Container(
                    child: Column(
                      //scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(width: size.width * 0.03,),
                            ClipRRect(
                                borderRadius: BorderRadius.circular(40.0),
                                child: CircleAvatar(
                                  radius: 30.0,
                                  child: FadeInImage(
                                    width: size.width * 0.25,
                                    height: size.height * 0.1,
                                    image: prefs.photoUrl.toString() == 'null' ? AssetImage('assets/iconoapp/Selftour1.png') : NetworkImage('${prefs.photoUrl.toString()}'), //snapshot.data.photoUrl == null ? AssetImage('assets/iconoapp/Selftour1.png') : NetworkImage('${snapshot.data.photoUrl.toString()}')
                                    placeholder: AssetImage('assets/loading.gif'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            SizedBox(width: size.width * 0.03,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children:[ 
                                    Text(
                                      '$nombre: ${prefs.name.toString()}',//snapshot.data.displayName == null ? " " : snapshot.data.displayName.toString()
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                      fontFamily: 'Point-SemiBold',
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                      ),
                                    ),
                                   /* IconButton(
                                      icon: Icon(Icons.arrow_forward_ios),
                                      color: Colors.grey,
                                      iconSize: 14.0,
                                      onPressed: (){
                                        Navigator.pushNamed(context, 'infousuario');
                                      },
                                    )*/
                                  ]
                                ),
                               /* Text(
                                  '$correo: ${email.toString()}',//snapshot.data.providerData[1].email.toString()
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                  fontFamily: 'Point-SemiBold',
                                  color: Colors.black,
                                  fontSize: 12.0,
                                  ),
                                )*/
                              ],
                            ),
                          ],
                        ),
                        
                      ],
                    )
                   ),
                 // _verPerfil(context),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: size.width * 0.02),
                    child: Text('$confaccount',style: TextStyle(
                          fontFamily: 'Point-SemiBold',
                          color: Colors.black,
                          fontStyle: FontStyle.italic
                      )
                    ),
                  ),
                  SizedBox(height: size.height * 0.02,),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, 'editarinfo');
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(5.0),
                                        child: Container(
                                          width: 30.0,
                                          height: 30.0,
                                          color: Colors.lightBlue,
                                          child: Icon(
                                            Icons.person_outline,
                                            color: Colors.white,
                                          )
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.02,
                                      ),
                                      FlatButton(
                                        padding: EdgeInsets.zero,
                                        child: Text('$infoPers',style: TextStyle(
                                            fontFamily: 'Point-SemiBold'
                                          ),
                                        ),
                                        onPressed: (){
                                          Navigator.pushNamed(context, 'editarinfo');
                                        },
                                      ),
                                    ],
                                  ),
                                  
                                  SizedBox(
                                    width: size.width * 0.3,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16.0,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                            width: size.width * 0.6,
                            child: Divider(
                              color: Colors.grey,
                              )
                            ),
                        ),
                        /*Padding(
                          padding: EdgeInsets.only(left: size.width * 0.02,right: size.width * 0.02 ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              FlatButton(
                                padding: EdgeInsets.zero,
                                //color: Colors.orange,
                                child: Text('$paycollections',style: TextStyle(
                                  fontFamily: 'Point-SemiBold'
                                  ),
                                ),
                                onPressed: (){
                                  
                                },
                              ),
                              Icon(Icons.attach_money,color: Color(0xFF0865fe)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                            width: size.width * 0.6,
                            child: Divider(
                              color: Colors.grey,
                              )
                            ),
                        ),*/
                        /*Padding(
                          padding: EdgeInsets.only(left: size.width * 0.02,right: size.width * 0.02 ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              FlatButton(
                                padding: EdgeInsets.zero,
                                //color: Colors.orange,
                                child: Text('$notifications',style: TextStyle(
                                  fontFamily: 'Neue Haas Grotesk Display Pro'
                                  ),
                                ),
                                onPressed: (){
                                  
                                },
                              ),
                              Icon(Icons.notifications,color: Color(0xFF0865fe)),
                            ],
                          ),
                        ),*/
                      /*  SizedBox(
                          height: size.height * 0.03,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                            width: size.width * 0.6,
                            child: Divider(
                              color: Colors.grey,
                              )
                            ),
                        ),*/
                        Padding(
                          padding: EdgeInsets.only(left: size.width * 0.02,right: size.width * 0.02 ),
                          child: GestureDetector(
                            onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context){
                                    return TermServPage();
                                  }
                                ));
                              },
                              child: Container(
                                color: Colors.transparent,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(5.0),
                                        child: Container(
                                          width: 30.0,
                                          height: 30.0,
                                          color: Colors.black,
                                          child: Icon(
                                            Icons.library_books,
                                            color: Colors.white)
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.03,
                                      ),
                                      FlatButton(
                                        padding: EdgeInsets.zero,
                                        //color: Colors.orange,
                                        child: Text('$termserv',style: TextStyle(
                                          fontFamily: 'Point-SemiBold'
                                          ),
                                        ),
                                        onPressed: (){
                                          Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context){
                                              return TermServPage();
                                            }
                                          ));
                                        },
                                      ),
                                    ],
                                  ),
                                  
                                  SizedBox(
                                    width: size.width * 0.3,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16.0,
                                    color: Colors.grey,
                                  )
                                ],
                            ),
                              ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                            width: size.width * 0.6,
                            child: Divider(
                              color: Colors.grey,
                              )
                            ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                          child: GestureDetector(
                              onTap: (){
                                Navigator.pushNamed(context, 'prefidioma');
                              },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(5.0),
                                          child: Container(
                                            width: 30.0,
                                            height: 30.0,
                                            color: Colors.deepPurple,
                                            child: Icon(
                                              Icons.language,
                                              color: Colors.white
                                            )
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.02,
                                        ),
                                        FlatButton(
                                          padding: EdgeInsets.zero,
                                          child: Text('$preflang',style: TextStyle(
                                              fontFamily: 'Point-SemiBold'
                                            ),
                                          ),
                                          onPressed: (){
                                            Navigator.pushNamed(context, 'prefidioma');
                                          },
                                        ),
                                      ],
                                    ),
                                    
                                    SizedBox(
                                    width: size.width * 0.25,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16.0,
                                      color: Colors.grey,
                                    )
                                  ],
                              ),
                                ),
                            ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                            width: size.width * 0.6,
                            child: Divider(
                              color: Colors.grey,
                              )
                            ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                          child: GestureDetector(
                            onTap: (){
                              userBloc.signOut();
                              Navigator.pushReplacementNamed(context, 'menuprincipal');
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(5.0),
                                        child: Container(
                                          width: 30.0,
                                          height: 30.0,
                                          color: Colors.red,
                                          child: Icon(
                                            Icons.exit_to_app,
                                            color: Colors.white
                                          )
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.02,
                                      ),
                                      FlatButton(
                                        padding: EdgeInsets.zero,
                                        //color: Colors.orange,
                                        child: Text('$logout',style: TextStyle(
                                          fontFamily: 'Point-SemiBold'
                                          ),
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            
                                          });
                                          userBloc.signOut();
                                          Navigator.pushReplacementNamed(context, 'menuprincipal');
                                        },
                                      ),
                                    ],
                                  ),
                                  
                                  SizedBox(
                                  width: size.width * 0.43,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16.0,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  /*Container(
                padding: EdgeInsets.all(20.0),
                alignment: Alignment.topLeft,
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      maxRadius: 50.0,
                      backgroundImage: NetworkImage(
                          'https://img-cdn.hipertextual.com/files/2019/04/hipertextual-avengers-endgame-contiene-ultimo-cameo-stan-lee-2019632812.jpg?strip=all&lossy=1&quality=65&resize=740%2C490&ssl=1'),
                    ),
                    SizedBox(
                      width: size.width * 0.04, //30.0
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Nombre completo: ',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Correo: ',
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white24),
                        )
                      ],
                    ),
                  ],
                ),
              ),*/

                  /*SizedBox(
                height: size.height * 0.02,
              ),*/
                  /*Expanded(
                child: ListView(
                  shrinkWrap: true,
                  //itemBuilder: (context,index){
                  //Column(
                  children: <Widget>[
                    _card(),
                   // SizedBox(height: size.height * 0.08,),
                    _card2(),
                   // SizedBox(height: size.height * 0.08,),
                    _card3(),
                   // SizedBox(height: size.height * 0.08,),
                    _card4(),
                   // SizedBox(height: size.height * 0.08,),
                    _card5(),
                   // SizedBox(height: size.height * 0.08,),
                    _card6(),
                   // SizedBox(height: size.height * 0.08,),
                    _card7(),
                   // SizedBox(height: size.height * 0.08,),
                    _card8(),
                    //SizedBox(height: size.height * 0.08,),
                  ],
                  //),
                  //},
                ),
              )*/
                ],
              ),
            ),
            
          ]
          );
      /*Container(
        child: Column(
          //scrollDirection: Axis.horizontal,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(40.0),
                    child: CircleAvatar(
                      radius: 30.0,
                      child: FadeInImage(
                        width: size.width * 0.25,
                        height: size.height * 0.1,
                        image: NetworkImage('${snapshot.data.photoUrl.toString()}'),
                        placeholder: AssetImage('assets/jar-loading.gif'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Nombre: ${snapshot.data.displayName}',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      'Correo: ${snapshot.data.email.toString()}',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                      color: Colors.white24,
                      fontSize: 14.0,
                      ),
                    )
                  ],
                ),
              ],
            ),
            
          ],
        )
      );*/
      /*Container(
        width: double.infinity,
        height: size.height * 0.2,
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.topLeft,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10.0),
              /*decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: NetworkImage('${snapshot.data.photoUrl.toString()}'),fit: BoxFit.cover)
              ),*/
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                child: CircleAvatar(
                  radius: 30.0,
                  child: FadeInImage(
                    image: NetworkImage('${snapshot.data.photoUrl.toString()}'),
                    placeholder: AssetImage('assets/jar-loading.gif'),
                    fit: BoxFit.fill
                    ),
                ),
              ),
              ),
            SizedBox(
              width: size.width * 0.02, //30.0
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Nombre completo: ${snapshot.data.displayName.toString()}',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Correo: ${snapshot.data.email.toString()}',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white24,
                    fontSize: 14.0,
                    ),
                )
              ],
            ),
          ],
        ),
      );*/
    }
    
  }
  /*Widget _verPerfil(BuildContext context){
    String seeprofile = AppTranslations.of(context).text('title_seeprofile');
    return FlatButton(
      child: Text('$seeprofile',style: TextStyle(
            fontFamily: 'Point-SemiBold',
            color: Colors.black),),
      onPressed: (){
        Navigator.pushNamed(context, 'infousuario');
      },
    );
  }*/
}
