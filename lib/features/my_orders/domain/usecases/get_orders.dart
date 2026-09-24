import '../entities/order.dart';
import '../repositories/my_orders_repository.dart';

class GetOrders {
  final MyOrdersRepository repository;

  GetOrders({
    required this.repository,
  });

  List<Order> call() {
    return repository.getOrders();
  }
}