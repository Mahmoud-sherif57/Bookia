abstract class CategoryState {}

class InitialCategoryState extends CategoryState {}

/// ===============================================================>
class GetAllBooksLoading extends CategoryState {}

class GetAllBooksSuccess extends CategoryState {}

class GetAllBooksFailed extends CategoryState {
  final String error;
  GetAllBooksFailed(this.error);
}

/// ===============================================================>
class GetBooksByCategoryIdLoading extends CategoryState {}

class GetBooksByCategoryIdSuccess extends CategoryState {}

class GetBooksByCategoryIdFailed extends CategoryState {
  final String error;
  GetBooksByCategoryIdFailed(this.error);
}

/// ===============================================================>
class CanselSearchState extends CategoryState {}

/// ===============================================================>

class ToggleFavouriteState extends CategoryState {
  final String msg;
  ToggleFavouriteState(this.msg);
}

class ToggleFavouriteLoading extends CategoryState {}

class ToggleFavouriteSuccess extends CategoryState {}

class ToggleFavouriteFailed extends CategoryState {}

/// ===============================================================>

class GetFavouriteLoadingState extends CategoryState {}

class GetFavouriteSuccessState extends CategoryState {}

class GetFavouriteFailedState extends CategoryState {
  final String error;
  GetFavouriteFailedState(this.error);
}

/// ===============================================================>

class AddedToCartLoadingState extends CategoryState {}

class AddedToCartSuccessfulState extends CategoryState {
  // final String msg;
  // AddedToCartSuccessfulState(this.msg);
}

class AddedToCartFailedState extends CategoryState {}

/// ===============================================================>

class RemovedFromCartLoadingState extends CategoryState {}

class RemovedFromCartSuccessState extends CategoryState {}

class RemovedFromCartFailedState extends CategoryState {}

/// ===============================================================>
class DecreasedFromCartSuccessState extends CategoryState {}

class DecreasedFromCartFailedState extends CategoryState {}

class DecreasedFromCartLoadingState extends CategoryState {}

/// ===============================================================>
class ViewCartLoadingState extends CategoryState {}

class ViewCartSuccessState extends CategoryState {
  // final CartModel cartData;
  // ViewCartSuccessState(this.cartData);
}

class ViewCartFailedState extends CategoryState {}

/// ===============================================================>

class CheckOutLoadingState extends CategoryState {}

class CheckOutSuccessState extends CategoryState {
  final String msg;
  CheckOutSuccessState(this.msg);
}

class CheckOutFailedState extends CategoryState {
  final String error;
  CheckOutFailedState(this.error);
}

/// ===============================================================>

class ViewOrdersLoadingState extends CategoryState {}

class ViewOrdersSuccessState extends CategoryState {}

class ViewOrdersFailedState extends CategoryState {
  final String error;
  ViewOrdersFailedState(this.error);
}

/// ===============================================================>
