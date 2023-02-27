import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user.dart';

import 'order.dart';

class OrdersManager extends ChangeNotifier {
  UserModel user;
  List<Order> orders = [];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  StreamSubscription _subscription;

  void updateUser(UserModel user) {
    this.user = user;
    orders.clear();

    _subscription?.cancel();
    if (user != null) {
      _listenToOrders();
    }
  }

  void _listenToOrders() {
    _subscription = firestore
        .collection('orders')
        .where('user', isEqualTo: user.id)
        .snapshots()
        .listen((snapshot) {
      orders.clear();
      for (final DocumentSnapshot document in snapshot.docs) {
        orders.add(Order.fromDocument(document));
      }
      print(orders.toString());
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}
