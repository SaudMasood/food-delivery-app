import '../entities/order.dart';

abstract class MyOrdersRepository {
  List<Order> getOrders();
}