import 'package:bookia_118/core/constants/app_strings.dart';
import 'package:bookia_118/core/cubits/category_cubit/category_state.dart';
import 'package:bookia_118/core/theming/styles.dart';
import 'package:bookia_118/core/widgets/app_shimmer.dart';
import 'package:bookia_118/data/categories_model.dart';
import 'package:bookia_118/data/local/app_data.dart';
import 'package:bookia_118/feature/home/presentation/screens/notification_screen.dart';
import 'package:bookia_118/core/widgets/the_book_card_widget.dart';
import 'package:bookia_118/feature/login/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/cubits/category_cubit/category_cubit.dart';
import '../../../../core/functions/navigation.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../data/book_model.dart';
import 'books_by_category_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final categoryCubit = CategoryCubit.get(context);
    final categoryCubit = context.read<CategoryCubit>();
    var size = MediaQuery.of(context).size;
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state is GetBooksByCategoryIdSuccess) {
          AppFunctions.navigateTo(context, const BooksByCategoryScreen());
        } else if (state is ToggleFavouriteState) {
          EasyLoading.showSuccess(state.msg);
        }
        // if (state is AddedToCartSuccessfulState) {
        //   EasyLoading.showSuccess(state.msg);
        //   EasyLoading.dismiss();
        // } else if (state is AddedToCartFailedState) {
        //   EasyLoading.showError("Failed to add to cart");
        //   EasyLoading.dismiss();
        // } else if (state is AddedToCartLoadingState) {
        //   EasyLoading.show(status: "loading..");
        // }
      },
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: categoryCubit.onRefresh,
          displacement: 60,
          backgroundColor: AppColors.primary,
          color: AppColors.black,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.backGround,
              body: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ///----------the appBar---------->
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 30,
                              child: InkWell(
                                  onTap: () {
                                    categoryCubit.getAllBooks();
                                  },
                                  child: Image.asset(AppImages.splashLogo, fit: BoxFit.cover)),
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    AppFunctions.navigateTo(context, const NotificationScreen());
                                  },
                                  child: SvgPicture.asset(AppIcons.notification),
                                ),
                                const SizedBox(width: 16),
                                InkWell(
                                  onTap: () {
                                    AppFunctions.navigateTo(context, const LoginScreen());
                                  },
                                  child: SvgPicture.asset(AppIcons.search),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        ///-----------------start the slider section---------------->

                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              width: 350,
                              height: 150, //0.34
                              child: PageView.builder(
                                pageSnapping: true,
                                padEnds: true,
                                // controller: homeCubit.controller,
                                physics: const BouncingScrollPhysics(),
                                itemCount: bannerList.length,
                                itemBuilder: (context, index) {
                                  if (state is GetAllBooksLoading) {
                                    return const AppShimmer();
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: AppColors.primary),
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: bannerList[index].image != null
                                                  ? NetworkImage(
                                                      bannerList[index].image ?? "",
                                                    )
                                                  : const AssetImage('assets/images/aflaton.png')
                                                      as ImageProvider,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 5,
                                          left: 10,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.beige,
                                              borderRadius: BorderRadius.circular(7),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 5),
                                              child: Text(
                                                bannerList[index].title ?? "",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                        )
                                      ]),
                                    );
                                  }
                                },
                              ),
                            ),

                            ///-----------make the indicator------>
                            // Align(
                            //   alignment: Alignment.center,
                            //   child: SmoothPageIndicator(
                            //     controller: homeCubit.controller,
                            //     count: bannerList.length,
                            //     effect: const ExpandingDotsEffect(
                            //       dotColor: AppColors.primary,
                            //       activeDotColor: AppColors.primary,
                            //       dotWidth: 8.0,
                            //       dotHeight: 8.0,
                            //       strokeWidth: 1.5,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),

                        ///---------- the category section-------->
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: 350,
                          height: 100, //0.34
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: categoryList.length,
                            itemBuilder: (context, index) {
                              CategoriesModel current = categoryList[index];
                              if (state is GetAllBooksLoading) {
                                return const AppShimmer();
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            categoryCubit.getBookByCategory(current.categoryId);
                                            // AppFunctions.navigateTo(context, const BooksByCategoryScreen());
                                          },
                                          child: Container(
                                            width: 70,
                                            height: 70,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: current.image != null
                                                    ? NetworkImage(current.image!)
                                                    : const AssetImage('assets/images/aflaton.png')
                                                        as ImageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(current.name!),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        ),

                        ///---------the popular books text------->
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            AppString.popularBooks,
                            style: font30RegularDark.copyWith(fontSize: 24),
                          ),
                        ),
                        const SizedBox(height: 5),

                        ///--------the popular books gridView------>
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: booksListData.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.54, crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            if (state is GetAllBooksLoading) {
                              return const AppShimmer();
                            } else {
                              BookModel current = booksListData[index];
                              return TheBookCardWidget(
                                current: current,
                                index: index,
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  // );
}

var notFavouriteIcon = const Icon(Icons.favorite_outline_sharp);
var favouriteIcon = const Icon(
  Icons.favorite,
  color: AppColors.red,
);
// var notOnTheCartIcon = const Icon(
//   Icons.add_shopping_cart_sharp,
//   color: AppColors.primary,
// );
// var onTheCartIcon = const Icon(
//   Icons.add_shopping_cart_sharp,
//   color: AppColors.green,
// );
