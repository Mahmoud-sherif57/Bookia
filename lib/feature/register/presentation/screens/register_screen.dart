import 'package:bookia_118/core/constants/app_strings.dart';
import 'package:bookia_118/core/constants/constants.dart';
import 'package:bookia_118/core/functions/navigation.dart';
import 'package:bookia_118/core/theming/app_colors.dart';
import 'package:bookia_118/core/theming/styles.dart';
import 'package:bookia_118/core/widgets/app_back_button.dart';
import 'package:bookia_118/core/widgets/centered_text_divider.dart';
import 'package:bookia_118/core/widgets/main_button.dart';
import 'package:bookia_118/core/widgets/reusable_rich_text.dart';
import 'package:bookia_118/core/widgets/reusable_text_form_field.dart';
import 'package:bookia_118/core/widgets/social_auth.dart';
import 'package:bookia_118/feature/login/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cubits/auth_cubit/auth_cubit.dart';
import '../../../../core/cubits/auth_cubit/auth_state.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit.get(context);
    return SafeArea(
      child: BlocConsumer<AuthCubit, AuthState>(
  listener: (context, state) {},
  builder: (context, state) {
    return Scaffold(
        backgroundColor: AppColors.backGround,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 11,
                ),
                const AppBackButton(),
                const SizedBox(height: 29),
                ///------------the register welcome message---------->
                SizedBox(
                  width: 331,
                  height: 78, // it's 78 in figma but it doesn't fit.
                  child: Text(AppString.registerWelcomeMessage, style: font30RegularDark),
                ),
                const SizedBox(
                  height: 32,
                ),
                ///-------the user name field-------->
                const ReusableTextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  hintText: "",
                  labelText: AppString.userName,
                ),
                const SizedBox(
                  height: 12,
                ),
                ///-------the email field-------->
                const ReusableTextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  hintText: "",
                  labelText: AppString.email,
                ),
                const SizedBox(
                  height: 12,
                ),
                ///-------the password field-------->
                ReusableTextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: authCubit.hidden,
                  hintText: "",
                  suffixIcon: IconButton(
                    onPressed: () {
                      authCubit.togglePassword();
                    },
                    icon: const Icon(Icons.remove_red_eye),
                  ),
                  labelText: AppString.password,
                ),
                const SizedBox(
                  height: 12,
                ),
                ///-------the confirm password field-------->
                 ReusableTextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: authCubit.hidden,
                  hintText: "",
                  suffixIcon: IconButton(
                    onPressed: () {
                      authCubit.togglePassword();
                    },
                    icon: const Icon(Icons.remove_red_eye),
                  ),
                  labelText: AppString.confirmPassword,
                ),
                const SizedBox(
                  height: 30,
                ),
                ///------------the register button---------->
                Center(
                  child: MainButton(
                      onTap: () {
                        AppFunctions.navigateTo(context, const LoginScreen());
                      },
                      title: AppString.register,
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                ///-------start the social auth -------->
                const CenteredTextDivider(
                  color: AppColors.border,
                  text: AppString.orRegisterWith,
                  thickness: 2,
                ),
                const SizedBox(
                  height: 21,
                ),
                const Row(
                  children: [
                    SocialAuth(
                      image: AppImages.facebookSVG,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    SocialAuth(
                      image: AppImages.googleSVG,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    SocialAuth(
                      image: AppImages.appleSVG,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 54,
                ),
                ///------------the richText---------->
                ReusableRichText(
                  text1: AppString.alreadyHaveAnAccount,
                  text2: AppString.loginNow ,
                  onPressed: () {
                    AppFunctions.navigateTo(context, const LoginScreen());
                  },
                )
              ],
            ),
          ),
        ),
      );
  },
),
    );
  }
}



var unhiddenicon = const Icon(Icons.visibility);
var hiddenicon = const Icon(Icons.visibility_off);