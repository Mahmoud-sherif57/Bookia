abstract class HomeScreenState {}

class HomeScreenInitial extends HomeScreenState {}

class HomePageChanged extends HomeScreenState {
  final int currentPage;
  HomePageChanged(this.currentPage);
}
