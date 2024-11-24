import 'package:bookia_118/core/constants/app_strings.dart';
import 'package:bookia_118/core/constants/constants.dart';
import 'package:bookia_118/core/functions/navigation.dart';
import 'package:bookia_118/core/theming/app_colors.dart';
import 'package:bookia_118/core/theming/styles.dart';
import 'package:bookia_118/core/widgets/centered_text_divider.dart';
import 'package:bookia_118/core/widgets/main_button.dart';
import 'package:bookia_118/core/widgets/reusable_rich_text.dart';
import 'package:bookia_118/core/widgets/reusable_text_form_field.dart';
import 'package:bookia_118/core/widgets/social_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../core/cubits/auth_cubit/auth_cubit.dart';
import '../../../../core/cubits/auth_cubit/auth_state.dart';
import '../../../forgot_password/presentation/screens/forgot_password.dart';
import '../../../register/presentation/screens/register_screen.dart';
import '../../../wrapper_screen/presentation/screen/wrapper_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit.get(context);
    // CategoryCubit.get(context).checkUserToken(context);
    return SafeArea(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccessState) {
            // EasyLoading.showSuccess('Success login! ');
            EasyLoading.showSuccess("Welcome ${state.msg}");
            AppFunctions.navigateAndRemove(context, const WrapperHomeScreen());
          } else if (state is AuthFailedState) {
            // EasyLoading.showError('Failed to LogIn');
            EasyLoading.showError(state.error);
            EasyLoading.dismiss();
          } else if (state is AuthLoadingState) {
            EasyLoading.show(status: "loading..");
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.backGround,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 11),
                    // const AppBackButton(),
                    const SizedBox(height: 29),

                    ///----------login welcome message------->
                    SizedBox(
                      width: 280,
                      height: 82, // it's 78 in figma but it doesn't fit.
                      child: Text(AppString.loginWelcomeMessage, style: font30RegularDark),
                    ),
                    const SizedBox(height: 32),

                    ///-------the email field-------->
                    ReusableTextFormField(
                      controller: authCubit.emailController,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      hintText: "",
                      labelText: AppString.enterYourEmail,
                    ),
                    const SizedBox(height: 12),

                    ///-------the password field-------->
                    ReusableTextFormField(
                      controller: authCubit.passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: authCubit.hidden,
                      hintText: "",
                      labelText: AppString.enterYourPassword,
                      suffixIcon: IconButton(
                        onPressed: () {
                          authCubit.togglePassword();
                        },
                        icon: authCubit.hidden ? hiddenicon : unhiddenicon,
                      ),
                    ),

                    /// ---------- the forgot password text-------->
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {
                          AppFunctions.navigateTo(context, const ForgotPassword());
                        },
                        child: Text(
                          AppString.forgotPassword,
                          style: font14RegularDarkGray,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    ///-------the login main button-------->
                    Center(
                      child: MainButton(
                          onTap: () {
                            // to prevent the user from calling the api while loading ⤵
                            if (state is AuthLoadingState) return;
                            authCubit.login();
                          },
                          // onTap: () { AppFunctions.navigateTo(context, const WrapperHomeScreen());},
                          title: AppString.login),
                    ),
                    const SizedBox(height: 34),

                    ///-------start the social auth -------->
                    const CenteredTextDivider(
                        color: AppColors.border, text: AppString.orLogInWith, thickness: 2),
                    const SizedBox(height: 21),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialAuth(
                          image: AppImages.facebookSVG,
                          onTap: () {
                            authCubit.signInWithFacebook(context);
                          },
                        ),
                        const SizedBox(width: 8),
                        SocialAuth(
                          image: AppImages.googleSVG,
                          onTap: () {
                            authCubit.logInWithGoogle(context).then((data) {
                              debugPrint(data?.googleSignInAuthentication.accessToken);
                            });
                          },
                        ),
                        // const SizedBox(width: 8),
                        // const SocialAuth(
                        //   image: AppImages.appleSVG,
                        // ),
                      ],
                    ),

                    ///------------the richText---------->
                    const SizedBox(
                      height: 140,
                    ),
                    ReusableRichText(
                      text1: AppString.doNotHaveAnAccount,
                      text2: AppString.registerNow,
                      onPressed: () {
                        AppFunctions.navigateTo(context, const RegisterScreen());
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
