import '../../domain/entities/cart_item.dart';

class CartItemModel extends CartItem {
  const CartItemModel({
    required super.id,
    required super.name,
    required super.image,
    required super.size,
    required super.price,
    required super.quantity,
  });
}