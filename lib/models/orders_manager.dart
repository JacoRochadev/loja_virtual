import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user.dart';

import 'order.dart';

class OrdersManager extends ChangeNotifier {
  UserModel user;
  List<Order> orders = [];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void updateUser(UserModel user) {
    this.user = user;
    if (user != null) {
      _listenToOrders();
    }
  }

  void _listenToOrders() {
    firestore
        .collection('orders')
        .where('user', isEqualTo: user.id)
        .snapshots()
        .listen((snapshot) {
      orders.clear();
      for (final DocumentSnapshot document in snapshot.docs) {
        orders.add(Order.fromDocument(document));
      }
      notifyListeners();
    });
  }
}
