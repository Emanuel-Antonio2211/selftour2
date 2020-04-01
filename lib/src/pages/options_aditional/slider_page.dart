import 'package:flutter/material.dart';
//import 'package:generic_bloc_provider/generic_bloc_provider.dart';
//import 'package:selfttour/src/bloc/provider.dart';
//import 'package:flutter_swiper/flutter_swiper.dart';
//import 'package:intro_views_flutter/Models/page_view_model.dart';
//import 'package:page_slider/page_slider.dart';
//import 'package:advanced_page_slider/advanced_page_slider.dart';

//import 'package:transformer_page_view/transformer_page_view.dart';

import 'package:selftourapp/src/pages/options_aditional/app_theme_page.dart';
import 'package:selftourapp/src/pages/options_aditional/news_device_page.dart';
import 'package:selftourapp/src/pages/options_aditional/news_domains_place.dart';
//import 'package:selfttour/src/providers/usuario_provider.dart';

class SliderOptionsPage extends StatefulWidget {
  @override
  _SliderOptionsPageState createState() => _SliderOptionsPageState();
}

class _SliderOptionsPageState extends State<SliderOptionsPage> {
  //LoginBloc userBloc;
  //final usuarioProvider = new UsuarioProvider();

  final items = <Widget>[
    NewsDevicePage(),
    NewsDomainsPlacePage(),
    AppThemePage()
  ];

  //List<String> data=["aa","bb","cc","dd","ee","ff","gg","hh","ii","jj"];

  @override
  Widget build(BuildContext context) {
    //userBloc = BlocProvider.of<LoginBloc>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF034485), //Colors.greenAccent,
      body: DefaultTabController(
        length: items.length,
        child: Builder(
            builder: (BuildContext context) => Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: IconTheme(
                            data: IconThemeData(
                              size: 50.0,
                              //color: Colors.deepPurple,
                            ),
                            child: TabBarView(children: <Widget>[
                              NewsDevicePage(),
                              NewsDomainsPlacePage(),
                              AppThemePage()
                            ])),
                      ),
                      TabPageSelector(
                        indicatorSize: 15.0,
                        color: Colors.transparent,
                        selectedColor: Colors.white,
                      ),
                      SizedBox(height: size.height * 0.03,)
                    ],
                  ),
                )),
      ),
    );
  }
}

/*






*/
