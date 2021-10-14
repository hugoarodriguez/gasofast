import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
//import 'package:firebase_core/firebase_core.dart' as firebase_core;

//import 'package:gasofast/src/preferencias_usuario/preferencias_usuario.dart';

class UsuarioProvider{
  
  firebase_auth.FirebaseAuth auth = firebase_auth.FirebaseAuth.instance;
  get currentUser => auth.currentUser;

  final String _firebaseKey = 'AIzaSyBxPFBtYCmHetoMmlAoYRssQRsoGlCavgg';
  //final _prefs = new PreferenciasUsuario();

  Future<Map<String, dynamic>> login(String? email, String? password) async {
    print('Email $email');
    print('Password: $password');

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

  Future<Map<String, dynamic>> nuevoUsuario(String email, String password) async {

    final authData = {
      'email'     : email,
      'password'  : password,
      'returnSecureToken' : true
    };
    
    final resp = await http.post(
      Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseKey'),
      body: json.encode(authData)
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    if(decodedResp.containsKey('idToken')){
      
      //_prefs.token = decodedResp['idToken'];

      return { 'ok': true, 'token': decodedResp['idToken'] };
    } else {
      return { 'ok': false, 'mensaje': decodedResp['error']['message']};
    }
  }

  //Cerrar sesión
  Future signOut() async {
    await auth.signOut();
  }
}