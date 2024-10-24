import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/cubits/category_cubit/category_cubit.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_back_button.dart';
import '../../../../core/widgets/reusable_page_name.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryCubit = context.read<CategoryCubit>();
    num totalCost = categoryCubit.getTotalCost();
    num? totalAmount = categoryCubit.getTotalAmount();
    return Scaffold(
      backgroundColor: AppColors.backGround,
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        // padding: EdgeInsets.symmetric(horizontal: 24, vertical: 50),
        child: SizedBox(
          // height:size.height,
          // width: size.width,
          child: Column(
            children: [
              const SizedBox(height: 25),

              ///------the My order text-------->
              const Row(
                children: [
                  AppBackButton(),
                  SizedBox(width: 60),
                  ReusablePageName(
                    text: AppString.myOrder,
                  )
                ],
              ),
              const SizedBox(height: 34),

              ///-------order details-------->
              Container(
                width: 335,
                height: 172,
                decoration: BoxDecoration(
                    color: AppColors.backGround,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 8),
                        color: AppColors.gray.withOpacity(0.5),
                        blurRadius: 20,
                      ),
                    ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          ///------order number--------->
                          Row(
                            children: [
                              Text(
                                "Order No238562312",
                                style: font18RegularDark,
                              ),
                              const Spacer(),
                              Text(
                                "24/10/2024",
                                style: font15RegularGray,
                              ),
                            ],
                          ),
                          const Divider(),

                          ///------order quantity and amount--------->
                          Row(
                            children: [
                              Text(
                                "${AppString.quantity} $totalAmount",
                                style: font16MediumDark,
                              ),
                              const Spacer(),
                              Text(
                                "${AppString.totalAmount} \$ $totalCost",
                                style: font16MediumDark,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0, right: 15),
                      child: Row(
                        children: [
                          Container(
                              width: 100,
                              height: 36,
                              decoration: const BoxDecoration(
                                color: AppColors.dark,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  AppString.detail,
                                  style: font16MediumDark.copyWith(color: AppColors.offWhite),
                                ),
                              )),
                          const Spacer(),
                          Text(
                            AppString.delivered,
                            style: font16MediumDark.copyWith(color: AppColors.green),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 34),
              Container(
                width: 335,
                height: 172,
                decoration: BoxDecoration(
                  color: AppColors.backGround,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 8),
                      color: AppColors.gray.withOpacity(0.5),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          ///------order number--------->
                          Row(
                            children: [
                              Text(
                                "Order No238562312",
                                style: font18RegularDark,
                              ),
                              const Spacer(),
                              Text(
                                "24/10/2024",
                                style: font15RegularGray,
                              ),
                            ],
                          ),
                          const Divider(),

                          ///------order quantity and amount--------->
                          Row(
                            children: [
                              Text(
                                "${AppString.quantity} $totalAmount",
                                style: font16MediumDark,
                              ),
                              const Spacer(),
                              Text(
                                "${AppString.totalAmount} \$ $totalCost",
                                style: font16MediumDark,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0, right: 15),
                      child: Row(
                        children: [
                          Container(
                              width: 100,
                              height: 36,
                              decoration: const BoxDecoration(
                                color: AppColors.dark,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  AppString.detail,
                                  style: font16MediumDark.copyWith(color: AppColors.offWhite),
                                ),
                              )),
                          const Spacer(),
                          Text(
                            "cancelled",
                            style: font16MediumDark.copyWith(color: AppColors.red),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
