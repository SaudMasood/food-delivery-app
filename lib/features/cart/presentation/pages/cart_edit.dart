import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';
import '../widgets/cart_bottom.dart';
import '../widgets/cart_item_card.dart';
import 'cart_page.dart';

class EditCartPage extends StatelessWidget {
  final CartBloc? cartBloc;

  const EditCartPage({
    super.key,
    this.cartBloc,
  });

  @override
  Widget build(BuildContext context) {
    if (cartBloc != null) {
      return BlocProvider.value(
        value: cartBloc!,
        child: const EditCartView(),
      );
    }

    return BlocProvider(
      create: (_) => CartBloc()..add(LoadCart()),
      child: const EditCartView(),
    );
  }
}

class EditCartView extends StatelessWidget {
  const EditCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is! CartLoaded) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Padding(
              padding: const EdgeInsets.fromLTRB(
                24,
                10,
                24,
                18,
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Color(0xFF111122),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            padding: const EdgeInsets.fromLTRB(
                              17,
                              18,
                              17,
                              150,
                            ),
                            child: Column(
                              children: [
                                _buildHeader(context),

                                const SizedBox(height: 18),

                                Expanded(
                                  child: state.items.isEmpty
                                      ? _buildEmptyCart()
                                      : ListView.separated(
                                    padding: EdgeInsets.zero,
                                    itemCount: state.items.length,
                                    separatorBuilder:
                                        (context, index) {
                                      return const SizedBox(
                                        height: 20,
                                      );
                                    },
                                    itemBuilder:
                                        (context, index) {
                                      final item =
                                      state.items[index];

                                      return CartItemCard(
                                        item: item,
                                        showDelete: false,
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
                                        onRemove: () {},
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: CartBottom(
                        total: state.total,
                      ),
                    ),
                  ],
                ),
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
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              color: Color(0xFF29293B),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 12,
            ),
          ),
        ),

        const SizedBox(width: 12),

        const Text(
          'Cart',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
        ),

        const Spacer(),

        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Text(
            'EDIT ITEMS',
            style: TextStyle(
              color: Color(0xFFFF7622),
              fontSize: 8,
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
          fontSize: 11,
        ),
      ),
    );
  }
}