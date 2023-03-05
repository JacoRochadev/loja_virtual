import 'package:flutter/material.dart';
import 'package:loja_virtual/components/price_card.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:loja_virtual/presentetion/checkout/components/cpf_field.dart';
import 'package:provider/provider.dart';

import '../../models/checkout_manager.dart';
import 'components/credit_card_widget.dart';

class CheckoutScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  CheckoutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CartManager, CheckoutManager>(
      create: (_) => CheckoutManager(),
      update: (_, cartManager, checkoutManager) =>
          checkoutManager..updateCart(cartManager),
      lazy: false,
      child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: const Text('Pagamento'),
            centerTitle: true,
          ),
          body: Consumer<CheckoutManager>(
            builder: (_, checkoutManager, __) {
              if (checkoutManager.loading) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Processando seu pagamento...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Form(
                key: formKey,
                child: ListView(
                  children: [
                    CreditCardWidget(),
                    const CpfField(),
                    PriceCard(
                      buttonText: 'Finalizar Pedido',
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          return checkoutManager.checkout(
                            onStockFail: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Falha ao realizar o pedido'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              Navigator.of(context).popUntil(
                                  (route) => route.settings.name == '/cart');
                            },
                            onSuccess: (order) {
                              Navigator.of(context).popUntil(
                                  (route) => route.settings.name == '/');
                              Navigator.of(context)
                                  .pushNamed('/confirmation', arguments: order);
                            },
                          );
                        }
                      },
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}
