import 'package:bookia_118/data/book_model.dart';
import 'package:bookia_118/data/cart_model.dart';
import 'package:bookia_118/data/order_model.dart';
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
  List<OrdersModel> ordersList = [];
  CartModel? cartData;

  ///=>> if i used it >> after finishing search the home page show the items on search  >> fix it ⤵⤵
  // List<BookModel> itemsInSearch = booksListData;
  TextEditingController searchController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController paymentTypeController = TextEditingController();
  TextEditingController transactionIdController = TextEditingController();

  ///-------OnRefresh function-------->
  Future<void> onRefresh() async {
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
      // debugPrint("length of booksListData ${booksListData.length.toString()}");
      // debugPrint("length of itemsInSearch ${itemsInSearch.length.toString()}");
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

      // debugPrint("length of booksListData ${booksListData.length.toString()}");
      // debugPrint("length of itemsInSearch ${itemsInSearch.length.toString()}");

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
    emit(CanselSearchState());
    // debugPrint("length of booksListData ${booksListData.length.toString()}");
    // debugPrint("length of itemsInSearch ${itemsInSearch.length.toString()}");
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
      // debugPrint(value.data.toString());
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
      // debugPrint(value.data.toString());
      emit(ToggleFavouriteState(value.data["message"]));
    }).catchError((error) {
      emit(ToggleFavouriteState(""));
      if (error is DioException) {
        // debugPrint(error.response.toString());
        // emit(ToggleFavouriteFailed());
        return;
      }
      emit(ToggleFavouriteState(""));
      // emit(ToggleFavouriteFailed());
      // debugPrint(error.response.toString());
      throw error;
    });
  }

  ///---------getBooksInWishList---------->
  Future<void> getBooksInWishList() async {
    // DioHelper.setupDio();
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
      debugPrint(value.data.toString());

      emit(GetFavouriteSuccessState());
      // debugPrint(value.data.toString());
    }).catchError((error) {
      if (error is DioException) {
        emit(GetFavouriteFailedState(error.response.toString()));
        // debugPrint(error.response.toString());
        return;
      }
      emit(GetFavouriteFailedState(error.response.toString()));
      // debugPrint(error.response.toString());
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

  ///--------addToCart function ----------->

  Future<void> addToCart(num? bookId) async {
    emit(AddedToCartLoadingState());
    await DioHelper.post(endPoint: EndPoints.addToCart, withToken: true, body: {
      "book_id": bookId.toString(),
    }).then((value) {
      debugPrint(value.data.toString());
      // debugPrint(value.data["message"]);
      emit(AddedToCartSuccessfulState());
    }).catchError((error) {
      if (error is DioException) {
        // debugPrint(error.response?.data.toString());
        // debugPrint("Dio Exception **");
        emit(AddedToCartFailedState());
      }
      // debugPrint(error.toString());
      // debugPrint(" NOT Dio Exception **");
      emit(AddedToCartFailedState());
    });
  }

  ///--------view cart function------------>

  Future<void> viewCart() async {
    emit(ViewCartLoadingState());
    await DioHelper.get(
      endPoint: EndPoints.viewCart,
      withToken: true,
    ).then((value) {
      cartData = CartModel.formJson(value.data["data"]);
      // itemsInCart.clear();
      // itemsInCart.add(cartData);

      debugPrint(cartData?.subTotal);
      emit(ViewCartSuccessState());
      debugPrint(value.data.toString());
    }).catchError((error) {
      emit(ViewCartFailedState());
      // debugPrint(error.data?.toString());
    });
  }

  ///--------addToCart function ----------->

  Future<void> decreaseQuantity(num? bookId) async {
    emit(RemovedFromCartLoadingState());
    await DioHelper.post(endPoint: EndPoints.removeFromCart, withToken: true, body: {
      "book_id": bookId.toString(),
    }).then((value) {
      debugPrint(value.data.toString());
      // debugPrint(value.data["message"]);
      emit(DecreasedFromCartSuccessState());
    }).catchError((error) {
      if (error is DioException) {
        debugPrint(error.response?.data.toString());
        // debugPrint("Dio Exception **");
        emit(DecreasedFromCartFailedState());
      }
      debugPrint(error.toString());
      // debugPrint(" NOT Dio Exception **");
      emit(DecreasedFromCartFailedState());
    });
  }

  ///-----remove item from cart ----------->

  Future<void> removeFromCart(num? bookId) async {
    emit(RemovedFromCartLoadingState());
    await DioHelper.delete(
      endPoint: EndPoints.deleteFromCart,
      withToken: true,
      params: {"book_id": bookId},
    ).then((value) {
      // debugPrint(value.data.toString());
      // debugPrint(value.data["message"]);
      // debugPrint(value.data);
      emit(RemovedFromCartSuccessState());
    }).catchError((error) {
      if (error is DioException) {
        // debugPrint(error.response?.data.toString());
        // debugPrint("Dio Exception **");
        emit(RemovedFromCartFailedState());
        return;
      }
      // debugPrint(error.toString());
      // debugPrint(" NOT Dio Exception **");
      emit(RemovedFromCartFailedState());
    });
  }

  ///---------------checkOut------------->
  Future<void> checkOut() async {
    emit(CheckOutLoadingState());
    await DioHelper.post(
      endPoint: EndPoints.checkOut,
      withToken: true,
      body: {
        "name": nameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
        "address": addressController.text,
        "lat": latitudeController.text,
        "lng": longitudeController.text,
        "payment_type": paymentTypeController.text,
        "transaction_id": transactionIdController.text,
      },
    ).then((value) {
      emit(CheckOutSuccessState(value.data["message"]));
      // debugPrint(value.data.toString());
    }).catchError((error) {
      if (error is DioException) {
        emit(CheckOutFailedState(error.response!.data["message"].toString()));
        return;
      }
      emit(CheckOutFailedState("something went wrong in CheckOut"));
    });
  }

  ///----------view User Orders------------->
  Future<void> viewOrders() async {
    emit(ViewOrdersLoadingState());
    await DioHelper.get(
      endPoint: EndPoints.viewAllOrders,
      withToken: true,
    ).then((value) {
      ordersList.clear();
      for (var element in value.data["data"]) {
        OrdersModel order = OrdersModel.fromJson(element);
        ordersList.add(order);
      }

      emit(ViewOrdersSuccessState());
    }).catchError((error){
      if(error is DioException){
        emit(ViewOrdersFailedState(error.response!.data["message"].toString()));
        return ;
      }
      emit(ViewOrdersFailedState("something went wrong in viewing orders"));
    });
  }
}
