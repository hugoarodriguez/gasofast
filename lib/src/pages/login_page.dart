import 'package:flutter/material.dart';
import 'package:gasofast/src/utils/utils.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          crearFondo(context),
          _loginForm(context)
        ],
      ),
    );
  }
}

//Widget que contiene todo el formulario Login
Widget _loginForm(BuildContext context){
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
              Text('Login', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold )),
                SizedBox(height: 10.0),
                _crearEmail(),
                SizedBox(height: 20.0),
                _crearPassword(),
                SizedBox(height: 20.0),
                _crearButton(context),
                SizedBox(height: 10.0),
            ],
          ),
        ),

        TextButton(
          child: Text('¿No tienes una cuenta?', style: TextStyle(color: Colors.white ),),
          onPressed: () => Navigator.pushReplacementNamed(context, 'signup')
        ),
        TextButton(
          child: Text('¿Olvidaste tu contraseña?', style: TextStyle(color: Colors.white ),),
          onPressed: () => Navigator.pushReplacementNamed(context, 'recoveracc')
        ),

      ],
    ),
  );

}

//Widget para el TextField del Email
Widget _crearEmail(){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    child: TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        icon: Icon(Icons.alternate_email_rounded),
        hintText: 'ejemplo@correo.com',
        labelText: 'Correo',
      )
    ),
  );
}

//Widget para el TextField de la Password
Widget _crearPassword(){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    child: TextField(
      obscureText: true,
      decoration: InputDecoration(
        icon: Icon(Icons.lock_outline_rounded),
        labelText: 'Contraseña',
      )
    ),
  );
}

//Widget para el ElevatedButton de Ingresar
Widget _crearButton(BuildContext context){

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
        child: Text('Ingresar', style: TextStyle(color: Colors.black) ,),
      ),
      style: estiloBoton,
      //TODO: Cambiar por Navigator.pushReplacementNamed(context, 'favorites'),
      onPressed: () => Navigator.pushNamed(context, 'locations'),
    ),
  );
}