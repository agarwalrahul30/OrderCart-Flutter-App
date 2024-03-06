import 'package:flutter/material.dart';
import 'package:order_cart_app/state_controllers/favorites_controller.dart';
import 'package:get/get.dart';

class FavoritesPage extends StatelessWidget {
  FavoritesPage({super.key});

  final FavoritesController favoritesController = Get.find();

  @override
  Widget build(BuildContext context) {

    if (favoritesController.favoriteProducts.isEmpty) {
      return const Center(
        child: Text('No favorites yet.'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('You have '
              '${favoritesController.favoriteProducts.length} favorites:'),
        ),
        for (var product in favoritesController.favoriteProducts)
          ListTile(
            leading: const Icon(Icons.favorite),
            title: Text(product),
          ),
      ],
    );
  }
}