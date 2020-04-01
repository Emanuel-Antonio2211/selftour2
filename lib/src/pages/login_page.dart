import 'package:flutter/material.dart';
import 'package:selftourapp/src/bloc/login_bloc.dart';
import 'package:selftourapp/src/bloc/provider.dart';
import 'package:selftourapp/src/providers/usuario_provider.dart';
import 'package:selftourapp/src/utils/utils.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //Se importa el provider, creando la instancia
  final usuarioProvider = new UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       /*appBar: AppBar(
         title: Text('Inicio de Sesión'),
       ),*/
       body: Stack(
         children: <Widget>[
           _crearFondo(context),
           _loginForm(context)
         ],
       ),
    );
  }

  Widget _loginForm(BuildContext context){
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView( //permite hacer scroll dependiendo del alto del hijo
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 5.0
                  ),
              ]
            ),
            child: Column(
              children: <Widget>[
                Text('Ingreso',style: TextStyle(fontSize: 20.0),),
                SizedBox(
                  height: 60.0,
                ),
                _crearEmail(bloc),
                SizedBox(height: 30.0,),
                _crearPassword(bloc),
                SizedBox(height: 30.0,),
                _crearBoton(bloc)
              ],
            ),
          ),
          FlatButton(
            color: Colors.blue,
            textTheme: ButtonTextTheme.primary,
            child: Text('Crear una nueva cuenta'),
            onPressed: ()=>Navigator.pushReplacementNamed(context, 'registro'),
          ),
          SizedBox(
            height: 100.0,
          )
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc){
    //Escucha los cambios realizados en el Stream del input
    //Recibe los streams de la clase LoginBloc
    return StreamBuilder(
      stream: bloc.emailStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(
                Icons.email,
                color: Colors.deepPurple
              ),
              hintText: 'ejemplo@correo.com',
              labelText: 'Correo electrónico',
              counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: bloc.changeEmail, //Coloca informacion en el Stream del input

          ),
        );
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc){
    return StreamBuilder(
      stream: bloc.passwordStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock,color: Colors.deepPurple,),
              labelText: 'Contraseña',
              errorText: snapshot.error
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc){
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0,vertical: 15.0),
            child: Text('Ingresar'),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 0.0,
          color: Colors.deepPurple,
          textColor: Colors.white,
          onPressed: snapshot.hasData ? ()=>_login(bloc,context):null,
        );
      },
    );
  }

  _login(LoginBloc bloc, BuildContext context) async{
    //Se llama a la funcion de login
    Map info = await usuarioProvider.login(bloc.mail, bloc.pass);
    /*print('=============');
    print('Email: ${bloc.email}');
    print('Password: ${bloc.password}');
    print('=============');*/

  //Si el ok es correcto, entonces voy a navegar por el home
    if(info['ok']){
      Navigator.pushNamed(context, 'index');
    }else{
      mostrarAlerta(context,info['mensaje'],'Error al iniciar sesión','assets/error.png');
    }
  }

  Widget _crearFondo(BuildContext context){
    final size = MediaQuery.of(context).size;

    final fondoMorado = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0)
          ]
        )
      ),
    );

    return Stack(
      children: <Widget>[
        fondoMorado,
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.person_pin_circle,color: Colors.white,size: 100.0,),
              SizedBox(height: 10.0,width: double.infinity,),
              Text('SelftTour',style: TextStyle(color: Colors.white,fontSize: 25.0),)
            ],
          ),
        )
      ],
    );
  }
  
}