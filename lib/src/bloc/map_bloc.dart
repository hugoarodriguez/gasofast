import 'dart:async';

import 'package:gasofast/src/providers/gasolinera_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';

class MapBloc{

  final gasolineraProvider = GasolineraProvider();
  final _markersController = BehaviorSubject<Set<Marker>>();

  //Marcadores
  Set<Marker> _markers = Set<Marker>();

  MapBloc(){
    _createMarkers();
  }

  //Crear los marcadores
  void _createMarkers() async {
    List items = await gasolineraProvider.getGasolineras();

    for (var i = 0; i < items.length; i++) {
      _markers.add(Marker(
        markerId: MarkerId(items[i].id),
        position: LatLng(double.parse(items[i].locationLatitude), double.parse(items[i].locationLongitude)),
        infoWindow: InfoWindow(
          title: items[i].name,
          snippet: items[i].name,
          onTap: (){
            
          }
        ),
      ));
    }

    _markersController.sink.add(_markers);
  }

  //Obtener el último valor ingresado a los Streams
  Stream<Set<Marker>> get markersStream => _markersController.stream;

  //Limpiar los Streams
  dispose(){
    _markersController.close();
  }
  
}