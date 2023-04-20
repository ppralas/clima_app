import 'package:flutter/material.dart';

class TextInputState extends ChangeNotifier {
  String _text = '';

  String get text => _text;

  set text(String newText) {
    _text = newText;
    notifyListeners();
  }
}
