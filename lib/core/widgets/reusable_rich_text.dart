import 'package:bookia_118/core/theming/app_colors.dart';
import 'package:bookia_118/core/theming/styles.dart';
import 'package:flutter/material.dart';

class ReusableRichText extends StatelessWidget {
  const ReusableRichText({
    super.key,
    required this.text1,
    required this.text2,
    this.onPressed,
  });

  final String text1;
  final String text2;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text1,
          style: font15RegularGray.copyWith(color: AppColors.black),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            text2,
            style: font15RegularGray.copyWith(color: AppColors.primary),
          ),
        )
      ],
    );
  }
}

// 'Don’t have an account?'
//'Register Now'
