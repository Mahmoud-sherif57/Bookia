import 'package:bookia_118/core/cubits/category_cubit/category_cubit.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/app_back_button.dart';
import '../../../../core/widgets/reusable_page_name.dart';

class PaymentWaysScreen extends StatelessWidget {
  const PaymentWaysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var categoryCubit = CategoryCubit.get(context);
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            ///------the payment way text-------->
            const SizedBox(height: 15),
            const Row(
              children: [
                AppBackButton(),
                SizedBox(width: 45),
                ReusablePageName(
                  text: AppString.paymentWays,
                  width: 200,
                )
              ],
            ),

            ///----the payment ways types------->
            categoryCubit.paymentMethodsIsLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                        itemCount: categoryCubit.paymentMethodModel?.data?.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              categoryCubit.processPaymentWay(
                                  context, categoryCubit.paymentMethodModel!.data![index].paymentId!);
                            },
                            title: Text(categoryCubit.paymentMethodModel!.data![index].nameEn!),
                            subtitle: Text(categoryCubit.paymentMethodModel!.data![index].nameAr!),
                            leading: SizedBox(
                                child: Image.network(categoryCubit.paymentMethodModel!.data![index].logo!)),
                          );
                        }),
                  ),
          ],
        ),
      )),
    );
  }
}
