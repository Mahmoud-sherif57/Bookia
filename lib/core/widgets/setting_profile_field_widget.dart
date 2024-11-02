import 'package:flutter/material.dart';

import '../theming/app_colors.dart';
import '../theming/styles.dart';

class SettingProfileFieldsField extends StatelessWidget {
  const SettingProfileFieldsField({super.key, required this.text,  this.onPressed});

  final String text;
  final void Function()? onPressed ;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: 320,
        decoration: BoxDecoration(
          color: AppColors.backGround,
          // border: Border.all(color: AppColors.primary.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(-10, 15),
              blurRadius: 5,
              spreadRadius: 2,
              color: AppColors.gray.withOpacity(0.3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: font18RegularDark,
              ),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
