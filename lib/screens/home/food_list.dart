import 'package:codays/models/food.dart';
import 'package:codays/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'food_suggestion_tile.dart';

class FoodList extends StatefulWidget {
  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  @override
  Widget build(BuildContext context) {

    final foodSuggestion = Provider.of<List<Food>>(context)?? [];
//      foodSuggestion.forEach((food){ // for debugging
//      print(food.name);
//      print(food.foodSuggestion);
//      print(food.votes);
//    }
    if(foodSuggestion.length == null){
      return Loading();
    }else{
    return ListView.builder(
      itemCount: foodSuggestion.length,
      itemBuilder: (context,index){
        return FoodSuggestionTile(food: foodSuggestion[index]);
      },
    );}
  }
}
