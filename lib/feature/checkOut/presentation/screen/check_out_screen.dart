import 'package:bookia_118/core/widgets/reusable_page_name.dart';
import 'package:bookia_118/feature/checkOut/presentation/screen/success_check_out.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/cubits/category_cubit/category_cubit.dart';
import '../../../../core/functions/navigation.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/widgets/app_back_button.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../../core/widgets/reusable_row_for_cart.dart';
import '../../../../core/widgets/reusable_text_form_field.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final categoryCubit = context.read<CategoryCubit>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backGround,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SizedBox(
            height: size.height,
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 11,
                  ),

                  ///------the checkOut text-------->
                  const Row(
                    children: [
                      AppBackButton(),
                      SizedBox(
                        width: 60,
                      ),
                      ReusablePageName(
                        text: AppString.checkOut,
                      )
                    ],
                  ),

                  ///------the textForm fields-------->
                  const Column(
                    children: [
                      SizedBox(height: 29),

                      ///-------the fullName field-------->
                      ReusableTextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        hintText: "",
                        labelText: AppString.fullName,
                      ),
                      SizedBox(
                        height: 12,
                      ),

                      ///-------the email field-------->
                      ReusableTextFormField(
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        hintText: "",
                        labelText: AppString.email,
                      ),
                      SizedBox(
                        height: 12,
                      ),

                      ///-------the address field-------->
                      ReusableTextFormField(
                        keyboardType: TextInputType.streetAddress,
                        obscureText: false,
                        hintText: "",
                        labelText: AppString.address,
                      ),
                      SizedBox(
                        height: 12,
                      ),

                      ///-------the phoneNumber field-------->
                      ReusableTextFormField(
                        keyboardType: TextInputType.phone,
                        obscureText: false,
                        hintText: "",
                        labelText: AppString.phoneNumber,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 300,
                  ),

                  ///------the submitOrder Button-------->
                  Column(
                    children: [
                      ReusableRowForCart(
                        price: categoryCubit.getTotalCost(),
                        text: AppString.subTotal,
                      ),
                      Center(
                        child: MainButton(
                          title: AppString.submitOrder,
                          onTap: () {
                            AppFunctions.navigateTo(context, const SuccessCheckout());
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
