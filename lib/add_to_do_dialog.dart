import 'package:flutter/material.dart';

class AddToDoDialog extends StatelessWidget {
  AddToDoDialog({Key? key, required this.toDoList}) : super(key: key);
  final TextEditingController _myControler = TextEditingController();
  final Function(String) toDoList;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('nhập công việc'),
      content: TextField(
        controller: _myControler,
        decoration: const InputDecoration(hintText: 'nhập công việc vào đây'),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              toDoList(_myControler.text);
            },
            child: const Text('thêm công việc'))
      ],
    );
  }
}
