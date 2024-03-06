import 'package:flutter/material.dart';

class ItemDetailsPage extends StatelessWidget {
  final String itemName;
  final int price;
  final String imageUrl;

  const ItemDetailsPage({
    required this.itemName,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imageUrl,
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 16),
            Text(
              itemName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Price: Rs $price',
              style: const TextStyle(fontSize: 18),
            ),
            // Add more detailed description widgets as needed
          ],
        ),
      ),
    );
  }
}