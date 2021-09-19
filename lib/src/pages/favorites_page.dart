import 'package:flutter/material.dart';

import 'package:gasofast/src/utils/colors_utils.dart';
import 'package:gasofast/src/utils/styles_utils.dart';

class FavoritesPage extends StatelessWidget {

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
        title: Text('Favoritos', style: TextStyle(color: colorAzulOscuro()),),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, i) => _gasCardView(),
        ),
      )
    );
  }
}

Widget _gasCardView(){
  return Card(
    elevation: 10.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0) ),
    child: Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0) ),
          child: Image(
            image: NetworkImage('https://becaselsalvador.com/wp-content/uploads/2021/02/Empleo-en-Texaco-1024x535.jpg'),
            fit: BoxFit.cover,
            width: double.infinity,
            height: 115.0,
            ),
          ),
        _contentRow()
      ],
    ),
  );
}

Widget _contentRow(){
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Texaco Caribe', style: TextStyle(color: colorAzulOscuro(), fontSize: 15.0, fontWeight: FontWeight.bold ),),
            IconButton(
              icon: Icon(Icons.star, color: colorAzulOscuro(), size: 24.0,),
              onPressed: (){},
            )
          ],
        ),
        //Reemplazar por infomación dinámica
        Text('Abierto las 24 horas', style: TextStyle(color: colorVerdeClaro(), fontSize: 15.0, fontWeight: FontWeight.bold ),),
        SizedBox(height: 15.0) ,
        _buttonsRow()
      ],
    ),
  );
}

Widget _buttonsRow(){

  return Padding(
    padding: EdgeInsets.only(bottom: 15.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _buttonSize(
          ElevatedButton(
            child: Text('Indicaciones', style: TextStyle(color: Colors.white, fontSize: 12.0 ),),
            onPressed: (){
              //Mostrar indicaciones para ir a esa gasolinera
            },
            style: cardButtonStyleDark(),
          ),
        ),
        _buttonSize(
          ElevatedButton(
            child: Text('Precios', style: TextStyle(color: colorAzulOscuro(), fontSize: 12.0 ),),
            onPressed: (){
              //Redirigir a página "Precios"
            },
            style: cardButtonStyleLight(),
          ),
        ),
        _buttonSize(
          ElevatedButton(
            child: Text('Ver ofertas', style: TextStyle(color: colorAzulOscuro(), fontSize: 12.0 ),),
            onPressed: (){
              //Redirigir a página "Ofertas"
            },
            style: cardButtonStyleLight(),
          ),
        )
      ],
    ),
  );
}

Widget _buttonSize(ElevatedButton elevatedButtonP){
  return Container(
    width: 105.0,
    height: 30.0,
    child: elevatedButtonP,
  );
}