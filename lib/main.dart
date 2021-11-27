import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_v2/add_to_do_list.dart';
import 'package:to_do_list_v2/provider_form.dart';
import 'package:to_do_list_v2/provider_to_do_list.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProviderToDoList(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProviderForm(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'To Do List',
          style: TextStyle(fontSize: 50, color: Colors.blue),
        ),
      ),
      body: ListView.builder(
        itemCount: context.watch<ProviderToDoList>().toDoList.length,
        itemBuilder: (context, index) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.watch<ProviderToDoList>().toDoList[index],
              style: const TextStyle(
                fontSize: 25,
                color: Colors.amber,
              ),
            ),
            InkWell(
              hoverColor: Colors.red,
              highlightColor: Colors.blue,
              onTap: () {
                context.read<ProviderToDoList>().delete(index);
              },
              child: const Text('x'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: AddToDoList(),
      ),
    );
  }
}
