import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../food_details/presentation/pages/food_details_page.dart';
import '../../../restaurant/presentation/pages/restaurant_detail_page.dart';
import '../../domain/entities/food.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import 'food_category_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController =
  TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              18,
              24,
              18,
              10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),

                const SizedBox(height: 20),

                _buildSearch(),

                const SizedBox(height: 20),

                _buildRecentKeywords(),

                const SizedBox(height: 22),

                _buildSuggestedRestaurants(),

                const SizedBox(height: 22),

                _buildPopularTitle(),

                const SizedBox(height: 14),

                Expanded(
                  child: _buildSearchResults(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFF1F3F5),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 17,
            ),
          ),
        ),

        const SizedBox(width: 14),

        const Text(
          'Search',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF20242F),
          ),
        ),

        const Spacer(),

        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Color(0xFF20242F),
            shape: BoxShape.circle,
          ),
          child: Stack(
            children: [
              const Center(
                child: Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),

              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF7622),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '2',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearch() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(9),
      ),
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          setState(() {});

          context.read<HomeBloc>().add(
            SearchFood(value),
          );
        },
        style: const TextStyle(
          fontSize: 13,
          color: Color(0xFF20242F),
        ),
        decoration: InputDecoration(
          hintText: 'Search dishes, restaurants',
          hintStyle: const TextStyle(
            fontSize: 12,
            color: Color(0xFF9BA5BC),
          ),
          prefixIcon: const Icon(
            Icons.search,
            size: 20,
            color: Color(0xFF9BA5BC),
          ),
          suffixIcon: searchController.text.isEmpty
              ? null
              : IconButton(
            onPressed: () {
              searchController.clear();

              context.read<HomeBloc>().add(
                SearchFood(''),
              );

              setState(() {});
            },
            icon: const Icon(
              Icons.cancel,
              size: 18,
              color: Color(0xFFC5C5C5),
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildRecentKeywords() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Keywords',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF20242F),
          ),
        ),

        const SizedBox(height: 11),

        SizedBox(
          height: 38,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _keyword('Burger'),
              _keyword('Sandwich'),
              _keyword('Pizza'),
              _keyword('Hot Dog'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _keyword(String text) {
    return GestureDetector(
      onTap: () {
        if (text == 'Burger' ||
            text == 'Pizza' ||
            text == 'Hot Dog') {
          final homeBloc = context.read<HomeBloc>();

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return BlocProvider.value(
                  value: homeBloc,
                  child: FoodCategoryPage(
                    category: text,
                  ),
                );
              },
            ),
          );

          return;
        }

        searchController.text = text;

        context.read<HomeBloc>().add(
          SearchFood(text),
        );

        setState(() {});
      },
      child: Container(
        margin: const EdgeInsets.only(
          right: 9,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 9,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFFE5E5E5),
          ),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF4F5663),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestedRestaurants() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Suggested Restaurants',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF20242F),
          ),
        ),

        const SizedBox(height: 9),

        _restaurant(
          'Pansi Restaurant',
          '4.7',
        ),

        _restaurant(
          'American Spicy Burger Shop',
          '4.3',
        ),

        _restaurant(
          'Cafenio Coffee Club',
          '4.0',
        ),
      ],
    );
  }

  Widget _restaurant(
      String name,
      String rating,
      ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return RestaurantDetailPage(
                restaurantName: name,
                rating: rating,
              );
            },
          ),
        );
      },
      child: Container(
        height: 54,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFEAEAEA),
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFF9BAFC0),
                borderRadius: BorderRadius.circular(6),
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF20242F),
                    ),
                  ),

                  const SizedBox(height: 3),

                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color(0xFFFF7622),
                        size: 14,
                      ),

                      const SizedBox(width: 3),

                      Text(
                        rating,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF737B8C),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularTitle() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        String title = 'Popular Fast Food';

        if (state is HomeLoaded &&
            state.searchQuery.isNotEmpty) {
          title = 'Search Results';
        }

        return Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF20242F),
          ),
        );
      },
    );
  }

  Widget _buildSearchResults() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is! HomeLoaded) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.foods.isEmpty) {
          return const Center(
            child: Text(
              'No food found',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.only(
            bottom: 10,
          ),
          itemCount: state.foods.length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 0.82,
          ),
          itemBuilder: (context, index) {
            final food = state.foods[index];

            return _buildFoodCard(food);
          },
        );
      },
    );
  }

  Widget _buildFoodCard(Food food) {
    return GestureDetector(
      onTap: () {
        _openFoodDetails(food);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                food.image,
                width: double.infinity,
                height: 68,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 7),

            Text(
              food.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Color(0xFF20242F),
              ),
            ),

            const SizedBox(height: 3),

            Text(
              food.restaurant,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF9BA5BC),
              ),
            ),

            const Spacer(),

            Row(
              children: [
                Text(
                  '\$${food.price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF20242F),
                  ),
                ),

                const Spacer(),

                Container(
                  width: 22,
                  height: 22,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF8A3D),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _openFoodDetails(Food food) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return FoodDetailPage(
            food: food,
          );
        },
      ),
    );
  }
}