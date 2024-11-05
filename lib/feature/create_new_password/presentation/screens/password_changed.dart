import 'package:bookia_118/core/constants/app_strings.dart';
import 'package:bookia_118/core/constants/constants.dart';
import 'package:bookia_118/core/functions/navigation.dart';
import 'package:bookia_118/core/theming/app_colors.dart';
import 'package:bookia_118/core/theming/styles.dart';
import 'package:bookia_118/core/widgets/main_button.dart';
import 'package:bookia_118/feature/login/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/cubits/auth_cubit/auth_cubit.dart';
import '../../../../core/cubits/auth_cubit/auth_state.dart';

class PasswordChanged extends StatelessWidget {
  const PasswordChanged({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit.get(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          EasyLoading.showSuccess(" ${state.msg}");
          AppFunctions.navigateTo(context, const PasswordChanged());
        } else if (state is AuthFailedState) {
          EasyLoading.showError(state.error);
          EasyLoading.dismiss();
        } else if (state is AuthLoadingState) {
          EasyLoading.show(status: "loading..");
        }
      },
      builder: (context, state) {
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
                      const SizedBox(height: 3),
                      Text(
                        textAlign: TextAlign.center,
                        "Your password has been changed successfully.",
                        style: font15RegularGray,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 40),
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
      },
    );
  }
}
