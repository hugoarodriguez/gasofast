import 'package:flutter/material.dart';

import 'package:gasofast/src/bloc/login_bloc.dart';
export 'package:gasofast/src/bloc/login_bloc.dart';

class Provider extends InheritedWidget{

  final loginBloc = LoginBloc();

  static late Provider _instancia;

  factory Provider({required Key key, required Widget child}){

    _instancia = new Provider._internal(key: key, child: child);

    return _instancia;
  }

  Provider._internal({required Key key, required Widget child}) : super(key: key, child: child);

  //Sobreescribimos el método para notificar los cambios en el Widget especificado
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  //Esta función busca entre todo el árbol de Widgets y retorna la instancia del bloc 'loginBloc' basado en el 'context'
  static LoginBloc of ( BuildContext context ){
    final loginBlocN = LoginBloc();

    /*if(context.dependOnInheritedWidgetOfExactType<Provider>() != null){
      loginBlocN = context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
    }*/

    return context.dependOnInheritedWidgetOfExactType<Provider>() != null 
    ? 
    context.dependOnInheritedWidgetOfExactType<Provider>()!.loginBloc
    :
    loginBlocN;
  }

}