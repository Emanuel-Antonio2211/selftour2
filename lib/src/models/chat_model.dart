class Chats {
  String title;
  List<Chat> comments = List();

  Chats({
    this.title,
    this.comments,
  });

  Chats.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null){
      return;
    }
    for(var item in jsonList){
      final comentario = new Chat.fromJsonMap(item);
      comments.add(comentario);
    }
  }
}

class Chat {
  String usuario;
  String mensaje;
  String emailuser;
  String fotouser;
  String fotousuarionoti;
  String datauser;
  String dataemail;

  Chat({
    this.usuario,
    this.mensaje,
    this.emailuser,
    this.fotouser,
    this.fotousuarionoti,
    this.datauser,
    this.dataemail,
  });

  //Voy a llamar cuando quiero generar una instancia que viene en un mapa
  // en formato json
  Chat.fromJsonMap(Map<String,dynamic> json){
    usuario           = json['usuario'];
    mensaje           = json['mensaje'];
    emailuser         = json['emailuser'];
    fotouser          = json['fotouser'];
    fotousuarionoti   = json['fotousuarionoti'];
    datauser          = json['datauser'];
    dataemail         = json['dataemail'];
  }
}