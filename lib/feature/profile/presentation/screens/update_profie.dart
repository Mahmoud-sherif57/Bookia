import 'package:bookia_118/core/constants/app_strings.dart';
import 'package:bookia_118/core/theming/app_colors.dart';
import 'package:bookia_118/core/widgets/app_back_button.dart';
import 'package:bookia_118/core/widgets/main_button.dart';
import 'package:bookia_118/core/widgets/reusable_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../core/cubits/auth_cubit/auth_cubit.dart';
import '../../../../core/cubits/auth_cubit/auth_state.dart';
import '../../../../core/widgets/reusable_page_name.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit.get(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is UpdateProfileSuccessState) {
          EasyLoading.showSuccess(" ${state.msg}");
          EasyLoading.dismiss();
        } else if (state is UpdateProfileFailedState) {
          EasyLoading.showError(state.error);
          EasyLoading.dismiss();
        } else if (state is UpdateProfileLoadingState) {
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
                  const SizedBox(height: 25),

                  ///------the My order text-------->
                  const Row(
                    children: [
                      AppBackButton(),
                      SizedBox(width: 30),
                      ReusablePageName(width: 200, text: AppString.updateProfile)
                    ],
                  ),
                  const SizedBox(height: 40),

                  ///-------the user image ------->
                  Center(
                    child: Container(
                      width: 150,
                      decoration: const BoxDecoration(),
                      child: Stack(
                        children: [
                          ///-----the person icon ----->
                          authCubit.userPhoto == null
                              // authCubit.userImage == null
                              ? const CircleAvatar(
                                  backgroundColor: AppColors.primary,
                                  radius: 60,
                                  child: Icon(Icons.person, size: 100, color: AppColors.ivory),
                                )
                              : CircleAvatar(
                                  // backgroundImage: authCubit.userImage != null
                                  //     ? FileImage(authCubit.userImage as File)
                                  //     : null,
                                  backgroundImage: authCubit.userPhoto != null
                                      ? NetworkImage(authCubit.userPhoto ?? "")
                                      : null,
                                  backgroundColor: AppColors.primary,
                                  radius: 60,
                                ),

                          ///-----the camera icon ----->
                          Positioned(
                            left: 90,
                            top: 5,
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: AppColors.ivory,
                              child: IconButton(
                                color: AppColors.primary,
                                onPressed: () {
                                  authCubit.getUserImage();
                                  // authCubit.pickedImage();
                                },
                                icon: const Icon(Icons.add_a_photo_rounded, size: 22),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 44),

                  ///------------the user name field---------->
                  ReusableTextFormField(
                    controller: authCubit.nameController,
                    keyboardType: TextInputType.text,
                    hintText: authCubit.userInfoGoogleModel?.displayName ?? "",
                    labelText: AppString.userName,
                    obscureText: false,
                  ),
                  const SizedBox(height: 12),

                  ///-----------the email field---------->
                  ReusableTextFormField(
                    controller: authCubit.emailController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: authCubit.userInfoGoogleModel?.email ?? "",
                    labelText: AppString.email,
                    obscureText: false,
                  ),
                  const SizedBox(height: 12),

                  ///-----------the  address field---------->
                  ReusableTextFormField(
                    controller: authCubit.addressController,
                    keyboardType: TextInputType.streetAddress,
                    hintText: "",
                    labelText: AppString.address,
                    obscureText: false,
                  ),
                  const SizedBox(height: 50),

                  ///------------the reset password button---------->
                  Center(
                    child: MainButton(
                      onTap: () {
                        authCubit.updateProfile();
                        // AppFunctions.navigatePop(context);
                      },
                      title: AppString.updateProfile,
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
