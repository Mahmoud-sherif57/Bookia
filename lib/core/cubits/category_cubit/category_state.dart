abstract class CategoryState {}

class InitialCategoryState extends CategoryState {}

class GetAllBooksLoading extends CategoryState {}

class GetAllBooksSuccess extends CategoryState {}

class GetAllBooksFailed extends CategoryState {
  final String error;
  GetAllBooksFailed(this.error);
}

///-----get_books_by_category_id State----->

class GetBooksByCategoryIdLoading extends CategoryState {}

class GetBooksByCategoryIdSuccess extends CategoryState {}

class GetBooksByCategoryIdFailed extends CategoryState {
  final String error;
  GetBooksByCategoryIdFailed(this.error);
}

///-------------------
class ItemRemovedSuccessfully extends CategoryState {}

class ToggleFavouriteState extends CategoryState {}

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

class AddedToTheCartState extends CategoryState {}

class RemovedFromTheCartState extends CategoryState {}

class IncreaseValueState extends CategoryState {}

class DecreaseValueState extends CategoryState {}
