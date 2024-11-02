import 'package:bookia_118/core/theming/styles.dart';
import 'package:bookia_118/core/widgets/reusable_page_name.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/widgets/app_back_button.dart';
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: AppColors.backGround,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
          child: Column(
            children: [
              ///---------the appBar --------->
              const Row(
                children: [
                  AppBackButton(),
                  Spacer(
                    flex: 1,
                  ),
                  ReusablePageName(text: AppString.notification),
                  Spacer(
                    flex: 2,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              SizedBox(
                // color: AppColors.green,
                height: 680,
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    ///------the notification container-------->
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Container(
                        width: 386, //386
                        height: 95, //95
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: AppColors.border,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              Text(
                                "Your order #123456789 has been confirmed",
                                style: font20BoldDark.copyWith(fontSize: 12),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Turpis pretium et in arcu adipiscing nec. Turpis pretium et in arcu adipiscing nec. ",
                                style: font15RegularGray.copyWith(fontSize: 10, color: AppColors.gray),
                                textAlign: TextAlign.justify,
                              ),
                              Row(
                                children: [
                                  const Spacer(),
                                  Text(
                                    "New",
                                    style: font14SemiBoldGreen,
                                  ),
                                  const SizedBox(width: 10)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
