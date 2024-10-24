import 'package:bookia_118/core/constants/app_strings.dart';
import 'package:bookia_118/core/constants/constants.dart';
import 'package:bookia_118/core/functions/navigation.dart';
import 'package:bookia_118/core/theming/styles.dart';
import 'package:bookia_118/core/widgets/main_button.dart';
import 'package:bookia_118/feature/login/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/theming/app_colors.dart';
import '../../register/presentation/screens/register_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///---------the background image--------->
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.asset(AppImages.onBoardingImage).image,
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 230,
            ),
            ///---------the onBoarding text--------->
            Text(
              AppString.introSplash,
              style: font20RegularDark,
            ),
            const SizedBox(
              height: 333,
            ),
            ///---------the log in button--------->
            Center(
              child: MainButton(
                  onTap: () {
                    AppFunctions.navigateTo(context, const LoginScreen());
                  },
                  title: AppString.login),
            ),
            const SizedBox(
              height: 15,
            ),
            ///---------the register button--------->
            InkWell(
              onTap: () {
                AppFunctions.navigateTo(context, const RegisterScreen());
              },
              child: Container(
                width: 331,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.dark),
                    color: Colors.white),
                child: Text(
                  AppString.register,
                  style: font15RegularWhite.copyWith(color: AppColors.dark),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
