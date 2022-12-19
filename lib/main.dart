import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sugar_shack/models/cart.dart';
import 'package:sugar_shack/models/catalog.dart';
import 'package:sugar_shack/screens/cart.dart';
import 'package:sugar_shack/screens/catalog.dart';
import 'package:sugar_shack/screens/order.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => CatalogModel()),
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            if (cart == null) throw ArgumentError.notNull('cart');
            cart.catalog = catalog;
            return cart;
          },
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sugar Shack',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        initialRoute: '/catalog',
        routes: {
          '/cart': (context) => const MyCart(),
          '/catalog': (context) => const MyCatalog(),
          '/order': (context) => const MyOrder(),
        },
      ),
    );
  }
}
