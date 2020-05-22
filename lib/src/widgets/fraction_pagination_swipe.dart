import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class FractionPaginationSwipe extends SwiperPlugin{
  final Color color;
  final Color activeColor;
  final double fontSize;
  final double activeFontSize;
  final Key key;
  final String fontFamily;

  const FractionPaginationSwipe({
    this.color,
    this.activeColor,
    this.fontSize,
    this.activeFontSize,
    this.key,
    this.fontFamily
  });
  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    ThemeData themeData = Theme.of(context);
    Color activeColor = this.activeColor ?? themeData.primaryColor;
    Color color = this.color ?? themeData.scaffoldBackgroundColor;

    if(Axis.vertical == config.scrollDirection){
      return Column(
        key: key,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "${config.activeIndex + 1}",
            style: TextStyle(
              color: activeColor,
              fontFamily: fontFamily,
              fontSize: activeFontSize
            ),
          ),
          Text(
            " /",
            style: TextStyle(
              color: color,
              fontSize: fontSize
            )
          ),
          Text(
            "${config.itemCount}",
            style: TextStyle(
              color: color,
              fontFamily: fontFamily,
              fontSize: fontSize
            )
          )
        ],
      );
    }else{
      return Row(
        key: key,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "${config.activeIndex + 1}",
            style: TextStyle(
              color: activeColor,
              fontFamily: fontFamily,
              fontSize: activeFontSize
            ),
          ),
          Text(
            " / ",
            style: TextStyle(
              color: color,
              fontSize: fontSize
            ),
          ),
          Text(
            "${config.itemCount}",
            style: TextStyle(
              color: color,
              fontFamily: fontFamily,
              fontSize: fontSize
            )
          )
        ],
      );
    }

  }

}