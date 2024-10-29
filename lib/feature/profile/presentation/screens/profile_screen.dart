import 'package:bookia_118/core/functions/navigation.dart';
import 'package:bookia_118/feature/login/presentation/screens/login_screen.dart';
import 'package:bookia_118/feature/profile/presentation/screens/my_orders.dart';
import 'package:bookia_118/feature/profile/presentation/screens/reset_password.dart';
import 'package:bookia_118/feature/profile/presentation/screens/update_profie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/cubits/auth_cubit/auth_cubit.dart';
import '../../../../core/cubits/auth_cubit/auth_state.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/reusable_page_name.dart';
import '../../../../core/widgets/setting_profile_field.dart';
import 'package:animate_do/animate_do.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccessState) {
            // EasyLoading.showSuccess('Success login! ');
            EasyLoading.showSuccess(" ${state.msg}");
            AppFunctions.navigateAndRemove(context, const LoginScreen());
          } else if (state is AuthFailedState) {
            EasyLoading.showError(state.error);
          } else if (state is AuthLoadingState) {
            EasyLoading.show(status: "loading..");
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: AppColors.offWhite,
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: size.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Center(
                        child: ReusablePageName(
                          text: AppString.profile,
                        ),
                      ),
                      const SizedBox(height: 25),

                      ///-------user information------>
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: AppColors.primary,
                            radius: 35,
                            child: Icon(
                              Icons.person,
                              size: 50,
                              color: AppColors.ivory,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Eng. Mahmoud sherif',
                                style: font20BoldDark,
                              ),
                              Text(
                                "mahmoudsherif388@gmail.com",
                                style: font14RegularDarkGray,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 35),

                      ///--------settings fields------->
                      Column(
                        children: [
                          SettingProfileFieldsField(
                            onPressed: () {
                              AppFunctions.navigateTo(context, const MyOrders());
                            },
                            text: AppString.myOrder,
                          ),
                          const SizedBox(height: 25),
                          SettingProfileFieldsField(
                            onPressed: () {
                              AppFunctions.navigateTo(context, const UpdateProfile());
                            },
                            text: AppString.editProfile,
                          ),
                          const SizedBox(height: 25),
                          SettingProfileFieldsField(
                            onPressed: () {
                              AppFunctions.navigateTo(context, const ResetPassword());
                            },
                            text: AppString.resetPassword,
                          ),
                          const SizedBox(height: 25),
                          const SettingProfileFieldsField(
                            text: AppString.faq,
                          ),
                          const SizedBox(height: 25),
                          const SettingProfileFieldsField(
                            text: AppString.contactUs,
                          ),
                          const SizedBox(height: 25),
                          const SettingProfileFieldsField(
                            text: AppString.privacyAndTerms,
                          ),
                          const SizedBox(height: 25),
                          SettingProfileFieldsField(
                            text: AppString.logOut,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => FadeInUp(
                                  delay: const Duration(milliseconds: 50),
                                  child: AlertDialog(
                                    title: Text("Log out "),
                                    contentPadding: const EdgeInsets.all(20),
                                    content: Text("are you sure you want to log out ?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            AppFunctions.navigatePop(context);
                                          },
                                          child: Text("No")),
                                      TextButton(
                                          onPressed: () {
                                            AuthCubit.get(context).logOut();
                                          },
                                          child: Text("YES")),
                                    ],
                                  ),
                                ),
                              );
                            },
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
