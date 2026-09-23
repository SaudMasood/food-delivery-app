import '../../domain/entities/restaurant.dart';

abstract class RestaurantState {}

class RestaurantInitial extends RestaurantState {}

class RestaurantLoaded extends RestaurantState {
  final Restaurant restaurant;

  RestaurantLoaded({
    required this.restaurant,
  });
}