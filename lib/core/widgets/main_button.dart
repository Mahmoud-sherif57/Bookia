import 'package:flutter/material.dart';
import '../theming/app_colors.dart';
import '../theming/styles.dart';

class MainButton extends StatelessWidget {
  const MainButton({super.key, required this.title, this.onTap,  this.width = 280, this.color = AppColors.primary,  this.height = 56 });

  final String title;
  final double width ;
  final double height ;
 final Color? color ;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: color,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: width,  //331
          // width: 280,  //331
          // height: 56,
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            title,
            style: font20mediumWhite,
          ),
        ),
      ),
    );
  }
}


