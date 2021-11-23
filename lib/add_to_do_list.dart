import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_v2/provider_to_do_list.dart';

class AddToDoList extends StatelessWidget {
  AddToDoList({Key? key, required this.toDoList}) : super(key: key);
  final TextEditingController _myControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final Function(String) toDoList;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Form(
            key: _formKey,
            child: TextFormField(
              validator: (value) =>
                  value!.isEmpty ? 'bạn cần nhập 1 cái gì đó' : null,
              controller: _myControler,
              decoration:
                  const InputDecoration(hintText: 'nhập công việc vào đây'),
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              _formKey.currentState!.validate();
              toDoList(_myControler.text);
            },
            child: const Icon(Icons.arrow_upward))
      ],
    );
  }
}
