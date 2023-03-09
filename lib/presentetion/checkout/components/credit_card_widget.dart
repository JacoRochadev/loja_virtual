import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/credit_card.dart';
import 'package:loja_virtual/presentetion/checkout/components/card_back.dart';
import 'package:loja_virtual/presentetion/checkout/components/card_front.dart';

class CreditCardWidget extends StatefulWidget {
  const CreditCardWidget({Key key, this.creditCard}) : super(key: key);

  final CreditCard creditCard;

  @override
  State<CreditCardWidget> createState() => _CreditCardWidgetState();
}

class _CreditCardWidgetState extends State<CreditCardWidget> {
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  final FocusNode numberFocus = FocusNode();
  final FocusNode dateFocus = FocusNode();
  final FocusNode nameFocus = FocusNode();
  final FocusNode cvvFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FlipCard(
            key: cardKey,
            direction: FlipDirection.HORIZONTAL,
            speed: 700,
            front: CardFront(
              creditCard: widget.creditCard,
              numberFocus: numberFocus,
              dateFocus: dateFocus,
              nameFocus: nameFocus,
              finished: () {
                cardKey.currentState.toggleCard();
                cvvFocus.requestFocus();
              },
            ),
            back: CardBack(
              creditCard: widget.creditCard,
              cvvFocus: cvvFocus,
            ),
          ),
          TextButton(
            onPressed: () {
              cardKey.currentState.toggleCard();
            },
            child: const Text('Virar Cartão',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
