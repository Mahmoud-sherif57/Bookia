import 'package:bookia_118/core/constants/app_strings.dart';
import 'package:bookia_118/core/functions/navigation.dart';
import 'package:bookia_118/core/theming/app_colors.dart';
import 'package:bookia_118/core/theming/styles.dart';
import 'package:bookia_118/core/widgets/app_back_button.dart';
import 'package:bookia_118/core/widgets/main_button.dart';
import 'package:bookia_118/core/widgets/reusable_text_form_field.dart';
import 'package:bookia_118/feature/create_new_password/presentation/screens/password_changed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../core/cubits/auth_cubit/auth_cubit.dart';
import '../../../../core/cubits/auth_cubit/auth_state.dart';

class CreateNewPassword extends StatelessWidget {
  const CreateNewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit.get(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          EasyLoading.showSuccess(state.msg);
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
          backgroundColor: AppColors.backGround,
          body: Padding(
            padding: const EdgeInsets.all(22.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 25
                  ),
                  const AppBackButton(),
                  const SizedBox(
                    height: 28
                  ),

                  ///------------the create new password message---------->
                  SizedBox(
                    // width: 279,
                    height: 39,
                    child: Text(
                      AppString.createNewPassword,
                      style: font30RegularDark,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 48,
                    width: 331,
                    child: Text(
                      AppString.createNewPasswordMessage,
                      style: font15RegularGray.copyWith(fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 32
                  ),

                  ///------------the new password field---------->
                  ReusableTextFormField(
                    controller: authCubit.passwordController,
                    keyboardType: TextInputType.text,
                    hintText: "",
                    labelText: AppString.newPassword,
                    obscureText: authCubit.hidden,
                    suffixIcon: IconButton(
                      onPressed: () {authCubit.togglePassword();},
                      icon: authCubit.hidden ? hiddenicon : unhiddenicon,
                    ),
                  ),
                  const SizedBox(height: 18),

                  ///-----------the confirm password field---------->
                  ReusableTextFormField(
                    controller: authCubit.confirmPasswordController,
                    keyboardType: TextInputType.text,
                    hintText: "",
                    labelText: AppString.confirmPassword,
                    suffixIcon: IconButton(
                      onPressed: () {authCubit.togglePassword();},
                      icon: authCubit.hidden ? hiddenicon : unhiddenicon,
                    ),
                    obscureText: authCubit.hidden,
                  ),
                  const SizedBox(
                    height: 38
                  ),

                  ///------------the reset password button---------->
                  Center(
                    child: MainButton(
                      onTap: () {
                        authCubit.resetPassword();
                      },
                      title: AppString.resetPassword,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

var unhiddenicon = const Icon(Icons.visibility);
var hiddenicon = const Icon(Icons.visibility_off);
