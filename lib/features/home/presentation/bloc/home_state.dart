import '../../domain/entities/food.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Food> foods;
  final String selectedCategory;
  final String searchQuery;

  HomeLoaded({
    required this.foods,
    required this.selectedCategory,
    required this.searchQuery,
  });
}