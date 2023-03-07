import 'dart:collection';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/credit_card.dart';
import 'package:loja_virtual/models/user.dart';

class CieloPayment {
  final FirebaseFunctions functions = FirebaseFunctions.instance;

  Future<String> authorize(
      {CreditCard creditCard,
      num price,
      String orderId,
      UserModel user}) async {
    try {
      final Map<String, dynamic> dataSale = {
        'merchantOrderId': orderId,
        'amount': (price * 100).toInt(),
        'softDescriptor': 'Loja Daniel',
        'installments': 1,
        'creditCard': creditCard.toJson(),
        'cpf': user.cpf,
        'paymentType': 'CreditCard',
      };

      final HttpsCallable callable =
          functions.httpsCallable('authorizeCreditCard');
      final response = await callable.call(dataSale);

      final data = Map<String, dynamic>.from(response.data as LinkedHashMap);
      if (data['success'] as bool) {
        return data['paymentId'] as String;
      } else {
        debugPrint(data['error']['message']);
        return Future.error(data['error']['message']);
      }
    } catch (e) {
      debugPrint('Erro no pagamento: $e');
      return Future.error('Falha ao processar o pagamento');
    }
  }

  Future<void> capture(String payId) async {
    try {
      final Map<String, dynamic> captureData = {
        'payId': payId,
      };

      final HttpsCallable callable =
          functions.httpsCallable('captureCreditCard');
      final response = await callable.call(captureData);

      final data = Map<String, dynamic>.from(response.data as LinkedHashMap);

      if (data['success'] as bool) {
        debugPrint('Capturado com sucesso');
      } else {
        debugPrint('${data['error']['message']}');
        return Future.error(data['error']['message']);
      }
    } catch (e) {
      debugPrint('Erro no pagamento: $e');
      return Future.error('Falha ao processar o pagamento');
    }
  }

  Future<void> cancel(String payId) async {
    try {
      final Map<String, dynamic> cancelData = {
        'payId': payId,
      };

      final HttpsCallable callable =
          functions.httpsCallable('cancelCreditCard');
      final response = await callable.call(cancelData);

      final data = Map<String, dynamic>.from(response.data as LinkedHashMap);

      if (data['success'] as bool) {
        debugPrint('Cancelado com sucesso');
      } else {
        debugPrint('${data['error']['message']}');
        return Future.error(data['error']['message']);
      }
    } catch (e) {
      debugPrint('Erro no pagamento: $e');
      return Future.error('Falha ao processar o pagamento');
    }
  }
}
