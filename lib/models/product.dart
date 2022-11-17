import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/item_size.dart';

class ProductModel extends ChangeNotifier {
  //ProductModel({this.name, this.description, this.images});
  ProductModel(
      {this.id, this.name, this.description, this.images, this.sizes}) {
    images = images ?? [];
    sizes = sizes ?? [];
  }

  ProductModel.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document['name'] as String;
    description = document['description'] as String;
    images = List<String>.from(document['images'] as List<dynamic>);
    if (document.data().toString().contains('sizes')) {
      sizes = (document['sizes'] as List<dynamic>)
          .map((s) => ItemSize.fromMap(s as Map<String, dynamic>))
          .toList();
    } else {
      sizes = [];
    }
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  DocumentReference get firestoreRef => firestore.doc('products/$id');

  String id;
  String name;
  String description;
  List<String> images;
  List<ItemSize> sizes;
  List<dynamic> newImages;

  ItemSize _selectedSize;
  ItemSize get selectedSize => _selectedSize;

  set selectedSize(ItemSize value) {
    _selectedSize = value;
    notifyListeners();
  }

  int get totalStock {
    int stock = 0;
    for (final size in sizes) {
      stock += size.stock;
    }
    return stock;
  }

  bool get hasStock {
    return totalStock > 0;
  }

  num get basePrice {
    num lowest = double.infinity;
    for (final size in sizes) {
      if (size.price < lowest && size.hasStock) lowest = size.price;
    }
    return lowest;
  }

  ItemSize findSize(String name) {
    try {
      return sizes.firstWhere((s) => s.name == name);
    } catch (e) {
      return null;
    }
  }

  ProductModel clone() {
    return ProductModel()
      ..id = id
      ..name = name
      ..description = description
      ..images = List.from(images)
      ..sizes = sizes.map((size) => size.clone()).toList();
  }

  List<Map<String, dynamic>> exportSizeList() {
    return sizes.map((size) => size.toMap()).toList();
  }

  Future<void> save() async {
    final Map<String, dynamic> data = {
      'name': name,
      'description': description,
      //'images': images,
      'sizes': exportSizeList(),
    };

    if (id == null) {
      final doc = await firestore.collection('products').add(data);
      id = doc.id;
    } else {
      await firestoreRef.update(data);
    }
  }
}
