class SectionItem {
  SectionItem({this.image, this.product});
  SectionItem.fromMap(Map<String, dynamic> map) {
    image = map['image'];
    product = map['product'];
  }

  dynamic image;
  String product;

  SectionItem clone() {
    return SectionItem(image: image, product: product);
  }

  @override
  String toString() {
    return 'SectionItem{image: $product, image: $product}';
  }
}
