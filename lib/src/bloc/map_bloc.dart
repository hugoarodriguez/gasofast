import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';

class MapBloc{

  Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  //Marcadores
  Set<Marker> _markers = Set<Marker>();

  final _mapTypeController = BehaviorSubject<MapType>();
  final _mapController = BehaviorSubject<Completer<GoogleMapController>>();

  MapBloc(data){
    _createMarkers(data);
  }

  void _createMarkers(data){
    List items = data;

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
  }
}