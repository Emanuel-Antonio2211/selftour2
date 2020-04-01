import 'dart:convert';

TourModel tourModelFromJson(String str) => TourModel.fromJson(json.decode(str));

String tourModelToJson(TourModel data) => json.encode(data.toJson());

class TourModel {
  List<int> categoria = [1,2,3,4,5,6];
  int categoriaSeleccionada = 1;
  List<int> paises = [1,2,3,4,5,6];
  int paisSeleccionado = 1;
  List<int> estados = [1,2,3,4,5,6];
  int estadoSeleccionado = 1;
  List<int> ciudades = [1,2,3,4,5,6];
  int ciudadSeleccionada = 1;

    String titulo;
    String description;
    int score;
    String cover;
    String duration;
    String budget;
    String recommendations;
    int idcategory;
    int idcountry;
    int idstate;
    int idcity;

    TourModel({
        this.titulo,
        this.description,
        this.score,
        this.cover,
        this.duration,
        this.budget,
        this.recommendations,
        this.idcategory,
        this.idcountry,
        this.idstate,
        this.idcity,
    });

    factory TourModel.fromJson(Map<String, dynamic> json) => TourModel(
        titulo: json["titulo"],
        description: json["description"],
        score: json["score"],
        cover: json["cover"],
        duration: json["duration"],
        budget: json["budget"],
        recommendations: json["recommendations"],
        idcategory: json["idcategory"],
        idcountry: json["idcountry"],
        idstate: json["idstate"],
        idcity: json["idcity"],
    );

    Map<String, dynamic> toJson() => {
        "titulo": titulo,
        "description": description,
        "score": score,
        "cover": cover,
        "duration": duration,
        "budget": budget,
        "recommendations": recommendations,
        "idcategory": idcategory,
        "idcountry": idcountry,
        "idstate": idstate,
        "idcity": idcity,
    };
}