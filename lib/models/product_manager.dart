import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/product.dart';

class ProductManager extends ChangeNotifier {
  ProductManager() {
    _loadAllProducts();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<ProductModel> allProducts = [];

  String _search = '';

  String get search => _search;

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<ProductModel> get filteredProducts {
    final List<ProductModel> filteredProducts = [];

    if (search.isEmpty) {
      filteredProducts.addAll(allProducts);
    } else {
      filteredProducts.addAll(
        allProducts.where(
          (p) => p.name.toString().toLowerCase().contains(search.toLowerCase()),
        ),
      );
    }

    return filteredProducts;
  }

  Future<void> _loadAllProducts() async {
    final QuerySnapshot snapProducts =
        await firestore.collection('products').get();
    allProducts =
        snapProducts.docs.map((d) => ProductModel.fromDocument(d)).toList();

    notifyListeners();
  }

  ProductModel findProductById(String id) {
    try {
      return allProducts.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  void update(ProductModel product) {
    allProducts.removeWhere((p) => p.id == product.id);
    allProducts.add(product);
    notifyListeners();
  }
}
