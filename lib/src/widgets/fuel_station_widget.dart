import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:gasofast/src/models/gasolinera_model.dart';

import 'package:gasofast/src/providers/gasolinera_provider.dart';
import 'package:gasofast/src/utils/colors_utils.dart';
import 'package:gasofast/src/utils/styles_utils.dart';

// ignore: must_be_immutable
class FuelStation extends StatefulWidget {

  String gasStationId;

  FuelStation({required this.gasStationId});

  @override
  State<FuelStation> createState() => _FuelStationState();
}

class _FuelStationState extends State<FuelStation> {
  final firebase_auth.FirebaseAuth auth = firebase_auth.FirebaseAuth.instance;

  final firebase_auth.User? user = firebase_auth.FirebaseAuth.instance.currentUser;

  final gasolineraProvider = GasolineraProvider();

  List<GasolineraModel> datosGasolinera = [];

  @override
  void initState() {
    super.initState();
    isFavorita();
  }

  
  Icon favoriteUnchecked = Icon(Icons.star_outline, color: colorAzulOscuro(), size: 20.0,);
  Icon favoriteChecked = Icon(Icons.star, color: colorAzulOscuro(), size: 20.0,);
  bool _favoriteIsChecked = false;

  @override
  Widget build(BuildContext context) {
    return _gasCardView(context);
  }

  void isFavorita() async{
    //Evaluamos si la gasolinera está marcada como favorita para este usuario
    _favoriteIsChecked = await gasolineraProvider.isFavorita(user!.uid, widget.gasStationId);
  }

  Widget _gasCardView(BuildContext context){
    return FutureBuilder(
      future: gasolineraProvider.getGasolinera(widget.gasStationId),
      builder: (BuildContext context, AsyncSnapshot snapshot){

        if(snapshot.hasData) {

          //Obtenemos los datos de la gasolinera que se va a guardar o eliminar de favoritos
          datosGasolinera.add(snapshot.data[0]);

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
                _contentRow(context, snapshot.data[0].name, snapshot.data[0].schedule),
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
                _contentRow(context, 'Cargando...', 'Cargando...'),
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
                icon: _favoriteIsChecked ? favoriteChecked : favoriteUnchecked,
                onPressed: () async {

                  String uid = user!.uid;
                  bool r = false;

                  if (_favoriteIsChecked){

                    //Quitar de favoritos
                    r = await gasolineraProvider.elmGasolineraFavorita(uid, datosGasolinera[0]);

                  } else {

                    //Agregar a favoritos
                    r = await gasolineraProvider.aggGasolineraFavorita(uid, datosGasolinera[0]);
                  }
                  
                  setState((){
                    if (_favoriteIsChecked && r){

                      //Quitar de favoritos
                      _favoriteIsChecked = false;

                    } else if (!_favoriteIsChecked && r){

                      //Agregar a favoritos
                      _favoriteIsChecked = true;
                    }
                  });

                },
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
                Navigator.pushNamed(context, 'prices', arguments: datosGasolinera[0]);
              },
              style: cardButtonStyleLight(),
            ),
          ),
          _buttonSize(
            ElevatedButton(
              child: Text('Ver ofertas', style: TextStyle(color: colorAzulOscuro(), fontSize: 10.0 ),),
              onPressed: (){
                //Redirigir a página "Ofertas"
                Navigator.pushNamed(context, 'offers', arguments: datosGasolinera[0]);
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