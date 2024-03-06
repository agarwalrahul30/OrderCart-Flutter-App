import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_cart_app/state_controllers/cart_controller.dart';
import 'package:order_cart_app/state_controllers/favorites_controller.dart';

class CartItem extends StatefulWidget {
  const CartItem({Key? key, required this.title, required this.price, required this.imageUrl});

  final String title;
  final int price;
  final String imageUrl;

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  final CartController cartController = Get.find();
  final FavoritesController favoritesController = Get.find(); // Define FavortieController
  late int counter;
  late bool isFavorite;
  late String product;

  @override
  void initState() {
    super.initState();
    counter = cartController.itemCounts[widget.title] ?? 0;
    product = widget.title; // Initialize product

    //set the isFavorite boolean 
    if(favoritesController.favoriteProducts.contains(product)) {
      isFavorite = true;
    } else {
      isFavorite = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWideScreen = constraints.maxWidth > 600;

          if (isWideScreen) {
            return _buildWideScreenLayout();
          } else {
            return _buildNormalLayout();
          }
        },
      ),
    );
  }

  Widget _buildWideScreenLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                widget.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                contentPadding: const EdgeInsets.all(8),
                title: Text(
                  widget.title,
                  style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Price: ₹${widget.price}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              _buildTrailingButtons(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNormalLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.asset(
            widget.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              widget.title,
              style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
            ),
            // Subtitle
            Text(
              'Price: ₹${widget.price}',
              style: const TextStyle(fontSize: 16),
            ),
            // Trailing buttons in a new row
            _buildTrailingButtons(),
          ],
        ),
      ),
      ],
    );
  }

  Widget _buildTrailingButtons() {
    return Row(
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.remove, color: Theme.of(context).primaryColor),
              onPressed: () {
                if (counter > 0) {
                  setState(() {
                    counter--;
                    cartController.decrement(widget.title, widget.price);
                  });
                }
              },
            ),
            Text(
              '$counter',
              style: const TextStyle(fontSize: 20),
            ),
            IconButton(
              icon: Icon(Icons.add, color: Theme.of(context).primaryColor),
              onPressed: () {
                setState(() {
                  counter++;
                  cartController.increment(widget.title, widget.price);
                });
              },
            ),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () {
            setState(() {
              isFavorite = !isFavorite;
            });
            favoritesController.toggleFavorite(product);
          },
          icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
          label: const Text('Like'),
        ),
      ],
    );
  }
}
