import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:gasofast/src/providers/usuario_provider.dart';
import 'package:gasofast/src/utils/colors_utils.dart';
import 'package:gasofast/src/widgets/fuel_station_widget.dart';

//Creamos un enum con las opciones del Menú
  enum MenuOptions { favorites, changepwd, about, exit }

class LocationsPage extends StatelessWidget {
  final usuarioProvider = UsuarioProvider();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _content(context)
      ),
    );
  }

  //Contenido completo
  Widget _content(BuildContext context){
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
            child: Image(
              image: AssetImage('assets/images/GoogleMaps.jpg'),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          _frontContent(context)
        ],
      ),
    );
  }

  //Contenido frontal completo
  Widget _frontContent(BuildContext context){
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            _searchBar(context),
            _favoritesFAB(context),
            _locateFAB(context),
            FuelStation(
              gasStationName: 'Texaco Caribe',
              gasStationSchedule: 'Abierto las 24 horas',
              gasStationUrlImg: 'https://becaselsalvador.com/wp-content/uploads/2021/02/Empleo-en-Texaco-1024x535.jpg',
            )
          ],
        ),
      ),
    );
  }

  //Barra de Búsqueda
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

  //Menú flotante
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

  //FloatingActionButton para acceder a la pantalla de Favoritos
  Widget _favoritesFAB(BuildContext context){
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.28,left: size.width * 0.80),
      child: FloatingActionButton(
        heroTag: 'favoritesFAB',
        backgroundColor: colorAzulOscuro(),
        child: Icon(Icons.star, size: 32.0,),
        onPressed: () => Navigator.pushNamed(context, 'favorites'),
      ),
    );
  }

  //FloatingActionButton para encontrar la ubicación actual del usuario
  Widget _locateFAB(BuildContext context){
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.01,left: size.width * 0.80),
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

