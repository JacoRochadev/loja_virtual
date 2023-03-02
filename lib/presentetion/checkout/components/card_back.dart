import 'package:flutter/material.dart';

class CardBack extends StatelessWidget {
  const CardBack({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: const Color(0xFF134B52),
      child: Container(
        height: 200,
      ),
    );
  }
}
