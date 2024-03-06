import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_cart_app/state_controllers/favorites_controller.dart';
import 'package:provider/provider.dart';
import 'package:order_cart_app/state_controllers/cart_controller.dart';
import 'package:order_cart_app/views/home_page.dart';

void main() {
  runApp(
    MultiProvider(
      //creates instances of CartController and FavoritesController using provider class
      providers: [
        ChangeNotifierProvider(create: (context) => CartController()),
        ChangeNotifierProvider(create: (context) => FavoritesController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Order and Cart',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MyHomePage(),
    );
  }
}