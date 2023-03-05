import 'package:cloud_functions/cloud_functions.dart';
import 'package:loja_virtual/models/credit_card.dart';
import 'package:loja_virtual/models/user.dart';

class CieloPayment {
  final functions = FirebaseFunctions.instance;
  void authorize(
      {CreditCard creditCard,
      num price,
      String orderId,
      UserModel user}) async {
    final Map<String, dynamic> dataSale = {
      'MerchantOrderId': orderId,
      'amount': (price * 100).toInt(),
      'softDescriptor': 'Loja jaco',
      'installments': 1,
      'creditCard': creditCard.toMap(),
      'cpf': user.cpf,
      'paymentType': 'CreditCard',
    };
    final HttpsCallable callable =
        functions.httpsCallable('authorizeCreditCard');
    final response = await callable.call(dataSale);
    print(response.data);
  }
}
