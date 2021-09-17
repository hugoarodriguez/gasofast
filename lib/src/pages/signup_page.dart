import 'package:flutter/material.dart';
import 'package:gasofast/src/utils/utils.dart';

class SignUpPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _backButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Stack(
        children: <Widget>[
          crearFondo(context),
          _signUpForm(context)
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
Widget _signUpForm(BuildContext context){
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
              Text('Sign Up', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold )),
                SizedBox(height: 10.0),
                _crearEmail(),
                SizedBox(height: 20.0),
                _crearPassword(),
                SizedBox(height: 20.0),
                _crearPasswordC(),
                SizedBox(height: 20.0),
                _crearButton(),
                SizedBox(height: 10.0),
            ],
          ),
        ),

        _crearRegistroOpciones(),

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

//Widget para el TextField de la confirmación de la Password
Widget _crearPasswordC(){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    child: TextField(
      obscureText: true,
      decoration: InputDecoration(
        icon: Icon(Icons.lock_outline_rounded),
        labelText: 'Repetir Contraseña',
      )
    ),
  );
}

//Widget para el ElevatedButton de Registrar
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
        child: Text('Registrarme', style: TextStyle(color: Colors.black) ,),
      ),
      style: estiloBoton,
      onPressed: (){},
    ),
  );
}

Widget _crearRegistroOpciones(){
  final textHeader =  Container(
    child: Text('Prefiero registrarme con:', style: TextStyle(color: Colors.white), )
  );

  final googleButton = ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Container(
            color: Color.fromRGBO(17, 45, 78, 1.0),
            child: IconButton(
              icon: Image(
                image: AssetImage('assets/images/google_logo.png'),
                width: 32.0,
                height: 32.0,
                fit: BoxFit.cover,
              ),
              onPressed: (){},
            ),
          ),
        );
  
  final facebookButton = ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Container(
            color: Color.fromRGBO(17, 45, 78, 1.0),
            child: IconButton(
              icon: Image(
                image: AssetImage('assets/images/facebook_logo.png'),
                width: 32.0,
                height: 32.0,
                fit: BoxFit.cover,
              ),
              onPressed: (){},
            ),
          ),
        );

  return Container(
    padding: EdgeInsets.symmetric(vertical: 15.0),
    child: Column(
      children: [
        textHeader,
        SizedBox(height: 10.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            googleButton,
            SizedBox(width: 20.0,),
            facebookButton
          ],
        ),
      ],
    ),
  );
}