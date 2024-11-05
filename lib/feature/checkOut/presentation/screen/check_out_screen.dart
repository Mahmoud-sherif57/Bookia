import 'package:bookia_118/core/theming/styles.dart';
import 'package:bookia_118/core/widgets/reusable_page_name.dart';
import 'package:bookia_118/feature/checkOut/presentation/screen/success_check_out.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/cubits/category_cubit/category_cubit.dart';
import '../../../../core/cubits/category_cubit/category_state.dart';
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
    final cartData = categoryCubit.cartData;
    context.read<CategoryCubit>();
    return SafeArea(
      child: BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) {
          if (state is CheckOutSuccessState) {
            AppFunctions.navigateTo(context, const SuccessCheckout());
          }

          if (state is CheckOutSuccessState) {
            EasyLoading.showSuccess(state.msg);
            EasyLoading.dismiss();
          } else if (state is CheckOutFailedState) {
            EasyLoading.showError(state.error);
            EasyLoading.dismiss();
          } else if (state is CheckOutLoadingState) {
            EasyLoading.show(status: "loading..");
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.backGround,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SizedBox(
                height: size.height,
                child: SingleChildScrollView(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(height: 11),

                      ///------the checkOut text-------->
                      const Row(
                        children: [
                          AppBackButton(),
                          SizedBox(width: 60),
                          ReusablePageName(
                            text: AppString.checkOut,
                          )
                        ],
                      ),

                      ///------the textForm fields-------->
                      Column(
                        children: [
                          const SizedBox(height: 29),

                          ///-------the fullName field-------->
                          ReusableTextFormField(
                            controller: categoryCubit.nameController,
                            keyboardType: TextInputType.text,
                            prefixIcon: const Icon(Icons.abc),
                            obscureText: false,
                            hintText: "",
                            labelText: AppString.fullName,
                          ),
                          const SizedBox(height: 12),

                          ///-------the email field-------->
                          ReusableTextFormField(
                            controller: categoryCubit.emailController,
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: const Icon(Icons.email_rounded),
                            obscureText: false,
                            hintText: "",
                            labelText: AppString.email,
                          ),
                          const SizedBox(height: 12),

                          ///-------the address field-------->
                          ReusableTextFormField(
                            controller: categoryCubit.addressController,
                            keyboardType: TextInputType.streetAddress,
                            prefixIcon: const Icon(Icons.location_on),
                            obscureText: false,
                            hintText: "",
                            labelText: AppString.address,
                          ),
                          const SizedBox(height: 12),

                          ///-------the phoneNumber field-------->
                          ReusableTextFormField(
                            controller: categoryCubit.phoneController,
                            keyboardType: TextInputType.phone,
                            prefixIcon: const Icon(Icons.phone),
                            obscureText: false,
                            hintText: "",
                            labelText: AppString.phoneNumber,
                          ),
                          const SizedBox(height: 12),

                          ///-------the latitude field-------->
                          ReusableTextFormField(
                            controller: categoryCubit.latitudeController,
                            keyboardType: TextInputType.text,
                            prefixIcon: const Icon(Icons.my_location_rounded),
                            obscureText: false,
                            hintText: "",
                            labelText: AppString.latitude,
                          ),
                          const SizedBox(height: 12),

                          ///-------the longitude field-------->
                          ReusableTextFormField(
                            controller: categoryCubit.longitudeController,
                            keyboardType: TextInputType.text,
                            prefixIcon: const Icon(Icons.my_location_rounded),
                            obscureText: false,
                            hintText: "",
                            labelText: AppString.longitude,
                          ),
                          const SizedBox(height: 12),

                          ///-------the payment type field-------->
                          ReusableTextFormField(
                            controller: categoryCubit.paymentTypeController,
                            keyboardType: TextInputType.text,
                            prefixIcon: const Icon(Icons.payment),
                            obscureText: false,
                            hintText: "",
                            labelText: AppString.paymentType,
                          ),

                          const SizedBox(height: 12),

                          ///-------the transactionId field-------->
                          ReusableTextFormField(
                            controller: categoryCubit.transactionIdController,
                            keyboardType: TextInputType.text,
                            prefixIcon: const Icon(Icons.add_card_outlined),
                            obscureText: false,
                            hintText: "",
                            labelText: AppString.transactionId,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      ///------the submitOrder Button-------->
                      Column(
                        children: [
                          const Divider(thickness: 2),
                          ReusableRowForCart(
                            // price: categoryCubit.getTotalCost(),
                            style: font20BoldDark,
                            price: cartData?.total ?? "",
                            text: AppString.subTotal,
                          ),
                          const Divider(thickness: 2),
                          Center(
                            child: MainButton(
                              title: AppString.submitOrder,
                              onTap: () {
                                // if (cartData?.total != null) return;
                                categoryCubit.checkOut();
                                // AppFunctions.navigateTo(context, const SuccessCheckout());
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
          );
        },
      ),
    );
  }
}
