abstract class FoodDetailState {}

class FoodDetailInitial extends FoodDetailState {}

class FoodDetailLoaded extends FoodDetailState {
  final int quantity;
  final String size;
  final bool addedToCart;

  FoodDetailLoaded({
    required this.quantity,
    required this.size,
    required this.addedToCart,
  });
}