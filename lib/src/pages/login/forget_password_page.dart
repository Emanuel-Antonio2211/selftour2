import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:selftourapp/src/bloc/provider.dart';
import 'package:selftourapp/src/providers/usuario_provider.dart';

class ForgetPasswordPage extends StatefulWidget {
  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final usuarioProvider = new UsuarioProvider();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: size.height * 0.09,),
            Container(
              alignment: Alignment.center,
              child: Text('Olvidaste tu contraseña?',style: TextStyle(color: Colors.black,fontSize: 26.0),),
            ),
            SizedBox(height: size.height * 0.1,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: Center(
                child: Text('Por favor ingrese su correo. Recibirá un enlace para crear su nueva contraseña via email'),
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Container(
              child: _email(bloc),
              //color: Colors.black12,
            ),
            SizedBox(height: size.height * 0.04,),
            _botonEnviar(),
            SizedBox(height: size.height * 0.3,),
            Container(
              child: _backLogin(),
            )
          ],
        ),
      ),
    );
  }

  Widget _email(LoginBloc bloc){
    final size = MediaQuery.of(context).size;
 return StreamBuilder(
    stream: bloc.emailStream,
    builder: (BuildContext context, AsyncSnapshot snapshot){
      return Container(
        height: size.height * 0.10,
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
        child: TextField(
          style: TextStyle(color: Colors.black),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.black,),
            icon: Icon(Icons.mail_outline,color: Colors.grey,),
            labelText: 'Email',
            hintStyle: TextStyle(color: Colors.grey),
            //hintText: 'Correo',
            counterText: snapshot.data,
            errorText: snapshot.error
    ),
     onChanged: bloc.changeEmail, //Coloca informacion en el Stream del input
  ),
      );
    },
  );
}

  Widget _botonEnviar(){
    final size = MediaQuery.of(context).size;
  return RaisedButton(
    child: Container(
      width: size.width * 0.7,
      padding: EdgeInsets.all(20.0),
      child: Text('SEND EMAIL',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15.0),),
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    color: Color(0xFFD62250),
    onPressed: (){},
  );
}
Widget _backLogin(){
  return FlatButton(
    child: Text('BACK TO LOGIN',style: TextStyle(color: Colors.white,fontSize: 18.0),),
    onPressed: (){
      Navigator.pushReplacementNamed(context, 'login');
    },
  );
}
}