import 'package:flutter/material.dart';

Widget gasoFastIcon(Size size){
  return Container(
    height: size.height * 0.15,
    child: Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Image(
          image: AssetImage('assets/images/location.png'),
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 12.0),
          child: Image(
            image: AssetImage('assets/images/petrol.png'),
            height: size.height * 0.070,
          ),
        )
      ],
    )
  );
}