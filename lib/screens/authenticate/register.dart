import 'package:codays/services/auth.dart';
import 'package:codays/shared/constants.dart';
import 'package:codays/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function
      toggleView; //this function is passed from the authenticate class to toggle between sign in and register views
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field form
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      backgroundColor:Color(0xff212b38),
      appBar: AppBar(
        backgroundColor: Color(0xff726eff),
        elevation: 0.0,
        title: Text("Register",style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 25.0,),),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                widget.toggleView(); //widget is used here instead of using this wea referring to Register class
              },
              icon: Icon(Icons.person),
              label: Text('Sign in'))
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          decoration: BoxDecoration(
              image: DecorationImage(colorFilter: ColorFilter.mode(Colors.blueAccent, BlendMode.overlay) ,fit: BoxFit.cover,image:AssetImage('images/food_background.jpg'))
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                    height:
                        20.0), //to give some space from the top //works like a padding or balloon
                TextFormField(
                  //username text field
                  validator: (val) => val.isEmpty? 'Enter an email' : null, // is the value of the field empty? if yes then return 'enter email', else return null which means the field is valid
                  decoration:textInputDecoration.copyWith(hintText: "email")
                    /* InputDecoration(
                      labelText: 'Email',
                      hintText: 'enter your email',
                      fillColor: Colors.white,
                      filled: true,
                      errorStyle: TextStyle(color: Colors.red),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)))*/,
                  onChanged: (val) {
                    // val is the value of whatever is inside the text field
                    //passing the value of the field to the email variable
                    setState(() => email =
                        val); // ()=>  is a short way of writing a function (equals to (){code of the function})
                  },
                ),
                SizedBox(
                    height:
                        20.0), //to give some space from the top //works like a padding or balo
                TextFormField(
                  //password text field
                  obscureText: true,
                  decoration: textInputDecoration.copyWith(hintText: "password"),
                  validator: (val) => val.length < 6? 'Enter a password > 6 charcthers': null, // is the value of the field less than 6 characters? if yes then return 'short password', else return null which means the field is valid
                  onChanged: (val) {
                    // val is the value of whatever is inside the text field
                    //passing the value of the field to the password variable
                    setState(() => password =
                        val); // ()=>  is a short way of writing a function (equals to (){code of the function})
                  },
                ),
                SizedBox(
                    height:
                        20.0), //to give some space from the top //works like a padding or place holder
                RaisedButton(
                  child: Text('Register'),
                  color: Color(0xff5affb7),
                  textColor: Colors.white,
                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        setState(() => loading = true);
                        dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                        if(result == null) {
                          setState(() {
                            error = 'Please supply a valid email';
                            loading = false;
                          });
                        }
                      }
                    }
                ),
                SizedBox(
                    height:
                    12.0),
                Text(error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),)
              ],
            ),
          )),
    );
  }
}
