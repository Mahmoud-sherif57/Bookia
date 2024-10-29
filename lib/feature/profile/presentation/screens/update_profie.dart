import 'package:bookia_118/core/constants/app_strings.dart';
import 'package:bookia_118/core/functions/navigation.dart';
import 'package:bookia_118/core/theming/app_colors.dart';
import 'package:bookia_118/core/widgets/app_back_button.dart';
import 'package:bookia_118/core/widgets/main_button.dart';
import 'package:bookia_118/core/widgets/reusable_text_form_field.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/reusable_page_name.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      const CircleAvatar(
                        backgroundColor: AppColors.primary,
                        radius: 60,
                        child: Icon(Icons.person, size: 100, color: AppColors.ivory),
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
                              // authCubit.pickImageFromGallery();
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
              const ReusableTextFormField(
                hintText: "",
                labelText: AppString.userName,
                obscureText: false,
              ),
              const SizedBox(height: 12),

              ///-----------the email field---------->
              const ReusableTextFormField(
                hintText: "",
                labelText: AppString.email,
                obscureText: false,
              ),
              const SizedBox(height: 12),

              ///-----------the  password field---------->
              const ReusableTextFormField(
                hintText: "",
                labelText: AppString.password,
                obscureText: false,
              ),
              const SizedBox(height: 12),

              ///-----------the confirm password field---------->
              const ReusableTextFormField(
                hintText: "",
                labelText: AppString.confirmPassword,
                obscureText: false,
              ),
              const SizedBox(height: 45),

              ///------------the reset password button---------->
              Center(
                child: MainButton(
                  onTap: () {
                    AppFunctions.navigatePop(context);
                  },
                  title: AppString.updateProfile,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
