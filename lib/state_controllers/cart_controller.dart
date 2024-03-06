import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

class CartController extends ChangeNotifier {
  var total = 0.obs;
  var itemCounts = <String, int>{}.obs;

  void increment(String itemName, int price) {
    total.value += price;
    itemCounts[itemName] = (itemCounts[itemName] ?? 0) + 1;
    notifyListeners();
  }

  void decrement(String itemName, int price) {
    if (itemCounts[itemName] != null && itemCounts[itemName]! > 0) {
      total.value -= price;
      itemCounts[itemName] = itemCounts[itemName]! - 1;
      notifyListeners();
    }
  }
}