import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual/presentetion/checkout/components/card_text_field.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CardFront extends StatelessWidget {
  const CardFront({Key key}) : super(key: key);

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
          child: Expanded(
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
                      title: 'Número do Cartão',
                      bold: true,
                      hint: '0000.0000.0000.0000',
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(16),
                      ],
                    ),
                    CardTextField(
                      title: 'Validade',
                      bold: true,
                      hint: '00/0000',
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        dateFormatter,
                      ],
                    ),
                    const CardTextField(
                      title: 'Titular do Cartão',
                      bold: true,
                      hint: 'Jaco R Ferreira',
                      keyboardType: TextInputType.text,
                    ),
                  ],
                ))
              ],
            ),
          ),
        ));
  }
}
