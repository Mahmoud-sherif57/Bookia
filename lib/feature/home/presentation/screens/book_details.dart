import 'package:bookia_118/core/cubits/category_cubit/category_cubit.dart';
import 'package:bookia_118/core/cubits/category_cubit/category_state.dart';
import 'package:bookia_118/core/theming/styles.dart';
import 'package:bookia_118/core/widgets/app_back_button.dart';
import 'package:bookia_118/core/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../data/base_model.dart';

class BookDetails extends StatefulWidget {
  const BookDetails({super.key, required this.data});
  final BaseModel data;

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  @override
  Widget build(BuildContext context) {
    final categoryCubit = context.read<CategoryCubit>();
    // var current = booksList[index];
    BaseModel current = widget.data;

    return BlocBuilder<CategoryCubit, CategoryState>(
  builder: (context, state) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          children: [
            const SizedBox(height: 25),
            const Row(
              children: [
                AppBackButton(),
              ],
            ),

            ///--------the book details------>
            SizedBox(
              height: 630,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 15),  //30
                    ///-----the image of the book----->
                    Container(
                      width: 200, //183
                      height: 300,  //271
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 8),
                            color: AppColors.gray.withOpacity(0.5),
                            blurRadius: 20,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                        image:  DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(current.imageUrl),
                          // image: AssetImage(AppImages.book4),
                        ),
                      ),
                    ),
                    const SizedBox(height: 11),
                    ///-----the name of the book----->
                    Text(current.name, style: font24RegularDark),
                    const SizedBox(height: 11),
                    ///-----the author name of the book----->
                    Text(
                      current.writerName,
                      style: font15RegularGray.copyWith(color: AppColors.primary),
                    ),
                    const SizedBox(height: 11),
                    ///-----the summary of the book----->
                    const Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                      textAlign: TextAlign.justify,
                    ),
                    const Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            ///-----the price & mainButton of the book----->
             Row(
              children: [
                ///-----the price of the book----->
                Text("${current.price} \$" , style: font24RegularDark),
                const Spacer(),
                ///-----the add to cart button----->
                MainButton(
                  onTap: (){
                    categoryCubit.toggleCart(current, context);
                  },
                  width: 180,
                  color: AppColors.black,
                  title: current.isOnTheCart? AppString.inTheCart : AppString.addToCart,
                  /// TODO: add cubit
                )
              ],
            )
          ],
        ),
      ),
    );
  },
);
  }
}

