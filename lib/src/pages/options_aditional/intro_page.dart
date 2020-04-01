import 'package:flutter/material.dart';
import 'package:selftourapp/src/pages/options_aditional/app_theme_page.dart';
import 'package:selftourapp/src/pages/options_aditional/news_device_page.dart';
import 'package:selftourapp/src/pages/options_aditional/news_domains_place.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          NewsDevicePage(),
          NewsDomainsPlacePage(),
          AppThemePage()
        ],
      ),
    );
  }
}