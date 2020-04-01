import 'package:flutter/material.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:selftourapp/src/providers/pagos_provider.dart';

class PagadoPage extends StatefulWidget {
  @override
  _PagadoPageState createState() => _PagadoPageState();
}

class _PagadoPageState extends State<PagadoPage> {
  PreferenciasUsuario prefs = PreferenciasUsuario();
  PagosProvider pagosProvider = PagosProvider();
  @override
  void initState() {
    super.initState();
    pagosProvider.capturarOrden(prefs.idCompra.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            Image.asset('assets/check.jpg'),
            Text('Su pago se capturó con éxito',style: TextStyle(fontSize: 30.0,fontFamily: 'Point-SemiBold'),)
          ],
        ),
      )
    );
  }
}