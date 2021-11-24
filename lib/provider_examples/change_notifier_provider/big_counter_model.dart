import 'package:flutter/foundation.dart';

class BigCounterModel extends ChangeNotifier {

  int value = 0;

  void increase() {
    value = value + 1;
    notifyListeners();
  }

  void decrease() {
    value = value - 1;
    notifyListeners();
  }

}