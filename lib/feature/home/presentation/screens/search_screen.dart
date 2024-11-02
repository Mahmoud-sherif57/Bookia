import 'package:bookia_118/core/widgets/the_book_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/cubits/category_cubit/category_cubit.dart';
import '../../../../core/cubits/category_cubit/category_state.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/widgets/app_shimmer.dart';
import '../../../../data/book_model.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryCubit = context.read<CategoryCubit>();
    return SafeArea(
      child: BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.backGround,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  ///-------------start the searchField section------------>
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: SizedBox(
                      height: 45,
                      child: TextFormField(
                        controller: categoryCubit.searchController,
                        onChanged: (value) => categoryCubit.booksInSearch(value),
                        decoration: InputDecoration(
                          // contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          fillColor: AppColors.offWhite,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.primary,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: AppColors.primary, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              categoryCubit.canselTheSearch();
                            },
                            icon: const Icon(Icons.close),
                          ),
                          hintText: 'إبحث عن كتابك المفضل     ',
                          // hintStyle: TextTheme,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  ///--------the popular books gridView------>
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: categoryCubit.itemsInSearch.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.54, crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      if (state is GetAllBooksLoading) {
                        return const AppShimmer();
                      } else {
                        BookModel current = categoryCubit.itemsInSearch[index];
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
          );
        },
      ),
    );
  }
}
