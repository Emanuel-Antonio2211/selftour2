import 'package:flutter/material.dart';


class ListaGrid extends StatefulWidget {
  @override
  _ListaGridState createState() => _ListaGridState();
}

class _ListaGridState extends State<ListaGrid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista Grid'),
      ),
      body: GridView.count(
        scrollDirection: Axis.horizontal,
          // Crea una grid con 2 columnas. Si cambias el scrollDirection a
          // horizontal, esto produciría 2 filas.
          crossAxisCount: 2,
          // Genera 100 Widgets que muestran su índice en la lista
          children: 
          
          /*<Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                 ClipRRect(
                   borderRadius: BorderRadius.circular(10.0),
                   child: Image.asset('assets/images/beach.jpeg',fit: BoxFit.fill,)
                   ),
                   SizedBox(height: 20.0,),
                   Text('Bahamas',style: TextStyle(fontSize: 30.0),),
                   SizedBox(height: 20.0,),
                   Text('dsadsadsadssadasdsadsadsasdsadsaddddasdadadadadsdsdsad dsdsadasdasdasdadasdasasdad')
                ],
              ),
            ),
          ]*/
          
          List.generate(100, (index) {
            return Center(
              child: Text(
                'Item $index',
                style: Theme.of(context).textTheme.headline,
              ),
            );
          }),
        ),
    );
  }
}