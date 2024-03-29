import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/item_size.dart';
import 'package:uuid/uuid.dart';

class ProductModel extends ChangeNotifier {
  ProductModel(
      {this.id,
      this.name,
      this.description,
      this.images,
      this.sizes,
      this.deleted}) {
    deleted = deleted ?? false;
    images = images ?? [];
    sizes = sizes ?? [];
  }

  ProductModel.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document['name'] as String;
    description = document['description'] as String;
    images = List<String>.from(document['images'] as List<dynamic>);

    if (document.data().toString().contains('deleted')) {
      deleted = document['deleted'] as bool;
    } else {
      deleted = false;
    }

    if (document.data().toString().contains('sizes')) {
      sizes = (document['sizes'] as List<dynamic>)
          .map((s) => ItemSize.fromMap(s as Map<String, dynamic>))
          .toList();
    } else {
      sizes = [];
    }
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  DocumentReference get firestoreRef => firestore.doc('products/$id');
  Reference get storageRef => storage.ref().child('products').child(id);

  String id;
  String name;
  String description;
  List<String> images;
  List<ItemSize> sizes;
  List<dynamic> newImages;
  bool deleted;

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

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
    return totalStock > 0 && !deleted;
  }

  num get basePrice {
    num lowest = double.infinity;
    for (final size in sizes) {
      if (size.price < lowest) lowest = size.price;
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
      ..sizes = sizes.map((size) => size.clone()).toList()
      ..deleted = deleted;
  }

  List<Map<String, dynamic>> exportSizeList() {
    return sizes.map((size) => size.toMap()).toList();
  }

  Future<void> save() async {
    loading = true;
    final Map<String, dynamic> data = {
      'name': name,
      'description': description,
      'sizes': exportSizeList(),
      'deleted': deleted,
    };

    if (id == null) {
      final doc = await firestore.collection('products').add(data);
      id = doc.id;
    } else {
      await firestoreRef.update(data);
    }

    final List<String> updateImages = [];

    for (final newImage in newImages) {
      if (images.contains(newImage)) {
        updateImages.add(newImage as String);
      } else {
        final UploadTask task =
            storageRef.child(const Uuid().v1()).putFile(newImage as File);
        final TaskSnapshot snapshot = await task.whenComplete(() => null);
        final String url = await snapshot.ref.getDownloadURL();
        updateImages.add(url);
      }
    }

    for (final image in images) {
      if (!newImages.contains(image) && image.contains('firebase')) {
        try {
          final ref = storage.ref(image);
          await ref.delete();
        } catch (e) {
          debugPrint('Falha ao deletar $image');
        }
      }
    }

    await firestoreRef.update({'images': updateImages});
    images = updateImages;

    loading = false;
  }

  void delete() {
    firestoreRef.update({'deleted': true});
  }
}
