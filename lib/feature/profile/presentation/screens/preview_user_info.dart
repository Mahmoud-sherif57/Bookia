import 'package:bookia_118/core/widgets/app_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/cubits/auth_cubit/auth_cubit.dart';
import '../../../../core/cubits/auth_cubit/auth_state.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/reusable_page_name.dart';
import '../../../../core/widgets/setting_profile_field_widget.dart';
import '../../../../core/widgets/user_info_field_widget.dart';

class PreviewUserInfo extends StatelessWidget {
  const PreviewUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          // if (state is AuthSuccessState) {
          //   // EasyLoading.showSuccess('Success login! ');
          //   EasyLoading.showSuccess(" ${state.msg}");
          //   AppFunctions.navigateAndRemove(context, const LoginScreen());
          // } else if (state is AuthFailedState) {
          //   EasyLoading.showError(state.error);
          // } else if (state is AuthLoadingState) {
          //   EasyLoading.show(status: "loading..");
          // }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: AppColors.offWhite,
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: size.height,
                child: const SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          AppBackButton(),
                          Spacer(),
                          Center(
                            child: ReusablePageName(
                              width: 170,
                              text: AppString.profile,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(height: 25),

                      ///-------user information------>
                      CircleAvatar(
                        backgroundColor: AppColors.primary,
                        radius: 55,
                        child: Icon(
                          Icons.person,
                          size: 100,
                          color: AppColors.ivory,
                        ),
                      ),
                      SizedBox(height: 35),

                      ///--------settings fields------->
                      Column(
                        children: [
                          UserInfoFieldWidget(
                            text: 'name : **********',
                          ),
                          SizedBox(height: 25),
                          UserInfoFieldWidget(
                            text: 'email : **********',
                          ),
                          SizedBox(height: 25),
                          UserInfoFieldWidget(
                            text: 'address : **********',
                          ),
                          SizedBox(height: 25),
                          Row(
                            children: [
                              UserInfoFieldWidget(
                                text: 'lat : **********',
                                width: 160,
                              ),
                              Spacer(),
                              UserInfoFieldWidget(
                                text: 'lng : **********',
                                width: 160,
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
