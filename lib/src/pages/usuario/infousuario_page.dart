import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class InfoUsuarioPage extends StatefulWidget {
  @override
  _InfoUsuarioPageState createState() => _InfoUsuarioPageState();
}

class _InfoUsuarioPageState extends State<InfoUsuarioPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Perfil',
                    style: TextStyle(
                      fontFamily: 'Point',
                      fontWeight: FontWeight.bold
                    ),
                  ),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: size.height * 0.04),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60.0),
                child: FadeInImage(
                  width: size.width * 0.3,
                  image: NetworkImage('https://www.psicoactiva.com/blog/wp-content/uploads/2017/07/mujer-feliz-gorro-tatuaje.jpg'),
                  fit: BoxFit.fill,
                  placeholder: AssetImage('assets/jar-loading.gif'),
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.03,),
          Text('Hola, Soy (Nombre del usuario)',style: TextStyle(
                fontFamily: 'Source Sans Pro',
                fontStyle: FontStyle.italic
            ),
          ),
          Tooltip(
            message: 'Editar Información',
            verticalOffset: 48,
            child: IconButton(
              icon: Icon(Icons.edit),
              color: Color(0xFF0865fe),
              onPressed: (){
                _editarInformacion(context);
              },
            ),
          )
        ],
      ),
    );
  }

  void _editarInformacion(BuildContext context) {
    var size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (context){
        return SimpleDialog(
        title: Text('Editar tu Foto'),
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.grey[200],
                  alignment: Alignment.bottomRight,
                  width: double.infinity,
                  height: size.height * 0.2,
                  child: Icon(Icons.camera_alt),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      child: Text('Guardar'),
                      onPressed: (){

                      },
                    ),
                    FlatButton(
                      child: Text('Cancelar'),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    )
                  ],
                )
              ],
            ),
          ),

        ],
      );
      }
      
    );
  }
  
}