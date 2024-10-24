import 'package:bookia_118/core/constants/app_strings.dart';
import 'package:bookia_118/core/functions/navigation.dart';
import 'package:bookia_118/core/theming/app_colors.dart';
import 'package:bookia_118/core/theming/styles.dart';
import 'package:bookia_118/core/widgets/app_back_button.dart';
import 'package:bookia_118/core/widgets/main_button.dart';
import 'package:bookia_118/core/widgets/reusable_text_form_field.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backGround,
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              const AppBackButton(),
              const SizedBox(
                height: 74,
              ),
              SizedBox(
                height: 39,
                child: Center(
                  child: Text(
                    AppString.newPassword,
                    style: font30RegularDark,
                  ),
                ),
              ),
              const SizedBox(
                height: 44,
              ),
              ///------------the current password field---------->
              const ReusableTextFormField(
                hintText: "",
                labelText: AppString.currentPassword,
                // suffixIcon: IconButton(
                //   onPressed: () {},
                //   icon: const Icon(Icons.remove_red_eye),
                // ),
                obscureText: false,
              ),
              const SizedBox(height: 26),
              ///-----------the new password field---------->
              ReusableTextFormField(
                hintText: "",
                labelText: AppString.newPassword,
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.remove_red_eye),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 26),
              ///-----------the confirm password field---------->
              ReusableTextFormField(
                hintText: "",
                labelText: AppString.confirmPassword,
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.remove_red_eye),
                ),
                obscureText: true,
              ),
              const SizedBox(
                height: 45,
              ),
              ///------------the reset password button---------->
              Center(
                child: MainButton(
                  onTap: () {
                    AppFunctions.navigatePop(context);
                  },
                  title: AppString.updatePassword,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
