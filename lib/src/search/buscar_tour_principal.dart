import 'package:flutter/material.dart';
import 'package:selftourapp/src/models/tour_categoria_model.dart';
//import 'package:selfttour/src/models/tour_categoria_model.dart';
import 'package:selftourapp/src/providers/categorias_providers.dart';
import 'package:selftourapp/src/translation_class/app_translations.dart';

class BuscarTour extends SearchDelegate{
  
  //Cuando se hace click en el elemento de la lista, resultado del filtro de búsqueda
  String seleccion = '';
  //Se crea una instancia de la clase categoriasprovider, donde se invoca al método
  //que regresa el listado de tours
  final CategoriasProvider _categoriasProvider = new CategoriasProvider();
  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestra AppBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
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
    // Crea los resultados que se va a mostrar
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe
     //Aplicar el filtro a un listado para que ese sea el que se muestre
    //Cada vez que la persona escribe, la propiedad query va cambiando
    if(query.isEmpty){
      return Container();
    }
    return FutureBuilder(
      future: _categoriasProvider.buscarTours(query),
      builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot) {
        String noDatos = AppTranslations.of(context).text('title_nodata');
        final size = MediaQuery.of(context).size;
        if(snapshot.hasData){
          final tours = snapshot.data;
          if(tours.containsKey('msg')){
            return Column(
              children: <Widget>[
                SizedBox(
                  height: size.height * 0.24,
                ),
                Center(
                  child: Text(
                    "$noDatos",
                    style: TextStyle(
                      fontFamily: 'Point-SemiBold'
                    ),
                  ),
                )
              ],
            );
          }else{
            final tourEncontrado = new ListaToursC.fromJsonList(snapshot.data['tour']);
            return ListView(
              children: tourEncontrado.itemsTours.map((tour){
                return ListTile(
                  /*leading: FadeInImage(
                    image: NetworkImage(tour.gallery),
                    placeholder: AssetImage('assets/no-image.jpg'),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),*/
                  title: Text(tour.title),
                  onTap: (){
                    //Se cierra la búsqueda primero
                    close(context, null);
                    //tour.uniqueid='';
                    Navigator.pushNamed(context, 'detalletour',/*arguments: tour*/);
                  },
                );
              }).toList(),
            );
          }
        }else{
        return Center(
          child: CircularProgressIndicator(),
        ) ;
        }
      },
    );
  }

}