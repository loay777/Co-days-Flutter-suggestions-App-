import 'package:codays/models/user.dart';
import 'package:codays/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

// this class handles the sign in/registrations auth from firebase
class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create a user object based on firebase user
  User _userFromFirebaseUser (FirebaseUser user){
    // the (?) = if and the (:) = else , it means (if user is not equal to null , then return a new User object, else return null)
    return user!= null ? User(uid: user.uid): null;
  }

 //Stream for users auth (so that we could listen to it in case of changes in authentications such as sign out or new sign in)
  Stream<User> get user{
    return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser);

}

  //Sign in anonymous
  Future signInAnon() async{
    try{
      AuthResult result = await _auth.signInAnonymously(); // built in function from FirebaseAuth
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user); // create an instance from the class User(in models folder) using the user from firebase
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //Sign in with email & PW
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //Register with email & PW
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      
      // create a new document in the database for that user using its uid
      await DatabaseService(uid: user.uid).updateUserData('family member', 'Food suggestion goes here',0);
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //Sign out
  Future signOut() async{
    try{
      return await _auth.signOut(); //signOut() in this line is a built in function from the FirebaseAuth class
    }catch(e){
      print(e.toString());
    }
  }
}