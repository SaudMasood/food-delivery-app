import '../../domain/entities/cart_item.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> items;

  CartLoaded({
    required this.items,
  });

  double get total {
    double value = 0;

    for (final item in items) {
      value += item.price * item.quantity;
    }

    return value;
  }
}