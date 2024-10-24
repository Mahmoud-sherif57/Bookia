import 'package:bookia_118/core/constants/app_strings.dart';
import 'package:bookia_118/core/cubits/category_cubit/category_state.dart';
import 'package:bookia_118/core/cubits/homeScreen_cubit/home_screen_cubit.dart';
import 'package:bookia_118/core/cubits/homeScreen_cubit/home_screen_state.dart';
import 'package:bookia_118/core/theming/styles.dart';
import 'package:bookia_118/data/app_data.dart';
import 'package:bookia_118/feature/home/presentation/screens/book_details.dart';
import 'package:bookia_118/feature/home/presentation/screens/notification.dart';
import 'package:bookia_118/feature/login/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/cubits/category_cubit/category_cubit.dart';
import '../../../../core/functions/navigation.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../data/base_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final categoryCubit = CategoryCubit.get(context);
    final categoryCubit = context.read<CategoryCubit>();

    var size = MediaQuery.of(context).size;
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
      builder: (context, state) {
        var homeCubit = context.read<HomeScreenCubit>();

        return SafeArea(
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
                                onTap: () { AppFunctions.navigateTo(context,  const NotificationScreen());},
                                child: SvgPicture.asset(AppIcons.notification),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              InkWell(
                                onTap: () { AppFunctions.navigateTo(context, const LoginScreen());},
                                child: SvgPicture.asset(AppIcons.search),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),

                      ///-----------------start the page view section---------------->

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
                              controller: homeCubit.controller,
                              physics: const BouncingScrollPhysics(),
                              itemCount: bannerList.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.primary),
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: AssetImage(bannerList[index]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          ///-----------make the indicator------>
                          Align(
                            alignment: Alignment.center,
                            child: SmoothPageIndicator(
                              controller: homeCubit.controller,
                              count: bannerList.length,
                              effect: const ExpandingDotsEffect(
                                dotColor: AppColors.primary,
                                activeDotColor: AppColors.primary,
                                dotWidth: 8.0,
                                dotHeight: 8.0,
                                strokeWidth: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      ///---------the popular books text------->
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          AppString.popularBooks,
                          style: font30RegularDark.copyWith(fontSize: 24),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      ///--------the popular books gridView------>
                      BlocConsumer<CategoryCubit, CategoryState>(
                        listener: (context, state) {
                          // TODO: implement listener
                        },
                        builder: (context, state) {
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: booksListData.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 0.54, crossAxisCount: 2),
                            itemBuilder: (context, index) {
                              BaseModel current = booksListData[index];
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
                                              AppFunctions.navigateTo(context,  BookDetails(data: booksListData[index],));
                                            },
                                            child: Container(
                                              width: 140,
                                              height: 200, //
                                              margin: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(booksList[index]),
                                                ),
                                              ),
                                            ),
                                          ),

                                          ///---------add name of the item---------->
                                          Text(
                                            current.name,
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
                                                    color:current.isOnTheCart? AppColors.green : AppColors.black,
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
                                                child: current.isFavourite ? favouriteIcon : notFavouriteIcon,
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
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

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
