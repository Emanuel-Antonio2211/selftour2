import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class SliderImage extends StatefulWidget {
  @override
  _SliderImageState createState() => _SliderImageState();
}

class _SliderImageState extends State<SliderImage> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SizedBox(
          height: 400.0,
          width: double.infinity,
          child: Carousel(
            boxFit: BoxFit.cover,
            //Reproduccion del slider automático
            autoplay: true,
            animationCurve: Curves.fastOutSlowIn,
            animationDuration: Duration(milliseconds: 1000),
            //Tamaño de los indicadores del slider
            dotSize: 8.0,
            //Color de los indicadores del slider
            dotIncreasedColor: Color(0xFFFF335C),
            //Color de fondo de la barra de los indicadores
            dotBgColor:Colors.transparent,
            //Posición de la barra de los indicadores
            dotPosition: DotPosition.bottomCenter,
            //Relleno vertical de la barra de indicadores
            dotVerticalPadding: 5.0,
            showIndicator: true,
            //Relleno del indicador
            indicatorBgPadding: 4.0,
            images: [
              ExactAssetImage('assets/images/beach.jpeg'),
              ExactAssetImage('assets/images/beach_palm.jpeg'),
              ExactAssetImage('assets/images/mountain_stars.jpeg'),
              ExactAssetImage('assets/images/mountain.jpeg'),
              ExactAssetImage('assets/images/river.jpeg'),
              ExactAssetImage('assets/images/sisal-01.jpg'),
              ExactAssetImage('assets/images/sunset.jpeg'),
              ExactAssetImage('assets/images/travelguy.jpg')
            ],
          ),
        ),
      ),
    );
  }
}