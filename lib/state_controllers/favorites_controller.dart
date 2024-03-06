import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

class FavoritesController extends ChangeNotifier {
  var favoriteProducts = <String>[].obs;

  void toggleFavorite(String product) {
    if (favoriteProducts.contains(product)) {
      favoriteProducts.remove(product);
    } else {
      favoriteProducts.add(product);
    }
    notifyListeners();
  }
}