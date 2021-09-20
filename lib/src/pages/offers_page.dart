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
      _offer('https://scontent-mia3-1.xx.fbcdn.net/v/t1.6435-9/228863650_2925651757676343_2482445850995764283_n.jpg?_nc_cat=100&ccb=1-5&_nc_sid=730e14&_nc_ohc=1ymdC-3UtdMAX_Iu-lx&_nc_ht=scontent-mia3-1.xx&oh=7a7d2baefa385824f22900d6b5528bf1&oe=616BDB8E'),
      SizedBox(height: 20.0,),
      _offer('https://scontent-mia3-1.xx.fbcdn.net/v/t1.6435-9/229198922_2923772724530913_5528591209936415093_n.jpg?_nc_cat=100&ccb=1-5&_nc_sid=730e14&_nc_ohc=k04cynmzLf4AX9bb8D8&tn=8ADJkxdl2lOQ7rEb&_nc_ht=scontent-mia3-1.xx&oh=08fe64f5b18f5939897e652a3f574cd8&oe=616C3B07'),
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