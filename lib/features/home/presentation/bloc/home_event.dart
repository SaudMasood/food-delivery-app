abstract class HomeEvent {}

class LoadHome extends HomeEvent {}

class SelectCategory extends HomeEvent {
  final String category;

  SelectCategory(this.category);
}

class SearchFood extends HomeEvent {
  final String query;

  SearchFood(this.query);
}