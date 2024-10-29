import 'package:bookia_118/core/theming/app_colors.dart';
import 'package:bookia_118/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReusableOtpField extends StatelessWidget {
  final dynamic controller;

  const ReusableOtpField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 66, // it's 70 in figma
      height: 60,
      child: TextFormField(
        controller: controller,
        // the next step is to move the indicator to next field automatically .
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        onSaved: (_) {},
        decoration: InputDecoration(
          fillColor: AppColors.backGround,
          filled: true,
          hintText: "",
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primary, width: 1.2),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.border, width: 1),
              borderRadius: BorderRadius.circular(8)),
        ),
        style: font22BoldDark,
        keyboardType: TextInputType.number,
        showCursor: false,
        textAlign: TextAlign.center,
        textInputAction: TextInputAction.next,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1), // it accepts just one input .
          FilteringTextInputFormatter.digitsOnly, // it accepts just digits not letters .
        ],
      ),
    );
  }
}
