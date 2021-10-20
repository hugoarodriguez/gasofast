import 'package:flutter/material.dart';

import 'package:gasofast/src/utils/colors_utils.dart';

class OffersPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorAzulOscuro(),),
          onPressed: () => Navigator.of(context).pop()
        ),
        title: Text('Ofertas', style: TextStyle(color: colorAzulOscuro()),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: _content(),
      ),
    );
  }
}

Widget _content(){
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Text('Texaco Caribe', textAlign: TextAlign.center,style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold ),),
        ),
        _offers()
      ],
    ),
  );
}

Widget _offers(){
  return Column(
    children: <Widget>[
      _offer('https://firebasestorage.googleapis.com/v0/b/gasofastf.appspot.com/o/offers%2Ftexaco%2FPromocionJuega.png?alt=media&token=de17f92d-827e-4dbd-966c-4cd84fd3fc76'),
      SizedBox(height: 20.0,),
      _offer('https://firebasestorage.googleapis.com/v0/b/gasofastf.appspot.com/o/offers%2Ftexaco%2FPuntosTexaco.jpg?alt=media&token=90acc4f6-09fb-42da-981d-50667d24610b'),
      SizedBox(height: 20.0,),
    ],
  );
}

Widget _offer(String imageUrl){
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 40.0),
    color: colorCeleste(),
    elevation: 5.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    child: Container(
      width: 300.0,
      height: 300.0,
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: IconButton(
        icon: Image(
          image: NetworkImage(imageUrl),
        ),
        onPressed: (){
          //Añadir función para expandir imagen en toda la pantalla
          print('Oferta Seleccionada');
        },
      )
    ),
  );
}