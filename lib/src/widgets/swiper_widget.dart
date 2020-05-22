import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:selftourapp/src/widgets/fraction_pagination_swipe.dart';

class SwiperPaginationWidget extends SwiperPlugin{
  static const SwiperPlugin fraction = const FractionPaginationSwipe(
    activeFontSize: 25.0,
    fontFamily: 'Point-SemiBold',
    fontSize: 25.0
  ); //FractionPaginationSwipe FractionPaginationBuilder
  final Alignment alignment;
  final EdgeInsetsGeometry margin;
  final SwiperPlugin builder;
  final Key key;

  const SwiperPaginationWidget(
    {
      this.alignment,
      this.key,
      this.margin: const EdgeInsets.all(0.0),
      this.builder: SwiperPagination.fraction
    }
  );
  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    Alignment alignment = this.alignment ?? (config.scrollDirection == Axis.horizontal
     ? Alignment.bottomCenter : Alignment.centerRight);

     Widget child = Container(
       margin: margin,
       child: this.builder.build(context, config),
     );
     if(!config.outer){
       child = new Align(
         key: key,
         alignment: alignment,
         child: child,
       );
     }
     return child;
  }
}