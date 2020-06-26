import 'package:flutter/material.dart';
import 'package:selftourapp/src/models/tour_categoria_model.dart';
import 'package:selftourapp/src/providers/categorias_providers.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';
import 'package:selftourapp/src/utils/utils.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:selftourapp/src/widgets/tree_size_dot_widget.dart';

class FormComentarioPage extends StatefulWidget {
  @override
  _FormComentarioPageState createState() => _FormComentarioPageState();
}

class _FormComentarioPageState extends State<FormComentarioPage> {
  CategoriasProvider categoriasProvider = CategoriasProvider();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controller = new TextEditingController();

  String comentario = '';
  bool marcado1 = false;
  bool marcado2 = false;
  bool marcado3 = false;
  bool marcado4 = false;
  bool marcado5 = false;
  int contador = 0;
  @override
  Widget build(BuildContext context) {
    InfoTour detalleTour = ModalRoute.of(context).settings.arguments;
    String instruccion = AppTranslations.of(context).text('title_instruccion');
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              SafeArea(
                child: SizedBox(
                  height: size.height * 0.04,
                ),
              ),
              Text('$instruccion',style: TextStyle(fontFamily: 'Point-SemiBold'),),
              SizedBox(
                height: size.height * 0.04,
              ),
              valoracion(),
              SizedBox(
                height: size.height * 0.04,
              ),
              comentarios(context),
              SizedBox(
                height: size.height * 0.04,
              ),
              enviarComentario(detalleTour)
            ],
          ),
        ),
      ),
    );
  }

  Widget valoracion(){
    String valoracion = AppTranslations.of(context).text('title_valorar');
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: Row(
        children: <Widget>[
         Text('$valoracion: ',style: TextStyle(fontFamily: 'Point-SemiBold'),),
         GestureDetector(
           onTap: (){
             marcar();
           },
           child: Icon( 
             marcado1 ? Icons.star : Icons.star_border,
             color: marcado1 ? Color(0xFF034485) : null,
            )
          ),
         GestureDetector(
           onTap: (){
             marcar2();
           },
           child: Icon( 
             marcado2 ? Icons.star : Icons.star_border,
             color: marcado2 ? Color(0xFF034485) : null,
            )
          ),
         GestureDetector(
           onTap: (){
             marcar3();
           },
           child: Icon( 
             marcado3 ? Icons.star : Icons.star_border,
             color: marcado3 ? Color(0xFF034485) : null,
            )
          ),
         GestureDetector(
           onTap: (){
             marcar4();
           },
           child: Icon( 
             marcado4 ? Icons.star : Icons.star_border,
             color: marcado4 ? Color(0xFF034485) : null,
            )
          ),
         GestureDetector(
           onTap: (){
             marcar5();
           },
           child: Icon( 
             marcado5 ? Icons.star : Icons.star_border,
             color: marcado5 ? Color(0xFF034485) : null,
            )
          ),
          Text(contador.toString())
        ],
      ),
    );
  }

  Widget comentarios(BuildContext context){
    final size = MediaQuery.of(context).size;
    String comentarioEtiqueta = AppTranslations.of(context).text('title_comentario');
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: <Widget>[
          Text('$comentarioEtiqueta: ',style: TextStyle(fontFamily: 'Point-SemiBold'),),
          Container(
            width: size.width * 0.8,
            child: TextFormField(
              //textCapitalization: TextCapitalization.characters,
              controller: controller,
              // toolbarOptions: ToolbarOptions(
              //   copy: true,
              //   paste: true,
              //   cut: true,
              //   selectAll: true
              // ),
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              onSaved: (value){
                comentario = value;
              },
              style: TextStyle(fontFamily: 'Point-SemiBold'),
            ),
          ),
        ],
      ),
    );
  }

  Widget enviarComentario(InfoTour detalle){
    final size = MediaQuery.of(context).size;
    String enviar = AppTranslations.of(context).text('title_send');
    String comentariosuccess = AppTranslations.of(context).text('title_comentariosuccess');
    String comentarioerror = AppTranslations.of(context).text('title_comentarioerror');
    return ProgressButton(
      defaultWidget: Text(
        '$enviar',
        style: TextStyle(
          fontFamily: 'Point-SemiBold',
          color: Colors.white
        )
      ),
      width: size.width * 0.6,
      height: size.height * 0.07,
      borderRadius: 5.0,
      progressWidget: ThreeSizeDot(),
      color: Color(0xFFD62250),
      type: ProgressButtonType.Raised,
      animate: false,
      onPressed: ()async{
        formKey.currentState.save();
        setState(() {
          
        });
        print("Valoración: ");
        print(contador);
        print("Comentario: ");
        print(comentario);
        await categoriasProvider.comentar(detalle.idtour.toString(), comentario,contador).then((result){
          if(result['msg'] == 'COMMENT ADDED SUCCESFULY'){
            
            //mostrarAlerta(context, 'Comentario agregado, gracias por su colaboración', '', 'assets/check.jpg');
            mostrarConfirmacion(context,'$comentariosuccess', '', 'assets/check.jpg');
          }else{
            mostrarAlerta(context, '$comentarioerror', '', 'assets/error.png');
          }
        }).catchError((error){
          mostrarAlerta(context, error.toString(), '', 'assets/error.png');
        });
      },
    );
    
    /*RaisedButton(
      child: Text('$enviar',style: TextStyle(fontFamily: 'Point-SemiBold',color: Colors.white),),
      color: Color(0xFFD62250),
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      onPressed: ()async{
        formKey.currentState.save();
        setState(() {
          
        });
        await categoriasProvider.comentar(detalle.idtour.toString(), comentario).then((result){
          if(result['msg'] == 'COMMENT ADDED SUCCESFULY'){
            
            //mostrarAlerta(context, 'Comentario agregado, gracias por su colaboración', '', 'assets/check.jpg');
            mostrarConfirmacion(context,'$comentariosuccess', '', 'assets/check.jpg');
          }else{
            mostrarAlerta(context, '$comentarioerror', '', 'assets/error.png');
          }
        }).catchError((error){
          mostrarAlerta(context, error.toString(), '', 'assets/error.png');
        });
      },
    );*/
  }

  void marcar(){
    setState(() {
      if(marcado1){
        contador = 1;
       // marcado1 = false;
        marcado2 = false;
        marcado3 = false;
        marcado4 = false;
        marcado5 = false;
      }else{
        contador += 1;
        marcado1 = true;
      }
    });
  }
  void marcar2(){
    setState(() {
      if(marcado2){
        contador = 2;
        //marcado1 = false;
        //marcado2 = false;
        marcado3 = false;
        marcado4 = false;
        marcado5 = false;
        
      }else if(!marcado1){
        contador = 2;
        marcado1 = true;
        marcado2 = true;
      }else if(!marcado2){
        contador = 2;
        marcado2 = true;
      }
    });
  }
  void marcar3(){
    setState(() {
      if(!marcado3){
        contador = 3;
        marcado1 = true;
        marcado2 = true;
        marcado3 = true;
      }else if(marcado3){
        contador = 3;
        marcado1 = true;
        marcado2 = true;
        marcado3 = true;
        marcado4 = false;
        marcado5 = false;
      }
    });
  }
  void marcar4(){
    setState(() {
      if(marcado4){
        contador = 4;
        marcado1 = true;
        marcado2 = true;
        marcado3 = true;
        marcado4 = true;
        marcado5 = false;
      }else if(!marcado4){
        contador = 4;
        marcado1 = true;
        marcado2 = true;
        marcado3 = true;
        marcado4 = true;
      }
    });
  }
  void marcar5(){
    setState(() {
      if(marcado5){
        contador = 5;
        marcado1 = true;
        marcado2 = true;
        marcado3 = true;
        marcado4 = true;
        marcado5 = true;
      }else if(!marcado5){
        contador = 5;
        marcado1 = true;
        marcado2 = true;
        marcado3 = true;
        marcado4 = true;
        marcado5 = true;
      }
    });
  }
}