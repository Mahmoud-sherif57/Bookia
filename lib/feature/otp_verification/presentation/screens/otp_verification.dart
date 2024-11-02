import 'package:bookia_118/core/constants/app_strings.dart';
import 'package:bookia_118/core/functions/navigation.dart';
import 'package:bookia_118/core/theming/app_colors.dart';
import 'package:bookia_118/core/theming/styles.dart';
import 'package:bookia_118/core/widgets/app_back_button.dart';
import 'package:bookia_118/core/widgets/main_button.dart';
import 'package:bookia_118/core/widgets/reusable_rich_text.dart';
import 'package:bookia_118/feature/create_new_password/presentation/screens/create_new_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../core/cubits/auth_cubit/auth_cubit.dart';
import '../../../../core/cubits/auth_cubit/auth_state.dart';
import '../../../../core/widgets/reusable_otp_field.dart';

class OtpVerification extends StatelessWidget {
  const OtpVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit.get(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          EasyLoading.showSuccess(" ${state.msg}");
          AppFunctions.navigateTo(context, const CreateNewPassword());
        } else if (state is AuthFailedState) {
          EasyLoading.showError(state.error);
          EasyLoading.dismiss();
        } else if (state is AuthLoadingState) {
          EasyLoading.show(status: "loading..");
        } else if (state is ResendOtpLoadingState) {
          EasyLoading.show(status: "loading..");
        } else if (state is ResendOtpSuccessState) {
          EasyLoading.showSuccess(" ${state.msg}");
          AppFunctions.navigateTo(context, const OtpVerification());
        } else if (state is ResendOtpFailedState) {
          EasyLoading.showError(state.error);
          EasyLoading.dismiss();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.backGround,
          body: Padding(
            padding: const EdgeInsets.all(22.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),
                  const AppBackButton(),
                  const SizedBox(height: 28),

                  ///------------the otp text---------->
                  SizedBox(
                    height: 39,
                    child: Text(
                      AppString.otpVerification,
                      style: font30RegularDark,
                    ),
                  ),
                  const SizedBox(height: 10),

                  ///------------the otp message---------->
                  SizedBox(
                    height: 48,
                    width: 331,
                    child: Text(
                      AppString.otpMessage,
                      style: font15RegularGray.copyWith(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 32),

                  ///------------the otp fields---------->
                  Row(
                    children: [
                      ReusableOtpField(controller: authCubit.otpController1),
                      const SizedBox(width: 17),
                      ReusableOtpField(controller: authCubit.otpController2),
                      const SizedBox(width: 17),
                      ReusableOtpField(controller: authCubit.otpController3),
                      const SizedBox(width: 17),
                      ReusableOtpField(controller: authCubit.otpController4)
                    ],
                  ),
                  const SizedBox(height: 38),

                  ///------------the verify button---------->
                  Center(
                    child: MainButton(
                      onTap: () {
                        if (state is AuthLoadingState) return;
                        authCubit.sendOtp();
                      },
                      title: AppString.verify,
                    ),
                  ),
                  const SizedBox(height: 345),

                  ///------------the richText---------->
                  ReusableRichText(
                    text1: AppString.didNotReceivedCode,
                    text2: AppString.resend,
                    onPressed: () {
                      // to prevent the user from calling the api while loading ⤵
                      if (state is AuthLoadingState) return;
                      // if the OTP code didn't received i call the endPoint again .
                      authCubit.forgotPassword();
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
