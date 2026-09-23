import '../../domain/entities/food.dart';

class FoodModel extends Food {
  const FoodModel({
    required super.id,
    required super.name,
    required super.image,
    required super.price,
    required super.category,
    required super.restaurant,
    required super.rating,
  });
}