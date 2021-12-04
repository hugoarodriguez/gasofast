import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:gasofast/src/models/gasolinera_model.dart';

import 'package:gasofast/src/providers/gasolinera_provider.dart';
import 'package:gasofast/src/utils/colors_utils.dart';
import 'package:gasofast/src/utils/styles_utils.dart';
import 'package:gasofast/src/widgets/fuel_station_widget.dart';

class FavoritesPage extends StatefulWidget {

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  GasolineraProvider gasolineraProvider = GasolineraProvider();
  ListView _listView = ListView();

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
        centerTitle: true,
      ),
      body: Container(
        child: _favoritesGasStations(),
      )
    );
  }

  void callback() {
    setState(() {
    });
  }

  Widget _favoritesGasStations(){
    
    final firebase_auth.User? user = firebase_auth.FirebaseAuth.instance.currentUser;

    return FutureBuilder(
      future: gasolineraProvider.getGasolinerasFavoritas(user!.uid),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasData){

          List<GasolineraModel> data = snapshot.data;

          _listView = ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, i) => FuelStation(gasStationId: data[i].id, callback: callback, widgetCaller: 1,),
          );

          return _listView;

        } else {

          return Container();
          
        }
      },
    );
  }
}

Widget _gasCardView(BuildContext context){
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
        _contentRow(context)
      ],
    ),
  );
}

Widget _contentRow(BuildContext context){
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
              Navigator.pushNamed(context, 'prices');
            },
            style: cardButtonStyleLight(),
          ),
        ),
        _buttonSize(
          ElevatedButton(
            child: Text('Ver ofertas', style: TextStyle(color: colorAzulOscuro(), fontSize: 12.0 ),),
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
    width: 105.0,
    height: 30.0,
    child: elevatedButtonP,
  );
}