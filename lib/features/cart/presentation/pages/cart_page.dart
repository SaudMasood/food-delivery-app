import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';
import '../widgets/cart_bottom.dart';
import '../widgets/cart_item_card.dart';
import 'cart_edit.dart';

class MyCartPage extends StatelessWidget {
  final CartBloc? cartBloc;

  const MyCartPage({
    super.key,
    this.cartBloc,
  });

  @override
  Widget build(BuildContext context) {
    if (cartBloc != null) {
      return BlocProvider.value(
        value: cartBloc!,
        child: const MyCartView(),
      );
    }

    return BlocProvider(
      create: (_) => CartBloc()..add(LoadCart()),
      child: const MyCartView(),
    );
  }
}

class MyCartView extends StatelessWidget {
  const MyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is! CartLoaded) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFFF7622),
                ),
              );
            }

            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      color: const Color(0xFF111122),
                      padding: const EdgeInsets.fromLTRB(
                        18,
                        28,
                        18,
                        20,
                      ),
                      child: Column(
                        children: [
                          _buildHeader(context),

                          const SizedBox(height: 20),

                          Expanded(
                            child: state.items.isEmpty
                                ? _buildEmptyCart()
                                : ListView.separated(
                              padding: EdgeInsets.zero,
                              itemCount: state.items.length,
                              separatorBuilder: (_, __) {
                                return const SizedBox(
                                  height: 20,
                                );
                              },
                              itemBuilder: (context, index) {
                                final item =
                                state.items[index];

                                return CartItemCard(
                                  item: item,
                                  showDelete: true,
                                  onIncrease: () {
                                    context
                                        .read<CartBloc>()
                                        .add(
                                      IncreaseCartItem(
                                        item.id,
                                      ),
                                    );
                                  },
                                  onDecrease: () {
                                    context
                                        .read<CartBloc>()
                                        .add(
                                      DecreaseCartItem(
                                        item.id,
                                      ),
                                    );
                                  },
                                  onRemove: () {
                                    context
                                        .read<CartBloc>()
                                        .add(
                                      RemoveCartItem(
                                        item.id,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  CartBottom(
                    total: state.total,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              color: Color(0xFF29293B),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),

        const SizedBox(width: 14),

        const Text(
          'Cart',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),

        const Spacer(),

        GestureDetector(
          onTap: () {
            final cartBloc = context.read<CartBloc>();

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return BlocProvider.value(
                    value: cartBloc,
                    child: const EditCartView(),
                  );
                },
              ),
            );
          },
          child: const Text(
            'EDIT ITEMS',
            style: TextStyle(
              color: Color(0xFFFF7622),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyCart() {
    return const Center(
      child: Text(
        'Your cart is empty',
        style: TextStyle(
          color: Color(0xFF8E8EA3),
          fontSize: 14,
        ),
      ),
    );
  }
}