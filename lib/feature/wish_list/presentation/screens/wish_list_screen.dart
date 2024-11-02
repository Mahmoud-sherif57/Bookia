import 'package:bookia_118/core/constants/app_strings.dart';
import 'package:bookia_118/core/theming/app_colors.dart';
import 'package:bookia_118/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/cubits/category_cubit/category_cubit.dart';
import '../../../../core/cubits/category_cubit/category_state.dart';
import '../../../../core/widgets/reusable_page_name.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryCubit = context.read<CategoryCubit>();
    categoryCubit.getBooksInWishList();
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) {
          if (state is GetFavouriteSuccessState) {
            // EasyLoading.showSuccess('');
            EasyLoading.dismiss();

          } else if (state is GetFavouriteFailedState) {
            // EasyLoading.showError('Failed to LogIn');
            EasyLoading.showError(state.error);
            EasyLoading.dismiss();
          } else if (state is GetFavouriteLoadingState) {
            EasyLoading.show(status: "loading..");
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.backGround,
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: size.width,
                child: Center(
                  child: Column(
                    children: [
                      const ReusablePageName(text: AppString.wishlist),
                      const SizedBox(height: 10),
                      Expanded(
                        child: categoryCubit.itemsInWishList.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: categoryCubit.itemsInWishList.length,
                                itemBuilder: (context, index) {
                                  var current = categoryCubit.itemsInWishList[index];
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.beige,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    margin: const EdgeInsets.all(5),
                                    child: Stack(children: [
                                      /// the book image
                                      Container(
                                        width: 100,
                                        height: 120,
                                        margin: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: current.imageUrl != null
                                                ? NetworkImage(current.imageUrl!)
                                                : const AssetImage('assets/images/aflaton.png')
                                                    as ImageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),

                                      /// the book name,
                                      Positioned(
                                        top: 10,
                                        left: 120,
                                        child: Text(current.bookName),
                                      ),

                                      /// the book price
                                      Positioned(
                                        top: 40,
                                        left: 120,
                                        child: Text(
                                          "${current.price.toString()} \$",
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
                                          },
                                        ),
                                      ),

                                      /// the addToCart Button
                                      Positioned(
                                        bottom: 10,
                                        right: 25,
                                        child: InkWell(
                                          onTap: () {
                                            categoryCubit.toggleCart(current, context);
                                          },
                                          child: Container(
                                            width: 180,
                                            height: 40,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: AppColors.primary,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              "add To Cart",
                                              // current.isOnTheCart? AppString.inTheCart : AppString.addToCart,
                                              style: font15RegularWhite,
                                            ),
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
                                  Text(
                                    "Your wish list is empty right now",
                                    style: font20RegularDark,
                                  ),
                                ],
                              ),
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
