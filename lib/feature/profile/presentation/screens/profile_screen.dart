import 'package:bookia_118/core/functions/navigation.dart';
import 'package:bookia_118/feature/profile/presentation/screens/my_orders.dart';
import 'package:bookia_118/feature/profile/presentation/screens/reset_password.dart';
import 'package:bookia_118/feature/profile/presentation/screens/update_profie.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/reusable_page_name.dart';
import '../../../../core/widgets/setting_profile_field.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
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
                  const SizedBox(
                    height: 25,
                  ),

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
                      const SizedBox(
                        width: 15,
                      ),
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
                  const SizedBox(
                    height: 35,
                  ),

                  ///--------settings fields------->
                  Column(
                    children: [
                      SettingProfileFieldsField(
                        onPressed: () {
                          AppFunctions.navigateTo(context, const MyOrders());
                        },
                        text: AppString.myOrder,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SettingProfileFieldsField(
                        onPressed: () {
                          AppFunctions.navigateTo(context, const UpdateProfile());
                        },
                        text: AppString.editProfile,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SettingProfileFieldsField(
                        onPressed: () {
                          AppFunctions.navigateTo(context, const ResetPassword());
                        },
                        text: AppString.resetPassword,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const SettingProfileFieldsField(
                        text: AppString.faq,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const SettingProfileFieldsField(
                        text: AppString.contactUs,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const SettingProfileFieldsField(
                        text: AppString.privacyAndTerms,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
