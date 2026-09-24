import '../../domain/entities/order.dart';

abstract class MyOrdersState {}

class MyOrdersInitial extends MyOrdersState {}

class MyOrdersLoading extends MyOrdersState {}

class MyOrdersLoaded extends MyOrdersState {
  final List<Order> ongoingOrders;
  final List<Order> historyOrders;
  final int selectedTab;

  MyOrdersLoaded({
    required this.ongoingOrders,
    required this.historyOrders,
    required this.selectedTab,
  });
}