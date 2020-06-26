import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

/*
  Recordar instalar el paquete de:
    shared_preferences:

  Inicializar en el main
    final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();
    
    Recuerden que el main() debe de ser async {...

*/

class PreferenciasUsuario {

  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del nombre
  //Grabar el token en el dispositivo
  get token {
    return _prefs.getString('token') ?? '';
  }

  get tokenFCM{
    return _prefs.getString('tokenfcm');
  }

  get iduser {
    return _prefs.getString('iduser');
  }

  get uid {
    return _prefs.getString('uid');
  }

  get originLogin{
    return _prefs.getString('originLogin');
  }

  get name{
    return _prefs.getString('name') ?? '';
  }

  get email{
    return _prefs.getString('email') ?? '';
  }

  get phone{
    return _prefs.getString('phone') ?? '';
  }

  get photoUrl{
    return _prefs.getString('photoUrl');
  }
  get tokenVerif{
    return _prefs.getString('tokenVerif');
  }
  get idTarjeta {
    return _prefs.getString('idTarjeta');
  }

  get idCompra{
    return _prefs.getString('idCompra');
  }
  get comprado{
    return _prefs.getString('comprado');
  }
  get idtour{
    return _prefs.getString('idtour');
  }

  set token ( String value ) {
    _prefs.setString('token', value);
  }

  set tokenFCM (String value){
    _prefs.setString('tokenfcm', value);
  }

  set iduser (String value){
    _prefs.setString('iduser', value);
  }

  set uid (String value){
    _prefs.setString('uid', value);
  }

  set idsell(String value){
    _prefs.setString('idsell', value);
  }

  get idsell{
    return _prefs.getString('idsell');
  }

  set originLogin(String value){
    _prefs.setString('originLogin', value);
  }
  
  set name (String value){
    _prefs.setString('name', value);
  }

  set email (String value){
    _prefs.setString('email', value);
  }

  set phone (String value){
    _prefs.setString('phone', value);
  }

  set fNac(DateTime value){
    _prefs.setString('fNac', value.toString());
  }

  get fNac{
    return _prefs.getString('fNac');
  }

  set accountFacebook(String value){
    _prefs.setString('accountFacebook', value);
  }

  get accountFacebook{
    return _prefs.getString('accountFacebook');
  }

  set pagWeb(String value){
    _prefs.setString('pagWeb', value);
  }
  get pagWeb{
    return _prefs.getString('pagWeb');
  }

  set photoUrl(String value){
    _prefs.setString('photoUrl', value);
  }

  set photoEditar(String value){
    _prefs.setString('photoEditar', value);
  }
  get photoEditar{
    return _prefs.getString('photoEditar');
  }

  set tokenVerif (String value){
    _prefs.setString('tokenVerif', value);
  }

  set idTarjeta (String value){
    _prefs.setString('idTarjeta', value);
  }

  set idCompra (String value){
    _prefs.setString('idCompra', value);
  }

  set comprado (String value){
    _prefs.setString('comprado', value);
  }

  set idtour (String value){
    _prefs.setString('idtour', value);
  }

  set nombreTour(String value){
    _prefs.setString('nombreTour', value);
  }

  get nombreTour{
    return _prefs.getString('nombreTour');
  }

  set ciudad(String value){
    _prefs.setString('ciudad', value);
  }
  get ciudad{
    return _prefs.getString('ciudad');
  }

  set estado(String value){
    _prefs.setString('estado', value);
  }
  get estado{
    return _prefs.getString('estado');
  }

  set pais(String value){
    _prefs.setString('pais', value);
  }
  get pais{
    return _prefs.getString('pais');
  }

  set idioma(Locale value){
    _prefs.setString('idioma', value.toString());
  }

  get idioma{
    return _prefs.getString('idioma');//?? 'en'
  }

  set idiomaOriginal(Locale value){
    _prefs.setString('idiomaOriginal', value.toString());
  }

  get idiomaOriginal{
    return _prefs.getString('idiomaOriginal');
  }

  set idiomaDetalle(Locale value){
    _prefs.setString('idiomaDetalle', value.toString());
  }

  get idiomaDetalle{
    return _prefs.getString('idiomaDetalle');
  }

  set idiomaDescripcion(Locale value){
    _prefs.setString('idiomaDescripcion', value.toString());
  }

  get idiomaDescripcion{
    _prefs.getString('idiomaDescripcion');
  }

  set idiomaRecomendacion(Locale value){
    _prefs.setString('idiomaRecomendacion', value.toString());
  }
  get idiomaRecomendacion{
    _prefs.getString('idiomaRecomendacion');
  }

  set idiomaComentario(Locale value){
    _prefs.setString('idiomaComentario', value.toString());
  }
  get idiomaComentario{
    return _prefs.getString('idiomaComentario');
  }

  // GET y SET de la última página
  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'login';
  }

  set ultimaPagina( String value ) {
    _prefs.setString('ultimaPagina', value);
  }

}