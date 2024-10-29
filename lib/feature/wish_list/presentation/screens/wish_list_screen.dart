import 'package:bookia_118/core/constants/app_strings.dart';
import 'package:bookia_118/core/theming/app_colors.dart';
import 'package:bookia_118/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/cubits/category_cubit/category_cubit.dart';
import '../../../../core/cubits/category_cubit/category_state.dart';
import '../../../../core/widgets/reusable_page_name.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    final categoryCubit = context.read<CategoryCubit>();
    return SafeArea(
      child: BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) {},
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
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: categoryCubit.itemsInWishList.isNotEmpty?
                        ListView.builder(
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
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(current.imageUrl),
                                    ),
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
                                      categoryCubit.deleteFromFavourite(current);
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
                                        current.isOnTheCart? AppString.inTheCart : AppString.addToCart,
                                        style: font15RegularWhite,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            );
                          },
                        ): Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Lottie.asset("assets/animations/empty_lottie_2.json"),

                            // Image(
                            //   // image: AssetImage(AppAssets.emptyLogo),
                            //   fit: BoxFit.cover,
                            // ),

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
