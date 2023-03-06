import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual/models/credit_card.dart';
import 'package:loja_virtual/presentetion/checkout/components/card_text_field.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CardFront extends StatelessWidget {
  final FocusNode numberFocus;
  final FocusNode dateFocus;
  final FocusNode nameFocus;
  final VoidCallback finished;
  final CreditCard creditCard;
  const CardFront(
      {Key key,
      this.numberFocus,
      this.dateFocus,
      this.nameFocus,
      this.finished,
      this.creditCard})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormatter = MaskTextInputFormatter(
      mask: '!#/####',
      filter: {'#': RegExp(r'[0-9]'), '!': RegExp(r'[0-1]')},
    );
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF134B52),
              Color(0xFF134B52),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Icon(
                        Icons.credit_card,
                        color: Colors.white,
                        size: 50,
                      ),
                    ],
                  ),
                  CardTextField(
                    initialValue: creditCard.number,
                    title: 'Número do Cartão',
                    bold: true,
                    hint: '0000.0000.0000.0000',
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(16),
                    ],
                    onSaved: creditCard.setNumber,
                    onFieldSubmitted: (_) {
                      dateFocus.requestFocus();
                    },
                    focusNode: numberFocus,
                    validator: (number) {
                      if (number.isEmpty ||
                          number.length != 16 ||
                          detectCCType(number) == CreditCardType.unknown) {
                        return 'Inválido';
                      }
                      return null;
                    },
                  ),
                  CardTextField(
                    initialValue: creditCard.expirationDate,
                    title: 'Validade',
                    bold: true,
                    hint: '00/0000',
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      dateFormatter,
                    ],
                    onSaved: creditCard.setExpirationDate,
                    focusNode: dateFocus,
                    onFieldSubmitted: (_) {
                      nameFocus.requestFocus();
                    },
                    validator: (date) {
                      if (date.isEmpty || date.length != 7) {
                        return 'Inválido';
                      }
                      return null;
                    },
                  ),
                  CardTextField(
                    initialValue: creditCard.holder,
                    title: 'Titular do Cartão',
                    bold: true,
                    hint: 'Jaco R Ferreira',
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (_) {
                      finished();
                    },
                    onSaved: creditCard.setHolder,
                    focusNode: nameFocus,
                    validator: (name) {
                      if (name.isEmpty) {
                        return 'Inválido';
                      }
                      return null;
                    },
                  ),
                ],
              ))
            ],
          ),
        ));
  }
}
