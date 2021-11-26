import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
//import 'package:firebase_core/firebase_core.dart' as firebase_core;

//import 'package:gasofast/src/preferencias_usuario/preferencias_usuario.dart';

class UsuarioProvider{
  
  firebase_auth.FirebaseAuth auth = firebase_auth.FirebaseAuth.instance;
  get currentUser => auth.currentUser;

  //final _prefs = new PreferenciasUsuario();

  Future<Map<String, dynamic>> login(String? email, String? password) async {

    try {
      if(email != null && password != null){
        await firebase_auth.FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password
          );
        return { 'ok': true };
      } else {
        return { 'ok': false, 'mensaje': '¡Ingrese usuario y contraseña!' };
      }

      } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return { 'ok': false, 'mensaje': '¡No existe un usuario registrado con ese email!' };
      } else if (e.code == 'wrong-password') {
        return { 'ok': false, 'mensaje': '¡Contraseña incorrecta!' };
      } else {
        print('Error: ' + e.code);
      }
    }

    return { 'ok': false, 'mensaje': '¡No se pudo iniciar sesión intente mas tarde!' };
  }

  Future<Map<String, dynamic>> nuevoUsuario(String? email, String? password, String? passwordc) async {

    try {
      if(email != null && password != null && passwordc != null){
        if(password == passwordc){
          await firebase_auth.FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password
            );

          return { 'ok': true };
        } else {
          return { 'ok': false, 'mensaje': '¡Las contraseñas deben coincidir!' };
        }
      } else {
        return { 'ok': false, 'mensaje': '¡Ingrese correo, contraseña y confirme la contraseña!' };
      }

      } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return { 'ok': false, 'mensaje': '¡Ya existe un usuario registrado con ese email!' };
      } else {
        print('Error: ' + e.code);
      }
    }

    return { 'ok': false, 'mensaje': '¡No se pudo iniciar sesión intente mas tarde!' };
  }

  //Cerrar sesión
  Future signOut() async {
    await auth.signOut();
  }
}