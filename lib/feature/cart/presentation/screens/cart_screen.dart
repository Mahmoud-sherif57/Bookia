import 'package:bookia_118/core/constants/app_strings.dart';
import 'package:bookia_118/core/functions/navigation.dart';
import 'package:bookia_118/core/theming/app_colors.dart';
import 'package:bookia_118/core/theming/styles.dart';
import 'package:bookia_118/core/widgets/main_button.dart';
import 'package:bookia_118/core/widgets/reusable_page_name.dart';
import 'package:bookia_118/core/widgets/reusable_row_for_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/cubits/category_cubit/category_cubit.dart';
import '../../../../core/cubits/category_cubit/category_state.dart';
import '../../../checkOut/presentation/screen/check_out_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryCubit.get(context).viewCart();
    var size = MediaQuery.of(context).size;

    /// call the viewCart function when i navigate to the cart screen =====>
    return SafeArea(
      child: BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) {},
        builder: (context, state) {
          final categoryCubit = context.read<CategoryCubit>();
          final cartData = categoryCubit.cartData;
          return Scaffold(
            backgroundColor: AppColors.backGround,
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: size.width,
                child: Center(
                  child: Column(
                    children: [
                      const ReusablePageName(text: AppString.myCart),
                      const SizedBox(
                        height: 10
                      ),

                      ///--------the books in cart------->
                      Expanded(
                        flex: 6,
                        child: cartData?.items?.isNotEmpty ?? false
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: cartData?.items!.length,
                                itemBuilder: (context, index) {
                                  var current = cartData?.items![index];
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.beige,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    margin: const EdgeInsets.all(5),
                                    child: Stack(children: [
                                      /// the book image
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          width: 100,
                                          height: 120,
                                          margin: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            image: DecorationImage(
                                              image: current?.image != null
                                                  ? NetworkImage(current!.image!)
                                                  : const AssetImage('assets/images/splash_image.png')
                                                      as ImageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),

                                      /// the book name,
                                      Positioned(
                                        top: 10,
                                        left: 120,
                                        child: Text(current?.name ?? ""),
                                      ),

                                      /// the book price
                                      Positioned(
                                        top: 40,
                                        left: 120,
                                        child: Text(
                                          "${current?.price ?? ""} \$  ",
                                          style: font18RegularDark.copyWith(fontSize: 16),
                                        ),
                                      ),

                                      /// the remove icon
                                      Positioned(
                                        top: 10,
                                        right: 10,
                                        child: InkWell(
                                          child: SvgPicture.asset(
                                            AppImages.deleteIconSVG,
                                            fit: BoxFit.cover,
                                          ),
                                          onTap: () {
                                            categoryCubit.removeFromCart(current?.bookId);
                                          },
                                        ),
                                      ),

                                      Positioned(
                                        bottom: 10,
                                        right: 95,
                                        child: SizedBox(
                                          width: 120,
                                          height: 45,
                                          child: Row(
                                            children: [
                                              /// the sum(+)
                                              InkWell(
                                                onTap: () {
                                                  categoryCubit.addToCart(current?.bookId);
                                                },
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.primary,
                                                    borderRadius: BorderRadius.circular(10),
                                                    border: Border.all(color: AppColors.primary),
                                                  ),
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: AppColors.black,
                                                  ),
                                                ),
                                              ),

                                              /// -------the amount------>
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                                child: Text(
                                                  current!.qty.toString(),
                                                  style: font18RegularDark,
                                                ),
                                              ),

                                              /// the minus (-)
                                              InkWell(
                                                onTap: () {
                                                  categoryCubit.decreaseQuantity(current.bookId);
                                                },
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.primary,
                                                    borderRadius: BorderRadius.circular(10),
                                                    border: Border.all(color: AppColors.primary),
                                                  ),
                                                  child: const Icon(
                                                    Icons.remove,
                                                    color: AppColors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]),
                                  );
                                },
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Lottie.asset("assets/animations/empty_lottie_2.json"),

                                  // Image(
                                  //   // image: AssetImage(AppAssets.emptyLogo),
                                  //   fit: BoxFit.cover,
                                  // ),

                                  Text(
                                    "Your cart is empty right now",
                                    style: font20RegularDark,
                                  ),
                                ],
                              ),
                      ),

                      ///--------the pricing------>
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.beige,
                          ),
                          child: Column(
                            children: [
                              ///----the sub total--------->
                              ReusableRowForCart(
                                price: cartData?.subTotal ?? "",
                                text: AppString.subTotal,
                              ),

                              ///----the tax--------->
                              ReusableRowForCart(
                                price: cartData?.tax ?? "",
                                text: AppString.tax,
                              ),

                              ///----the discount--------->
                              ReusableRowForCart(
                                price: cartData?.discount ?? "",
                                text: AppString.discount,
                              ),

                              ///----the shipping--------->
                              ReusableRowForCart(
                                price: cartData?.shipping ?? "",
                                text: AppString.shipping,
                              ),
                              const Divider(color: AppColors.gray, indent: 10, endIndent: 10),

                              ///----the subTotal--------->
                              ReusableRowForCart(
                                price: cartData?.total ?? "",
                                text: AppString.total,
                              ),
                            ],
                          ),
                        ),
                      ),

                      ///-----the check out button------->
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Center(
                          child: MainButton(
                            height: 50,
                            title: AppString.checkOut,
                            onTap: () {
                              AppFunctions.navigateTo(context, const CheckoutScreen());
                            },
                          ),
                        ),
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
