class SectionItem {
  SectionItem.fromMap(Map<String, dynamic> map) {
    image = map['image'];
    product = map['product'];
  }

  String image;
  String product;

  @override
  String toString() {
    return 'SectionItem{image: $product, image: $product}';
  }
}
