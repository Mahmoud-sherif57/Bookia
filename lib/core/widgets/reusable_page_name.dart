import 'package:flutter/material.dart';
import '../theming/app_colors.dart';
import '../theming/styles.dart';

class ReusablePageName extends StatelessWidget {
  const ReusablePageName({super.key, required this.text,  this.width =150,  this.height =40 });

  final String text;
  final double width , height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(color: AppColors.beige ,width: 1),
        boxShadow: [
          BoxShadow(
            offset: const Offset(-4, 8),
            color: AppColors.gray.withOpacity(0.5),
            blurRadius: 10,
          ),
        ],
        borderRadius: BorderRadius.circular(15),
        color: AppColors.backGround.withOpacity(0.8),
      ),
      width: width, //150
      height: height,  //40
      child: Center(
        child: Text(
          text,
          style: font24RegularDark,
        ),
      ),
    );
  }
}
