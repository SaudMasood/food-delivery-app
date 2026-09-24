import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/order.dart';
import '../../domain/usecases/get_orders.dart';
import 'my_orders_event.dart';
import 'my_orders_state.dart';

class MyOrdersBloc
    extends Bloc<MyOrdersEvent, MyOrdersState> {
  final GetOrders getOrders;

  MyOrdersBloc({
    required this.getOrders,
  }) : super(MyOrdersInitial()) {
    on<LoadOrders>(_loadOrders);
    on<SelectOrderTab>(_selectTab);
    on<CancelOrder>(_cancelOrder);
    on<Reorder>(_reorder);
    on<RateOrder>(_rateOrder);
  }

  void _loadOrders(
      LoadOrders event,
      Emitter<MyOrdersState> emit,
      ) {
    emit(MyOrdersLoading());

    final orders = getOrders();

    emit(
      MyOrdersLoaded(
        ongoingOrders: orders
            .where(
              (order) =>
          order.status == OrderStatus.ongoing,
        )
            .toList(),
        historyOrders: orders
            .where(
              (order) =>
          order.status != OrderStatus.ongoing,
        )
            .toList(),
        selectedTab: 0,
      ),
    );
  }

  void _selectTab(
      SelectOrderTab event,
      Emitter<MyOrdersState> emit,
      ) {
    if (state is MyOrdersLoaded) {
      final current = state as MyOrdersLoaded;

      emit(
        MyOrdersLoaded(
          ongoingOrders: current.ongoingOrders,
          historyOrders: current.historyOrders,
          selectedTab: event.index,
        ),
      );
    }
  }

  void _cancelOrder(
      CancelOrder event,
      Emitter<MyOrdersState> emit,
      ) {
    if (state is! MyOrdersLoaded) {
      return;
    }

    final current = state as MyOrdersLoaded;

    final ongoing = current.ongoingOrders
        .where(
          (order) => order.id != event.orderId,
    )
        .toList();

    emit(
      MyOrdersLoaded(
        ongoingOrders: ongoing,
        historyOrders: current.historyOrders,
        selectedTab: current.selectedTab,
      ),
    );
  }

  void _reorder(
      Reorder event,
      Emitter<MyOrdersState> emit,
      ) {}

  void _rateOrder(
      RateOrder event,
      Emitter<MyOrdersState> emit,
      ) {}
}