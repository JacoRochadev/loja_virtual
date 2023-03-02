import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/presentetion/checkout/components/card_back.dart';
import 'package:loja_virtual/presentetion/checkout/components/card_front.dart';

class CreditCardWidget extends StatelessWidget {
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  CreditCardWidget({Key key}) : super(key: key);

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
              numberFocus: numberFocus,
              dateFocus: dateFocus,
              nameFocus: nameFocus,
              finished: () {
                cardKey.currentState.toggleCard();
                cvvFocus.requestFocus();
              },
            ),
            back: CardBack(
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
