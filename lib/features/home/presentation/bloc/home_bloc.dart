import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/food_model.dart';
import '../../domain/entities/food.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final List<Food> allFoods = [
    const FoodModel(
      id: 1,
      name: 'Burger Bistro',
      image: 'assets/images/burger.png',
      price: 40,
      category: 'Burger',
      restaurant: 'Rose Garden',
      rating: 4.7,
    ),

    const FoodModel(
      id: 2,
      name: "Smokin' Burger",
      image: 'assets/images/burger.png',
      price: 60,
      category: 'Burger',
      restaurant: 'Cafenio Restaurant',
      rating: 4.5,
    ),

    const FoodModel(
      id: 3,
      name: 'Buffalo Burgers',
      image: 'assets/images/burger.png',
      price: 75,
      category: 'Burger',
      restaurant: 'Kaji Firm Kitchen',
      rating: 4.6,
    ),

    const FoodModel(
      id: 4,
      name: 'Bullseye Burgers',
      image: 'assets/images/burger.png',
      price: 94,
      category: 'Burger',
      restaurant: 'Kabab Restaurant',
      rating: 4.8,
    ),

    const FoodModel(
      id: 5,
      name: 'Pizza',
      image: 'assets/images/pizza.png',
      price: 70,
      category: 'Pizza',
      restaurant: 'Rose Garden',
      rating: 4.7,
    ),

    const FoodModel(
      id: 6,
      name: 'Cheese Pizza',
      image: 'assets/images/pizza.png',
      price: 80,
      category: 'Pizza',
      restaurant: 'Cafenio',
      rating: 4.5,
    ),

    const FoodModel(
      id: 7,
      name: 'Hot Dog',
      image: 'assets/images/hotdog.png',
      price: 40,
      category: 'Hot Dog',
      restaurant: 'Halal Restaurant',
      rating: 4.4,
    ),
  ];

  HomeBloc() : super(HomeInitial()) {
    on<LoadHome>((event, emit) {
      emit(
        HomeLoaded(
          foods: allFoods,
          selectedCategory: 'All',
          searchQuery: '',
        ),
      );
    });

    on<SelectCategory>((event, emit) {
      final foods = _filterFoods(
        event.category,
        '',
      );

      emit(
        HomeLoaded(
          foods: foods,
          selectedCategory: event.category,
          searchQuery: '',
        ),
      );
    });

    on<SearchFood>((event, emit) {
      final foods = _filterSearch(
        event.query,
      );

      emit(
        HomeLoaded(
          foods: foods,
          selectedCategory: 'All',
          searchQuery: event.query,
        ),
      );
    });
  }

  List<Food> _filterFoods(
      String category,
      String query,
      ) {
    List<Food> result = allFoods;

    if (category != 'All') {
      result = result
          .where(
            (food) =>
        food.category == category,
      )
          .toList();
    }

    if (query.isNotEmpty) {
      result = result
          .where(
            (food) =>
            food.name
                .toLowerCase()
                .contains(
              query.toLowerCase(),
            ),
      )
          .toList();
    }

    return result;
  }

  List<Food> _filterSearch(String query) {
    if (query.isEmpty) {
      return allFoods;
    }

    return allFoods.where((food) {
      final name = food.name.toLowerCase();
      final restaurant =
      food.restaurant.toLowerCase();

      final search =
      query.toLowerCase();

      return name.contains(search) ||
          restaurant.contains(search);
    }).toList();
  }
}