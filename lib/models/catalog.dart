const List<String> syrupTypes = ['Ambré', 'Foncé', 'Clair'];

const int idAmber = 0;
const int idDark = 1;
const int idLight = 2;

List<Syrup> listSyrups = [
  Syrup(0, 'Sirop', 'Description du sirop', 5.99, idAmber),
  Syrup(1, 'Sirop 1', 'Description du sirop 1', 5.99, idAmber),
  Syrup(2, 'Sirop 2', 'Description du sirop 2', 6.99, idAmber),
  Syrup(3, 'Sirop 3', 'Description du sirop 3', 7.99, idDark),
  Syrup(4, 'Sirop 4', 'Description du sirop 4', 8.99, idAmber),
  Syrup(5, 'Sirop 5', 'Description du sirop 5', 2.99, idDark),
  Syrup(6, 'Sirop 6', 'Description du sirop 6', 3.99, idAmber),
  Syrup(7, 'Sirop 7', 'Description du sirop 7', 5.99, idLight),
  Syrup(8, 'Sirop 8', 'Description du sirop 8', 6.99, idLight),
  Syrup(9, 'Sirop 9', 'Description du sirop 9', 3.99, idLight),
  Syrup(10, 'Sirop 10', 'Description du sirop 10', 5.99, idAmber),
  Syrup(11, 'Sirop 11', 'Description du sirop 11', 5.99, idLight),
  Syrup(12, 'Sirop 12', 'Description du sirop 12', 5.99, idDark),
  Syrup(13, 'Sirop 13', 'Description du sirop 13', 5.99, idAmber),
  Syrup(14, 'Sirop 14', 'Description du sirop 14', 5.99, idLight),
];

class CatalogModel {
  Syrup getById(int id) => listSyrups.firstWhere((item) => item.id == (id));
  int getCount() => listSyrups.length;
}

class Syrup {
  final int id;
  final String name;
  final String description;
  final double price;
  final int idType;

  Syrup(this.id, this.name, this.description, this.price, this.idType);
}
