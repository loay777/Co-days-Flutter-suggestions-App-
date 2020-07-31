import 'package:codays/models/user.dart';
import 'package:codays/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authenticate/authenticate.dart';


//the wrapper is container the lives on the main activity which will either show home or authentication depending on the condition
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context); // to get the user from the stream provider
    print(user); // for debugging

    //return either Home or Authenticate depends the user stream
    if(user==null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}
