import 'package:flutter/material.dart';

class OrderNumberProvider with ChangeNotifier {
  List<String> _orderNumbers = [];

  List<String> get orderNumbers => _orderNumbers;

  void addOrderNumber(String orderNumber) {
    _orderNumbers.add(orderNumber);
    notifyListeners();
  }
}
