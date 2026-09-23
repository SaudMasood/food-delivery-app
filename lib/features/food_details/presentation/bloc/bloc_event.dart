abstract class FoodDetailEvent {}

class LoadFoodDetail extends FoodDetailEvent {}

class IncreaseQuantity extends FoodDetailEvent {}

class DecreaseQuantity extends FoodDetailEvent {}

class SelectFoodSize extends FoodDetailEvent {
  final String size;

  SelectFoodSize(this.size);

}

class AddFoodToCart extends FoodDetailEvent {}