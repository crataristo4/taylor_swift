import 'package:flutter/material.dart';

class ItemRows extends StatelessWidget {
  final Widget widgetA;
  final Widget widgetB;

  const ItemRows({Key? key, required this.widgetA, required this.widgetB})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [widgetA, widgetB],
    );
  }
}
