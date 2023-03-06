import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual/presentetion/checkout/components/card_text_field.dart';

import '../../../models/credit_card.dart';

class CardBack extends StatelessWidget {
  final FocusNode cvvFocus;
  final CreditCard creditCard;
  const CardBack({Key key, this.cvvFocus, this.creditCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: const Color(0xFF134B52),
      child: SizedBox(
        height: 200,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              height: 50,
              color: Colors.black,
            ),
            Row(
              children: [
                Expanded(
                    flex: 70,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 10),
                      color: Colors.grey[500],
                      child: CardTextField(
                        bold: true,
                        hint: 'CVV',
                        keyboardType: TextInputType.number,
                        onSaved: creditCard.setCVV,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                        textAlign: TextAlign.end,
                        focusNode: cvvFocus,
                        validator: (cvv) {
                          if (cvv.isEmpty || cvv.length != 3) {
                            return 'Inválido';
                          }
                          return null;
                        },
                      ),
                    )),
                Expanded(
                  flex: 30,
                  child: Container(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
