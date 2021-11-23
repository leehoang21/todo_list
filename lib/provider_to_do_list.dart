import 'package:flutter/material.dart';

class ProviderToDoList extends ChangeNotifier {
  final List<String> _toDoList = [];

  List<String> get toDoList => _toDoList;
  void add(String toDo) {
    _toDoList.add(toDo);
    notifyListeners();
  }

  void delete(int index) {
    _toDoList.removeAt(index);
    notifyListeners();
  }
}
