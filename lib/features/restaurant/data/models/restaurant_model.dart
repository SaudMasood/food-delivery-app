import '../../domain/entities/restaurant.dart';

class RestaurantModel extends Restaurant {
  const RestaurantModel({
    required super.id,
    required super.name,
    required super.image,
    required super.description,
    required super.rating,
    required super.delivery,
    required super.deliveryTime,
  });
}