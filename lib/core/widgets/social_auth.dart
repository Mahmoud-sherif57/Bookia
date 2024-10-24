import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theming/app_colors.dart';

class SocialAuth extends StatelessWidget {
  final String image;
  final void Function()? onTap;
  const SocialAuth({super.key, required this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: AppColors.backGround,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 98, // it's 105 in figma
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.backGround,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 2, color: AppColors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SvgPicture.asset(
              image,
              fit: BoxFit.contain,
              width: 26,
              height: 26,
            ),
          ),
        ),
      ),
    );
  }
}
