import '../../domain/entities/order.dart';

abstract class MyOrdersEvent {}

class LoadOrders extends MyOrdersEvent {}

class SelectOrderTab extends MyOrdersEvent {
  final int index;

  SelectOrderTab(this.index);
}

class CancelOrder extends MyOrdersEvent {
  final int orderId;

  CancelOrder(this.orderId);
}

class Reorder extends MyOrdersEvent {
  final Order order;

  Reorder(this.order);
}

class RateOrder extends MyOrdersEvent {
  final Order order;

  RateOrder(this.order);
}