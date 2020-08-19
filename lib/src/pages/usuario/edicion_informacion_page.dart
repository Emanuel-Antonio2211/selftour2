import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:selftourapp/src/googlemaps/states/app_state.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:selftourapp/src/providers/usuario_provider.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';
import 'package:selftourapp/src/utils/utils.dart';
import 'package:selftourapp/src/widgets/tree_size_dot_widget.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class EditInformationPage extends StatefulWidget {
  @override
  _EditInformationPageState createState() => _EditInformationPageState();
}

class _EditInformationPageState extends State<EditInformationPage> {
  PreferenciasUsuario prefs = PreferenciasUsuario();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UsuarioProvider _usuarioProvider = UsuarioProvider();
  final format = DateFormat('yyyy-MM-dd');

  File foto;
  String nombre;
  String telefono;
  String imgProfile;
  String fechaNacimiento;
  String cuentaFacebook;
  String webPag;

  @override
  void initState() { 
    super.initState();
    _usuarioProvider.obtenerDatosUsuario(prefs.token.toString());
  }

  seleccionarFoto()async{
   foto = await ImagePicker.pickImage(
      source: ImageSource.gallery
    );
    setState(() {
        
    });
    if(foto != null){
      //limpieza
      //prefs.photoUrl = '';
      prefs.photoEditar = '';
      //fotoUrl = null;
    }
    //prefs.photoUrl = foto?.path;
    print("Foto");
    // print(foto.path);
    print(foto);
    print(prefs.photoEditar);
  }

  tomarFoto()async{
    foto = await ImagePicker.pickImage(
      source: ImageSource.camera
    );
    setState(() {
        
    });
    if(foto != null){
      //limpieza
      //prefs.photoUrl = '';
      //fotoUrl = null;
      prefs.photoEditar = '';
    }
    
    //prefs.photoUrl = foto?.path;
    print("Foto");
    // print(foto.path);
    print(foto);
    print(prefs.photoEditar);
  }

  Widget _mostrarFoto(String fotoUrl){
    //print(foto!=null);
    var size = MediaQuery.of(context).size;
    if(fotoUrl != '') {
      //prefs.photoUrl.toString()
      return Image( 
          image: NetworkImage(fotoUrl),
        );
 
    }else if(foto != null) {
      return Image.file(
          foto,
          fit: BoxFit.cover,
          height: size.height * 0.6,
          width: size.width * 0.4,
        );
    }else{
      return Image( 
        image: AssetImage('assets/no-image.jpg'),
        fit: BoxFit.cover,
        width: size.width * 0.4,
        height: size.height * 0.4,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    String guardar = AppTranslations.of(context).text('title_guardar');
    String editainfo = AppTranslations.of(context).text('title_editainfo');
    String nombre = AppTranslations.of(context).text('title_name');
    //String correo = AppTranslations.of(context).text('title_email');
    String telefono = AppTranslations.of(context).text('title_telefono');
    String successDataUpdate = AppTranslations.of(context).text('title_success_update');
    String fecNacimiento = AppTranslations.of(context).text('title_fecha_Nac');
    String ctaFacebook = AppTranslations.of(context).text('title_facebook');
    String paginaWeb = AppTranslations.of(context).text('title_webpag');
    String ejemplo = AppTranslations.of(context).text('title_ejemplo');


    AppState _appState = AppState();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
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
        actions: <Widget>[
         /* CircleAvatar(
            backgroundColor: Color(0xFFD62250),
            child: IconButton(
              icon: Icon(
                Icons.image,
                color: Colors.white,
              ),
              onPressed: seleccionarFoto,
            ),
          ),
          CircleAvatar(
            backgroundColor: Color(0xFFD62250),
            child: IconButton(
              icon: Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
              onPressed: tomarFoto,
            ),
          ),*/

          /*
          FlatButton(
            child: Text('$guardar',style: TextStyle(color: Colors.red),),
            onPressed: ()async{
              int codPais;
              String codPostal;
              await _appState.userLocation().then((result){
                print(result[5]);
                codPostal = result[7].toString();
                //result[2] == 'Mexico'
                if(result[5] == 'MX'){
                  codPais = 200;
                }else if(result[5] == 'DE'){
                  codPais = 4;
                }else if(result[5] == 'JP'){
                  codPais = 168;
                }else if(result[5] == 'FR'){
                  codPais = 136;
                }else if(result[5] == 'US'){
                  codPais = 129;
                }
              });
              print(codPais.toString());
              if(formKey.currentState.validate()){
                formKey.currentState.save();
                print("Datos a ingresar");
                //final mymeType = mime(foto.path).split('/'); //image/jpeg
               // final imageUploadRequest = http.MultipartRequest()
              /* final file = await http.MultipartFile.fromPath(
                 'file',
                  foto.path,
                  contentType: MediaType(
                    mymeType[0],
                    mymeType[1]
                  )
                );*/
                print(foto.path);
                print(nombre);
                print(telefono);
                
               await _usuarioProvider.actualizarPerfil(nombre, telefono,fechaNacimiento, codPostal,codPais.toString(),cuentaFacebook,webPag,foto, prefs.token).then((result)async{
                  final respuesta = result;
                  setState(() {
                  
                  });
                  prefs.photoUrl = respuesta['dataUser']['data'][0]['img_profile'].toString();
                  print(prefs.photoUrl);
                  final QuerySnapshot resultado = await Firestore.instance.collection('users').where('email',isEqualTo: prefs.email).getDocuments();
                  final List<DocumentSnapshot> documents = resultado.documents;
                  /*if(documents.single.data['photoUrl'] != ){
                    Firestore.instance.collection('users').document(prefs.email).updateData({'photoUrl': userEmail});
                  }else{
                    print("La foto es igual");
                  }*/

                  mostrarAviso(context, 'Se actualizó de manera exitosa', '', 'assets/check.jpg');
                }).catchError((error){
                  print(error.toString());
                  mostrarAviso(context, error.toString(), '', 'assets/error.png');
                });

              }
              
            },
          ),*/
          Padding(
            padding: EdgeInsets.only(right: 5.0),
            child: ProgressButton(
              defaultWidget: Text(
                '$guardar',
                style: TextStyle(
                  fontFamily: 'Point-SemiBold',
                  fontSize: 15.0,
                  color: Colors.white
                ),
              ),
              width: size.width * 0.2,
              height: size.height * 0.01,
              borderRadius: 3.0,
              progressWidget: ThreeSizeDot(),
              color: Color(0xFFD62250),
              type: ProgressButtonType.Raised,
              animate: false,
              onPressed: ()async{
                await Future.delayed(Duration(seconds: 2),()async{
                  int codPais;
                  //String codPostal;

                 // List<String> tokens = List();
                  // await _appState.userLocation().then((result){
                  //   print(result[5]);
                  //   codPostal = result[7].toString();
                  //   //result[2] == 'Mexico'
                  //   if(result[5] == 'MX'){
                  //     codPais = 200;
                  //   }else if(result[5] == 'DE'){
                  //     codPais = 4;
                  //   }else if(result[5] == 'JP'){
                  //     codPais = 168;
                  //   }else if(result[5] == 'FR'){
                  //     codPais = 136;
                  //   }else if(result[5] == 'US'){
                  //     codPais = 129;
                  //   }
                  // });
                  if(prefs.countryCode == 'MX'){
                      codPais = 200;
                    }else if(prefs.countryCode == 'DE'){
                      codPais = 4;
                    }else if(prefs.countryCode == 'JP'){
                      codPais = 168;
                    }else if(prefs.countryCode == 'FR'){
                      codPais = 136;
                    }else if(prefs.countryCode == 'US'){
                      codPais = 129;
                    }
                  print(codPais.toString());
                  if(formKey.currentState.validate()){
                    formKey.currentState.save();
                    print("Datos a ingresar");
                    //print(foto.path);
                    print(cuentaFacebook);
                    print(nombre);
                    print(telefono);
                    /*
                  /* Firestore.instance.collection('users').document('${prefs.email}').collection('tokensfcm').snapshots().listen((t){
                      t.documents.forEach((doc){
                        //print(doc.data.keys); 
                        //print(doc.data['token']);
                        
                      });
                    });*/
                    final query = await Firestore.instance.collection('users').document('${prefs.email}').collection('tokensfcm').getDocuments();
                    print("Resultados");
                    for(int i = 0; i < query.documents.length; i++){
                      //print(query.documents[i].data['token']);
                      tokens.add(query.documents[i].data['token']);
                    }

                    print(tokens);
                    */

                  await _usuarioProvider.actualizarPerfil(nombre, telefono,fechaNacimiento, prefs.codPostal,codPais.toString(),cuentaFacebook,webPag,foto, prefs.token).then((result)async{
                      final respuesta = result;
                      setState(() {
                      
                      });
                      prefs.name = respuesta['dataUser']['data'][0]['name'];
                      prefs.photoUrl = respuesta['dataUser']['data'][0]['img_profile'].toString();
                      prefs.phone = respuesta['dataUser']['data'][0]['phone'].toString();
                      prefs.fNac = DateTime.parse(respuesta['dataUser']['data'][0]['dbirth'].toString()); //.substring(0,10)
                      prefs.accountFacebook = respuesta['dataUser']['data'][0]['fb'].toString();
                      prefs.pagWeb = respuesta['dataUser']['data'][0]['webpage'].toString();
                      print(prefs.photoUrl);
                      final QuerySnapshot resultado = await Firestore.instance.collection('users').where('email',isEqualTo: prefs.email).getDocuments();
                      final List<DocumentSnapshot> documents = resultado.documents;
                      if(documents.single.data['photoUrl'] != prefs.photoUrl){
                        Firestore.instance.collection('users').document(prefs.email).updateData({'photoUrl': prefs.photoUrl});
                        print("La imagen se actualizó");
                      }else{
                        print("La foto es igual");
                      }

                      await _usuarioProvider.obtenerDatosUsuario(prefs.token.toString());
                      //mostrarAviso(context, '$successDataUpdate', '', 'assets/check.jpg');
                      mostrarAlerta(context, '$successDataUpdate', '', 'assets/check.jpg');
                    }).catchError((error){
                      print(error.toString());
                      //mostrarAviso(context, error.toString(), '', 'assets/error.png');
                      mostrarAlerta(context, error.toString(), '', 'assets/error.png');
                    });

                  }
                });
                
              },
            ),
          )
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: StreamBuilder(
            stream: _usuarioProvider.streamEdition,
            builder: (context, AsyncSnapshot<Map<String,dynamic>> snapshot) {
              final datosUsuario = snapshot.data;
              
              if(!snapshot.hasData){
                return Column(
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.34,
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    )
                  ],
                );
              }else{
                prefs.photoEditar = datosUsuario['dataUser']['data'][0]['img_profile'].toString();
                return Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: size.width * 0.02),
                      child: Text('$editainfo',style: TextStyle(
                        fontFamily: 'Point-SemiBold',
                        fontSize: 25.0
                      )),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                      child: CircleAvatar(
                        radius: 50.0,
                        child: Stack(
                          children:[ 
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: //_mostrarFoto(prefs.photoEditar.toString())
                              (foto != null) ? Image.file(
                                foto,
                                fit: BoxFit.cover,
                                height: size.height * 0.6,
                                width: size.width * 0.4,
                              ):
                              Image( 
                                image: NetworkImage(prefs.photoEditar.toString()),
                                height: size.height * 0.6,
                                width: size.width * 0.4
                              )
                            /*FadeInImage(
                              image: _mostrarFoto(), //prefs.photoUrl.toString() != '' ? NetworkImage( prefs.photoUrl.toString()) : ( foto != null ? Image.network(foto.path,fit: BoxFit.fill ) : AssetImage( 'assets/iconoapp/Selftour1.png') ),
                              placeholder: AssetImage('assets/loading.gif'),
                              fit: BoxFit.fill,
                              )*/
                          ),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: CircleAvatar(
                                backgroundColor: Color(0xFFD62250),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                  onPressed: tomarFoto
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: CircleAvatar(
                                backgroundColor: Color(0xFFD62250),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.image,
                                    color: Colors.white,
                                  ),
                                  onPressed: seleccionarFoto
                                ),
                              ),
                            )
                          ]
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        //autofocus: true, //Sirve para enfocar directamente al primer elemento del formulario
                        initialValue: datosUsuario['dataUser']['data'][0]['name'].toString(),//prefs.name
                        decoration: InputDecoration(
                          labelText: '$nombre', //OutlineInputBorder UnderlineInputBorder
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 0.0)
                          ),
                          labelStyle: TextStyle(
                            fontFamily: 'Point-SemiBold',
                            color: Colors.black
                          )
                        ),
                        onSaved: (String name){
                          nombre = name;
                        },
                      ),
                    ),
                    /*SizedBox(height: size.height * 0.04,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: '$correo',
                          labelStyle: TextStyle(
                            fontFamily: 'Point-SemiBold',
                            color: Colors.black
                          )
                        ),
                      ),
                    ),*/
                    SizedBox(height: size.height * 0.04,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                      child: TextFormField(
                        keyboardType: TextInputType.phone, //datosUsuario['dataUser']['data'][0]
                        initialValue: datosUsuario['dataUser']['data'][0]['phone'] == null ? '':datosUsuario['dataUser']['data'][0]['phone'].toString(),//prefs.phone //(prefs.phone == "null" || prefs.phone == '' || prefs.phone == null) ? '' : prefs.phone
                        decoration: InputDecoration(
                          labelText: '$telefono',
                          labelStyle: TextStyle(
                            fontFamily: 'Point-SemiBold',
                            color: Colors.black
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 0.0)
                          )
                        ),
                        maxLength: 10,
                        onSaved: (String phone){
                          telefono = phone;
                        },
                      ),
                    ),
                    SizedBox(height: size.height * 0.02,),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                    //   child: TextFormField(
                    //     keyboardType: TextInputType.datetime,
                    //     initialValue: prefs.fNac == null ? '' : prefs.fNac,
                    //     decoration: InputDecoration(
                    //       labelText: '$fecNacimiento *',
                    //       labelStyle: TextStyle(
                    //         fontFamily: 'Point-SemiBold',
                    //         color: Colors.black
                    //       )
                    //     ),
                    //     maxLength: 10,
                    //     onSaved: (String fechNac){
                    //       fechaNacimiento = fechNac;
                    //     },
                    //   ),
                    // ),
                    
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                      child: DateTimeField(
                        format: format,
                        initialValue: datosUsuario['dataUser']['data'][0]['dbirth'] == null ? DateTime.now() : DateTime.parse(datosUsuario['dataUser']['data'][0]['dbirth']),//prefs.fNac == null ? DateTime.now() : DateTime.parse(prefs.fNac)
                        decoration: InputDecoration(
                          labelText: "$fecNacimiento",
                          labelStyle: TextStyle(
                            fontFamily: "Point-SemiBold",
                            color: Colors.black
                          )
                        ),
                        onShowPicker: (context,currentValue){
                          return showDatePicker(
                            context: context, 
                            initialDate: datosUsuario['dataUser']['data'][0]['dbirth'] == null ? DateTime.now() ?? currentValue : DateTime.parse(datosUsuario['dataUser']['data'][0]['dbirth']),
                            firstDate: DateTime(1900), 
                            lastDate: DateTime(2100),
                            locale: Locale(prefs.idioma)
                          );
                        },
                        onSaved: (DateTime date){
                          fechaNacimiento = date.toString();
                        },
                        onChanged: (DateTime dateTime){
                          print(dateTime.toString());
                        },
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.only(left:size.width * 0.02),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '$ejemplo: AAAA-MM-dd',
                          style: TextStyle(
                            fontFamily: 'Point-SemiBold',
                            color: Colors.black
                          ),
                        ),
                      )
                    ),
                    SizedBox(height: size.height * 0.04,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        initialValue: ( datosUsuario['dataUser']['data'][0]['fb'] == '0' || datosUsuario['dataUser']['data'][0]['fb'] == null || datosUsuario['dataUser']['data'][0]['fb'] == "" || datosUsuario['dataUser']['data'][0]['fb'] == "ninguno") ? 'https://web.facebook.com/': datosUsuario['dataUser']['data'][0]['fb'].toString(),
                        //(prefs.accountFacebook == null || prefs.accountFacebook == "null") ? '': prefs.accountFacebook
                        decoration: InputDecoration(
                          labelText: '$ctaFacebook',
                          labelStyle: TextStyle(
                            fontFamily: 'Point-SemiBold',
                            color: Colors.black
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 0.0)
                          )
                        ),
                        onSaved: (String facebook){
                          cuentaFacebook = facebook;
                        },
                        // onChanged: (String facebook){
                        //   print(facebook);
                        // },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left:size.width * 0.02),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '$ejemplo: https://facebook.com/',
                          style: TextStyle(
                            fontFamily: 'Point-SemiBold',
                            color: Colors.black
                          ),
                        ),
                      )
                    ),
                    SizedBox(height: size.height * 0.04,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        initialValue: ( datosUsuario['dataUser']['data'][0]['webpage'] == '0' || datosUsuario['dataUser']['data'][0]['webpage'] == 'undefined' || datosUsuario['dataUser']['data'][0]['webpage'] == null || datosUsuario['dataUser']['data'][0]['webpage'] == "" || datosUsuario['dataUser']['data'][0]['webpage'] == "ninguno") ? '': datosUsuario['dataUser']['data'][0]['webpage'].toString(),
                        //(prefs.pagWeb == 'undefined' || prefs.pagWeb == null || prefs.pagWeb == "null") ? '': prefs.pagWeb.toString()
                        decoration: InputDecoration(
                          labelText: '$paginaWeb',
                          labelStyle: TextStyle(
                            fontFamily: 'Point-SemiBold',
                            color: Colors.black
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 0.0)
                          )
                        ),
                        onSaved: (String web){
                          webPag = web;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left:size.width * 0.02),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '$ejemplo: https://mipagina.com/',
                          style: TextStyle(
                            fontFamily: 'Point-SemiBold',
                            color: Colors.black
                          ),
                        ),
                      )
                    ),
                  ],
                );
              }
            }
          ),
        ),
      ),
    );
  }
}