import 'package:bookia_118/core/constants/app_strings.dart';
import 'package:bookia_118/core/functions/navigation.dart';
import 'package:bookia_118/core/theming/app_colors.dart';
import 'package:bookia_118/core/theming/styles.dart';
import 'package:bookia_118/core/widgets/app_back_button.dart';
import 'package:bookia_118/core/widgets/main_button.dart';
import 'package:bookia_118/core/widgets/reusable_rich_text.dart';
import 'package:bookia_118/feature/wrapper_screen/presentation/screen/wrapper_screen.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/reusable_otp_field.dart';

class OtpVerification extends StatelessWidget {
  const OtpVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
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
                height: 28,
              ),
              ///------------the otp text---------->
              SizedBox(
                height: 39,
                child: Text(
                  AppString.otpVerification,
                  style: font30RegularDark,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ///------------the otp message---------->
              SizedBox(
                height: 48,
                width: 331,
                child: Text(
                    AppString.otpMessage,
                  style: font15RegularGray.copyWith(fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              ///------------the otp fields---------->
              const Row(
                children: [
                  ReusableOtpField(),
                  SizedBox(
                    width: 17,
                  ),
                  ReusableOtpField(),
                  SizedBox(
                    width: 17,
                  ),
                  ReusableOtpField(),
                  SizedBox(
                    width: 17,
                  ),
                  ReusableOtpField()
                ],
              ),
              const SizedBox(
                height: 38,
              ),
              ///------------the verify button---------->
              Center(
                child: MainButton(
                  onTap: (){AppFunctions.navigateTo(context, const WrapperHomeScreen());},
                  title: AppString.verify,
                ),
              ),
              const SizedBox(
                height: 345,  //357
              ),
              ///------------the richText---------->
              ReusableRichText(
                text1:  AppString.didNotReceivedCode,
                text2:  AppString.resend,
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
