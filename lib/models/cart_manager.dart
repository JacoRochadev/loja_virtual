import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loja_virtual/models/adress.dart';
import 'package:loja_virtual/models/cart_product.dart';
import 'package:loja_virtual/models/product.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/user_manager.dart';

import '../services/cep_aberto.dart';

class CartManager extends ChangeNotifier {
  List<CartProduct> items = [];

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  UserModel user;
  Adress adress;
  final firestore = FirebaseFirestore.instance;

  num productsPrice = 0.0;
  num deliveryPrice;

  num get totalPrice => productsPrice + (deliveryPrice ?? 0);

  void updateUser(UserManager userManager) {
    user = userManager.userModel;
    productsPrice = 0.0;
    items.clear();
    removeAdress();

    if (user != null) {
      _loadCartItems();
      _loadUserAdress();
    }
  }

  Future<void> _loadUserAdress() async {
    if (user.adress != null &&
        await calculateDelivery(user.adress.latitude, user.adress.longitude)) {
      adress = user.adress;
      notifyListeners();
    }
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await user.cartReference.get();

    items = cartSnap.docs
        .map((d) => CartProduct.fromDocument(d)..addListener(_onItemUpdated))
        .toList();
  }

  void addToCart(ProductModel product) {
    try {
      final e = items.firstWhere((e) => e.stacklable(product));
      e.increment();
    } catch (e) {
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct.addListener(_onItemUpdated);
      items.add(cartProduct);
      user.cartReference
          .add(cartProduct.toCartItemMap())
          .then((doc) => cartProduct.id = doc.id);
      _onItemUpdated();
    }
    notifyListeners();
  }

  void _onItemUpdated() {
    productsPrice = 0.0;
    for (int i = 0; i < items.length; i++) {
      final cartProduct = items[i];
      if (cartProduct.quantity == 0) {
        removeOfCart(cartProduct);
        i--;
        continue;
      }
      productsPrice += cartProduct.totalPrice;
      _updateCartProduct(cartProduct);
      notifyListeners();
    }
  }

  void _updateCartProduct(CartProduct cartProduct) {
    if (cartProduct.id != null) {
      user.cartReference
          .doc(cartProduct.id)
          .update(cartProduct.toCartItemMap());
    }
  }

  void removeOfCart(CartProduct cartProduct) {
    items.removeWhere((p) => p.id == cartProduct.id);
    user.cartReference.doc(cartProduct.id).delete();
    cartProduct.removeListener(_onItemUpdated);
    notifyListeners();
  }

  bool get isCartValid {
    for (final cartProduct in items) {
      if (!cartProduct.hasStock) return false;
    }
    return true;
  }

  bool get isAdressValid => adress != null && deliveryPrice != null;

  Future<void> getadress(String cep) async {
    loading = true;

    final cepAbertoService = CepAbertoService();

    try {
      final cepAbertoadress = await cepAbertoService.getAdressFromCep(cep);

      if (cepAbertoadress != null) {
        adress = Adress(
            street: cepAbertoadress.logradouro,
            district: cepAbertoadress.bairro,
            zip: cepAbertoadress.cep,
            city: cepAbertoadress.cidade.nome,
            state: cepAbertoadress.estado.sigla,
            latitude: cepAbertoadress.latitude,
            longitude: cepAbertoadress.longitude);
      }

      loading = false;
    } catch (e) {
      loading = false;
      return Future.error('CEP Inválido');
    }
  }

  void removeAdress() {
    adress = null;
    deliveryPrice = null;
    notifyListeners();
  }

  Future<void> setAdress(Adress adress) async {
    loading = true;
    this.adress = adress;

    if (await calculateDelivery(adress.latitude, adress.longitude)) {
      user.setAdress(adress);
      loading = false;
    } else {
      loading = false;
      return Future.error('Endereço fora do raio de entrega');
    }
  }

  Future<bool> calculateDelivery(double lat, double long) async {
    final DocumentSnapshot doc = await firestore.doc('aux/delivery').get();
    final latStore = doc['lat'] as double;
    final longStore = doc['long'] as double;
    final maxkm = doc['maxkm'] as num;

    final base = doc['base'] as num;
    final km = doc['km'] as num;

    double distance =
        Geolocator.distanceBetween(latStore, longStore, lat, long);
    distance /= 1000.0;

    if (distance > maxkm) {
      return false;
    }
    deliveryPrice = 10;
    return true;
  }

  void clear() {
    for (final cartProduct in items) {
      user.cartReference.doc(cartProduct.id).delete();
    }
    items.clear();
    productsPrice = 0.0;
    deliveryPrice = null;
    notifyListeners();
  }
}
