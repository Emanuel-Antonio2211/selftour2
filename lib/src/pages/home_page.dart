import 'package:flutter/material.dart';
//import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();

    // Initialize the Tab Controller
    controller = new TabController(length: 3, vsync: this);
  }
  @override
  void dispose() {
    // Dispose of the Tab Controller
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido',style:TextStyle(fontSize: 30.0)),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            //_swiperTarjetas()
          ],
        ),
      ),
      bottomNavigationBar: new Material(
        // set the color of the bottom navigation bar
        color: Colors.white,
        // set the tab bar as the child of bottom navigation bar
        child: new TabBar(
          //indicatorColor: Colors.white,
          tabs: <Tab>[
            new Tab(
              // set icon to the tab
              icon: new Icon(Icons.home,color: Colors.blue),
            ),
            new Tab(
              icon: new Icon(Icons.search,color: Colors.blue),
            ),
            new Tab(
              icon: new Icon(Icons.account_circle,color: Colors.blue),
            ),
          ],
          // setup the controller
          controller: controller,
        ),
      ),
    );
  }

 /* Widget _swiperTarjetas(){
    return CardSwiper(
      categorias: [1,2,3,4,5],
    );
  }*/
}