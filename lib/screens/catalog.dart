import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sugar_shack/models/cart.dart';
import 'package:sugar_shack/models/catalog.dart';
import 'package:badges/badges.dart';

class MyCatalog extends StatefulWidget {
  const MyCatalog({super.key});

  @override
  MyCatalogState createState() => MyCatalogState();
}

class MyCatalogState extends State<MyCatalog> {
  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartModel>();
    var catalog = context.read<CatalogModel>();
    return Scaffold(
        appBar: AppBar(
          title: Text('Sugar Shack'),
        ),
        body: ChangeNotifierProvider<FilterState>(
            create: (context) => FilterState([true, true, true]),
            child: Column(children: [
              _MyFilters(),
              Expanded(
                  child: ListView.builder(
                itemBuilder: (context, index) => _MyListItem(index),
                itemCount: catalog.getCount(),
              )),
              const Divider(height: 4, color: Colors.black),
              TextButton(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Voir le panier'),
                        Badge(
                            animationType: BadgeAnimationType.fade,
                            badgeContent: Text(cart.syrups.length.toString()),
                            child: const Icon(Icons.shopping_cart)),
                      ]),
                  onPressed: () => Navigator.pushNamed(context, '/cart')),
            ])));
  }
}

class _AddButton extends StatelessWidget {
  final Syrup item;

  const _AddButton({required this.item});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        var cart = context.read<CartModel>();
        cart.add(item);
      },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Theme.of(context).primaryColor;
          }
          return null; // Defer to the widget's default.
        }),
      ),
      child: const Icon(Icons.add),
    );
  }
}

class FilterState extends ChangeNotifier {
  List<bool> selectedTypes = [true, true, true];

  FilterState(this.selectedTypes);

  void updateState(index) {
    selectedTypes[index] = !selectedTypes[index];
    notifyListeners();
  }
}

class _MyListItem extends StatelessWidget {
  final int index;

  const _MyListItem(this.index);

  @override
  Widget build(BuildContext context) {
    var item = context.select<CatalogModel, Syrup>(
      (catalog) => catalog.getById(index),
    );

    if (item.idType == idAmber &&
            Provider.of<FilterState>(context).selectedTypes[idAmber] ||
        item.idType == idDark &&
            Provider.of<FilterState>(context).selectedTypes[idDark] ||
        item.idType == idLight &&
            Provider.of<FilterState>(context).selectedTypes[idLight]) {
      return Row(
        children: [
          Expanded(
              child: ListTile(
            title: Text(item.name,
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 2.0)),
            subtitle: Row(children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Chip(label: Text(syrupTypes[item.idType])),
              ),
              Text(item.description),
            ]),
          )),
          _AddButton(item: item),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class _MyFilters extends StatelessWidget {
  const _MyFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 5),
          ToggleButtons(
            direction: Axis.horizontal,
            onPressed: (int index) {
              Provider.of<FilterState>(context, listen: false)
                  .updateState(index);
            },
            selectedBorderColor: Colors.red[100],
            selectedColor: Colors.white,
            fillColor: Colors.red[200],
            color: Colors.red[300],
            constraints: const BoxConstraints(
              minHeight: 40.0,
              minWidth: 80.0,
            ),
            isSelected: Provider.of<FilterState>(context).selectedTypes,
            children: syrupTypes.map((item) => Text(item)).toList(),
          ),
        ],
      ),
    );
  }
}
