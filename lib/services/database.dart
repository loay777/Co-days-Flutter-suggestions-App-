import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codays/models/food.dart';
import 'package:codays/models/user.dart';
import 'package:codays/screens/home/spin_the_wheel/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatabaseService {

  //uid is passed into the database service instance in order to identify the user who is using it and fitch data based on this user ID
  final String uid;
  DatabaseService({this.uid});


  //in fire base a table is called a collection
  // collection reference
  final CollectionReference foodCollection = Firestore.instance.collection('food'); // this line will create a collection in the firestore DB

  //updates document for existing user //creates document for new user
  Future updateUserData(String name,String foodSuggestion,int votes) async{
    // fitch the document of this user from the food collection **food table
    // if that document doesn't exist **in case of new user** fireStore will create it for us
    return await foodCollection.document(uid).setData({
        'name': name,
        'foodSuggestion': foodSuggestion,
        'votes' : votes,
        'uid': uid,
      }) ;
  }

  // get food list from snapshot ('snapshot' means the current state of the database )

  List<Food> _foodListFromSnapshot (QuerySnapshot snapshot){
    return snapshot.documents.map((doc){//map function iterates through the documents in the snapshot and execute a function ( emaxmple:   snapshot.documents.map((){})  )
      return Food(
          name: doc.data['name']?? '',  // [?? ''] means if it doesn't exist ?? then use this empty string value ''
          foodSuggestion: doc.data['foodSuggestion']??'',
          votes: doc.data['votes']?? 0,
          uid: doc.data ['uid']??'',
      );
    }).toList();
  }
  List<Luck> _luckListFromSnapshot (QuerySnapshot snapshot){
    return snapshot.documents.map((doc){//map function iterates through the documents in the snapshot and execute a function ( emaxmple:   snapshot.documents.map((){})  )
      return Luck(suggestion: doc.data['foodSuggestion']??'', color: Colors.accents[doc.data['votes']+2]);
    }).toList();
  }

  Future updateVotes (QuerySnapshot snapshot,String name)async{
    snapshot.documents.map((doc){//map function iterates through the documents in the snapshot and execute a function ( example:   snapshot.documents.map((){})  )

      if(doc.data['name']==name){
        doc.data['votes']+1;
      }
      return Food(
       name: doc.data['name']?? '',  // [?? ''] means if it doesn't exist ?? then use this empty string value ''
       foodSuggestion: doc.data['foodSuggestion']??'',
       votes: doc.data['votes']?? 0,
     );
   });
  }

  //get food stream
  Stream<List<Food>> get foods{ // this stream will be listened to in Home screen for any changes in the food collection data
    return foodCollection.snapshots().map(_foodListFromSnapshot);
  }
  Stream<List<Luck>> get lucks{ // this stream will be listened to in Home screen for any changes in the food collection data
    return foodCollection.snapshots().map(_luckListFromSnapshot);
  }


//get user doc stream and
Stream<UserData> get userData{
    return foodCollection.document(uid).snapshots().map(_userDataFromSnapshot);
}

// user data from snapshot // map the data from the collection documents to a UserData object
UserData _userDataFromSnapshot (DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      foodSuggestion: snapshot.data['foodSuggestion'],
      votes: snapshot.data['votes'],
    );
}


}