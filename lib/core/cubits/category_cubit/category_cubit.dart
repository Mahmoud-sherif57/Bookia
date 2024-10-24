import 'package:bookia_118/data/base_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState>{
  CategoryCubit() : super(InitialCategoryState());


  static CategoryCubit get (context)=> BlocProvider.of<CategoryCubit> (context);

  List itemsInWishList =[] ;
  List itemsInCart =[] ;



  ///------------------addToFavouriteFunction---------->
  void addToFavourite(BaseModel data, BuildContext context) {
    itemsInWishList.add(data);
    emit(AAddedToTheCartState());
  }

  ///------------------delete item from Favourite---------->
  void deleteFromFavourite(BaseModel data) {
    itemsInWishList.removeWhere((element) => element.id == data.id);
    data.isFavourite;
    // if i increased the value(quantity) and removed the item from the list the value still increased..
    // to solve this problem when i tap on close. the value will be reset to 1..
    emit(RemovedFromFavoritesState());
  }

  ///----------toggle favourite--------->
  toggleFavourite(BaseModel data, BuildContext context) {
    emit(FavouriteLoadingState());
    data.isFavourite = !data.isFavourite;
    if (data.isFavourite) {
      addToFavourite(data, context);
    } else {
      deleteFromFavourite(data);
    }
  }

  ///------------------addToCartFunction---------->
  void addToCart(BaseModel data, BuildContext context) {
    itemsInCart.add(data);
    emit(AAddedToTheCartState());
  }

  ///------------------delete item from the cart---------->
  void deleteFromCart(BaseModel data) {
    itemsInCart.removeWhere((element) => element.id == data.id);
    // if i increased the value(quantity) and removed the item from the list the value still increased..
    // to solve this problem when i tap on close. the value will be reset to 1..
    data.value = 1;
    emit(RemovedFromTheCartState());
    // emit(DeletedSuccessfullyState());
  }

  ///-------------toggle cart------------>
  void toggleCart(BaseModel data, BuildContext context) {
    data.isOnTheCart = !data.isOnTheCart;
    if (data.isOnTheCart) {
      addToCart(data, context);
    } else {
      deleteFromCart(data);
    }
  }

  ///------------------increase quantity of item------------>
  void increaseQuantity(BaseModel current) {
    if (current.value! >= 0) {
      current.value = (current.value)! + 1;
      emit(IncreaseValueState());
    }
  }

  ///------------------decrease quantity of item------------>
  void decreaseQuantity(BaseModel current ,BuildContext context) {
    if (current.value! > 1) {
      current.value = (current.value)! - 1;
      emit(DecreaseValueState());
    } else {
      toggleCart(current,context);
      // current.value = 1;
      emit(RemovedFromTheCartState());
    }
  }

  ///----------calculates the total cost of the items on the cart------->
  num getTotalCost() {
    num total = 0;
    if (itemsInCart.isEmpty) {
      total = 0;
      return total;
    } else {
      for (BaseModel items in itemsInCart) {
        total = total + items.price * items.value!;
        // ex: total = 0 + 10$ * 2 pieces ;
        //     total = 20$ ;
      }
    }
    return double.parse(total.toStringAsFixed(
        2));
    // Safety format to 2 decimals because sometimes the total be like (00.00000000000)
  }

  ///----------calculates the total amount of the items on the cart------->
  num getTotalAmount(){
    num total = 0;
    if(itemsInCart.isEmpty){
      total =0 ;
      return total ;
    } else{
      for (BaseModel items in itemsInCart){
        total = total + items.value! ;
      }
    } return total ;
  }


}