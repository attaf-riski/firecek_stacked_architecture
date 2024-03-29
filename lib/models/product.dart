class Product {
  final String name;
  final String description;
  final String idProduct;
  Product({this.name, this.description, this.idProduct});

  static Product fromMap({Map<String, dynamic> map}) {
    if (map == null) return null;

    return Product(
      name: map['name'],
      idProduct: map['idProduct'],
      description: map['description'],
    );
  }
}
