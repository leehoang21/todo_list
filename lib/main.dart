import 'package:flutter/material.dart';
import 'package:todo_list/add_to_do_dialog.dart';
import 'package:todo_list/to_to.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _myControler = TextEditingController();
  bool _clickDeleteButton = false;
  final List<ToDo> _listToDo = [];
  List<int> _listDelete = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _clickDeleteButton = !_clickDeleteButton;
                });
              },
              icon: const Icon(Icons.delete))
        ],
        title: const Text('To-Do List'),
      ),
      body: ListView(
        children: [
          for (var i = 0; i < _listToDo.length; i++) displayToDoList(i)
        ],
      ),
      floatingActionButton: add(context),
      bottomNavigationBar: _clickDeleteButton ? displayDeleteButton() : null,
    );
  }

  Widget displayToDoList(int i) {
    return _clickDeleteButton
        ? CheckboxListTile(
            title: textToDo(i),
            value: _listToDo[i].check,
            onChanged: (_) {
              setState(() {
                _listToDo[i].check = !_listToDo[i].check;
                if (_listToDo[i].check) _listDelete.add(i);
              });
            },
          )
        : textToDo(i);
  }

  Text textToDo(int i) {
    return Text(
      _listToDo[i].toDo,
      style: const TextStyle(
        fontSize: 25,
      ),
    );
  }

  void listToDo(String toDo) {
    ToDo td = ToDo();
    td.toDo = toDo;
    setState(() {
      _listToDo.add(td);
    });
  }

  FloatingActionButton add(context) {
    return FloatingActionButton(
      onPressed: () {
        displayDialog(context);
      },
      child: const Icon(Icons.add),
    );
  }

  displayDeleteButton() {
    return BottomAppBar(
      child: ElevatedButton(
        onPressed: () {
          for (var i in _listDelete) {
            setState(() {
              _listToDo.removeAt(i);
            });
          }
          _listDelete = [];
        },
        child: const Text('xóa'),
      ),
    );
  }

  displayDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (_) {
        return AddToDoDialog(toDoList: (val) => listToDo(val));
      },
    );
  }
}
