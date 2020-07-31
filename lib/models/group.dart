import 'food.dart';

class Group{

  final String groupID;
  final String groupName;
  final String password;
  List<Food> _suggestions;

  Group(this.groupID, this.groupName, this.password, this._suggestions);
}
//To Do