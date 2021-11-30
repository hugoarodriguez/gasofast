import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gasofast/src/bloc/map_bloc.dart';
import 'package:gasofast/src/bloc/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:gasofast/src/providers/gasolinera_provider.dart';
import 'package:gasofast/src/providers/usuario_provider.dart';
import 'package:gasofast/src/utils/colors_utils.dart';

//Creamos un enum con las opciones del Menú
  enum MenuOptions { favorites, changepwd, about, exit }

class LocationsPage extends StatefulWidget {
  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  
  final usuarioProvider = UsuarioProvider();
  final gasolineraProvider = GasolineraProvider();
  List<Widget> _listadoWidgets = [];

  Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  //Marcadores
  Set<Marker> markers = Set<Marker>();

  CameraPosition puntoInicial = CameraPosition(
      target: LatLng(13.700667619304799, -89.2249587653901),
      zoom: 15,
      tilt: 50.0,
    );

  @override
  Widget build(BuildContext context) {
    final mapBloc = Provider.ofMap(context);

    return Scaffold(
      body: Container(
        child: _fullContent(context, mapBloc)
      ),
    );
  }

  Widget _fullContent(BuildContext context, MapBloc bloc){
    return FutureBuilder(
      future: gasolineraProvider.getGasolineras(),
      builder: (BuildContext context, AsyncSnapshot snapshot){

        if(snapshot.hasData){

          bloc.createMarkers(snapshot.data, _listadoWidgets);

          return StreamBuilder(
            stream: bloc.markersStream,
            builder: (BuildContext context, AsyncSnapshot snapshotMarkers){

              if(snapshotMarkers.hasData){

                _listadoWidgets = [
                  GoogleMap(
                    markers: Set<Marker>.of(
                      snapshotMarkers.data.length > 0 
                      ? snapshotMarkers.data
                      : []),
                    zoomControlsEnabled: false,
                    mapType: mapType,
                    initialCameraPosition: puntoInicial,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                  _frontContent(context),
                  _favoritesFAB(context),
                  _locateFAB(context),
                ];
                
                bloc.createWidgetList(_listadoWidgets);

                return SafeArea(
                  child: StreamBuilder<Object>(
                    stream: bloc.listaWidgetStream,
                    builder: (BuildContext context, AsyncSnapshot snapshotWidgets) {

                      if(snapshotWidgets.hasData){
                        return Stack(
                          children: snapshotWidgets.data,
                        );
                      } else {
                        return Stack(
                          children: _listadoWidgets,
                        );
                      }
                    }
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }
    );
  }

  Widget _frontContent(BuildContext context){
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            _searchBar(context),
          ],
        ),
      ),
    );
  }

  Widget _searchBar(BuildContext context){

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0 ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black,
            blurRadius: 5.0,
            offset: Offset(0.0, 2.0),
            spreadRadius: 1.0
          )
        ]
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0 ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Buscar gasolinera',
                ),
              ),
            ),
            _popUpMenu(context)
          ],
        ),
      ),
    );
  }

  Widget _popUpMenu(BuildContext context){


    return PopupMenuButton<MenuOptions>(
      offset: Offset(0.0, 55.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
      icon: CircleAvatar(
        child: Icon(Icons.person_outlined),
        backgroundColor: colorAzulOscuro(),
      ),
      onSelected: (MenuOptions result) { 

        if(result.index == 0){
          Navigator.pushNamed(context, 'favorites');
        } else if(result.index == 1){
          Navigator.pushNamed(context, 'changepwd');
        } else if(result.index == 2){
          Navigator.pushNamed(context, 'about');
        } else if(result.index == 3){

          usuarioProvider.signOut();
          Navigator.pushReplacementNamed(context, 'login');
          
        }

      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuOptions>>[
        PopupMenuItem<MenuOptions>(
          value: MenuOptions.favorites,
          child: Row(
            children: [
              Icon(Icons.star, size: 16.0,),
              SizedBox(width: 5.0,),
              Text('Favoritos', style: TextStyle(fontSize: 12.0)),
            ],
          ),
          height: 20.0,
        ),
        PopupMenuItem<MenuOptions>(
          value: MenuOptions.changepwd,
          child: Row(
            children: [
              Icon(Icons.lock_outline_rounded, size: 16.0,),
              SizedBox(width: 5.0,),
              Text('Contraseña', style: TextStyle(fontSize: 12.0)),
            ],
          ),
          height: 20.0,
        ),
        PopupMenuItem<MenuOptions>(
          value: MenuOptions.about,
          child: Row(
            children: [
              Icon(Icons.info, size: 16.0,),
              SizedBox(width: 5.0,),
              Text('Acerca de', style: TextStyle(fontSize: 12.0)),
            ],
          ),
          height: 20.0,
        ),
        PopupMenuItem<MenuOptions>(
          value: MenuOptions.exit,
          child: Row(
            children: [
              Icon(Icons.exit_to_app, size: 16.0,),
              SizedBox(width: 5.0,),
              Text('Salir', style: TextStyle(fontSize: 12.0)),
            ],
          ),
          height: 20.0,
        ),
      ],
    );
  }

  Widget _favoritesFAB(BuildContext context){
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.85,left: size.width * 0.80),
      child: FloatingActionButton(
        heroTag: 'favoritesFAB',
        backgroundColor: colorAzulOscuro(),
        child: Icon(Icons.star, size: 32.0,),
        onPressed: () => Navigator.pushNamed(context, 'favorites'),
      ),
    );
  }

  Widget _locateFAB(BuildContext context){
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.75,left: size.width * 0.80),
      child: FloatingActionButton(
        heroTag: 'locateFAB',
        backgroundColor: colorAzulOscuro(),
        child: Icon(Icons.my_location, size: 32.0,),
        onPressed: (){
          print('Mostrar mi ubicación actual');
        },
      ),
    );
  }
}

