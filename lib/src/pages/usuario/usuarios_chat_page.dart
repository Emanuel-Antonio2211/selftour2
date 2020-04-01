import 'package:cached_network_image/cached_network_image.dart';
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
      body: StreamBuilder(
            stream: Firestore.instance.collection('users').where('chattingWith',isEqualTo: '${prefs.email.toString()}').snapshots(), //prefs.iduser.toString()
            builder: (context,snapshot){
              switch(snapshot.connectionState){
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator()
                  );
                break;
                case ConnectionState.none:
                  return Center(
                    child: Text('$noData')
                  );
                break;
                case ConnectionState.done:
                  if(!snapshot.hasData){
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
                  }
                break;
                case ConnectionState.active:
                  if(!snapshot.hasData){
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
                  }
                break;
                default:
                  return Center(
                    child: Text('$noData')
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
    //if(snapshot[''])
    return Card(
      child: Container(
        child: FlatButton(
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: 
                /*Image.network(
                  snapshot['photoUrl'].toString(),
                  width: size.width * 0.3,
                  height: size.height * 0.15,
                  fit: BoxFit.fill,
                  scale: 1.0,
                )*/
                CachedNetworkImage(
                  imageUrl: "${snapshot['photoUrl'].toString()}",
                  //errorWidget: (context, url, error)=>Icon(Icons.error),
                  //cacheManager: baseCacheManager,
                  useOldImageOnUrlChange: true,
                  width: size.width * 0.3,
                  height: size.height * 0.15,
                  fit: BoxFit.fill,
                )
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
                return ChatPage(userId: snapshot['id'].toString(),tokenFCM: snapshot['tokenfcm'].toString(),userEmail: snapshot['email'].toString() ,userName: snapshot['nickname'].toString(),userAvatar: snapshot['photoUrl'].toString(),); //snapshot['id'].toString()
              },
              //settings: RouteSettings(arguments: snapshot['id'].toString())
            ));
          },
        ),
      ),
    );
  }
}