import 'package:flutter/material.dart';

import 'package:gasofast/src/utils/colors_utils.dart';

class PricesPage extends StatelessWidget {

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
        title: Text('Texaco Caribe', style: TextStyle(color: colorAzulOscuro()),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: _content(),
        ),
      ),
    );
  }
}

Widget _content(){
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 40.0,),
        _schedule(),
        SizedBox(height: 40.0,),
        Text('Combustibles', textAlign: TextAlign.center,style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold ),),
        SizedBox(height: 10.0,),
        _fuels()
      ],
    ),
  );
}

Widget _schedule(){
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 60.0),
    child: Text(
      'Abierto de lunes a domingo las 24 horas',
      textAlign: TextAlign.center,
      style: TextStyle(color: colorVerdeClaro(), fontSize: 18.0, fontWeight: FontWeight.bold ),
    ),
  );
}

Widget _fuels(){
  return Column(
    children: <Widget>[
      _fuel('Regular', 3.56),
      SizedBox(height: 20.0,),
      _fuel('Especial', 3.78),
      SizedBox(height: 20.0,),
      _fuel('Diésel', 3.15),
    ],
  );
}

Widget _fuel(String fuelName, double fuelPrice){
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 40.0),
    color: colorCeleste(),
    elevation: 5.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    child: Container(
      width: 300.0,
      height: 60.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(fuelName, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold) ),
                Text('\$$fuelPrice', style: TextStyle(color: colorRojo(), fontSize: 20.0, fontWeight: FontWeight.bold ),),
              ],
            ),
    ),
  );
}