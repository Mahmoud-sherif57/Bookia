abstract class CategoryState {}
  class InitialCategoryState extends CategoryState{}

class GetAllBooksLoading extends CategoryState {}
class GetAllBooksSuccess extends CategoryState {}
class GetAllBooksFailed extends CategoryState {
  final String error ;
  GetAllBooksFailed(this.error) ;
}
class ItemRemovedSuccessfully extends CategoryState{}

  class FavouriteLoadingState extends CategoryState{}
  class RemovedFromFavoritesState extends CategoryState{}
  class AddedToTheCartState extends CategoryState{}
  class RemovedFromTheCartState extends CategoryState{}
  class IncreaseValueState extends CategoryState{}
  class DecreaseValueState extends CategoryState{}






