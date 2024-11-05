import 'package:bookia_118/core/theming/styles.dart';
import 'package:flutter/material.dart';

class ReusableRowForCart extends StatelessWidget {
  const ReusableRowForCart({super.key, required this.price, required this.text, this.style});
  final String? price;
  final String text;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            text,
            // style: font20BoldDark,
            style: style ?? font16MediumDark,
          ),
          const Spacer(),
          Text(
            // "$price \$",
            price != null ? "${double.parse(price!).toStringAsFixed(2)} \$" : "-",
            style: style ?? font16MediumDark,
            // style: font20BoldDark,
          ),
        ],
      ),
    );
  }
}

// double.parse(price.toStringAsFixed(2)), => to reduce price to 2 decimal places
