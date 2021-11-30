import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gasofast/src/widgets/fuel_station_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';

class MapBloc{

  final _markersController = BehaviorSubject<Set<Marker>>();
  final _visibilityController = BehaviorSubject<bool>();
  final _listaWidgetsController = BehaviorSubject<List<Widget>>();


  bool visibility = false;

  //Marcadores
  Set<Marker> _markers = Set<Marker>();

  //Crear los marcadores
  void createMarkers(data, List<Widget> listaWidget) async {
    List items = data;

    _visibilityController.add(false);

    for (var i = 0; i < items.length; i++) {
      _markers.add(Marker(
        markerId: MarkerId(items[i].id),
        position: LatLng(double.parse(items[i].locationLatitude), double.parse(items[i].locationLongitude)),
        infoWindow: InfoWindow(
          title: items[i].name,
          snippet: items[i].name,
          onTap: (){

            listaWidget = _listaWidgetsController.value!;

            if(listaWidget.length <= 4){
              listaWidget.add(
                Padding(
                  padding: EdgeInsets.only(bottom: 500.0, top: 70.0),
                  child: Visibility(
                    visible: true,
                    child: FuelStation(gasStationId: items[i].id),
                  ),
                )
              );
              _listaWidgetsController.sink.add(listaWidget);
            } else {
              listaWidget.removeLast();
              _listaWidgetsController.sink.add(listaWidget);
            }

            
          }
        ),
      ));
    }

    _markersController.sink.add(_markers);
  }

  void createWidgetList(List<Widget> listaWidget){
    _listaWidgetsController.sink.add(listaWidget);
  }

  void addWidget(String idGasStation, List<Widget> listaWidget){

  }

  //Obtener el último valor ingresado a los Streams
  Stream<Set<Marker>> get markersStream => _markersController.stream;
  Stream<List<Widget>> get listaWidgetStream => _listaWidgetsController.stream;
  Stream<bool> get visibilityStream => _visibilityController.stream;

  //Obtener valor actual
  bool get getVisibility => visibility;

  //Limpiar los Streams
  dispose(){
    _markersController.close();
    _visibilityController.close();
    _listaWidgetsController.close();
  }
  
}