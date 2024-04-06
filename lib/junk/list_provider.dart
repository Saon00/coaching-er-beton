import 'package:flutter/material.dart';

class NumberListProvider extends ChangeNotifier {
  List<int> numbers = [1];

  void add() {
    numbers.add(numbers.last + 1);
    notifyListeners();
  }
}
