import 'package:bookia_118/core/constants/app_strings.dart';
import 'package:bookia_118/core/cubits/category_cubit/category_state.dart';
import 'package:bookia_118/core/theming/styles.dart';
import 'package:bookia_118/data/local/app_data.dart';
import 'package:bookia_118/feature/home/presentation/screens/book_details.dart';
import 'package:bookia_118/feature/home/presentation/screens/notification.dart';
import 'package:bookia_118/feature/login/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/cubits/category_cubit/category_cubit.dart';
import '../../../../core/functions/navigation.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../data/book_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final categoryCubit = CategoryCubit.get(context);
    final categoryCubit = context.read<CategoryCubit>();
    var size = MediaQuery.of(context).size;
    // return BlocConsumer<HomeScreenCubit, HomeScreenState>(
    //   listener: (context, state) {},
    //   builder: (context, state) {
    //     var homeCubit = context.read<HomeScreenCubit>();

    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {

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
                              child: Image.asset(AppImages.splashLogo, fit: BoxFit.cover),
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    AppFunctions.navigateTo(context, const NotificationScreen());
                                  },
                                  child: SvgPicture.asset(AppIcons.notification),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
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
                              // width: size.width,
                              height: 150, //0.34
                              // height: size.height * 0.20, //0.34
                              child: PageView.builder(
                                pageSnapping: true,
                                padEnds: true,
                                // controller: homeCubit.controller,
                                physics: const BouncingScrollPhysics(),
                                itemCount: bannerList.length,
                                itemBuilder: (context, index) {
                                  if (state is GetAllBooksLoading) {
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white, borderRadius: BorderRadius.circular(8)),
                                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                        height: 80,
                                      ),
                                    );
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: AppColors.primary),
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: AssetImage(bannerList[index].image!),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 20,
                                          left: 10,
                                          child: Text(bannerList[index].title!,
                                              overflow: TextOverflow.ellipsis, maxLines: 1),
                                        )
                                      ]),
                                    );
                                  }
                                },
                              ),
                            ),
                            // const SizedBox(height: 5),

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
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(color: AppColors.gray.withOpacity(0.1)),
                          width: 350,
                          // width: size.width,
                          height: 100, //0.34
                          // height: size.height * 0.20, //0.34
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: categoryList.length,
                            itemBuilder: (context, index) {
                              if (state is GetAllBooksLoading) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white, borderRadius: BorderRadius.circular(8)),
                                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                    height: 80,
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(categoryList[index].image!),
                                          radius: 35,
                                          child: Image(
                                            fit: BoxFit.cover,
                                            image: AssetImage(categoryList[index].image! ?? ""),
                                          ),
                                        ),
                                      ),
                                      Text(categoryList[index].name!),
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
                        const SizedBox(height: 15),

                        ///--------the popular books gridView------>
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: booksListData.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.54, crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            if (state is GetAllBooksLoading) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white, borderRadius: BorderRadius.circular(8)),
                                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                  height: 80,
                                ),
                              );
                            } else {
                              BookModel current = booksListData[index];
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  width: 162,
                                  height: 280,
                                  decoration: BoxDecoration(
                                    color: AppColors.beige,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Stack(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          ///---------the image---------->
                                          InkWell(
                                            onTap: () {
                                              AppFunctions.navigateTo(
                                                  context,
                                                  BookDetails(
                                                    data: booksListData[index],
                                                  ));
                                            },
                                            child: Container(
                                              width: 140,
                                              height: 200, //
                                              margin: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  // image: AssetImage(booksListData[index].imageUrl!),
                                                  image: AssetImage(current.imageUrl!),
                                                ),
                                              ),
                                            ),
                                          ),

                                          ///---------add name of the item---------->
                                          Text(
                                            current.bookName!,
                                            // "Adham sharkawy",
                                            style: font18RegularDark.copyWith(fontSize: 15),
                                          ),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              ///---------add price of the item---------->
                                              Text(
                                                "${current.price} \$",
                                                style: font18RegularDark,
                                              ),

                                              ///---------the buy button------->
                                              InkWell(
                                                onTap: () {
                                                  categoryCubit.toggleCart(current, context);
                                                },
                                                child: Container(
                                                  width: 72,
                                                  height: 28,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.green,
                                                    // color:current.isOnTheCart! ? AppColors.green : AppColors.black,
                                                    borderRadius: BorderRadius.circular(4),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      AppString.buy,
                                                      style: font15RegularWhite,
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),

                                      ///------------the favorite icon--------->
                                      Positioned(
                                        right: 1,
                                        child: CircleAvatar(
                                          foregroundColor: AppColors.primary,
                                          radius: 17,
                                          backgroundColor: AppColors.beige,
                                          child: Center(
                                            child: IconButton(
                                              onPressed: () {
                                                categoryCubit.toggleFavourite(current, context);
                                              },
                                              icon: SizedBox(
                                                width: 20,
                                                height: 20,
                                                child: current.isInTheWishList!
                                                    ? favouriteIcon
                                                    : notFavouriteIcon,
                                              ),
                                              iconSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
// }

var notFavouriteIcon = const Icon(Icons.favorite_outline_sharp);
var favouriteIcon = const Icon(
  Icons.favorite,
  color: AppColors.red,
);
var notOnTheCartIcon = const Icon(
  Icons.add_shopping_cart_sharp,
  color: AppColors.primary,
);
var onTheCartIcon = const Icon(
  Icons.add_shopping_cart_sharp,
  color: AppColors.green,
);
