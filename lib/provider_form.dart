import 'package:flutter/material.dart';

class ProviderForm extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  bool errorText() {
    notifyListeners();
    return formKey.currentState!.validate();
  }
}
