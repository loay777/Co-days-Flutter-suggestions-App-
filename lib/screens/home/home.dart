import 'package:codays/models/food.dart';
import 'package:codays/screens/home/settings_form.dart';
import 'package:codays/screens/home/spin_the_wheel/model.dart';
import 'package:codays/screens/home/spin_the_wheel_screen.dart';
import 'package:codays/services/auth.dart';
import 'package:codays/shared/colors.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:codays/services/database.dart';

import 'food_list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Food>>.value(// we are getting query snapshots of the database from the stream
      value: DatabaseService().foods,
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
        backgroundColor: Colors.green[50],
        appBar: AppBar(
          title: Text("Ra'yak",style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 25.0,),),
          backgroundColor: Colors.green[400],
          elevation: 8.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Sign out'),
              onPressed: ()async{
                await _auth.signOut();
              },
            ),
            FlatButton.icon(onPressed:()=> _showSettingsPanel(SettingsForm()), icon: Icon(Icons.settings), label: Text('Settings'))
          ],
        ),
        floatingActionButton: FloatingActionButton(

          backgroundColor: primaryColor.withOpacity(0.7),
          elevation: 7.0,
          splashColor: primaryColor,
          child:  Padding(
                padding: const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 5.0),
                child: FlareActor('animations/wheel_spin.flr',
                  alignment: Alignment.center,
                  fit: BoxFit.scaleDown,
                  animation: 'spin',),
              ),
          onPressed:() {
            _showSpinWheel(SpinTheWheelScreen());
           },
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(colorFilter: ColorFilter.mode(Colors.white24, BlendMode.overlay) ,fit: BoxFit.cover,image:AssetImage('images/993ef9441d4db3f283079954260d5fe5.jpg'))
            ),
            child: FoodList()),
      ),
    );
  }

  void _showSpinWheel(Widget widget) {
    showModalBottomSheet(isScrollControlled: true,elevation: 7.0 ,backgroundColor: Colors.transparent,context: context, builder: (context) {
      return StreamProvider<List<Luck>>.value(
        value: DatabaseService().lucks,
        child: Container(
          decoration: new BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.greenAccent[100], Colors.blue.withOpacity(0.2)]),
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(25.0),
                  topRight: const Radius.circular(25.0))),
          child: Wrap(

              children:<Widget>[Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                child:widget,
              ),]
          ),
        ),
      );
    });
  }
  void _showSettingsPanel(Widget widget) {
    showModalBottomSheet(isScrollControlled: true,elevation: 7.0 ,backgroundColor: Colors.transparent,context: context, builder: (context) {
      return Container(
        decoration: new BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.greenAccent[100], Colors.blue.withOpacity(0.2)]),
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0))),
        child: Wrap(

            children:<Widget>[Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              child:widget,
            ),]
        ),
      );
    });
  }

}
