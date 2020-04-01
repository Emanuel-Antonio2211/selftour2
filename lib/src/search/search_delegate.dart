import 'package:flutter/material.dart';
import 'package:selftourapp/src/models/tour_categoria_model.dart';
//import 'package:selfttour/src/models/tour_model.dart';
import 'package:selftourapp/src/providers/categorias_providers.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';


class DataSearch extends SearchDelegate{
 /* @override
  ThemeData appBarTheme(BuildContext context){
    ThemeData theme = Theme.of(context);
    return theme;
  }*/

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme;
  }
  
  //Cuando hago click en el elemento(listado)
  String seleccion = '';
  //Se crea una instancia de categorias provider,donde se encuentra el método
  //que se encarga de obtener la lista de tours
   CategoriasProvider categorias = new CategoriasProvider();
  /*final tours = [
    'Chichen Itza',
    'Celestun',
    'Izamal',
    'Merida'
  ];*/

  final toursRecientes = [
    'Izamal',
    'Merida'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro AppBar
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: Colors.black,
        ),
        onPressed: (){
          print('Click!!!!');
          query = '';
        },
      ),
      
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        color: Colors.black,
        //El tiempo que se va a animar el ícono
        progress: transitionAnimation
      ),
      onPressed: (){
        print('Leading Icon');
        //Regresa a la página de la busqueda
        close(context,null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    
    return //Container();
    
    /*FutureBuilder(
      future: categorias.verTours(),
      builder: (BuildContext context, AsyncSnapshot<List<InfoTour>> snapshot) {
        if(snapshot.hasData){
          final tours = snapshot.data;
          return ListView(
            children: tours.map((tour){
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(tour.gallery.toString()),
                  placeholder: AssetImage('assets/no-image.jpg'),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(tour.title !=null ? tour.title:''),
                onTap: (){
                  //Se cierra la búsqueda primero
                  close(context, null);
                  //tour.uniqueid='';
                  Navigator.pushNamed(context, 'detalletour',arguments: tour);
                },
              );
            }).toList(),
          );
        }else{
        return Center(
          child: Text('No hay información'),
        ) ;
        }
      },
    );*/
    
    /*Center(
      child: Container(
        width: 100.0,
        height: 100.0,
        color: Colors.blueAccent,
        //Elemento al que se le hizo click
        child: Text(seleccion),
      ),
    );*/

    FutureBuilder(
      future: categorias.buscarTours(query),//categorias.buscarTours(query)
      builder: (BuildContext context, AsyncSnapshot<List<InfoTour>> snapshot) {
        final size = MediaQuery.of(context).size;
       // categorias.buscarTours(query);
        if(snapshot.hasData){
          final tours = snapshot.data;
          return ListView(
            children: tours.map((tour){
              return GestureDetector(
                onTap: (){
                  //Se cierra la búsqueda primero
                  close(context, null);
                  //tour.uniqueid='';
                  Navigator.pushNamed(context, 'detalletour',arguments: tour);
                },
                child: Card(
                  child: Container(
                    width: size.width * 1.0,
                    height: size.height * 0.2,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Image.network(
                              tour.gallery.toString(),
                              width: size.width * 0.5,
                              height: size.height * 0.15,
                              fit: BoxFit.fill,
                              scale: 1.0,
                            )
                          ),
                          SizedBox(
                            width: size.width * 0.04,
                          ),
                          Flexible(
                            child: Text( tour.title != null ? 
                              "${tour.title}":'',
                              style: TextStyle(fontFamily: 'Point-SemiBold'),
                            ),
                          ),
                            /*Column(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SafeArea(
                                child: SizedBox(
                                  height: size.height * 0.02,
                                ),
                              ),
                              
                            /* Row(
                                children: <Widget>[
                                  Icon(Icons.place),
                                ],
                              )*/
                            ],
                          ),*/
                        ],
                      ),
                    ),
                    
                   /* ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: FadeInImage(
                          image: NetworkImage(tour.gallery.toString()),
                          placeholder: AssetImage('assets/loading.gif'),
                          width: size.width * 0.4,
                          height: size.height * 0.2,
                          fit: BoxFit.fill,
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text( tour.title != null ? 
                              "${tour.title}":'',
                              style: TextStyle(fontFamily: 'Point-SemiBold'),
                            ),
                          ),
                         /* Row(
                            children: <Widget>[
                              Icon(Icons.place),
                            ],
                          )*/
                        ],
                      ),
                      onTap: (){
                        //Se cierra la búsqueda primero
                        close(context, null);
                        //tour.uniqueid='';
                        Navigator.pushNamed(context, 'detalletour',arguments: tour);
                      },
                    ),*/
                  ),
                ),
              );
            }).toList(),
          );
        }else{
        return Center(
          child: CircularProgressIndicator(),
        ) ;
        }
      },
    );
    
    /*Center(
      child: Container(
        width: 100.0,
        height: 100.0,
        color: Colors.blueAccent,
        //Elemento al que se le hizo click
        child: Text(seleccion),
      ),
    );*/
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe
   // categorias.buscarTours(query);
    //Aplicar el filtro a un listado para que ese sea el que se muestre
    //Cada vez que la persona escribe, la propiedad query va cambiando
   /* if(query.isEmpty){
      return FutureBuilder(
      future: categorias.getTours(),
      builder: (BuildContext context, AsyncSnapshot<List<InfoTour>> snapshot) {
       final size = MediaQuery.of(context).size;
        if(snapshot.hasData){
          final tours = snapshot.data;
          return ListView(
            children: tours.map((tour){
              return Card(
                child: Container(
                  height: size.height * 0.15,
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: FadeInImage(
                        image: NetworkImage(tour.gallery.toString()),
                        placeholder: AssetImage('assets/loading.gif'),
                        width: size.width * 0.4,
                        height: size.height * 0.2,
                        fit: BoxFit.fill,
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: size.width * 0.23,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: size.width * 0.2,
                              decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Text(
                                "\$ ${tour.price.toString()}",
                                style: TextStyle(
                                  fontFamily: 'Point-SemiBold',
                                  color: Colors.white
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${tour.title}",
                          style: TextStyle(fontFamily: 'Point-SemiBold'),
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.place,
                              color: Colors.grey,
                            ),
                            Text(
                              "${tour.country}",
                              style: TextStyle(fontFamily: 'Point-SemiBold'),
                            )
                          ],
                        )
                      ],
                    ),
                    onTap: (){
                      //Se cierra la búsqueda primero
                      close(context, null);
                      //tour.uniqueid='';
                      Navigator.pushNamed(context, 'detalletour',arguments: tour);
                    },
                  ),
                ),
              );
            }).toList(),
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
    }else{
      
    }*/

    return FutureBuilder(
      future: categorias.buscarTours(query),
      builder: (BuildContext context, AsyncSnapshot<List<InfoTour>> snapshot) {
        final size = MediaQuery.of(context).size;
        String noDatos = AppTranslations.of(context).text('title_nodata');
        if(snapshot.hasData){
          final tours = snapshot.data;
          return ListView(
            children: tours.map((tour){
              return GestureDetector(
                onTap: (){
                  //Se cierra la búsqueda primero
                  close(context, null);
                  //showResults(context);
                  Navigator.pushNamed(context, 'detalletour',arguments: tour);
                },
                child: Card(
                  child: Container(
                    width: size.width * 1.0,
                    height: size.height * 0.15,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Image.network(
                              tour.gallery.toString(),
                              width: 160.0,
                              height: 90.0,
                              fit: BoxFit.fill,
                              scale: 1.0,
                            )
                          ),
                          SizedBox(
                            width: size.width * 0.04,
                          ),
                          Flexible(
                            child: Text( tour.title != null ?
                              "${tour.title}":'',
                              style: TextStyle(fontFamily: 'Point-SemiBold'),
                            ),
                          ),
                        ],
                      ),
                    )
                    
                    /*ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: FadeInImage(
                            image: NetworkImage(tour.gallery.toString()),
                            placeholder: AssetImage('assets/loading.gif'),
                            width: 160.0,
                            height: 80.0,
                            fit: BoxFit.cover,
                          ),
                      ),
                      
                      title: Text( tour.title != null ?
                        "${tour.title}":'',
                        style: TextStyle(fontFamily: 'Point-SemiBold'),
                      ),
                      onTap: (){
                        //Se cierra la búsqueda primero
                        close(context, null);
                        //showResults(context);
                        Navigator.pushNamed(context, 'detalletour',arguments: tour);
                      },
                    ),*/
                  ),
                ),
              );
            }).toList(),
          );
        }else{
        return Center(
          child: Text('$noDatos'),
        ) ;
        }
      },
    );
    
  }

  /*@override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe

    //Aplicar el filtro a un listado para que ese sea el que se muestre
    //Cada vez que la persona escribe, la propiedad query va cambiando
    final listaSugerida = (query.isEmpty) 
                            ? toursRecientes
                            : tours.where((t)=>t.toLowerCase().startsWith(query.toLowerCase())
                            ).toList();
    return ListView.builder(
      itemCount: listaSugerida.length,
      itemBuilder: (context,i){
      return ListTile(
          leading: Icon(Icons.card_travel),
          title: Text(listaSugerida[i]),
          onTap: (){
            seleccion = listaSugerida[i];
            //Llamamos una instrucción que construye el resultado
            showResults(context);
          },
        );
      },
    );
  }*/

}