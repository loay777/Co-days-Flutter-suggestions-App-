import 'package:codays/models/user.dart';
import 'package:codays/screens/wrapper.dart';
import 'package:codays/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return StreamProvider<User>.value( // the stream provider in this case wraps the whole app tree to provide all of its branch widgets with the user
      value: AuthService().user,
      child: MaterialApp(
      home: Wrapper(),
        theme: ThemeData(
            /*accentColor: Colors.amberAccent[400],
            primaryColor: Color(0xff510a32),*/),
      ),
    );
  }
}

