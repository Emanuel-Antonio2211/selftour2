import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:selftourapp/src/models/categoria_model.dart';

class CardSwiper extends StatelessWidget {
  //Se enlista las categorias de tour
  final List<Categoria> categorias;

  CardSwiper({@required this.categorias});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        width: double.infinity,
        height: size.height * 0.2,
        child: Swiper(
              itemWidth: size.width * 0.3,
              itemHeight: size.height * 0.19,
              itemBuilder: (BuildContext context, index){
                return Card(
                  elevation: 1.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: FadeInImage(
                      //llama al método de obtener imagenes de categorias
                      //que se encuentra en el modelo de categorias
                      image: NetworkImage(categorias[index].getImageCategorias(),
                      //scale: 0.8
                      ),
                      placeholder: AssetImage('assets/no-image.jpg'),
                      fit: BoxFit.cover,
                    )
                  ),
                );
              },
              itemCount: categorias.length,
              
              viewportFraction: 0.5,
              scale: 0.9,
              
              //pagination: new SwiperPagination(),
              //control: new SwiperControl(),
              layout: SwiperLayout.DEFAULT,
            ),
        );
    
    /*Stack(
         children:<Widget>[ 
           Container(
        padding: EdgeInsets.only(top: 10.0),
        width: 800.0,
        height: 260.0,
        child: Swiper(
          
        itemBuilder: (BuildContext context,int index){
          return ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              
              child: Image.asset(
                'assets/images/beach_palm.jpeg',fit: BoxFit.fill,
                )
              
              /* Image.network("http://via.placeholder.com/350x150",
            fit: BoxFit.fill,),*/
            );
        },
        itemCount: 3,
        viewportFraction: 0.8,
        scale: 0.9,
        //pagination: new SwiperPagination(),
        //control: new SwiperControl(),
        ),
      ),
       Positioned(
             top: 200.0,
             left: 28.0,
             child: IconButton(
               iconSize: 40.0,
               icon: Icon(Icons.add_a_photo),
               onPressed: (){},
             ),
           ),
         ]
    );*/
  }


}