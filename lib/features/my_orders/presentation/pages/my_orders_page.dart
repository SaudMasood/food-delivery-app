import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/my_orders_local_data_source.dart';
import '../../data/repositories/my_orders_repository_impl.dart';
import '../../domain/usecases/get_orders.dart' hide MyOrdersRepositoryImpl;
import '../bloc/my_orders_bloc.dart';
import '../bloc/my_orders_event.dart';
import '../bloc/my_orders_state.dart';
import '../widgets/order_card.dart';
import '../widgets/order_tab.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dataSource = MyOrdersLocalDataSource();

    final repository = MyOrdersRepositoryImpl(
      dataSource: dataSource,
    );

    final getOrders = GetOrders(
      repository: repository,
    );

    return BlocProvider(
      create: (_) => MyOrdersBloc(
        getOrders: getOrders,
      )..add(LoadOrders()),
      child: const MyOrdersView(),
    );
  }
}

class MyOrdersView extends StatelessWidget {
  const MyOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 8),
            _buildTabs(context),
            const SizedBox(height: 8),
            Expanded(
              child: _buildOrders(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        18,
        18,
        18,
        10,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 46,
              height: 46,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 20,
                color: Color(0xFF20232D),
              ),
            ),
          ),
          const SizedBox(width: 15),
          const Text(
            'My Orders',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w700,
              color: Color(0xFF20232D),
            ),
          ),
          const Spacer(),
          Container(
            width: 46,
            height: 46,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.more_horiz,
              size: 27,
              color: Color(0xFF20232D),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs(BuildContext context) {
    return BlocBuilder<MyOrdersBloc, MyOrdersState>(
      builder: (context, state) {
        int selected = 0;

        if (state is MyOrdersLoaded) {
          selected = state.selectedTab;
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: OrderTab(
                  title: 'Ongoing',
                  selected: selected == 0,
                  onTap: () {
                    context.read<MyOrdersBloc>().add(
                      SelectOrderTab(0),
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OrderTab(
                  title: 'History',
                  selected: selected == 1,
                  onTap: () {
                    context.read<MyOrdersBloc>().add(
                      SelectOrderTab(1),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOrders() {
    return BlocBuilder<MyOrdersBloc, MyOrdersState>(
      builder: (context, state) {
        if (state is MyOrdersLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFFFF7622),
            ),
          );
        }

        if (state is! MyOrdersLoaded) {
          return const SizedBox();
        }

        final orders = state.selectedTab == 0
            ? state.ongoingOrders
            : state.historyOrders;

        if (orders.isEmpty) {
          return const Center(
            child: Text(
              'No orders found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xFF9BA5BC),
              ),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(
            16,
            18,
            16,
            25,
          ),
          itemCount: orders.length,
          separatorBuilder: (_, __) {
            return const SizedBox(height: 16);
          },
          itemBuilder: (context, index) {
            final order = orders[index];

            return OrderCard(
              order: order,
              history: state.selectedTab == 1,
              onTrack: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Opening tracking...',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
              onCancel: () {
                context.read<MyOrdersBloc>().add(
                  CancelOrder(order.id),
                );
              },
              onRate: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Rate order',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
              onReorder: () {
                context.read<MyOrdersBloc>().add(
                  Reorder(order),
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${order.restaurant} added again',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}