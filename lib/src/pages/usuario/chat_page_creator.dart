import 'dart:io';

//import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
//import 'package:selfttour/src/models/tour_categoria_model.dart';
import 'package:selftourapp/src/pages/usuario/fullFoto_page.dart';
import 'package:selftourapp/src/preferencias_usuario/preferencias_usuario.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class ChatPageCreator extends StatefulWidget {
  final String userId;
  final String userName;
  final String userAvatar;
  final String userEmail;
  ChatPageCreator({Key key, @required this.userId, this.userEmail,@required this.userName, @required this.userAvatar}):super(key:key);
  @override
  ChatPageState createState() => ChatPageState(userId: userId, userEmail: userEmail,userName: userName, userAvatar: userAvatar);
}

class ChatPageState extends State<ChatPageCreator> {
  ChatPageState({Key key, @required this.userId,this.userEmail, @required this.userName, @required this.userAvatar});
  String userId;
  String userName;
  String userAvatar;
  String id;
  String userEmail;
  String email;

  var listMessage;
  String groupChatId;
  PreferenciasUsuario prefs = new PreferenciasUsuario();

  File imageFile;
  bool isLoading;
  bool isShowSticker;
  String imageUrl;

  final TextEditingController textEditingController = new TextEditingController();
  final ScrollController listScrollController = new ScrollController();
  final FocusNode focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(onFocusChange);
    groupChatId = '';
    isLoading = false;
    isShowSticker = false;
    imageUrl = '';
    readLocal();
  }

  void onFocusChange(){
    if(focusNode.hasFocus){
      // Hide sticker when keyboard appear - Ocultar el sticker
      //cuando aparece el teclado
      setState(() {
        isShowSticker = false;
      });
    }
  }
  readLocal()async{
    //prefs = await SharedPreferences.getInstance();
    //id = prefs.iduser ?? ''; //prefs.getString('id') ?? ''
     email = prefs.email ?? ''; //prefs.getString('id') ?? ''
    if(email.hashCode <= userEmail.hashCode){
      groupChatId = '$email-$userEmail';
    }else{
      groupChatId = '$userEmail-$email';
    }
    FirebaseFirestore.instance.collection('users').doc(email).update({'chatingWith': userEmail});
    setState(() {
      
    });
  }

  Future getImage()async{
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(imageFile != null){
      setState(() {
        isLoading = true;
      });
      uploadFile();
    }
  }

  void getSticker(){
    // Hide keyboard when sticker appear - Ocultar el teclado cuando 
    //el sticker aparece
    //focusNode.unfocus();
    setState(() {
      //isShowSticker = !isShowSticker;
    });
  }

  Future uploadFile()async{
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putFile(imageFile);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl){
      imageUrl = downloadUrl;
      setState(() {
        isLoading = false;
        onSendMessage(imageUrl,1);
      });
    }, onError: (error){
      setState(() {
        isLoading = false;
      });
      //Fluttertoast.showToast(msg: 'This file is not an image');
    }
    );
  }

  void onSendMessage(String content, int type){
    // type: 0 = text, 1 = image, 2 = sticker
    if(content.trim() != ''){
      textEditingController.clear();

      DocumentReference documentReference = FirebaseFirestore.instance
        .collection('messages')
        .doc(groupChatId)
        .collection(groupChatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());
      
      FirebaseFirestore.instance.runTransaction((transaction)async{
        transaction.set(
          documentReference,
          {
            'idFrom': email,
            'idTo': userEmail,// detalletour.user
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content,
            'type':type
          }
          );
      });
      listScrollController.animateTo(0.0,duration: Duration(milliseconds: 300),curve: Curves.easeOut);
    }else{
      //Fluttertoast.showToast(msg: 'Nothing to send');
      print('Nothing to send');
    }
  }

  Widget buildItem(int index, DocumentSnapshot document){
    if(document.data()['idFrom']==email){
      // Right (my message) - Nuestro mensaje se ubica a la derecha
      return Row(
        children: <Widget>[
          document.data()['type'] == 0
           //Text
           ? Container(
             child: Text(
               document.data()['content'],
               style: TextStyle(color: Color(0xff203152)),
             ),
             padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
             width: 200.0,
             decoration: BoxDecoration(
               color: Color(0xffE8E8E8),
               borderRadius: BorderRadius.circular(5.0),
             ),
             margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),

           )
           : document.data()['type'] == 1
           //Image
           ? Container(
             child: FlatButton(
               child: Material(
                 child: Image.network(
                   document.data()['content'],
                   width: 200.0,
                   height: 200.0,
                   fit: BoxFit.fill,
                   scale: 1.0,
                 )
                 
                 /*CachedNetworkImage(
                   placeholder: (context, url) => Container(
                     child: CircularProgressIndicator(
                       valueColor: AlwaysStoppedAnimation<Color>(Color(0xfff5a623)),
                     ),
                     width: 200.0,
                     height: 200.0,
                     padding: EdgeInsets.all(70.0),
                     decoration: BoxDecoration(
                       color: Colors.grey,
                       borderRadius: BorderRadius.all(Radius.circular(8.0))
                     ),
                   ),
                   errorWidget: (context, url, error) => Material(
                     child: Image.asset(
                       'assets/no-image.jpg',
                       width: 200.0,
                       height: 200.0,
                       fit: BoxFit.cover,
                     ),
                     borderRadius: BorderRadius.all(
                       Radius.circular(8.0)
                     ),
                     clipBehavior: Clip.hardEdge,
                   ),
                   imageUrl: document['content'],
                   width: 200.0,
                   height: 200.0,
                   fit: BoxFit.cover
                 ),*/
                 //borderRadius: BorderRadius.all(Radius.circular(8.0)),
                 //clipBehavior: Clip.hardEdge,
               ),
               onPressed: (){
                 Navigator.push(
                              context, MaterialPageRoute(builder: (context) => FullPhoto(url: document.data()['content'])));
               },
               padding: EdgeInsets.all(0),

             ),
             margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
           )
           // Sticker
           : Container(
             child: Image.asset(
               'assets/loading.gif',
               width: 100.0,
               height: 100.0,
               fit: BoxFit.cover,
             ),
             margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
           )
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      );
    }else{
      // Left (peer message)
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                isLastMessageLeft(index)
                ? Material(
                  child: Image.network(
                    userAvatar,
                    width: 35.0,
                    height: 35.0,
                    fit: BoxFit.fill,
                  )
                  
                  /*CachedNetworkImage(
                    placeholder: (context, url) => Container(
                      child: CircularProgressIndicator(
                        strokeWidth: 1.0,
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xfff5a623)),
                      ),
                      width: 35.0,
                      height: 35.0,
                      padding: EdgeInsets.all(10.0),
                    ),
                    imageUrl: userAvatar,
                    width: 35.0,
                    height: 35.0,
                    fit: BoxFit.cover,
                  ),*/
                 /* borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                  ),*/
                  //clipBehavior: Clip.hardEdge,
                )
                : Container(width: 35.0),
                document.data()['type'] == 0
                ? Container(
                  child: Text(
                    document.data()['content'],
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  width: 200.0,
                  decoration: BoxDecoration(color: Color(0xff203152), borderRadius: BorderRadius.circular(8.0)),
                  margin: EdgeInsets.only(left: 10.0),
                )
                : document.data()['type'] == 1
                ? Container(
                  child: FlatButton(
                    child: Material(
                      child: Image.network(
                        document.data()['content'],
                        width: 200.0,
                        height: 200.0,
                        fit: BoxFit.fill,
                      )
                      
                      /*CachedNetworkImage(
                        placeholder: (context, url) => Container(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xfff5a623)),
                          ),
                          width: 200.0,
                          height: 200.0,
                          padding: EdgeInsets.all(70.0),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          )
                        ),
                        errorWidget: (context, url, error) => Material(
                          child: Image.asset(
                            'assets/no-image.jpg',
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          clipBehavior: Clip.hardEdge,
                        ),
                        imageUrl: document['content'],
                        width: 200.0,
                        height: 200.0,
                        fit: BoxFit.cover,
                      ),*/
                      //borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      //clipBehavior: Clip.hardEdge,
                    ),
                    onPressed: (){
                      Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => FullPhoto(url: document.data()['content'])));
                    },
                    padding: EdgeInsets.all(0),
                  ),
                  margin: EdgeInsets.only(left: 10.0),
                )
                : Container(
                  child: Image.asset(
                    'assets/loading.gif',
                    width: 100.0,
                    height: 100.0,
                    fit: BoxFit.cover,
                  ),
                  margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
                )
              ],
            ),
            // Time
            isLastMessageLeft(index)
            ? Container(
              child: Text(
                DateFormat('dd MMM kk:mm')
                .format(DateTime.fromMillisecondsSinceEpoch(int.parse(document.data()['timestamp']))),
                style: TextStyle(color: Colors.grey[300], fontSize: 12.0, fontStyle: FontStyle.italic),
              ),
              margin: EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
            )
            : Container()
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
  }

  bool isLastMessageLeft(int index){
    if((index > 0 && listMessage != null && listMessage[index-1]['idFrom']==email) || index == 0){
      return true;
    }else{
      return false;
    }
  }

  bool isLastMessageRight(int index){
    if((index > 0 && listMessage != null && listMessage[index-1]['idFrom'] != email) || index == 0){
      return true;
    }else{
      return false;
    }
  }

  // Hide sticker or back - Ocultar el sticker o regresar
  Future<bool> onBackPress(){
    Navigator.pop(context);
    return Future.value(false);

    /*
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    } else {
      Firestore.instance.collection('users').document(id).updateData({'chattingWith': null});
      Navigator.pop(context);
    }
    */
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
      ),
      body: WillPopScope(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                // List of messages - Lista de mensajes
                buildListMessage(),

                // Sticker
               // (isShowSticker ? buildSticker() : Container()),

                // Input content - Contenido del input
                buildInput(),
              ],
            ),
            // Loading
            buildLoading()
          ],
        ),
        onWillPop: onBackPress,
      )
    );
  }

  Widget buildSticker(){
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: ()=> onSendMessage('mimi1', 2),
                child: Image.asset(
                  'assets/loading.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: ()=> onSendMessage('mimi3', 2),
                child: Image.asset(
                  'assets/loading.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: ()=> onSendMessage('mimi4', 2),
                child: Image.asset(
                  'assets/no-image.jpg',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: ()=> onSendMessage('mimi5', 2),
                child: Image.asset(
                  'assets/no-image.jpg',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: ()=> onSendMessage('mimi6', 2),
                child: Image.asset(
                  'assets/jar-loading.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: ()=> onSendMessage('mimi7', 2),
                child: Image.asset(
                  'assets/jar-loading.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: ()=> onSendMessage('mimi8', 2),
                child: Image.asset(
                  'assets/jar-loading.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: ()=> onSendMessage('mimi9', 2),
                child: Image.asset(
                  'assets/jar-loading.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey,width: 0.5)
        ),
        color: Colors.white
      ),
      padding: EdgeInsets.all(5.0),
      height: 180.0,
    );
  }
  
  Widget buildLoading(){
    return Positioned(
      child: isLoading 
       ? Container(
         child: Center(
           child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xfff5a623))),
         ),
         color: Colors.white.withOpacity(0.8),
       ) : Container()
    );
  }

  Widget buildInput(){
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image - Botón para enviar imagen
         /* Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                icon: Icon(Icons.image),
                onPressed: getImage,
                color: Colors.black, //primarycolor
              ),
            ),
            color: Colors.white,
          ),*/
        /*  Material(
            child: Container(
              child: IconButton(
                icon: Icon(Icons.face),
                onPressed: getSticker,
                color: Colors.blueAccent,
              ),
            ),
            color: Colors.white,
          ),*/
          // Edit text
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                style: TextStyle(color: Colors.blue, fontSize: 15.0),
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Mensaje...',//Type your message...
                  hintStyle: TextStyle(color: Colors.grey), //greyColor
                ),
                focusNode: focusNode,
              ),
            ),
          ),
          // Button send message - Botón de enviar mensaje
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: ()=> onSendMessage(textEditingController.text, 0),
                color: Colors.lightBlue, //primarycolor
              ),
            ),
            color: Colors.white,
          )
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey[300], width: 0.5),
        ),
        color: Colors.white,
      ),
    );
  }
  Widget buildListMessage(){
    return Flexible(
      child: groupChatId == ''
      ? Center(
        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xfff5a623))),
      ) : StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('messages')
            .doc(groupChatId)
            .collection(groupChatId)
            .orderBy('timestamp',descending: true)
            .limit(20)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xfff5a623))),
            );
          }else{
            listMessage = snapshot.data.documents;
              return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context,index){
                return buildItem(index, snapshot.data.documents[index]);
              },
              itemCount: snapshot.data.documents.length,
              reverse: true,
              controller: listScrollController,
            );
          }
          
        },
      ),
    );
  }
}