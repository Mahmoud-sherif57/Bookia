import 'package:bookia_118/core/cubits/category_cubit/category_state.dart';
import 'package:bookia_118/core/widgets/app_shimmer.dart';
import 'package:bookia_118/core/widgets/the_book_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../core/cubits/category_cubit/category_cubit.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/widgets/app_back_button.dart';
import '../../../../core/widgets/reusable_page_name.dart';
import '../../../../data/book_model.dart';

class BooksByCategoryScreen extends StatelessWidget {
  const BooksByCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final categoryCubit = CategoryCubit.get(context);
    final categoryCubit = context.read<CategoryCubit>();
    var size = MediaQuery.of(context).size;
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state is GetBooksByCategoryIdLoading) {
          EasyLoading.showSuccess(" successful");
        } else if (state is GetBooksByCategoryIdFailed) {
          EasyLoading.showError(state.error);
        } else if (state is GetBooksByCategoryIdLoading) {
          EasyLoading.show(status: "loading..");
        }
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
                        Row(
                          children: [
                            const AppBackButton(),
                            const Spacer(),
                            Center(
                              child: ReusablePageName(
                                width: 170,
                                text: categoryCubit.booksByCategory[0].categoryName ?? "",
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                        const SizedBox(height: 12),

                        ///--------the books list by category gridView------>

                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.54, crossAxisCount: 2),
                          itemCount: categoryCubit.booksByCategory.length,
                          itemBuilder: (context, index) {
                            if (state is GetAllBooksLoading) {
                              return const AppShimmer();
                            } else {
                              BookModel current = categoryCubit.booksByCategory[index];
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
