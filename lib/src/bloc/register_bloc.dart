
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:selftourapp/src/bloc/validators.dart';

class RegisterBloc with Validators implements Bloc{

  final _nameController = BehaviorSubject<String>();
  final _mailController = BehaviorSubject<String>();
  final _passController = BehaviorSubject<String>();
  final _passConfirmController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();

  Stream<String> get nameStream => _nameController.stream;
  Stream<String> get mailStream => _mailController.stream.transform(validarEmail);
  Stream<String> get passStream => _passController.stream.transform(validarPassword);
  Stream<String> get passConfirm => _passConfirmController.stream;
  Stream<String> get phoneStream => _phoneController.stream;

  Stream<bool> get formValidStreamReg =>
    Observable.combineLatest4(nameStream, mailStream, passStream, phoneStream, (n,m,p,tel)=>true);
  
  //Insertar valores al stream
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeMail => _mailController.sink.add;
  Function(String) get changePass => _passController.sink.add;
  Function(String) get changePassConfirm => _passConfirmController.sink.add;
  Function(String) get changePhone => _phoneController.sink.add;

  //obtener el ultimo valor ingresado a los streams
  String get name => _nameController.value;
  String get mail => _mailController.value;
  String get pass => _passController.value;
  String get passConf => _passConfirmController.value;
  String get phone => _phoneController.value;

  //Cerrar los controladores cuando ya no se necesiten
  @override
  void dispose() {
    _nameController?.close();
    _mailController?.close();
    _passController?.close();
    _passConfirmController?.close();
    _phoneController?.close();
  }

}