import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:selftourapp/src/pages/usuario/chat_page.dart';
//import 'package:selfttour/src/pages/usuario/chat_page_creator.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';

class ChatUsuariosPage extends StatefulWidget {
  @override
  _ChatUsuariosPageState createState() => _ChatUsuariosPageState();
}

class _ChatUsuariosPageState extends State<ChatUsuariosPage> {
  @override
  Widget build(BuildContext context) {
    PreferenciasUsuario prefs = new PreferenciasUsuario();
    String noData = AppTranslations.of(context).text('title_nodatos');
    String mensajes = AppTranslations.of(context).text('title_mensajes');
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "$mensajes".toUpperCase(),
          style: TextStyle(
            fontFamily: 'Point-SemiBold',
            fontWeight: FontWeight.bold
          ),
        ),
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
      body: StreamBuilder(
            stream: Firestore.instance.collection('users').where('chattingWith',isEqualTo: '${prefs.email.toString()}').snapshots(), //prefs.iduser.toString()
            builder: (context, AsyncSnapshot<QuerySnapshot>snapshot){
              
              switch(snapshot.connectionState){
                case ConnectionState.waiting:
                  return Column(
                    children: <Widget>[
                      SizedBox(
                        height: size.height * 0.23,
                      ),
                      Center(
                        child: CircularProgressIndicator()
                      ),
                    ],
                  );
                break;
                case ConnectionState.none:
                  return Column(
                    children: <Widget>[
                      SizedBox(
                        height: size.height * 0.23,
                      ),
                      Center(
                        child: Text(
                          '$noData',
                          style: TextStyle(
                            fontFamily: 'Point-SemiBold'
                          ),
                        )
                      ),
                    ],
                  );
                break;
                case ConnectionState.done:
                  if(!snapshot.hasData){
                    return Column(
                      children: <Widget>[
                        SizedBox(
                          height: size.height * 0.23,
                        ),
                        Center(
                          child: CircularProgressIndicator()
                        ),
                      ],
                    );
                  }else{
                    if(snapshot.data.documents.isEmpty || snapshot.data.documents.length == 0 || snapshot.data.documents == null){
                      return Column(
                        children: <Widget>[
                          SizedBox(
                            height: size.height * 0.23,
                          ),
                          Center(
                            child: Text(
                              '$noData',
                              style: TextStyle(
                                fontFamily: 'Point-SemiBold'
                              ),
                            )
                          ),
                        ],
                      );
                    }else{
                      return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context,index){
                          return itemUser(context, snapshot.data.documents[index]);
                        },
                      );
                    }
                    
                  }
                break;
                case ConnectionState.active:
                  print("Mensajes: ");
                  print(snapshot.data.documents);
                  print(prefs.token);
                  if(!snapshot.hasData){
                    return Column(
                      children: <Widget>[
                        SizedBox(
                          height: size.height * 0.23,
                        ),
                        Center(
                          child: CircularProgressIndicator()
                        ),
                      ],
                    );
                  }else{
                    if(snapshot.data.documents.isEmpty || snapshot.data.documents.length == 0 || snapshot.data.documents == null){
                      return Column(
                        children: <Widget>[
                          SizedBox(
                            height: size.height * 0.23,
                          ),
                          Center(
                            child: Text(
                              '$noData',
                              style: TextStyle(
                                fontFamily: 'Point-SemiBold'
                              ),
                            )
                          ),
                        ],
                      );
                    }else{
                      return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context,index){
                          return itemUser(context, snapshot.data.documents[index]);
                        },
                      );
                    }
                    
                  }
                break;
                default:
                  return Column(
                    children: <Widget>[
                      SizedBox(
                        height: size.height * 0.23,
                      ),
                      Center(
                        child: Text(
                          '$noData',
                          style: TextStyle(
                            fontFamily: 'Point-SemiBold'
                          ),
                        )
                      ),
                    ],
                  );
                
              }
              /*if(!snapshot.hasData){
                return Center(
                  child: Text('$noData')
                );
              }else{
                return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context,index){
                    return itemUser(context, snapshot.data.documents[index]);
                  },
                );
              }*/
            },
          ),
    );
  }

  Widget itemUser(BuildContext context, DocumentSnapshot snapshot){
    final size = MediaQuery.of(context).size;
    String imageUser = "https://pluspng.com/img-png/user-png-icon-male-user-icon-512.png";
    //if(snapshot[''])
    return Card(
      child: Container(
        child: FlatButton(
          child: Row(
            children: <Widget>[
              Container(
                width: size.width * 0.3,
                height: size.height * 0.15,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      (snapshot['photoUrl'] == 'null' || snapshot['photoUrl'] == null || snapshot['photoUrl'] == '') ? imageUser : "${snapshot['photoUrl'].toString()}",
                    ),
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(
                width: size.width * 0.04,
              ),
              Text(snapshot['nickname'].toString())
            ],
          ),
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context){
                //userId: snapshot['id'].toString(),
                //tokenFCM: snapshot['tokenfcm'].toString(),
                return ChatPage(userEmail: snapshot['email'].toString() ,userName: snapshot['nickname'].toString(),userAvatar: snapshot['photoUrl'].toString()); //snapshot['id'].toString()
              },
              //settings: RouteSettings(arguments: snapshot['id'].toString())
            ));
          },
        ),
      ),
    );
  }
}