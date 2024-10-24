import 'package:bookia_118/core/constants/app_strings.dart';
import 'package:bookia_118/core/constants/constants.dart';
import 'package:bookia_118/core/functions/navigation.dart';
import 'package:bookia_118/core/theming/app_colors.dart';
import 'package:bookia_118/core/theming/styles.dart';
import 'package:bookia_118/core/widgets/main_button.dart';
import 'package:bookia_118/feature/login/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PasswordChanged extends StatelessWidget {
  const PasswordChanged({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.backGround,
        width: 375,
        height: 812,
        child: Column(
          children: [
            const SizedBox(height: 248),
            SvgPicture.asset(AppImages.successSVG),
            const SizedBox(height: 35),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Password Changed!",
                    style: font30RegularDark.copyWith(fontSize: 26),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    "Your password has been changed successfully.",
                    style: font15RegularGray,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: MainButton(
                title: AppString.backToLogin,
                onTap: () {
                  AppFunctions.navigateTo(context, const LoginScreen());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
