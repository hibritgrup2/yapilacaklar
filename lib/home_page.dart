import 'package:flutter/material.dart';
import 'package:flutter_application_3/data/database.dart';
import 'package:flutter_application_3/util/dialog_box.dart';
import 'package:flutter_application_3/util/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    //ilk defa uygulamayı açıyorsan , default data bunlar
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      //zaten data varsa
      db.loadData();
    }
    super.initState();
  }

// reference the hive box
  final _myBox = Hive.box('mybox');

//text controller
  final _controller = TextEditingController();

  ToDoDataBase db = ToDoDataBase();

  //yeni taslak kaydet
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop(); //ekledikten sonra kapatmak için
    db.updateDataBase();
  }

  //checkboxa tıklandığında
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  //yeni taslak oluşturma
  void yenitaslakolustur() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
    db.updateDataBase();
  }

  //taslak silme
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[200],
      appBar: AppBar(
        title: Text('       Yapılacaklar Listesi'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: yenitaslakolustur,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompeleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
