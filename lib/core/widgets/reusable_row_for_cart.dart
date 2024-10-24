import 'package:bookia_118/core/theming/styles.dart';
import 'package:flutter/material.dart';

class ReusableRowForCart extends StatelessWidget {
  const ReusableRowForCart({super.key, required this.price, required this.text});
  final num price;
  final String text;
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
            style: font16MediumDark,
          ),
          const Spacer(),
          Text(
            "${price.toStringAsFixed(2).toString()} \$",
            style: font16MediumDark,
            // style: font20BoldDark,
          ),
        ],
      ),
    );
  }
}

// double.parse(price.toStringAsFixed(2)), => to reduce price to 2 decimal places
