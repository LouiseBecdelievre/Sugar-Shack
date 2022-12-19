import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sugar_shack/models/cart.dart';

class MyCart extends StatelessWidget {
  const MyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panier'),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: _CartList(),
              ),
            ),
            const Divider(height: 4, color: Colors.black),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/order');
              },
              child: const Text('Valider le panier'),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var itemNameStyle = Theme.of(context).textTheme.titleLarge;
    var cart = context.watch<CartModel>();

    return ListView.builder(
      itemCount: cart.syrups.length,
      itemBuilder: (context, index) => ListTile(
        trailing: IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          onPressed: () {
            cart.remove(cart.syrups[index]);
          },
        ),
        title: Text(
          cart.syrups[index].name,
          style: itemNameStyle,
        ),
      ),
    );
  }
}
