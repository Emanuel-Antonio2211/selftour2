import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:provider/provider.dart';
//import 'package:selftourapp/src/googlemaps/requests/google_maps_requests.dart';
import 'package:selftourapp/src/googlemaps/states/app_state.dart';
import 'package:selftourapp/src/models/detalle_tour_model.dart';
//import 'package:selftourapp/src/widgets/compra_tour_page.dart';

class InformacionTour extends StatelessWidget {
  final List<DetalleTour> listadetalle;
  InformacionTour({@required this.listadetalle});
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Container(
      child: ListView.builder(
        itemCount: listadetalle.length,
        itemBuilder: (context,i){
          return _detalle(context,listadetalle[i]);
        },
      ),
    );
  }

  Widget _detalle(BuildContext context, DetalleTour detalle){
    final size = MediaQuery.of(context).size;
    return Container(
      //width: double.infinity,
      height: size.height * 0.87,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
            width: size.width * 0.5, //250.0
            height: size.height * 0.34, //300.0
            child: _fotosSitio(context,detalle)
          ),
          SizedBox(),
          _tituloTour(context,detalle),
          SizedBox(
            height: size.height * 0.04,
          ),
          _ciudadTour(context,detalle),
          SizedBox(
            height: size.height * 0.03, //20.0
          ),
          _duracionTour(context,detalle),
          SizedBox(
            height: size.height * 0.03,
            child: Container(
              padding: EdgeInsets.only(left: 10.0, right: 20.0),
              child: Divider(
                color: Colors.grey,
              ),
            ),
          ),
          _datosCreadorTour(context,detalle),
          SizedBox(height: size.height * 0.03,),
          /*_botonesOpcionesUsuario(context),
          SizedBox(height: size.height * 0.03,),*/
          _botonEnlace(context),
          Column(
            children: <Widget>[

            ],
          ),
          SizedBox(
            height: size.height * 0.03,
            child: Container(
              padding: EdgeInsets.only(left: 10.0, right: 20.0),
              child: Divider(
                color: Colors.grey,
                ),
              ),
            ),
           _tituloInformacion(),
           SizedBox(
            height: size.height * 0.03,
          ),
          _parrafoInformacion(context,detalle),
          SizedBox(
            height: size.height * 0.04,
            child: Container(
              padding: EdgeInsets.only(left: 10.0, right: 20.0),
              child: Divider(
                color: Colors.grey,
              ),
            ),
          ),
          _ubicacionTour(context,detalle),
          SizedBox(
            height: size.height * 0.04,
            child: Container(
              padding: EdgeInsets.only(left: 10.0, right: 20.0),
              child: Divider(
                color: Colors.grey,
              ),
            ),
          ),
          _opiniones(context),
          SizedBox(
            height: size.height * 0.06,
            child: Container(
              padding: EdgeInsets.only(left: 10.0, right: 20.0),
              child: Divider(
                color: Colors.grey,
              ),
            ),
          ),
          _comentarios(context),
        ],
      ),

    );
  }

  Widget _tituloTour(BuildContext context,DetalleTour detalle) {
    //InfoTour tour = ModalRoute.of(context).settings.arguments;
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.6,
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      color: Color(0xFFE3E8EC),
      alignment: Alignment.center,
      child: Text(
        detalle.title,
        style: TextStyle(
            fontSize: 25.0,
            fontFamily: 'Point',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _ciudadTour(BuildContext context,DetalleTour detalle) {
    //InfoTour tour = ModalRoute.of(context).settings.arguments;
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                detalle.city.toString(),
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Source Sans Pro',
                    fontStyle: FontStyle.italic),
              ),
              SizedBox(
                width: size.width * 0.06, //40.0
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.star,
                    size: 20.0,
                    color: Colors.yellow[700],
                  ),
                  Icon(
                    Icons.star,
                    size: 20.0,
                    color: Colors.yellow[700],
                  ),
                  Icon(
                    Icons.star,
                    size: 20.0,
                    color: Colors.yellow[700],
                  ),
                  Icon(
                    Icons.star,
                    size: 20.0,
                    color: Colors.yellow[700],
                  ),
                  Icon(
                    Icons.star_half,
                    size: 20.0,
                    color: Colors.yellow[700],
                  ),
                  SizedBox(width: size.width * 0.01,),
                  Text(detalle.score.toString(),
                      style: TextStyle(
                        fontFamily: 'Neue Haas Grotesk Display Pro',
                        fontStyle: FontStyle.normal,
                      )),
                ],
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                '${detalle.city.toString()}',
                style: TextStyle(
                    fontSize: 13.0,
                    fontFamily: 'Source Sans Pro',
                    fontStyle: FontStyle.italic),
              ),
            ],
          )
        ],
      ),
      //color: Colors.red,
    );
  }

  Widget _duracionTour(BuildContext context,DetalleTour detalle) {
    //InfoTour _tour = ModalRoute.of(context).settings.arguments;
    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: size.width * 0.02),
              child: Column(
                children: <Widget>[
                  Icon(Icons.schedule,color: Colors.orange,),
                  Container(height: size.height * 0.03)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: size.width * 0.03),
              child: Column(
                children: <Widget>[
                  Text('Duración',
                      style:
                          TextStyle(fontFamily: 'Neue Haas Grotesk Display Pro')),
                  Text(
                    detalle.duration.toString(),
                    style: TextStyle(
                        fontFamily: 'Neue Haas Grotesk Display Pro',
                        color: Colors.grey[700]),
                  )
                ],
              ),
            ),
            SizedBox(width: size.width * 0.2),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Icon(Icons.attach_money,color: Colors.orange,),
                        Container(
                          height: size.height * 0.03,
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                         Text('Precio',
                              style: TextStyle(
                                fontFamily: 'Neue Haas Grotesk Display Pro'
                              ),
                            ),
                        Text(detalle.budget,
                          style: TextStyle(
                          fontFamily: 'Neue Haas Grotesk Display Pro',
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                            )
                          ),
                      ],
                    )
                  ],
                ),
                
              ],
            ),
            
          ],
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: Row(
            children: <Widget>[
              Text('Categoría: '),
              Text(detalle.category),
            ],
          ),
        )
      ],
    );
  }

  Widget _datosCreadorTour(BuildContext context, DetalleTour detalle){
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10.0),
          child: Text(
            'Tour Maker',
            style: TextStyle(
            fontSize: 15.0,
            color: Colors.black,
            fontFamily: 'Source Sans Pro',
            fontStyle: FontStyle.italic),
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Container(
          //color: Colors.black12,
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: CircleAvatar(
                    radius: 30.0,
                    child: FadeInImage(
                      width: size.width * 0.25,
                      height: size.height * 0.1,
                      image: NetworkImage(
                        'https://fotos00.levante-emv.com/mmp/2018/11/20/328x206/errores-sacar-fotos.jpg',
                            //scale: 1.0
                        ),
                      placeholder:
                        AssetImage('assets/jar-loading.gif'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            SizedBox(
              width: size.width * 0.04,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(detalle.name,
                    style: TextStyle(
                        fontFamily:
                            'Neue Haas Grotesk Display Pro'
                  )
                ),
                Text(
                  'Tipo usuario',
                  style: TextStyle(
                    fontFamily:
                        'Neue Haas Grotesk Display Pro'
                  ),
                ),
                
              ],
            ),
            SizedBox(
              width: size.width * 0.04,
            ),
            Icon(
              Icons.stars,
              color: Color(0xFFDADE0E),
            ),
            SizedBox(
              width: size.width * 0.03,
            ),
            Container(
            width: size.width * 0.3,
            child: RaisedButton(
                color: Colors.lightBlue,
                shape: StadiumBorder(),
                textTheme: ButtonTextTheme.accent,
                child: Text('Enviar Mensaje',
                style: TextStyle(
                  fontFamily: 'Source Sans Pro',
                  fontSize: 10.0,
                  color: Colors.white)),
                  onPressed: () {},
            ),
        ),
            ],
          ),
        ),
        SizedBox(height: size.height * 0.01,),
        Row(
          children: <Widget>[
            SizedBox(width: size.width * 0.15,),
            SignInButton(
              Buttons.Facebook,
              onPressed: (){},
              mini: true,
            ),
            SignInButton(
              Buttons.Twitter,
              onPressed: (){},
              mini: true,
            ),
            SignInButton(
              Buttons.Google,
              onPressed: (){},
              mini: true,
            )
          ],
        )
      ],
    );
  }

  /*
  Widget _botonesOpcionesUsuario(BuildContext context){
    final size = MediaQuery.of(context).size;
    String _valor = "COMPRADO";
    return Column(
      children: <Widget>[
        
        Container(
          width: size.width * 0.56,
          height: size.height * 0.07,
          child: RaisedButton(
            color: Color(0xFFDD5FF7),
            shape: StadiumBorder(),
            textTheme: ButtonTextTheme.primary,
            child: Text('COMPRAR',
                style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    fontSize: 15.0,
                    color: Colors.white)),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context){
                  return CompraTourPage();
                }
              ));
            },
          ),
        ),
        
        /* Container(
            width: size.width * 0.49,
            child: RaisedButton(
              color: Colors.lightBlue,
              shape: StadiumBorder(),
              textTheme: ButtonTextTheme.primary,
              child: Text('Enviar Mensaje',style: TextStyle(fontFamily: 'Source Sans Pro',fontSize: 15.0,color: Colors.white)),
              onPressed: (){},
            ),
          ),*/
      ],
    );
  }*/

  Widget _botonEnlace(BuildContext context){
    return FlatButton(
      child: Text('¿Qué obtengo al comprar el tour?'),
      onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return InfoCompra();
        },fullscreenDialog: true));
      },
    );
  }

  Widget _tituloInformacion() {
    return Center(
        child: Text(
      'Información General',
      style: TextStyle(
        fontSize: 25.0,
        fontFamily: 'Source Sans Pro',
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
      ),
    ));
  }

  Widget _parrafoInformacion(BuildContext context,DetalleTour detalle) {
    //InfoTour _tour = ModalRoute.of(context).settings.arguments;
    //final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
              detalle.description,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontFamily: 'Neue Haas Grotesk Display Pro',
                  fontStyle: FontStyle.normal)),
        ),
      ],
    );
  }

  Widget _ubicacionTour(BuildContext context,DetalleTour detalle){
   // DetalleTour tour = new DetalleTour();
   final appState = new AppState();
    //final appState =Provider.of<AppState>(context);
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10.0),
            child: Text(
              'Ubicación del Tour',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontFamily: 'Source Sans Pro',
                fontStyle: FontStyle.italic),
          ),
        ),
        SizedBox(height: size.height * 0.02),
        
        Container(
            width: size.width * 1.0,
            height: size.height * 0.5,
            child: FutureBuilder(
              future: appState.enviarReq('${detalle.route.last.toString()}'),//${detalle.city.toString()}
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(appState.lastPosition == null){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: appState.lastPosition, zoom: 9.0),
                    onMapCreated: appState.onCreated,
                    //myLocationEnabled: true,
                    mapType: MapType.normal,
                    //compassEnabled: true,
                    markers: appState.markers,
                    onCameraMove: appState.onCameraMove,
                    //polylines: appState.polyLines,
                    //mapToolbarEnabled: true,
                    rotateGesturesEnabled: true,
                    scrollGesturesEnabled: true,
                    zoomGesturesEnabled: true,
                    tiltGesturesEnabled: true,
                    //myLocationButtonEnabled: true,
            );
              },
            ),
            //Image.asset('assets/iconomapa.png',fit: BoxFit.fill,)
          ),
        Center(
          child: RaisedButton(
            child: Text('Ver más',style: TextStyle(color: Colors.white),),
            onPressed: ()async{
          /*List<LatLng> puntos = [
                
                LatLng(20.9751655,-89.6212047),
                LatLng(20.974451,-89.6231728),
                LatLng(20.9717124,-89.6256245),
                LatLng(20.9713964,-89.6250387),
                
              ];*/
              //GoogleMapsServices services = new GoogleMapsServices();
             // services.navegar();
            Navigator.pushNamed(context, 'googlemap',arguments: detalle);
            },
            color: Colors.lightBlue,
            textTheme: ButtonTextTheme.primary,
            shape: StadiumBorder(),
          ),
        )
      ],
    );
  }

  Widget _opiniones(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: size.width * 0.03),
          child: Text(
            'Opiniones',
            style: TextStyle(
                fontFamily: 'Source Sans Pro',
                color: Colors.black,
                fontStyle: FontStyle.italic,
                fontSize: 15.0),
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: size.width * 0.02,
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.star,
                  size: 20.0,
                  color: Colors.yellow[700],
                ),
                Icon(
                  Icons.star,
                  size: 20.0,
                  color: Colors.yellow[700],
                ),
                Icon(
                  Icons.star,
                  size: 20.0,
                  color: Colors.yellow[700],
                ),
                Icon(
                  Icons.star,
                  size: 20.0,
                  color: Colors.yellow[700],
                ),
                Icon(
                  Icons.star_half,
                  size: 20.0,
                  color: Colors.yellow[700],
                ),
              ],
            ),
            SizedBox(
              width: size.width * 0.02,
            ),
            Text(
              '(50)',
              style: TextStyle(
                fontFamily: 'Neue Haas Grotesk Display Pro',
              ),
            ),
            SizedBox(
              width: size.width * 0.11,
            ),
            Text(
              '4.8 de 5 estrellas',
              style: TextStyle(
                fontFamily: 'Neue Haas Grotesk Display Pro',
              ),
            )
          ],
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: size.width * 0.03,
            ),
            Text(
              '5 estrellas',
              style: TextStyle(
                fontFamily: 'Neue Haas Grotesk Display Pro',
              ),
            ),
            SizedBox(
              width: size.width * 0.04,
            ),
            Container(
                width: size.width * 0.5,
                height: size.height * 0.025,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(30.0)),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.yellow[700],
                          borderRadius: BorderRadius.circular(30.0)),
                      width: size.width * 0.4,
                      height: size.height * 0.03,
                    )
                  ],
                )),
            SizedBox(
              width: size.width * 0.06,
            ),
            Text(
              '35',
              style: TextStyle(
                fontFamily: 'Neue Haas Grotesk Display Pro',
              ),
            )
          ],
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: size.width * 0.03,
            ),
            Text(
              '4 estrellas',
              style: TextStyle(
                fontFamily: 'Neue Haas Grotesk Display Pro',
              ),
            ),
            SizedBox(
              width: size.width * 0.04,
            ),
            Container(
                width: size.width * 0.5,
                height: size.height * 0.025,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(30.0)),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.yellow[700],
                          borderRadius: BorderRadius.circular(30.0)),
                      width: size.width * 0.3,
                      height: size.height * 0.03,
                    )
                  ],
                )),
            SizedBox(
              width: size.width * 0.08,
            ),
            Text(
              '6',
              style: TextStyle(
                fontFamily: 'Neue Haas Grotesk Display Pro',
              ),
            )
          ],
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: size.width * 0.03,
            ),
            Text(
              '3 estrellas',
              style: TextStyle(
                fontFamily: 'Neue Haas Grotesk Display Pro',
              ),
            ),
            SizedBox(
              width: size.width * 0.04,
            ),
            Container(
                width: size.width * 0.5,
                height: size.height * 0.025,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(30.0)),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.yellow[700],
                          borderRadius: BorderRadius.circular(30.0)),
                      width: size.width * 0.2,
                      height: size.height * 0.03,
                    )
                  ],
                )),
            SizedBox(
              width: size.width * 0.083,
            ),
            Text(
              '5',
              style: TextStyle(
                fontFamily: 'Neue Haas Grotesk Display Pro',
              ),
            )
          ],
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: size.width * 0.03,
            ),
            Text(
              '2 estrellas',
              style: TextStyle(
                fontFamily: 'Neue Haas Grotesk Display Pro',
              ),
            ),
            SizedBox(
              width: size.width * 0.04,
            ),
            Container(
                width: size.width * 0.5,
                height: size.height * 0.025,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(30.0)),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.yellow[700],
                          borderRadius: BorderRadius.circular(30.0)),
                      width: size.width * 0.1,
                      height: size.height * 0.03,
                    )
                  ],
                )),
            SizedBox(
              width: size.width * 0.084,
            ),
            Text(
              '2',
              style: TextStyle(
                fontFamily: 'Neue Haas Grotesk Display Pro',
              ),
            )
          ],
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: size.width * 0.03,
            ),
            Text(
              '1 estrella',
              style: TextStyle(
                fontFamily: 'Neue Haas Grotesk Display Pro',
              ),
            ),
            SizedBox(
              width: size.width * 0.067,
            ),
            Container(
                width: size.width * 0.5,
                height: size.height * 0.025,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(30.0)),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.yellow[700],
                          borderRadius: BorderRadius.circular(30.0)),
                      width: size.width * 0.1,
                      height: size.height * 0.03,
                    )
                  ],
                )),
            SizedBox(
              width: size.width * 0.084,
            ),
            Text(
              '2',
              style: TextStyle(
                fontFamily: 'Neue Haas Grotesk Display Pro',
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _comentarios(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                child: FadeInImage(
                  width: size.width * 0.2,
                  image: NetworkImage('https://www.psicoactiva.com/blog/wp-content/uploads/2017/07/mujer-feliz-gorro-tatuaje.jpg'),
                  placeholder: AssetImage('assets/jar-loading.gif'),
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(width: size.width * 0.03,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Título comentario',
                      style: TextStyle(
                        fontFamily: 'Source Sans Pro',
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold
                    )
                  ),
                  Text('Fecha publicada',
                        style: TextStyle(
                          fontFamily: 'Source Sans Pro',
                          color: Colors.grey[800],
                          fontSize: 12.0
                          ),
                        )
                ],
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.star,
                size: 20.0,
                color: Colors.yellow[700],
              ),
              Icon(
                Icons.star,
                size: 20.0,
                color: Colors.yellow[700],
              ),
              Icon(
                Icons.star,
                size: 20.0,
                color: Colors.yellow[700],
              ),
              Icon(
                Icons.star,
                size: 20.0,
                color: Colors.yellow[700],
              ),
              Icon(
                Icons.star_half,
                size: 20.0,
                color: Colors.yellow[700],
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Text(
              'Enim elit esse et occaecat id aliqua nostrud. Et id cupidatat ea adipisicing proident exercitation est. Elit dolore esse anim consequat exercitation ipsum amet in officia sunt. Eu magna magna cupidatat Lorem labore incididunt qui nisi voluptate eiusmod officia tempor. Occaecat quis proident laboris aliquip ullamco. Nostrud amet in pariatur veniam elit id laboris velit reprehenderit dolore aute exercitation duis.',
              style: TextStyle(fontFamily: 'Neue Haas Grotesk Display Pro'))
        ],
      ),
    );
  }

  Widget _fotosSitio(BuildContext context,DetalleTour detalle){
    var size = MediaQuery.of(context).size;
    //InfoTour tour = ModalRoute.of(context).settings.arguments;
    //DetalleTour tour = new DetalleTour();
    return PageView.builder(
      pageSnapping: false,
      controller: PageController(
        viewportFraction: 1.0,
      ),
      //itemCount: detalle.gallery.length,
      itemBuilder: (BuildContext context,i){
        //tour.gallery[i] = '${tour.gallery[i]}-tarjeta';
        return GestureDetector(
          onTap: (){
           //Navigator.pushNamed(context, 'galeriatour');
           /* Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
              return GaleriaTourPage();
            },fullscreenDialog: true));*/
          },
          child: Card(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: FadeInImage(
                  image: NetworkImage(''),
                  placeholder: AssetImage('assets/loading.gif'),
                  fit: BoxFit.cover,
                  width: size.width * 0.5,
                  height: size.height * 0.4,
                ),
              ),
          ),
        );
      },
    );
    
   /* ListView.builder(
      scrollDirection: Axis.horizontal,
      
      itemCount: tour.gallery.length,
      itemBuilder: (BuildContext context,i){
        return Card(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: FadeInImage(
              image: NetworkImage(tour.gallery[i]),
              placeholder: AssetImage('assets/jar-loading.gif'),
              fit: BoxFit.fill,
              width: size.width * 0.5,
              height: size.height * 0.2,
            ),
          ),
        );
      }
    );*/
  }
}

class InfoCompra extends StatefulWidget {
  @override
  _InfoCompraState createState() => _InfoCompraState();
}

class _InfoCompraState extends State<InfoCompra> {
  String _texto = """
  Non id aliqua quis pariatur do id incididunt. Nostrud ipsum officia adipisicing sunt culpa officia duis aliqua amet labore eu adipisicing. Amet non aliquip excepteur cupidatat anim ipsum non excepteur. Est duis Lorem laborum aute nostrud commodo ad cupidatat cillum laboris.

Minim magna et mollit duis cillum id cupidatat. Deserunt consequat cupidatat ullamco in sint magna cillum. Est officia occaecat anim ea cillum proident ipsum cillum labore. Nulla est pariatur exercitation sint anim cupidatat est veniam laboris duis eu aute.

Adipisicing cillum et reprehenderit culpa non eiusmod nostrud minim dolor. Minim eu mollit anim ad veniam adipisicing voluptate minim magna Lorem dolor exercitation. Voluptate proident excepteur Lorem nostrud id enim excepteur deserunt magna labore proident reprehenderit. Elit ipsum sunt proident eiusmod cupidatat reprehenderit tempor ut. Pariatur exercitation ea reprehenderit irure nulla mollit in culpa sunt laborum magna. Ipsum anim magna adipisicing ad tempor occaecat minim aliquip eu laboris est eu voluptate.

Tempor dolore duis aliqua nisi nulla occaecat incididunt nisi. Deserunt sint Lorem incididunt do cillum proident dolore proident et nulla enim ipsum. Veniam in et ea aliqua.

Commodo consequat consequat ullamco aliqua ullamco consequat non cillum exercitation laborum officia. Esse cillum minim duis laboris adipisicing elit sint. Est voluptate sint sint incididunt aliquip et eiusmod incididunt exercitation cillum ut. Labore anim elit sit velit est eiusmod id. Ullamco ipsum nulla deserunt voluptate magna enim duis. Sunt dolore et esse dolore non cillum nulla nulla.

Ut occaecat deserunt sint ullamco. Elit id duis consequat aliquip laborum eu sit elit sit. Magna amet enim aute adipisicing veniam esse. Sint sint sint nostrud voluptate excepteur velit labore esse Lorem.

Et consectetur aliquip ea ut qui pariatur anim eu voluptate proident exercitation eu quis. Velit proident voluptate minim ipsum sint commodo amet duis. Non fugiat aliquip ipsum consequat officia elit do dolore laboris culpa voluptate incididunt pariatur. Enim cupidatat aute commodo anim ex exercitation pariatur et.

Lorem incididunt sunt minim non ut duis consequat esse sit reprehenderit excepteur duis do. Eiusmod magna sint ut dolor ad velit fugiat duis veniam deserunt. Exercitation ex mollit culpa qui est ad mollit. Ullamco proident occaecat cupidatat ex deserunt nisi anim irure velit enim Lorem. Proident elit quis ea ex non deserunt velit et qui. Amet culpa ea ad quis laborum et anim mollit commodo cupidatat eiusmod amet mollit sunt. Proident irure aliqua tempor quis proident ex velit quis excepteur aliqua deserunt.
  """;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: Text(_texto)
            )
          ],
        ),
      ),
    );
  }
}