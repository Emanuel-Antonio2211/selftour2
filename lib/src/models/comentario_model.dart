// Generated by https://quicktype.io

class Comentario {
  String title;
  List<Comment> comments = List();

  Comentario({
    this.title,
    this.comments,
  });

  Comentario.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null){
      return;
    }
    for(var item in jsonList){
      final comentario = new Comment.fromJsonMap(item);
      comments.add(comentario);
    }
  }
}

class Comment {
  String commentary;
  String dateComment;
  String name;
  String mail;
  String imgProfile;

  Comment({
    this.commentary,
    this.dateComment,
    this.name,
    this.mail,
    this.imgProfile,
  });

  //Voy a llamar cuando quiero generar una instancia que viene en un mapa
  // en formato json
  Comment.fromJsonMap(Map<String,dynamic> json){
    commentary  = json['commentary'];
    dateComment = json['dateComment'];
    name        = json['name'];
    mail        = json['mail'];
    imgProfile  = json['img_profile'];
  }
}