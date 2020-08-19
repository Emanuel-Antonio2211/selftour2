// Generated by https://quicktype.io
//Esta clase sirve de contenedor de todos los tours que se
//manejen

//import 'dart:ffi';

class ListaToursC{
  //Esta lista va a contener todos los tours mapeados en el método
  //constructor fromJsonList
  List<InfoTour> itemsTours = new List();
  ListaToursC();
  //Este constructor recibe todas las respuestas del mapa
  //Se espera recibir la lista de tours
  ListaToursC.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null){
      return;
    }
    for(var item in jsonList){
      final tour = new InfoTour.fromJsonMap(item);
      //La lista items va a contener la lista de tours recorridos
      itemsTours.add(tour);
    }
  }
}

class InfoTour {
  bool guardado;

  dynamic icon;
  dynamic ctidss;

  int idtour;
  int idt;
  int iduser;
  Map<String,dynamic> userData;
  String user;
  String name;
  String title = '';
  String creation_date;
  int idMaker;
  String tourMaker;
  String description;
  int shop;
  String fulldescription;
  Map<String,dynamic> characteristics;
  String requeriments;
  int score;
  Map<String,dynamic> duration;
  String budget = '0.0';
  dynamic price;
  int purchases;
  String cover;
  String nameCategory;
  String category;
  String idCity;
  String city;
  Map<String,dynamic> ciudad;
  String region;
  String state;
  String country;
  String foto;
  //List<String> galeriaFotos;
  String gallery;
  String map_tour;
  Map<String,dynamic> temporada;
  //List picture;
  String picture;
  List route;
  List latlng;
  bool comprado = false;
  int favorite;
  int total_comment;

  //populares
  int totalcom;

  //Lugares cercanos
  int idroute;
  String title_route;
  String description_route;
  double latitude;
  double longitude;
  double distance;
  double lat;
  double lng;

  //shoppingtour
  int idsell;
  String client;
  dynamic total;
  String met_pay;
  String datesell;
  String url;


  InfoTour({
    this.guardado = false,
    this.icon,
    this.ctidss,
    this.idtour,
    this.idt,
    this.iduser,
    this.user,
    this.userData,
    this.name,
    this.title,
    this.creation_date,
    this.idMaker,
    this.tourMaker,
    this.description,
    this.shop,
    this.fulldescription,
    this.characteristics,
    this.requeriments,
    this.score,
    this.duration,
    this.purchases,
    this.budget,
    this.price,
    this.cover,
    this.nameCategory,
    this.category,
    this.idCity,
    this.city,
    this.ciudad,
    this.region,
    this.state,
    this.country,
    this.foto,
    this.gallery,
    //this.galeriaFotos,
    this.map_tour,
    this.temporada,
    this.picture,
    this.route,
    this.latlng,
    this.comprado,
    this.favorite,
    this.total_comment,

    //populares
    this.totalcom,

    this.idroute,
    this.title_route,
    this.description_route,
    this.latitude,
    this.longitude,
    this.lat,
    this.lng,
    this.distance,

    //Shopping tour
    
  });

  //Voy a llamar cuando quiero generar una instancia que viene en un mapa
  // en formato json
  InfoTour.fromJsonMap(Map<String,dynamic> json){
    idtour        = json['idtour'];
    idt           = json['_idt'];
    iduser        = json['iduser'];
    //user          = json['user'];
    userData      = json['user_data'];
    name          = json['name'];
    title         = json['title'];
    creation_date = json['creation_date'];
    idMaker       = json['_idmaker'];
    tourMaker     = json['tourmaker'];
    description   = json['description'];
    shop          = json['shop'];
    fulldescription = json['full_description'];
    characteristics = json['characteristic'];
    requeriments = json['requeriments_tour'];
    score         = json['score'];
    duration      = json['tour_duration'];
    budget        = json['budget'];
    price         = json['price'];
    purchases     = json['purchases'];
    cover         = json['cover'];
    nameCategory  = json['name_category'];
    icon          = json['icon'];
    ctidss        = json['ctidss'];
    category      = json['category'];
    idCity        = json['idcity'];
    city          = json['location'];//['location_ids']
    ciudad        = json['location_ids'];
    region        = json['state or region'];
    state         = json['state'];
    country       = json['country'];
    foto          = json['photo'];
    gallery       = json['gallery'];
    
    map_tour      = json['map_tour'];
    temporada     = json['days_and_season'];
    picture       = json['picture'];
    route         = json['sites'];
    latlng        = json['latlng'];
    comprado      = json['comprado'];
    favorite      = json['favorite'];
    total_comment = json['totalcomment'];

    //populares
    totalcom      = json['totalcom'];

    idroute       = json['idroute'];
    title_route   = json['title_route'];
    description_route = json['description_route'];
    latitude      = json['latitude'];
    longitude     = json['longitude'];
    lat           = json['lat'];
    lng           = json['lng'];
    //distance      = json['distance'];

    //ShoppingTour
    idsell        = json['_idsell'];
    client        = json['client'];
    total         = json['total'];
    met_pay       = json['met_pay'];
    datesell      = json['datesell'];
    url           = json['url'];
  }

  Map<String, dynamic> toJson() => {
        "idtour":idtour,
        "title": title,
        "description": description,
        "score": score,
        "cover": cover,
        "duration": duration,
        "budget": budget,
        //"recommendations": recomendation,
        "idcategory": nameCategory,
        "idcountry": country,
        "idstate": region,
        "idcity": city,
    };
  //Método para obtener las imágenes de la lista de tours por categoria
  getImageToursCategoria(){
    print(cover);
    if(cover== null){
      return 'https://cdn.samsung.com/etc/designs/smg/global/imgs/support/cont/NO_IMG_600x600.png';
    }else{
      return '${cover.toString()}';
    }
  }

  //Método para obtener las imágenes de la lista de tours por categoria
  getGalleryTourCategoria(){
    print(gallery);
    if(gallery== null){
      return 'https://cdn.samsung.com/etc/designs/smg/global/imgs/support/cont/NO_IMG_600x600.png';
    }else{
      return 
      '${gallery.toString()}';
    }
  }
}

