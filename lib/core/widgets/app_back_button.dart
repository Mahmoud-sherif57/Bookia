import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theming/app_colors.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: 41,
        height: 41,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Center(
          child: SvgPicture.asset(
            "assets/images/arrow_back.svg",
            width: 26,
            height: 26,
          ),
        ),
      ),
    );
  }
}
