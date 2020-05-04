import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:selftourapp/src/bloc/login_bloc.dart';
import 'package:selftourapp/src/bloc/provider.dart';
import 'package:selftourapp/src/pages/usuario/term_serv_page.dart';
import 'package:selftourapp/src/providers/usuario_provider.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';
import 'package:selftourapp/src/utils/utils.dart';
import 'package:selftourapp/src/widgets/tree_size_dot_widget.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final usuarioProvider = UsuarioProvider();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String crearCuenta = AppTranslations.of(context).text('title_createaccount');
    //final registerBloc = BlocProvider.of<RegisterBloc>(context);
    
    final bloc = BlocProvider.of<LoginBloc>(context);
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
      backgroundColor: Colors.white,//Colors.green[600],
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: size.height * 0.09,),
            Container(
              alignment: Alignment.center,
              child: Text('${crearCuenta.toUpperCase()}',style: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.black,fontSize: 20.0),),
            ),
            SizedBox(height: size.height * 0.06,),
            _userName(bloc),
            SizedBox(height: size.height * 0.02,),
            _email(bloc),
            SizedBox(height: size.height * 0.02,),
            _password(bloc),
            SizedBox(height: size.height * 0.02,),
            _passwordConfirm(bloc),
            SizedBox(height: size.height * 0.02,),
            _telefono(bloc),
            SizedBox(height: size.height * 0.03),
            _botonContinuar(bloc),
            Row(
              children: <Widget>[
                SizedBox(width: size.width * 0.07),
                _termsconditions(),
                SizedBox(width: size.width * 0.12,),
                _signIn()
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _userName(LoginBloc bloc){
    final size = MediaQuery.of(context).size;
    String nombreUsuario = AppTranslations.of(context).text('title_name');
    return StreamBuilder(
      stream: bloc.nameStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50.0),
              alignment: Alignment.centerLeft,
              child: Text('$nombreUsuario *',style: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.grey,fontSize: 16.0),)),
            Container(
             /* decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.black12
              ),*/
              height: size.height * 0.1,
              //width: size.width * 0.9, //70.0
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: TextField(
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelStyle: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.black),
                  //border: InputBorder.none,
                  icon: Icon(Icons.person_outline,color: Colors.grey,),
                  //labelText: 'Username',
                  hintStyle: TextStyle(color: Colors.grey),
                  //counterText: snapshot.data,
                  errorText: snapshot.error,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 0.0)
                  )
                ),
                  onChanged: bloc.changeName, //Coloca informacion en el Stream del input
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _email(LoginBloc bloc){
    final size = MediaQuery.of(context).size;
    String correo = AppTranslations.of(context).text('title_email');
  return StreamBuilder(
    stream: bloc.emailStream,
    builder: (BuildContext context, AsyncSnapshot snapshot){
      return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50.0),
            alignment: Alignment.centerLeft,
            child: Text('$correo *',style: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.grey,fontSize: 16.0),),
          ),
          Container(
           /* decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.black12
            ),*/
            height: size.height * 0.1,
            //margin: EdgeInsets.only(right: 30.0,left: 30.0),
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            child: TextField(
              style: TextStyle(color: Colors.black),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelStyle: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.black,),
                //border: InputBorder.none,
                icon: Icon(Icons.mail_outline,color: Colors.grey,),
                //labelText: 'Email',
                //hintStyle: TextStyle(color: Colors.white),
                //hintText: 'ejemplo@correo.com',
                //counterText: snapshot.data,
                errorText: snapshot.error,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 0.0)
                )
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
            /*decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60.0),
              color: Colors.black12
            ),*/
            height: size.height * 0.1,
            //margin: EdgeInsets.only(right: 30.0,left: 30.0),
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            child: TextField(
              obscureText: true,
              style: TextStyle(color: Colors.black),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.black),
                //border: InputBorder.none,
                icon: Icon(Icons.lock_outline,color: Colors.grey,),
                //labelText: 'Password',
                errorText: snapshot.error,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 0.0)
                )
                //hintStyle: TextStyle(color: Colors.white),
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
    },
  );
}
Widget _passwordConfirm(LoginBloc bloc){
  final size = MediaQuery.of(context).size;
  String confPass = AppTranslations.of(context).text('title_confpass');
  String errorvalidar = AppTranslations.of(context).text('title_errorvalidarpass');
  return StreamBuilder(
    stream:  bloc.passConfirm,
    builder: (BuildContext context, AsyncSnapshot snapshot){
      return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50.0),
            alignment: Alignment.centerLeft,
            child: Text('$confPass *',style: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.grey,fontSize: 16.0),),
          ),
          Container(
           /* decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60.0),
              color: Colors.black12
            ),*/
            height: size.height * 0.1,
            //margin: EdgeInsets.only(right: 30.0,left: 30.0),
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            child: TextField(
              obscureText: true,
              style: TextStyle(color: Colors.black),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelStyle: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.black),
                //border: InputBorder.none,
                icon: Icon(Icons.lock_outline,color: Colors.grey,),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 0.0)
                ),
                //labelText: 'Confirmar Password',
                errorText: bloc.passConf != bloc.pass ? '$errorvalidar' : ' ',
                //hintStyle: TextStyle(color: Colors.white),
                //hintText: 'Password'
              ),
              onChanged: bloc.changePassConfirm,
            ),
          ),
        ],
      );
    },
  );
}

Widget _telefono(LoginBloc bloc){
  final size = MediaQuery.of(context).size;
  String telefono = AppTranslations.of(context).text('title_phone');
  return StreamBuilder(
    stream:  bloc.phoneStream,
    builder: (BuildContext context, AsyncSnapshot snapshot){
      return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50.0),
            alignment: Alignment.centerLeft,
            child: Text('$telefono *',style: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.grey,fontSize: 16.0),),
          ),
          Container(
           /* decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60.0),
              color: Colors.black12
            ),*/
            height: size.height * 0.1,
            //margin: EdgeInsets.only(right: 30.0,left: 30.0),
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            child: TextField(
              style: TextStyle(color: Colors.black),
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelStyle: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.black),
                //border: InputBorder.none,
                icon: Icon(Icons.phone,color: Colors.grey,),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 0.0)
                )
                //labelText: 'Teléfono',
                //errorText: snapshot.error,
                //hintStyle: TextStyle(color: Colors.white),
                //hintText: 'Password'
              ),
              onChanged: bloc.changePhone,
            ),
          ),
        ],
      );
    },
  );
}

Widget _botonContinuar(LoginBloc bloc){
  final size = MediaQuery.of(context).size;
  String enviar = AppTranslations.of(context).text('title_send');
  return StreamBuilder(
    stream: bloc.formValidStreamReg,
    builder: (BuildContext context, AsyncSnapshot snapshot){
      return ProgressButton(
        defaultWidget: Text(
          '$enviar',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Point-SemiBold',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15.0
          ),
        ),
        animate: false,
        progressWidget: ThreeSizeDot(),
        width: size.width * 0.7,
        borderRadius: 5.0,
        color: Color(0xFFD62250),
        onPressed: snapshot.hasData ? ()async{
         await Future.delayed(Duration(seconds: 2),()async{
           await _registrar(context, bloc);
          });
        }:null,
      );
      
      
      /*RaisedButton(
        child: Container(
          width: size.width * 0.7,
          padding: EdgeInsets.all(20.0),
          child: Text('$enviar',textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15.0),),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        color: Color(0xFFD62250),
        onPressed: snapshot.hasData ? ()=>_registrar(context,bloc):null
            
      );*/
    },
  );
}

_registrar(BuildContext context,LoginBloc bloc)async{
  String error = AppTranslations.of(context).text('title_errorreg');
 Map info = await usuarioProvider.usuarioNuevo(bloc.name, bloc.mail, bloc.pass, bloc.phone);
  
  if(info['ok']){
    //Navigator.pop(context);
    await bloc.createUser(context,bloc.mail, bloc.pass);
    
  }else{
    mostrarAlerta(context, info['mensaje'],'$error', 'assets/error.png');
  }
  //Navigator.pushReplacementNamed(context, 'slidepage');
  //Navigator.popAndPushNamed(context, 'slidepage');
}

Widget _termsconditions(){
  String termServ = AppTranslations.of(context).text('title_termserv');
  return FlatButton(
    child: Text('$termServ',style: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.black,fontWeight: FontWeight.bold,fontSize: 13.0),),
    onPressed: (){
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context){
            return TermServPage();
          }
        )
      );
    },
  );
}

Widget _signIn(){
  String sesion = AppTranslations.of(context).text('title_login');
  return FlatButton(
    child: Text('$sesion',style: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.black,fontWeight: FontWeight.bold,fontSize: 13.0),),
    onPressed: (){
      //Navigator.pushReplacementNamed(context, 'sesionpage');
      /*Navigator.of(context).push(MaterialPageRoute(
        builder: (context){
          return SesionPage();
        },
        fullscreenDialog: true,
      ));*/
      Navigator.pop(context);
    },
  );
}
}