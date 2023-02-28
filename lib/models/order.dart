import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/models/adress.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:loja_virtual/models/cart_product.dart';

enum Status { canceled, preparing, transporting, delivered }

class Order {
  Order.fromCartManager(CartManager cartManager) {
    items = List.from(cartManager.items);
    price = cartManager.totalPrice;
    userId = cartManager.user.id;
    adress = cartManager.adress;
    status = Status.preparing;
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
    status = Status.values[document['status'] as int];
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> save() async {
    firestore.collection('orders').doc(orderId).set({
      'items': items.map((e) => e.toOrderItemMap()).toList(),
      'price': price,
      'userId': userId,
      'adress': adress.toMap(),
      'status': status.index,
      'date': Timestamp.now(),
    });
  }

  List<CartProduct> items;
  num price;
  String orderId;
  String userId;
  Adress adress;
  Timestamp date;
  Status status;

  String get formattedId => '#${orderId.padLeft(6, '0')}';

  String get statusText => getStatusText(status);

  static String getStatusText(Status status) {
    switch (status) {
      case Status.canceled:
        return 'Cancelado';
      case Status.preparing:
        return 'Em Preparação';
      case Status.transporting:
        return 'Em Transporte';
      case Status.delivered:
        return 'Entregue';
      default:
        return '';
    }
  }
}
