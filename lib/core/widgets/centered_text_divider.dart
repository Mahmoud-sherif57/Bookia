import 'package:bookia_118/core/theming/app_colors.dart';
import 'package:bookia_118/core/theming/styles.dart';
import 'package:flutter/material.dart';

class CenteredTextDivider extends StatelessWidget {
  const CenteredTextDivider(
      {super.key,
      required this.text,
      this.thickness = 1.0, // the default value is 1 .
      this.color = AppColors.gray});

  final String text;
  final double thickness;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Divider(
            thickness: thickness,
            color: color,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9.0),
          child: Text(
            text,
            style: font14RegularDarkGray.copyWith(color: AppColors.darkGray),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: thickness,
            color: color,
          ),
        ),
      ],
    );
  }
}
