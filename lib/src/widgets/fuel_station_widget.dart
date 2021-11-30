import 'package:flutter/material.dart';

import 'package:gasofast/src/providers/gasolinera_provider.dart';
import 'package:gasofast/src/utils/colors_utils.dart';
import 'package:gasofast/src/utils/styles_utils.dart';

// ignore: must_be_immutable
class FuelStation extends StatelessWidget {

  final gasolineraProvider = GasolineraProvider();

  String gasStationId;

  FuelStation({required this.gasStationId});

  @override
  Widget build(BuildContext context) {
    return _gasCardView(context);
  }

  Widget _gasCardView(BuildContext context){
    return FutureBuilder(
      future: gasolineraProvider.getGasolinera(gasStationId),
      builder: (BuildContext context, AsyncSnapshot snapshot){

        if(snapshot.hasData){
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0 ),
            elevation: 10.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0) ),
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0) ),
                  child: FadeInImage(
                    image: NetworkImage(snapshot.data[0].coverImg),
                    placeholder: AssetImage('assets/images/jar-loading.gif'),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 80.0,
                    ),
                  ),
                _contentRow(context, snapshot.data[0].name, snapshot.data[0].name)
              ],
            ),
          );
        } else {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0 ),
            elevation: 10.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0) ),
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0) ),
                  child: Image(
                    image: AssetImage('assets/images/jar-loading.gif'),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 80.0,
                    ),
                  ),
                _contentRow(context, 'Cargando...', 'Cargando...')
              ],
            ),
          );
        }
      },
    );
  }

  Widget _contentRow(BuildContext context, String gasStationName, String gasStationSchedule){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(gasStationName, style: TextStyle(color: colorAzulOscuro(), fontSize: 12.0, fontWeight: FontWeight.bold ),),
              IconButton(
                icon: Icon(Icons.star_outline, color: colorAzulOscuro(), size: 20.0,),
                onPressed: (){},
              )
            ],
          ),
          //Reemplazar por infomación dinámica
          Text(gasStationSchedule, style: TextStyle(color: colorVerdeClaro(), fontSize: 12.0, fontWeight: FontWeight.bold ),),
          SizedBox(height: 15.0) ,
          _buttonsRow(context)
        ],
      ),
    );
  }

  Widget _buttonsRow(BuildContext context){

    return Padding(
      padding: EdgeInsets.only(bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buttonSize(
            ElevatedButton(
              child: Text('Indicaciones', style: TextStyle(color: Colors.white, fontSize: 10.0 ),),
              onPressed: (){
                //Mostrar indicaciones para ir a esa gasolinera
              },
              style: cardButtonStyleDark(),
            ),
          ),
          _buttonSize(
            ElevatedButton(
              child: Text('Precios', style: TextStyle(color: colorAzulOscuro(), fontSize: 10.0 ),),
              onPressed: (){
                //Redirigir a página "Precios"
                Navigator.pushNamed(context, 'prices');
              },
              style: cardButtonStyleLight(),
            ),
          ),
          _buttonSize(
            ElevatedButton(
              child: Text('Ver ofertas', style: TextStyle(color: colorAzulOscuro(), fontSize: 10.0 ),),
              onPressed: (){
                //Redirigir a página "Ofertas"
                Navigator.pushNamed(context, 'offers');
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
      width: 90.0,
      height: 25.0,
      child: elevatedButtonP,
    );
  }
}