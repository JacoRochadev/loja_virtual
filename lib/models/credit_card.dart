import 'package:credit_card_type_detector/credit_card_type_detector.dart';

class CreditCard {
  String cardNumber;
  String cardHolderName;
  String expiryDate;
  String cvvCode;
  String brand;

  void setCardNumber(String cardNumber) {
    this.cardNumber = cardNumber;
    brand = detectCCType(cardNumber.replaceAll(' ', ''))
        .toString()
        .toUpperCase()
        .split(".")
        .last;
  }

  void setCardHolderName(String cardHolderName) =>
      cardHolderName = cardHolderName;
  void setExpiryDate(String expiryDate) => expiryDate = expiryDate;
  void setCvvCode(String cvvCode) => cvvCode = cvvCode;

  Map<String, dynamic> toMap() {
    return {
      'cardNumber': cardNumber.replaceAll(' ', ''),
      'cardHolderName': cardHolderName,
      'expiryDate': expiryDate,
      'cvvCode': cvvCode,
      'brand': brand,
    };
  }
}
