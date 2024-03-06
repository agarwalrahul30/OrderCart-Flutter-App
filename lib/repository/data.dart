import 'package:order_cart_app/models/cart_item_data.dart';

class Data {
  static final List<CartItemData> cartItems = [
    CartItemData(name: "Watch", price: 9999, imageURL: "images/watch-2.jpg"),
    CartItemData(name: "Shirt", price: 1999, imageURL: "images/shirt.jpg"),
    CartItemData(name: "Sunglasses", price: 5999, imageURL: "images/sunglasses.jpg"),
    CartItemData(name: "Shoes", price: 10999, imageURL: "images/shoes.jpg"),
    // Add more items as needed
  ];
}