import 'package:codays/screens/authenticate/authenticate.dart';
import 'package:codays/services/auth.dart';
import 'package:codays/shared/loading.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView; //this function is passed from the authenticate class to toggle between sign in and register views
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = "";
  String password = "";
  String error = "";


  @override
  Widget build(BuildContext context) {
    return loading? Loading():Scaffold(

      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        elevation: 7.0,
        title: Text("Sign in",style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 25.0,),),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: (){
                widget.toggleView(); //widget is used here instead of using this wea referring to SignIn class
              },
              icon: Icon(Icons.person),
              label: Text('Register')
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(colorFilter: ColorFilter.mode(Colors.accents[3].withOpacity(0.8), BlendMode.overlay) ,fit: BoxFit.cover,image:AssetImage('images/food_background.jpg'))
        ),
        padding:EdgeInsets.symmetric(vertical:20.0, horizontal:50.0),
        child: Form(
          key: _formKey,
          child:Column(
            children: <Widget>[
              SizedBox(height: 20.0), //to give some space from the top //works like a padding or balloon
              TextFormField( //username text field
                validator: (val) => val.isEmpty? 'Enter an email' : null, // is the value of the field empty? if yes then return 'enter email', else return null which means the field is valid
                  decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'enter your email',hintStyle: TextStyle(color: Colors.grey[400]),
                      fillColor: Colors.white70,
                      filled: true,
                      errorStyle: TextStyle(color: Colors.red),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                onChanged:(val){// val is the value of whatever is inside the text field
                  //passing the value of the field to the email variable
                  setState(() => email=val); // ()=>  is a short way of writing a function (equals to (){code of the function})
                } ,
              ),
              SizedBox(height: 20.0), //to give some space from the top //works like a padding or balo
              TextFormField( //password text field
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'enter your password',hintStyle: TextStyle(color: Colors.grey[400]),
                    fillColor: Colors.white70,
                    filled: true,
                    errorStyle: TextStyle(color: Colors.red),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
                validator: (val) => val.length < 6? 'Enter a password > 6 charcthers': null, // is the value of the field less than 6 characters? if yes then return 'short password', else return null which means the field is valid
                onChanged:(val){// val is the value of whatever is inside the text field
                  //passing the value of the field to the password variable
                  setState(() => password=val); // ()=>  is a short way of writing a function (equals to (){code of the function})
                },
              ),
              SizedBox(height: 20.0), //to give some space from the top //works like a padding or balo
              RaisedButton(
                child: Text('Sign in'),
                color: Colors.accents[8].withOpacity(0.8),
                textColor: Colors.white,
                onPressed: ()async{
                  if(_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null) {
                      setState(() {
                        error = 'could not sign in with those credintials';
                        loading = false;
                      });
                    }
                  }
                },
              ),
              SizedBox(
                  height:
                  12.0),
              Text(error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),)
            ],
          ) ,
        )
      ),
    );
  }
  Widget signInAnonBttn(){
    return RaisedButton(
        child: Text('Sign in anon'),
        onPressed: () async{
          dynamic result = await _auth.signInAnon();
          if(result==null){
            print('Sign in error');
          }else {
            print('signed in successfully');
            print(result.uid);
          }

        }
    );
  }
}
