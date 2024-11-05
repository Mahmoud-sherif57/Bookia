import 'package:bookia_118/core/functions/navigation.dart';
import 'package:bookia_118/feature/wrapper_screen/presentation/screen/wrapper_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/cubits/auth_cubit/auth_cubit.dart';
import '../../../../core/cubits/auth_cubit/auth_state.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/widgets/reusable_page_name.dart';
import '../../../../core/widgets/user_info_field_widget.dart';

class PreviewUserInfo extends StatelessWidget {
  const PreviewUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final authCubit = AuthCubit.get(context);
    return SafeArea(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
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
                      Row(
                        children: [
                          // AppBackButton(),
                          ///-------- instead of AppBackButton------->
                          InkWell(
                            onTap: () {
                              AppFunctions.navigateTo(context, const WrapperHomeScreen());
                            },
                            child: Container(
                              width: 41,
                              height: 41,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/images/arrow_back.svg",
                                  width: 26,
                                  height: 26,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          const Center(
                            child: ReusablePageName(
                              width: 170,
                              text: AppString.profile,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                      const SizedBox(height: 25),

                      ///-------user information------>
                      const CircleAvatar(
                        backgroundColor: AppColors.primary,
                        radius: 55,
                        child: Icon(
                          Icons.person,
                          size: 100,
                          color: AppColors.ivory,
                        ),
                      ),
                      const SizedBox(height: 35),

                      ///--------settings fields------->
                      Column(
                        children: [
                          UserInfoFieldWidget(
                            text: '  ${AppString.userName2} :${authCubit.userInfoMap[AppString.userName2]}',
                          ),
                          const SizedBox(height: 25),
                          UserInfoFieldWidget(
                            text: '${AppString.userEmail} : ${authCubit.userInfoMap[AppString.userEmail]} ',
                          ),
                          const SizedBox(height: 25),
                          UserInfoFieldWidget(
                            text: '${AppString.address} : ${authCubit.userInfoMap[AppString.address]}  ',
                          ),
                          const SizedBox(height: 25),
                          Row(
                            children: [
                              UserInfoFieldWidget(
                                text: '${AppString.lat} :${authCubit.userInfoMap[AppString.lat]} ',
                                width: 160,
                              ),
                              const Spacer(),
                              UserInfoFieldWidget(
                                text: '${AppString.lng} : ${authCubit.userInfoMap[AppString.lng]}',
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
