import 'package:flutter/material.dart';
import 'package:gasofast/src/utils/utils.dart';

class RecoverAccountPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _backButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Stack(
        children: <Widget>[
          crearFondo(context),
          _recoverAccountForm(context)
        ],
      ),
    );
  }
}

//Botón para regresar a la pantalla del Login
Widget _backButton(BuildContext context){
  return FloatingActionButton(
    elevation: 0.0,
    backgroundColor: Colors.transparent,
    child: Icon(Icons.arrow_back),
    onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
  );
}

//Widget que contiene todo el formulario Login
Widget _recoverAccountForm(BuildContext context){

  final textIndication1 = '''Ingresa el correo electrónico con el que te registraste y se te enviará una solicitud para que cambies tu contraseña.\n\n
Posteriormente tendrás que iniciar sesión con tu nueva contraseña''';

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
              Text('Recuperar Cuenta', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold )),
                SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(textIndication1, 
                  )
                ),
                SizedBox(height: 20.0),
                _crearEmail(),
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
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0 ),
        child: Text('Enviar Solicitud', style: TextStyle(color: Colors.black) ,),
      ),
      style: estiloBoton,
      onPressed: (){},
    ),
  );
}