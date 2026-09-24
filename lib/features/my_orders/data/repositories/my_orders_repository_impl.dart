import '../../domain/entities/order.dart';
import '../../domain/repositories/my_orders_repository.dart';
import '../datasources/my_orders_local_data_source.dart';

class MyOrdersRepositoryImpl
    implements MyOrdersRepository {
  final MyOrdersLocalDataSource dataSource;

  MyOrdersRepositoryImpl({
    required this.dataSource,
  });

  @override
  List<Order> getOrders() {
    return dataSource.getOrders();
  }
}