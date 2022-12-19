import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:provider/provider.dart';
import 'package:sugar_shack/models/cart.dart';

import '../models/catalog.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({Key? key}) : super(key: key);

  @override
  MyOrderState createState() => MyOrderState();
}

class MyOrderState extends State<MyOrder> {
  final _recipientController = TextEditingController(
    text: 'Votre adresse email',
  );

  Future<void> send() async {
    var cart = context.read<CartModel>();
    final Email emailSale = Email(
      subject: 'Nouvelle commande',
      body: "Commande de ${cart.syrups} pour ${_recipientController.text}",
      recipients: ['sales@example.com'],
    );

    final Email emailConfirmation = Email(
      subject: 'Votre commande est passée',
      body: "Commande de ${cart.syrups}",
      recipients: [
        _recipientController.text,
      ],
    );

    String platformResponse;
    platformResponse = 'Votre commande a bien été passée';

    try {
      await FlutterEmailSender.send(emailSale);
      try {
        await FlutterEmailSender.send(emailConfirmation);
        platformResponse = 'success';
      } catch (error) {
        // Doesn't work on emulator
        // print(error);
        // platformResponse = error.toString();
      }
    } catch (error) {
      // Doesn't work on emulator
      // print(error);
      // platformResponse = error.toString();
    }

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );

    cart.removeAll();
    Navigator.popUntil(context, ModalRoute.withName('/catalog'));
  }

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartModel>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Commande'),
        ),
        body: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                    'Vous allez commander ${cart.syrups.length} sirops.\nMerci de renseigner votre adresse mail. Nous vous contacterons très bientôt.')),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _recipientController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Recipient',
                ),
              ),
            )),
            const Divider(height: 4, color: Colors.black),
            TextButton(
              onPressed: send,
              child: const Text('Réserver commande'),
            )
          ],
        ));
  }
}
