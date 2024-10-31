import 'package:bookia_118/core/constants/app_strings.dart';
import 'package:bookia_118/core/theming/styles.dart';
import 'package:bookia_118/feature/home/presentation/screens/book_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/cubits/category_cubit/category_cubit.dart';
import '../../../../core/functions/navigation.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../data/book_model.dart';

class TheCategoryDetailsWidget extends StatelessWidget {
  const TheCategoryDetailsWidget({
    super.key,
    required this.current,
    required this.index,
  });

  final BookModel current;
  final int index;

  @override
  Widget build(BuildContext context) {
    final categoryCubit = context.read<CategoryCubit>();
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
                    AppFunctions.navigateTo(context, BookDetails(data: current));
                    // AppFunctions.navigateTo(context, BookDetails(data: booksListData[index]));
                  },
                  child: Container(
                    width: 140,
                    height: 220, //
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: current.imageUrl != null
                            // image: booksListData[index].imageUrl != null
                            ? NetworkImage(
                                current.imageUrl!,
                                // booksListData[index].imageUrl!,
                              )
                            : const AssetImage('assets/images/aflaton.png') as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),

                ///---------add name of the item---------->
                Text(
                  // current.bookName ?? "",
                  current.bookName!.length > 20
                      ? '${current.bookName!.substring(0, 20)}...'
                      : current.bookName ?? "",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                AppString.buy,
                                style: font15RegularWhite,
                                textAlign: TextAlign.center,
                              ),
                              const Icon(
                                Icons.plus_one,
                                color: AppColors.offWhite,
                                size: 20,
                              )
                            ],
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
                      child: current.isInTheWishList! ? favouriteIcon : notFavouriteIcon,
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
}

var notFavouriteIcon = const Icon(Icons.favorite_outline_sharp);
var favouriteIcon = const Icon(
  Icons.favorite,
  color: AppColors.red,
);
