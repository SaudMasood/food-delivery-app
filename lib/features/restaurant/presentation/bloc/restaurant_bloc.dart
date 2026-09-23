import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/restaurant_model.dart';
import 'restaurant_event.dart';
import 'restaurant_state.dart';

class RestaurantBloc
    extends Bloc<RestaurantEvent, RestaurantState> {

  RestaurantBloc()
      : super(RestaurantInitial()) {

    on<LoadRestaurant>((event, emit) {
      const restaurant = RestaurantModel(
        id: 1,
        name: 'Spicy Restaurant',
        image: 'assets/images/rose_garden.png',
        description:
        'Macarons and delicious meals made with fresh ingredients. Enjoy our tasty food and great service.',
        rating: 4.7,
        delivery: 'Free',
        deliveryTime: '20 min',
      );

      emit(
        RestaurantLoaded(
          restaurant: restaurant,
        ),
      );
    });
  }
}