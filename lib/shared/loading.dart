import 'package:codays/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken) ,fit: BoxFit.cover,image:AssetImage('images/food_background.jpg'))
      ),

      child: Center(
        child: SpinKitHourGlass( //loading spinner animation
          color:  primaryColor,
          size: 50.0,
        ),
      ),
    );
  }
}