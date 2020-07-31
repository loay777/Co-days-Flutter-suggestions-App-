import 'package:codays/models/user.dart';
import 'package:codays/services/database.dart';
import 'package:codays/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();

  // form values
  String _currentName;
  String _currentFoodSuggestion;
  int _currentVotes;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>( //if you dont understand this refer to https://www.youtube.com/watch?v=PT3v28eyOqg
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData _userData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Update your Suggestion settings',
                  style: TextStyle(fontSize: 18.0,fontWeight:FontWeight.bold),
                ),
                SizedBox(height: 30.0),
                TextFormField(
                  initialValue: _userData.name,
                  decoration: textInputDecoration.copyWith(hintText: 'Name'),
                  validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  initialValue: _userData.foodSuggestion,

                  decoration: textInputDecoration.copyWith(hintText: 'Food Suggestion'),
                  validator: (val) => val.isEmpty ? 'Please enter Food Suggestion' : null,
                  onChanged: (val) => setState(() => _currentFoodSuggestion = val),
                ),
                SizedBox(height: 10.0),
                RaisedButton(
                    color: Colors.amberAccent[400],
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        await DatabaseService(uid: user.uid).updateUserData(
                            _currentName??_userData.name,
                            _currentFoodSuggestion??_userData.foodSuggestion,
                            _userData.votes);
                        Navigator.pop(context);
                      }

                    }
                ),
                SizedBox(height: 220.0),

              ],
            ),
          );
        }else{
          return null;
        }

      }
    );
  }
}
