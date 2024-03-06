import 'package:flutter/material.dart';
import 'package:order_cart_app/state_controllers/cart_controller.dart';
import 'package:order_cart_app/state_controllers/favorites_controller.dart';
import 'package:order_cart_app/models/cart_item.dart';
import 'package:order_cart_app/repository/data.dart';
import 'package:order_cart_app/views/item_details_page.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer';

class CartScreen extends StatelessWidget {

  final CartController cartController = Get.put(CartController());
  final FavoritesController favoritesController = Get.put(FavoritesController()); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Item To Cart")),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded( // Use Expanded to allow ListView to take remaining space
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  shrinkWrap: true,
                  children: 
                    Data.cartItems.map((item) => 
                      GestureDetector(                  //to allow navigation on tap or click
                          onTap: () {
                            // Navigate to item details page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ItemDetailsPage(
                                  itemName: item.name,
                                  price: item.price,
                                  imageUrl: item.imageURL,
                                  // description: item.description,
                                ),
                              ),
                            );
                          },
                          child: CartItem(
                            title: item.name,
                            price: item.price,
                            imageUrl: item.imageURL,
                          ),
                      )
                   ).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16), // Add space between list and button
            ElevatedButton(
              onPressed: () async {
                String? encodeQueryParameters(Map<String, String> params) {
                  return params.entries
                      .map((MapEntry<String, String> e) =>
                      '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                      .join('&');
                }

                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: 'rahul.r.agarwal@kipi.bi',
                  query: encodeQueryParameters(<String, String>{
                    'subject': 'Order Bill for your Products',
                    'body': 'Dear Customer,\n\nPlease find your order bill amount below:\n\nAmount: ₹${cartController.total.value}\n\nRegards,\nRahul\n',
                  }),
                );

                try {
                  await launchUrl(emailLaunchUri);
                } catch (e) {
                  log(e.toString());
                }
              },
              child: Obx(() => Text('Total Payment : Rs ${cartController.total.value}',
                style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),
              )),
            ),
            const SizedBox(height: 48), // Add space between list and button
          ],
        ),
      ),
    );
  }
}
