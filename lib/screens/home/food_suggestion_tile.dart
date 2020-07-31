import 'package:codays/models/user.dart';
import 'package:codays/services/database.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:codays/models/food.dart';
import 'package:provider/provider.dart';

class FoodSuggestionTile extends StatefulWidget {
  final Food food;


  FoodSuggestionTile({this.food});

  @override
  _FoodSuggestionTileState createState() => _FoodSuggestionTileState();
}

class _FoodSuggestionTileState extends State<FoodSuggestionTile> {
  bool liked= false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Padding(
      padding: EdgeInsets.only(top: 8.0,),
      child: Card(

        color: Colors.white70,
        borderOnForeground: true,
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
            onTap: (){},
            onLongPress: ()async{
              if(user.uid==widget.food.uid){
               SnackBar snackbar=SnackBar(elevation: 8.0,
                 backgroundColor: Colors.transparent,
                 content:Center(
                   child: Padding(
                     padding: const EdgeInsets.only(top:140.0),
                     child: Column(
                       children: <Widget>[
                       AspectRatio(
                       aspectRatio: 1,
                         child: FlareActor('animations/ghost.flr',
                           alignment: Alignment.center,
                           fit: BoxFit.contain,
                           animation: 'Eyes and lipsing',),
                     ),
                         SizedBox(height: 20.0,),
                         Text('Are you voting for yourself ?! ....WOW!!',style: TextStyle(color:Colors.white , fontStyle: FontStyle.italic,fontWeight: FontWeight.bold, fontSize: 15.0),),
                       ],
                     ),
                   ),
                 ),
             );
               Scaffold.of(context).showSnackBar(snackbar);
             }else{
              if(liked==false){
                await DatabaseService(uid:widget.food.uid).updateUserData(widget.food.name,widget.food.foodSuggestion,widget.food.votes+1);
                setState(() =>liked=true );
                SnackBar likeSnackBar = SnackBar(content: Text('you Liked ${widget.food.name} food :D'),);
                Scaffold.of(context).showSnackBar(likeSnackBar);
              }
              else{
                await DatabaseService(uid:widget.food.uid).updateUserData(widget.food.name,widget.food.foodSuggestion,widget.food.votes-1);
                setState(() =>liked=false);
                SnackBar dislikeSnackBar = SnackBar(content: Text('you Disliked ${widget.food.name} food :('),);
                Scaffold.of(context).showSnackBar(dislikeSnackBar);
              }}
            },
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: voteColor(widget.food.votes),
              child: Text('+${widget.food.votes.toString()}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20.0),),
            ),
            title: Text(widget.food.foodSuggestion),
            subtitle: Text(widget.food.name),
            trailing:popularSuggestionIcon(widget.food.votes)
        ),
      ),
    );
  }

  Color voteColor (int foodVotes){

    if (foodVotes<= 1){
      return Colors.grey;
    }if (foodVotes== 2){
      return Colors.limeAccent;
    }
    if (foodVotes==3  ){
      return Colors.limeAccent[400];
    }if (foodVotes==4){
      return Colors.deepOrange[300];
    }if (foodVotes>=4){
      return Colors.deepOrange;
    }else{
      return Colors.grey;
    }
  }

  Widget popularSuggestionIcon (int votes){
    if (votes>=5){
      return AspectRatio(
        aspectRatio: 1,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: FlareActor('animations/Trophy.flr',
            alignment: Alignment.center,
            fit: BoxFit.contain,
            animation: 'go',),
        ),
      );
    }else{
      return AspectRatio(
        aspectRatio: 1,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: SizedBox(),
        ),
      );
    }
  }
}
