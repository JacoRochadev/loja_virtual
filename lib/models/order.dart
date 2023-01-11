import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/models/adress.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:loja_virtual/models/cart_product.dart';

class Order {
  Order.fromCartManager(CartManager cartManager) {
    items = List.from(cartManager.items);
    price = cartManager.totalPrice;
    userId = cartManager.user.id;
    adress = cartManager.adress;
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> save() {
    firestore.collection('orders').doc(orderId).set({
      'items': items.map((e) => e.toOrderItemMap()).toList(),
      'price': price,
      'userId': userId,
      'adress': adress.toMap(),
    });
  }

  List<CartProduct> items;
  num price;
  String orderId;
  String userId;
  Adress adress;
  Timestamp date;
}
