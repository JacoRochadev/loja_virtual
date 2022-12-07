import 'package:flutter/cupertino.dart';

import 'cart_manager.dart';

class CheckoutManager extends ChangeNotifier {
  CartManager cartManager;
  void updateCart(CartManager cartManager) {
    this.cartManager = cartManager;

    print(cartManager.productsPrice);
  }
}
