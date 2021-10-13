

import 'dart:async';

class Validators{
  final validarEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink){

      //Patrón para comparar el email
      String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

      RegExp regExp = new RegExp(pattern);

      if(regExp.hasMatch(email)){
        sink.add(email);
      } else {
        sink.addError('Formato de correo incorrecto');
      }
    }
  );

  final validarPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink){
      //Patrón para comparar la contraseña
      String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
      
      RegExp regExp = new RegExp(pattern);

      if(regExp.hasMatch(password)){
        sink.add(password);
      } else {
        sink.addError('Formato de contraseña incorrecto');
      }
    }
  );
}