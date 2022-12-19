import 'package:flutter/foundation.dart';
import 'package:sugar_shack/models/catalog.dart';

class CartModel extends ChangeNotifier {
  late CatalogModel _catalog;
  final List<int> _syrupIds = [];

  CatalogModel get catalog => _catalog;

  set catalog(CatalogModel newCatalog) {
    _catalog = newCatalog;
    notifyListeners();
  }

  List<Syrup> get syrups =>
      _syrupIds.map((id) => _catalog.getById(id)).toList();

  void add(Syrup newSyrup) {
    _syrupIds.add(newSyrup.id);
    notifyListeners();
  }

  void remove(Syrup syrup) {
    _syrupIds.remove(syrup.id);
    notifyListeners();
  }

  void removeAll() {
    _syrupIds.clear();
    notifyListeners();
  }
}
