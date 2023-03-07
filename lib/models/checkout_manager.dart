import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/credit_card.dart';
import 'package:loja_virtual/models/product.dart';
import 'package:loja_virtual/services/cielo_payment.dart';

import 'cart_manager.dart';
import 'order.dart';

class CheckoutManager extends ChangeNotifier {
  CartManager cartManager;

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final CieloPayment cieloPayment = CieloPayment();

  // ignore: use_setters_to_change_properties
  void updateCart(CartManager cartManager) {
    this.cartManager = cartManager;
  }

  Future<void> checkout(
      {CreditCard creditCard,
      Function onStockFail,
      Function onSuccess,
      Function onPayFail}) async {
    loading = true;

    final orderId = await _getOrderId();
    String payId;
    try {
      payId = await cieloPayment.authorize(
        creditCard: creditCard,
        price: cartManager.totalPrice,
        orderId: orderId.toString(),
        user: cartManager.user,
      );
      debugPrint('sucess PAYID: $payId');
    } catch (e) {
      onPayFail(e);
      loading = false;
      return;
    }

    try {
      await _decrementStock();
    } catch (e) {
      onStockFail(e);
      loading = false;
      return;
    }

    try {
      await cieloPayment.capture(payId);
    } on Exception catch (e) {
      onPayFail(e);
      loading = false;
      return;
    }

    final order = Order.fromCartManager(cartManager);
    order.orderId = orderId.toString();
    order.payId = payId;
    await order.save();
    cartManager.clear();

    onSuccess(order);
    loading = false;
  }

  Future<int> _getOrderId() async {
    final ref = firestore.doc('aux/ordercounter');

    try {
      final result = await firestore.runTransaction((tx) async {
        final doc = await tx.get(ref);
        final orderId = doc['current'] as int;
        tx.update(ref, {'current': orderId + 1});
        return {'orderId': orderId};
      });
      return result['orderId'];
    } catch (e) {
      debugPrint(e.toString());
      return Future.error('Falha ao gerar número do pedido');
    }
  }

  Future<void> _decrementStock() {
    // 1. Ler todos os estoques 3xM
    // 2. Decremento localmente os estoques 2xM
    // 3. Salvar os estoques no firebase 2xM

    return firestore.runTransaction((tx) async {
      final List<ProductModel> productsToUpdate = [];
      final List<ProductModel> productsWithoutStock = [];

      for (final cartProduct in cartManager.items) {
        ProductModel product;

        if (productsToUpdate.any((p) => p.id == cartProduct.productId)) {
          product =
              productsToUpdate.firstWhere((p) => p.id == cartProduct.productId);
        } else {
          final doc =
              await tx.get(firestore.doc('products/${cartProduct.productId}'));
          product = ProductModel.fromDocument(doc);
        }

        cartProduct.product = product;

        final size = product.findSize(cartProduct.size);
        if (size.stock - cartProduct.quantity < 0) {
          productsWithoutStock.add(product);
        } else {
          size.stock -= cartProduct.quantity;
          productsToUpdate.add(product);
        }
      }

      if (productsWithoutStock.isNotEmpty) {
        return Future.error(
            '${productsWithoutStock.length} produtos sem estoque');
      }

      for (final product in productsToUpdate) {
        tx.update(firestore.doc('products/${product.id}'),
            {'sizes': product.exportSizeList()});
      }
    });
  }
}
