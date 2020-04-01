import 'package:flutter/material.dart';
import 'package:selftourapp/src/models/creartour_model.dart';
import 'package:selftourapp/src/models/tour_categoria_model.dart';
import 'package:selftourapp/src/pages/tours/tituloTour.dart';
import 'package:selftourapp/src/providers/categorias_providers.dart';

class CreateTourPage extends StatefulWidget {
  @override
  _CreateTourPageState createState() => _CreateTourPageState();
}

class _CreateTourPageState extends State<CreateTourPage> {
  String dropdownValue = 'Elige una ciudad';
  TourModel tour = TourModel();
  final categoriaProvider = CategoriasProvider();
 // InfoTour tour = InfoTour();

  List<int> categorias = [1,2,3,4,5,6];
    int categoriaSeleccionada=1;
  List<int> paises = [1,2,3,4,5,6];
    var _paisSeleccionado = 1;
  List<int> estados = [1,2,3,4,5,6];
    var _estadoSeleccionado = 1;
  List<int> ciudades = [1,2,3,4,5,6];
    var _ciudadSeleccionada = 1;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Creación del tour'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _tituloTour(),
                _descripcionTour(),
                _duracionTour(),
                _precio(),
                _recomendaciones(),
                _categoria(context),
                _pais(),
                _estado(),
                _ciudad(),
                _botonCrearTour()
              ],
            ),
          ),
        ),
      )
    );
  }
  Widget _tituloTour(){
    return TextFormField(
      initialValue: tour.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Título del Tour'
      ),
      onSaved: (titulo)=>tour.titulo = titulo,
      validator: (titulo){
        if(titulo.length < 3){
          return 'Debes ingresar el título del tour';
        }
        return null;
      },
    );
  }
  Widget _descripcionTour(){
    return TextFormField(
      initialValue: tour.description,
      keyboardType: TextInputType.multiline,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: 'Descripción del tour'
      ),
      onSaved: (descripcion)=>tour.description = descripcion,
      validator: (descripcion){
        if(descripcion.isEmpty){
          return 'Debes ingresar la descripción';
        }
        return null;
      },
    );
  }
  Widget _duracionTour(){
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Duración del tour'
      ),
      onSaved: (duracion)=>tour.duration = duracion,
      validator: (duracion){
        if(duracion.isEmpty){
          return 'No ingresaste la duración';
        }
        final n = double.parse(duracion);
        return n.toString();
      },
    );
  }
  Widget _precio(){
   return TextFormField(
     keyboardType: TextInputType.numberWithOptions(decimal: true),
     decoration: InputDecoration(
       labelText: 'Precio del tour'
     ),
     onSaved: (precio)=>tour.budget = precio,
     validator: (precio){
       if(precio.isEmpty){
         return false.toString();
       }else{
         final n = num.tryParse(precio);
         return (n == null) ? '' : true;
       }
     },
   );
  }
  Widget _recomendaciones(){
    return TextFormField(
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        labelText: 'Recomendaciones'
      ),
      onSaved: (recomendacion)=>tour.recommendations = recomendacion,
      validator: (recomendacion){
        if(recomendacion.isEmpty){
          return 'No has ingresado la recomendación';
        }
        return recomendacion;
      },
    );
  }
  Widget _categoria(BuildContext context){
    
    return DropdownButton(
      items: tour.categoria.map((categoria){
        return DropdownMenuItem(
          value: categoria,
          child: Text(categoria.toString()),
        );
      }).toList(),
      onChanged: (int nuevaCategoriaSeleccionada){
        setState(() {
          tour.categoriaSeleccionada = nuevaCategoriaSeleccionada;
          print(tour.categoriaSeleccionada);
        });
      },
      value: tour.categoriaSeleccionada,
    );
  }
  Widget _pais(){
    
    return DropdownButton(
      items: tour.paises.map((pais){
        return DropdownMenuItem(
          value: pais,
          child: Text(pais.toString()),
        );
      }).toList(),
      onChanged: (nuevoPaisSeleccionado){
        setState(() {
          tour.paisSeleccionado = nuevoPaisSeleccionado;
        });
      },
      value: tour.paisSeleccionado,
    );
  }
  Widget _estado(){
    
    return DropdownButton(
      items: tour.estados.map((estado){
        return DropdownMenuItem(
          value: estado,
          child: Text(estado.toString()),
        );
      }).toList(),
      onChanged: (nuevoEstadoSeleccionado){
        setState(() {
          tour.estadoSeleccionado = nuevoEstadoSeleccionado;
        });
      },
      value: tour.estadoSeleccionado,
    );
  }
  Widget _ciudad(){
    
    return DropdownButton(
      items: tour.ciudades.map((ciudad){
        return DropdownMenuItem(
          value: ciudad,
          child: Text(ciudad.toString()),
        );
      }).toList(),
      onChanged: (nuevaCiudadSeleccionada){
        setState(() {
          tour.ciudadSeleccionada = nuevaCiudadSeleccionada;
        });
      },
      value: tour.ciudadSeleccionada,
    );
  }
  Widget _botonCrearTour(){
    return RaisedButton(
      color: Colors.lightBlue,
      textTheme: ButtonTextTheme.primary,
      shape: StadiumBorder(),
      onPressed: _enviar,
      child: Text('Crear Tour',style: TextStyle(color: Colors.white),),
    );
  }

  void _enviar(){
  //Sirve para validar el formulario
    if(!formKey.currentState.validate()){
      ///Cuando el formulario es válido
      return;
    }
    //Guarda los valores que estén en el formulario
    formKey.currentState.save();
    print('Tour Creado con éxito');
    print(tour.titulo);
    print(tour.description);
    print(tour.duration);
    print(tour.recommendations);
    print(tour.categoriaSeleccionada);
    print(tour.ciudadSeleccionada);
    print(tour.estadoSeleccionado);
    print(tour.paisSeleccionado);
    
    categoriaProvider.crearTour(tour);
  }
}
