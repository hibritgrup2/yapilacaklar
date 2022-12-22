import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];

// refence our box
  final _myBox = Hive.box('mybox');

  //run this method if this is the 1st time ever opening this app
  void createInitialData() {
    toDoList = [
      ["Deneme", false],
      ["Egzersiz Yap", false],
    ];
  }

  //load the data from database
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  //update the database
  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
