import 'package:bookia_118/core/theming/styles.dart';
import 'package:bookia_118/core/widgets/main_button.dart';
import 'package:bookia_118/feature/wrapper_screen/presentation/screen/wrapper_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/functions/navigation.dart';
import '../../../../core/theming/app_colors.dart';

class SuccessCheckout extends StatelessWidget {
  const SuccessCheckout({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backGround,
        body: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Center(
            child: SizedBox(
              // color: AppColors.green,
              height: 400,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ///------the success svg------->
                  SizedBox(
                      height: 145,
                      width: 145,
                      child: SvgPicture.asset(
                        AppImages.successSVG,
                        fit: BoxFit.cover,
                      )),
                  Text(
                    AppString.success,
                    style: font35boldBlack,
                  ),
                  Text(
                    AppString.successMessage,
                    style: font18RegularDark.copyWith(color: AppColors.darkGray),
                    textAlign: TextAlign.center,
                  ),
                  MainButton(title: AppString.backToHome,onTap: (){
                    AppFunctions.navigateTo(context, const WrapperHomeScreen()) ;
                  },)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
