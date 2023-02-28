import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user.dart';
import 'order.dart';

class AdminOrdersManager extends ChangeNotifier {
  UserModel user;
  UserModel userFilter;
  final List<Order> _orders = [];
  List<Order> get filteredOrders {
    List<Order> output = _orders.reversed.toList();
    if (userFilter != null) {
      output = output.where((o) => o.userId == userFilter.id).toList();
    }
    return output;
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  StreamSubscription _subscription;

  void updateAdmin(bool adminEnabled) {
    _orders.clear();

    _subscription?.cancel();
    if (adminEnabled) {
      _listenToOrders();
    }
  }

  void _listenToOrders() {
    _subscription = firestore.collection('orders').snapshots().listen((event) {
      for (final change in event.docChanges) {
        switch (change.type) {
          case DocumentChangeType.added:
            _orders.add(Order.fromDocument(change.doc));
            break;
          case DocumentChangeType.modified:
            final modOrder =
                _orders.firstWhere((o) => o.orderId == change.doc.id);
            modOrder.updateFromDocument(change.doc);
            break;
          case DocumentChangeType.removed:
            debugPrint('Removido');
            break;
        }
      }
      notifyListeners();
    });
  }

  void setUserFilter(UserModel user) {
    userFilter = user;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}
