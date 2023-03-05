import 'package:credit_card_type_detector/credit_card_type_detector.dart';

class CreditCard {
  String cardNumber;
  String cardHolderName;
  String expiryDate;
  String cvvCode;
  String brand;

  void setCardNumber(String cardNumber) {
    this.cardNumber = cardNumber;
    brand = detectCCType(cardNumber.replaceAll(' ', '')).toString();
  }

  void setCardHolderName(String cardHolderName) =>
      cardHolderName = cardHolderName;
  void setExpiryDate(String expiryDate) => expiryDate = expiryDate;
  void setCvvCode(String cvvCode) => cvvCode = cvvCode;
}
