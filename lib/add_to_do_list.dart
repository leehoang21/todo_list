import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_v2/provider_form.dart';
import 'package:to_do_list_v2/provider_to_do_list.dart';

class AddToDoList extends StatelessWidget {
  AddToDoList({Key? key}) : super(key: key);
  final TextEditingController _myControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Form(
            key: context.read<ProviderForm>().formKey,
            child: TextFormField(
              validator: (value) {
                List<String> toDoList =
                    context.read<ProviderToDoList>().toDoList;
                if (value!.isEmpty) {
                  return 'bạn cần nhập 1 cái gì đó';
                }
                for (var i = 0; i < value.length; i++) {
                  if (value[i] != ' ') {
                    return null;
                  }
                }
                return 'bạn cần nhập 1 cái gì đó';
              },
              // validator: (value) => value!.isEmpty || value == ''
              //     ? 'bạn cần nhập 1 cái gì đó'
              //     : null,
              controller: _myControler,
              decoration:
                  const InputDecoration(hintText: 'nhập công việc vào đây'),
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              if (context.read<ProviderForm>().errorText()) {
                context.read<ProviderToDoList>().add(_myControler.text);
              }
            },
            child: const Icon(Icons.arrow_upward))
      ],
    );
  }
}
