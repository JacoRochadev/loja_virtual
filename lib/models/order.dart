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

  Order.fromDocument(DocumentSnapshot document) {
    orderId = document.id;
    items = (document['items'] as List<dynamic>).map((e) {
      return CartProduct.fromMap(e as Map<String, dynamic>);
    }).toList();
    price = document['price'] as num;
    userId = document['userId'] as String;
    adress = Adress.fromMap(document['adress'] as Map<String, dynamic>);
    date = document['date'] as Timestamp;
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> save() async {
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

  @override
  String toString() {
    return 'Order{items: $items, price: $price, orderId: $orderId, userId: $userId, adress: $adress, date: $date}';
  }
}
