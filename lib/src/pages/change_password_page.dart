import 'package:flutter/material.dart';
import 'package:gasofast/src/utils/utils.dart';

class ChangePasswordPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _backButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Stack(
        children: <Widget>[
          crearFondo(context),
          _changePasswordForm(context)
        ],
      ),
    );
  }
}

//Botón para regresar a la pantalla de Inicio
Widget _backButton(BuildContext context){
  return FloatingActionButton(
    elevation: 0.0,
    backgroundColor: Colors.transparent,
    child: Icon(Icons.arrow_back),
    onPressed: () => Navigator.of(context).pop(),
  );
}

//Widget que contiene todo el formulario Login
Widget _changePasswordForm(BuildContext context){
  final size = MediaQuery.of(context).size;

  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        SafeArea(
          child: Container(
            height: 120.0,
          ),
        ),

        Container(
          width: size.width * 0.85,
          margin: EdgeInsets.only(top: 30.0, bottom: 5.0),
          padding: EdgeInsets.symmetric(vertical: 30.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(219, 226, 239, 1.0),
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black26,
                blurRadius: 3.0,
                offset: Offset(0.0, 5.0),
                spreadRadius: 3.0
              )
            ]
          ),
          child: Column(
            children: <Widget>[
              Text('Cambiar Contraseña', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold )),
                SizedBox(height: 10.0),
                _crearPasswordA(),
                SizedBox(height: 20.0),
                _crearPasswordN(),
                SizedBox(height: 20.0),
                _crearPasswordNC(),
                SizedBox(height: 20.0),
                _crearButton(),
                SizedBox(height: 10.0),
            ],
          ),
        ),

      ],
    ),
  );

}

//Widget para el TextField de la PasswordA
Widget _crearPasswordA(){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    child: TextField(
      obscureText: true,
      decoration: InputDecoration(
        icon: Icon(Icons.lock_outline_rounded),
        labelText: 'Contraseña actual',
      )
    ),
  );
}

//Widget para el TextField de la PasswordN
Widget _crearPasswordN(){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    child: TextField(
      obscureText: true,
      decoration: InputDecoration(
        icon: Icon(Icons.lock_outline_rounded),
        labelText: 'Contraseña nueva',
      )
    ),
  );
}

//Widget para el TextField de la Password
Widget _crearPasswordNC(){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    child: TextField(
      obscureText: true,
      decoration: InputDecoration(
        icon: Icon(Icons.lock_outline_rounded),
        labelText: 'Repetir contraseña nueva',
      )
    ),
  );
}

//Widget para el ElevatedButton de Ingresar
Widget _crearButton(){

  final estiloBoton = ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled))
            return Colors.grey;//Color si está deshabilitado
          return Colors.white; //Color si está habilitado
        },
      ),
      elevation: MaterialStateProperty.all<double>(10.0),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))
    );

  return Container(
    child: ElevatedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 15.0 ),
        child: Text('Cambiar', style: TextStyle(color: Colors.black) ,),
      ),
      style: estiloBoton,
      onPressed: (){},
    ),
  );
}