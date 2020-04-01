import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:selftourapp/src/models/tour_categoria_model.dart';
class GaleriaTourPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    InfoTour tour = ModalRoute.of(context).settings.arguments;
    //InfoTour tour = new InfoTour();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading:IconButton(
            alignment: Alignment.centerLeft,
            icon: Icon(Icons.close),
            onPressed: (){
             Navigator.pop(context);
            },
          ) ,
      ),
   body: Center(
     child: Container(
       width: double.infinity,
       height: 280.0,
       child: PageView.builder(
         itemCount: tour.gallery.length,
            itemBuilder: (BuildContext context,int i){
              return  ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: new Image.network(tour.gallery[i],fit: BoxFit.fill));
            },
          ),
     ),
   )
    );
  }
}