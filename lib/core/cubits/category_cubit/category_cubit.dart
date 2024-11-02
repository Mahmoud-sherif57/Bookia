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
  List<BookModel> itemsInSearch = [];
  List<BookModel> booksByCategory = [];

  ///=>> if i used it >> after finishing search the home page show the items on search  >> fix it ⤵⤵
  // List<BookModel> itemsInSearch = booksListData;
  TextEditingController searchController = TextEditingController();

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
      ///-------save data in the sliders List ---->
      bannerList.clear();
      // to store the api data in the banner list( bannerList)
      for (var element in value.data["data"]["sliders"]) {
        SliderModel sliders = SliderModel.fromJson(element);
        bannerList.add(sliders);
      }

      ///-------save data in the books List ---->
      booksListData.clear();
      // to store the api data in the book list( bookListData)
      for (var element in value.data["data"]["books"]) {
        BookModel book = BookModel.fromJson(element);
        booksListData.add(book);
      }

      ///-------save data in the category List ---->
      categoryList.clear();
      // to store the api data in the category list( categoryList)
      for (var element in value.data["data"]["categories"]) {
        CategoriesModel category = CategoriesModel.fromJson(element);

        categoryList.add(category);
      }
      emit(GetAllBooksSuccess());
      // debugPrint(value.data["data"].toString());
      debugPrint("length of booksListData ${booksListData.length.toString()}");
      debugPrint("length of itemsInSearch ${itemsInSearch.length.toString()}");
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

  ///------the search function---------->
  Future<void> booksInSearch(String value) async {
    emit(GetAllBooksLoading());
    await DioHelper.get(
      endPoint: EndPoints.search,
      params: {"input": value},
    ).then((value) {
      ///-------save data in the category List ---->
      itemsInSearch.clear();
      // to store the api data in the book list( bookListData)
      for (var element in value.data["data"]) {
        BookModel bookInSearch = BookModel.fromJson(element);
        itemsInSearch.add(bookInSearch);
      }

      debugPrint("length of booksListData ${booksListData.length.toString()}");
      debugPrint("length of itemsInSearch ${itemsInSearch.length.toString()}");

      emit(GetAllBooksSuccess());
    }).catchError((error) {
      if (error is DioException) {
        emit(GetAllBooksFailed(error.response.toString()));
        return;
      }
      emit(GetAllBooksFailed("can not find your book "));
      throw error;
    });
    // emit(GetAllBooksSuccess());
    // itemsInSearch = booksListData.where((element)=> element.bookName!.contains(value)).toList();
  }

  ///------cancel search function---------->
  void canselTheSearch() {
    searchController.clear();
    itemsInSearch = [];
    emit(ItemRemovedSuccessfully());
    debugPrint("length of booksListData ${booksListData.length.toString()}");
    debugPrint("length of itemsInSearch ${itemsInSearch.length.toString()}");
  }

  ///------the getBookByCategory function---------->
  Future<void> getBookByCategory(num? categoryId) async {
    emit(GetBooksByCategoryIdLoading());
    await DioHelper.get(
      endPoint: "get_books_by_category_id/$categoryId",
    ).then((value) {
      ///-------save data in the booksByCategory list ---->
      booksByCategory.clear();
      // to store the api data in the book list( booksByCategory)
      for (var element in value.data["data"]) {
        BookModel book = BookModel.fromJson(element);
        booksByCategory.add(book);
      }
      debugPrint(value.data.toString());
      emit(GetBooksByCategoryIdSuccess());
    }).catchError((error) {
      if (error is DioException) {
        emit(GetBooksByCategoryIdFailed(error.response?.data.toString() ?? ""));
        return;
      }
      emit(GetBooksByCategoryIdFailed("can't get your order"));
      throw error;
    });

    // for (var element in value.data["data"]) {
    //   BookModel bookInSearch = BookModel.fromJson(element).categoryId;
    //   itemsInSearch.add(bookInSearch);
    // }
    // CategoriesModel current = categoryList[index].categoryId ;
  }

  ///--------toggle favourite--------------->
  Future<void> toggleFavorite(num? bookId) async {
    // emit(ToggleFavouriteState());
    // emit(ToggleFavouriteLoading());
    await DioHelper.get(
      endPoint: "toggle_wishlist/$bookId",
      withToken: true,
    ).then((value) {
      debugPrint(value.data.toString());
      // emit(ToggleFavouriteSuccess());
      emit(ToggleFavouriteState());
    }).catchError((error) {
      if (error is DioException) {
        debugPrint(error.response.toString());
        // emit(ToggleFavouriteFailed());
        return;
      }
      // emit(ToggleFavouriteFailed());
      debugPrint(error.response.toString());
      throw error;
    });
  }

  ///---------getBooksInWishList---------->
  Future<void> getBooksInWishList() async {
    emit(GetFavouriteLoadingState());
    await DioHelper.get(
      endPoint: EndPoints.wishLists,
      withToken: true,
    ).then((value) {
      itemsInWishList.clear();
      for (var element in value.data["data"]) {
        BookModel book = BookModel.fromJson(element);
        itemsInWishList.add(book);
      }

      emit(GetFavouriteSuccessState());
      debugPrint(value.data.toString());
    }).catchError((error) {
      if (error is DioException) {
        emit(GetFavouriteFailedState(error.response.toString()));
        debugPrint(error.response.toString());
        return;
      }
      emit(GetFavouriteFailedState(error.response.toString()));
      debugPrint(error.response.toString());
    });
  }

  ///-----------show books function--------->
  // Future<void> showBooks(num bookId) async {
  //   await DioHelper.get(endPoint: "books/$bookId").then((value) {
  //     for (var element in value.data["data"]) {
  //       BookModel book = BookModel.fromJson(element);
  //       booksListData.add(book);
  //     }
  //   }).catchError((error) {
  //     if (error is DioException) {
  //       debugPrint(error.response.toString() ?? "hi hi ");
  //       emit(GetAllBooksFailed(error.response?.data["message"] ?? "can not get your order"));
  //       return;
  //     }
  //     debugPrint(error.response?.toString());
  //     emit(GetAllBooksFailed("can not get your order "));
  //     throw error;
  //   });
  // }






  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
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
    emit(ToggleFavouriteSuccess());
  }

  ///----------toggle favourite--------->
  toggleFavourite(BookModel data, BuildContext context) {
    emit(ToggleFavouriteLoading());
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
