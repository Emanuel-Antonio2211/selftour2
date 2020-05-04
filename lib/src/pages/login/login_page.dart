import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:selftourapp/src/bloc/login_bloc.dart';

//import 'package:selfttour/src/bloc/provider.dart';
import 'package:selftourapp/src/providers/usuario_provider.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';
import 'package:selftourapp/src/utils/utils.dart';
import 'package:selftourapp/src/widgets/tree_size_dot_widget.dart';


class Login extends StatefulWidget {
  
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //Se importa el provider, creando la instancia
  final usuarioProvider = new UsuarioProvider();
  
  @override
  Widget build(BuildContext context) {
    LoginBloc bloc = BlocProvider.of<LoginBloc>(context);
    final size = MediaQuery.of(context).size;
    //String login = AppTranslations.of(context).text('title_login');
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SafeArea(
            child: Container(
              height: size.height * 0.07,
              ),
            ),
            Image.asset(
              'assets/iconoapp/Selftour1.png',
              width: 120.0,
            ),
            SizedBox(height: size.height * 0.04),
            _email(bloc),
            SizedBox(height: size.height * 0.02,),
            _password(bloc),
            SizedBox(height: size.height * 0.04),
            Container(
              child: _botonIngresar(bloc),
            ),
            SizedBox(height: size.height * 0.01,),
            Row(
              children: <Widget>[
                SizedBox(width: size.width * 0.02,),
                Container(
                  child: _crearCuenta(context),
                ),
               
                Container(
                  child: _recordarPassword(context),
                )
              ],
            ),
           /* Row(
              children: <Widget>[
                SizedBox(width: size.width * 0.65,),
                Container(
                  height: size.height * 0.05,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white,width: 1.0,style: BorderStyle.solid)
                  ),
                  child: _omitir(context)
                )
              ],
            ),*/
            SizedBox(height: size.height * 0.02,),
           /* Container(
              child: Text('ó', style: TextStyle(color: Colors.white,fontSize: 20.0),),
            ),*/
            SizedBox(height: size.height * 0.01,),
          /*  Container(
              child: Text('$login:',style:TextStyle(color: Colors.white,fontSize:20.0)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SignInButton(
                  Buttons.Google,
                  onPressed: (){
                    bloc.signInGoogle();
                    Navigator.pop(context);
                  },
                  mini: true,
                ),
                SignInButton(
                  Buttons.Facebook,
                  onPressed: (){
                    bloc.signInFacebook();
                    Navigator.pop(context);
                  },
                  mini: true,
                ),
                SignInButton(
                  Buttons.Twitter,
                  onPressed: (){
                    bloc.signInTwitter();
                    Navigator.pop(context);
                  },
                  mini: true,
                )
              ],
            )*/
          ],
        ),
      ),
    );
  }

Widget _email(LoginBloc bloc){
    final size = MediaQuery.of(context).size;
    String email = AppTranslations.of(context).text('title_email');
 return StreamBuilder(
    stream: bloc.emailStream,
    builder: (BuildContext context, AsyncSnapshot snapshot){
      //String errorEmail = AppTranslations.of(context).text('title_erroremail');

      return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50.0),
            alignment: Alignment.centerLeft,
            child: Text('$email*',style: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.grey,fontSize: 16.0),),
          ),
          Container(
           /* decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.black12
            ),*/
            height: size.height * 0.1,
           // width: size.width * 0.8,
            //margin: EdgeInsets.only(right: 30.0,left: 30.0),
            padding: EdgeInsets.only(right: 20.0,left: 20.0),
            child: TextField(
              style: TextStyle(color: Colors.black),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.black,),
                //border: InputBorder.none,
                icon: Icon(Icons.mail_outline,color: Colors.grey,),
                //labelText: 'Email',
                hintStyle: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.black),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 0.0)
                )
                //hintText: 'ejemplo@correo.com',
                //counterText: snapshot.data,
               // errorText: snapshot.error
                ),
                  onChanged: bloc.changeEmail, //Coloca informacion en el Stream del input
              ),
            ),
        ],
      );
    },
  );
}

Widget _password(LoginBloc bloc){
    final size = MediaQuery.of(context).size;
    String password = AppTranslations.of(context).text('title_password');
    String errorPass = AppTranslations.of(context).text('title_errorpass');
  return StreamBuilder(
    stream:  bloc.passwordStream,
    builder: (BuildContext context, AsyncSnapshot snapshot){
      return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50.0),
            alignment: Alignment.centerLeft,
            child: Text('$password *',style: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.grey,fontSize: 16.0),),
          ),
          Container(
             /* decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60.0),
                color: Colors.black12
              ),*/
              height: size.height * 0.1,
             // width: size.width * 0.8,
              //margin: EdgeInsets.only(right: 30.0,left: 30.0),
              padding: EdgeInsets.only(right: 20.0,left: 20.0),
              child: TextField(
                obscureText: true,
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),
                 // border: InputBorder.none,
                  icon: Icon(Icons.lock_outline,color: Colors.grey,),
                 // labelText: 'Password',
                  errorText: snapshot.error , //snapshot.error,
                  hintStyle: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.black),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 0.0)
                  )
                  //hintText: 'Password'
                ),
                onChanged: bloc.changePassword,
              ),
            ),
            Container(
            padding: EdgeInsets.symmetric(horizontal: 50.0),
            alignment: Alignment.centerLeft,
            child: Text('$errorPass',style: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.black,fontSize: 10.0),),
          ),
        ],
      );
      
      /*Card(
        color: Colors.black12,
        shape: StadiumBorder(),
        child: 
      );*/
    },
  );
}

Widget _botonIngresar(LoginBloc bloc){
    final size = MediaQuery.of(context).size;
    String iniciar = AppTranslations.of(context).text('title_login');
  return StreamBuilder(
    stream: bloc.formValidStream,
    builder: (BuildContext context, AsyncSnapshot snapshot){
      return ProgressButton(
        defaultWidget: Text(
          '$iniciar',
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
        onPressed: snapshot.hasData ? ()async{
          await Future.delayed(Duration(seconds: 2),()async{
            await _login(bloc, context);
          });
          
        }:null,
      );
      
      /*RaisedButton(
        child: Container(
          width: size.width * 0.7,
          height: size.height * 0.07,
          padding: EdgeInsets.all(10.0),
          child: Text('$iniciar',textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0),),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        color: Color(0xFFD62250),
        onPressed: snapshot.hasData ? ()=>_login(bloc, context) : null
      );*/
    },
  );
}

_login(LoginBloc bloc,BuildContext context) async {
 Map info = await usuarioProvider.loginIn(bloc.mail, bloc.pass);
 
 String errorLog = AppTranslations.of(context).text('title_errorlog');
//await bloc.signInEmail(bloc.mail,bloc.pass, context);

 if(info['success']){
   //Navigator.pushReplacementNamed(context, 'menuprincipal');
    await bloc.signInEmail(bloc.mail, bloc.pass, context).then((result){});
   //Navigator.pop(context);
 }else{
   mostrarAlerta(context,info['mensaje'],'$errorLog','assets/error.png');
 }
  
}

}

Widget _crearCuenta(BuildContext context){
  String crearCuenta = AppTranslations.of(context).text('title_createaccount');
  return FlatButton(
    child: Text('$crearCuenta',style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 12.0,color: Colors.black),),
    onPressed: (){
      Navigator.pushNamed(context, 'createaccount');
    },
  );
}

Widget _recordarPassword(BuildContext context){
  String forgetPass = AppTranslations.of(context).text('title_forgetpass');
  return FlatButton(
    child: Text('$forgetPass',style: TextStyle(fontFamily: 'Point-SemiBold',fontSize: 12.0,color: Color(0xFFD62250)),),
    onPressed: (){
      Navigator.pushNamed(context, 'forgetpassword');
    },
  );
}

/*Widget _omitir(BuildContext context){
  final size = MediaQuery.of(context).size;
  return RaisedButton(
    color: Colors.black12,
    child: Container(
      height: size.height * 0.025,
      child: Text('Omitir',style: TextStyle(color: Colors.white),),
    ),
    onPressed: (){
      Navigator.pushReplacementNamed(context, 'menuprincipal');
    },
  );
}*/