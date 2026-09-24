import '../../domain/entities/order.dart';

class OrderModel extends Order {
  const OrderModel({
    required super.id,
    required super.category,
    required super.restaurant,
    required super.orderNumber,
    required super.price,
    required super.itemCount,
    required super.date,
    required super.status,
    required super.image,
  });
}