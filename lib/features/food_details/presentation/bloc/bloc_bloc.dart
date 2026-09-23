import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_event.dart';
import 'bloc_state.dart';


class FoodDetailBloc
    extends Bloc<FoodDetailEvent, FoodDetailState> {

  FoodDetailBloc()
      : super(FoodDetailInitial()) {

    on<LoadFoodDetail>((event, emit) {
      emit(
        FoodDetailLoaded(
          quantity: 1,
          size: '14"',
          addedToCart: false,
        ),
      );
    });

    on<IncreaseQuantity>((event, emit) {
      if (state is FoodDetailLoaded) {
        final current =
        state as FoodDetailLoaded;

        emit(
          FoodDetailLoaded(
            quantity: current.quantity + 1,
            size: current.size,
            addedToCart: current.addedToCart,
          ),
        );
      }
    });

    on<DecreaseQuantity>((event, emit) {
      if (state is FoodDetailLoaded) {
        final current =
        state as FoodDetailLoaded;

        if (current.quantity > 1) {
          emit(
            FoodDetailLoaded(
              quantity: current.quantity - 1,
              size: current.size,
              addedToCart: current.addedToCart,
            ),
          );
        }
      }
    });

    on<SelectFoodSize>((event, emit) {
      if (state is FoodDetailLoaded) {
        final current =
        state as FoodDetailLoaded;

        emit(
          FoodDetailLoaded(
            quantity: current.quantity,
            size: event.size,
            addedToCart: current.addedToCart,
          ),
        );
      }
    });

    on<AddFoodToCart>((event, emit) {
      if (state is FoodDetailLoaded) {
        final current =
        state as FoodDetailLoaded;

        emit(
          FoodDetailLoaded(
            quantity: current.quantity,
            size: current.size,
            addedToCart: true,
          ),
        );
      }
    });
  }
}