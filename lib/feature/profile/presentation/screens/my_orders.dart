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
    categoryCubit.viewOrders();

    return Scaffold(
      backgroundColor: AppColors.backGround,
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        // padding: EdgeInsets.symmetric(horizontal: 24, vertical: 50),
        child: SizedBox(
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
              // const SizedBox(height: 34),

              ///-------order details-------->
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: categoryCubit.ordersList.length,
                  itemBuilder: (context, index) {
                    var current = categoryCubit.ordersList[index];
                    return Column(
                      children: [
                        Container(
                          width: 350,
                          // width: 335,
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
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    ///------order number--------->
                                    Row(
                                      children: [
                                        Text(
                                          // current.id.toString(),
                                          "${AppString.orderId} ${current.id ?? ""} ",
                                          style: font18RegularDark,
                                        ),
                                        const Spacer(),
                                        Text(
                                          current.createdAt.toString(),
                                          style: font15RegularGray,
                                        ),
                                      ],
                                    ),
                                    const Divider(),

                                    ///------order quantity and amount--------->
                                    Row(
                                      children: [
                                        Text(
                                          "${AppString.name} ${current.name ?? ""} ",
                                          style: font14RegularDarkGray,
                                          // style: font16MediumDark,
                                        ),
                                        const Spacer(),
                                        Text(
                                          "${AppString.total} ${current.total ?? ""} \$ ",
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
                                      current.status == 0 ? AppString.delivered : AppString.cancelled,
                                      style: font16MediumDark.copyWith(
                                        color: current.status == 0 ? AppColors.green : AppColors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                      ],
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
