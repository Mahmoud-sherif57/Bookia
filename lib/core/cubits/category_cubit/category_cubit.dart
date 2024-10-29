import 'package:bookia_118/data/book_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/categories_model.dart';
import '../../../data/local/app_data.dart';
import '../../../data/network/dio_helper.dart';
import '../../../data/network/end_points.dart';
import '../../../data/slider_model.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(InitialCategoryState());

  static CategoryCubit get(context) => BlocProvider.of<CategoryCubit>(context);

  List itemsInWishList = [];
  List itemsInCart = [];


  ///-------OnRefresh function-------->
  Future<void> onRefresh() async {
    // booksListData.clear();
    // bannerList.clear();
    // categoryList.clear();
    await getAllBooks();
    while (state is GetAllBooksLoading) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  ///-------get all books function-------->
  Future<void> getAllBooks() async {
    emit(GetAllBooksLoading());
    await DioHelper.get(
      endPoint: EndPoints.home,
      withToken: true,
    ).then((value) {
      bannerList.clear();
      // to store the api data in the banner list( bannerList)
      for (var element in value.data["data"]["sliders"]) {
        SliderModel sliders = SliderModel.fromJson(element);
        bannerList.add(sliders);
      }
      booksListData.clear();
      // to store the api data in the book list( bookListData)
      for (var element in value.data["data"]["books"]) {
        BookModel book = BookModel.fromJson(element);
        booksListData.add(book);
      }
      categoryList.clear();
      // to store the api data in the category list( categoryList)
      for (var element in value.data["data"]["categories"]) {
        CategoriesModel category = CategoriesModel.fromJson(element);
        categoryList.add(category);
      }

      emit(GetAllBooksSuccess());
      // debugPrint(value.data["data"].toString());
    }).catchError((error) {
      if (error is DioException) {
        // debugPrint(error.message.toString());
        // debugPrint(error.response?.data);
        emit(GetAllBooksFailed(error.response?.data["message"] ?? "can not get your order"));
        return;
      }
      // debugPrint(error.toString());
      emit(GetAllBooksFailed("can not get your order "));
      throw error;
    });
  }

  ///------------------addToFavouriteFunction---------->
  void addToFavourite(BookModel data, BuildContext context) {
    itemsInWishList.add(data);
    emit(AddedToTheCartState());
  }

  ///------------------delete item from Favourite---------->
  void deleteFromFavourite(BookModel data) {
    itemsInWishList.removeWhere((element) => element.bookId == data.bookId);
    data.isInTheWishList;
    // if i increased the value(quantity) and removed the item from the list the value still increased..
    // to solve this problem when i tap on close. the value will be reset to 1..
    emit(RemovedFromFavoritesState());
  }

  ///----------toggle favourite--------->
  toggleFavourite(BookModel data, BuildContext context) {
    emit(FavouriteLoadingState());
    data.isInTheWishList = !data.isInTheWishList!;
    if (data.isInTheWishList!) {
      addToFavourite(data, context);
    } else {
      deleteFromFavourite(data);
    }
  }

  ///------------------addToCartFunction---------->
  void addToCart(BookModel data, BuildContext context) {
    itemsInCart.add(data);
    emit(AddedToTheCartState());
  }

  ///------------------delete item from the cart---------->
  void deleteFromCart(BookModel data) {
    itemsInCart.removeWhere((element) => element.bookId == data.bookId);
    // if i increased the value(quantity) and removed the item from the list the value still increased..
    // to solve this problem when i tap on close. the value will be reset to 1..
    // data.value = 1;
    emit(RemovedFromTheCartState());
  }

  ///-------------toggle cart------------>
  void toggleCart(BookModel data, BuildContext context) {
    // data.isOnTheCart = !data.isOnTheCart!;
    // if (data.isOnTheCart!) {
    //   addToCart(data, context);
    // } else {
    //   deleteFromCart(data);
    // }
  }

  ///------------------increase quantity of item------------>
  /// replace with api
  void increaseQuantity(BookModel current) {
    // if (current.value! >= 0) {
    //   current.value = (current.value)! + 1;
    //   emit(IncreaseValueState());
    // }
  }

  ///------------------decrease quantity of item------------>
  /// replace with api
  void decreaseQuantity(BookModel current, BuildContext context) {
    // if (current.value! > 1) {
    //   current.value = (current.value)! - 1;
    //   emit(DecreaseValueState());
    // }
    // else {
    //   toggleCart(current,context);
    //   // current.value = 1;
    //   emit(RemovedFromTheCartState());
    // }
  }

  ///----------calculates the total cost of the items on the cart------->
  /// replace with api
  num getTotalCost() {
    num total = 0;
    if (itemsInCart.isEmpty) {
      total = 0;
      return total;
    } else {
      for (BookModel items in itemsInCart) {
        total = total;
        // ex: total = 0 + 10$ * 2 pieces ;
        //     total = 20$ ;
      }
    }
    return double.parse(total.toStringAsFixed(2));
    // return null;
    // Safety format to 2 decimals because sometimes the total be like (00.00000000000)
  }

  ///----------calculates the total amount of the items on the cart------->
  num getTotalAmount() {
    num total = 0;
    if (itemsInCart.isEmpty) {
      total = 0;
      return total;
    } else {
      for (BookModel items in itemsInCart) {
        total = total;
      }
      return total;
    }
  }
}
