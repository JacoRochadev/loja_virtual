class ItemSize {
  ItemSize();
  ItemSize.fromMap(Map<String, dynamic> map) {
    name = map['name'] as String;
    stock = map['stock'] as int;
    price = map['price'] as num;
  }
  String name;
  num price;
  int stock;

  bool get hasStock => stock > 0;

  @override
  String toString() {
    return 'ItemSize{name: $name, price: $price, stock: $stock}';
  }
}
