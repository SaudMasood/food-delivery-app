import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/cart_model.dart';
import '../../domain/entities/cart_item.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final List<CartItem> cartItems = [
    const CartItemModel(
      id: 1,
      name: 'Pizza Calzone European',
      image: 'assets/images/pizza.png',
      size: '14"',
      price: 64,
      quantity: 2,
    ),
    const CartItemModel(
      id: 2,
      name: 'Pizza Calzone European',
      image: 'assets/images/pizza.png',
      size: '14"',
      price: 32,
      quantity: 1,
    ),
  ];

  CartBloc() : super(CartInitial()) {
    on<LoadCart>((event, emit) {
      emit(
        CartLoaded(
          items: List.from(cartItems),
        ),
      );
    });

    on<IncreaseCartItem>((event, emit) {
      if (state is CartLoaded) {
        final current =
        List<CartItem>.from(
          (state as CartLoaded).items,
        );

        final index = current.indexWhere(
              (item) => item.id == event.id,
        );

        if (index != -1) {
          current[index] =
              current[index].copyWith(
                quantity:
                current[index].quantity + 1,
              );
        }

        emit(
          CartLoaded(items: current),
        );
      }
    });

    on<DecreaseCartItem>((event, emit) {
      if (state is CartLoaded) {
        final current =
        List<CartItem>.from(
          (state as CartLoaded).items,
        );

        final index = current.indexWhere(
              (item) => item.id == event.id,
        );

        if (index != -1) {
          final quantity =
              current[index].quantity;

          if (quantity > 1) {
            current[index] =
                current[index].copyWith(
                  quantity: quantity - 1,
                );
          }
        }

        emit(
          CartLoaded(items: current),
        );
      }
    });

    on<RemoveCartItem>((event, emit) {
      if (state is CartLoaded) {
        final current =
        List<CartItem>.from(
          (state as CartLoaded).items,
        );

        current.removeWhere(
              (item) => item.id == event.id,
        );

        emit(
          CartLoaded(items: current),
        );
      }
    });
  }
}