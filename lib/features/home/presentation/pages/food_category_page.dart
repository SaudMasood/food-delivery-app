import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../food_details/presentation/pages/food_details_page.dart';
import '../../domain/entities/food.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class FoodCategoryPage extends StatefulWidget {
  final String category;

  const FoodCategoryPage({
    super.key,
    required this.category,
  });

  @override
  State<FoodCategoryPage> createState() =>
      _FoodCategoryPageState();
}

class _FoodCategoryPageState extends State<FoodCategoryPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(
        SelectCategory(widget.category),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                18,
                8,
                18,
                10,
              ),
              child: Text(
                'Food - ${widget.category}s',
                style: const TextStyle(
                  fontSize: 17,
                  color: Color(0xFF9BA5BC),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    18,
                    18,
                    18,
                    0,
                  ),
                  child: BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state is! HomeLoaded) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFFFF7622),
                          ),
                        );
                      }

                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            _buildHeader(),

                            const SizedBox(height: 20),

                            Text(
                              'Popular ${widget.category}s',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF20242F),
                              ),
                            ),

                            const SizedBox(height: 14),

                            _buildFoods(
                              context,
                              state,
                            ),

                            const SizedBox(height: 24),

                            _buildRestaurantTitle(),

                            const SizedBox(height: 12),

                            _buildRestaurant(),

                            const SizedBox(height: 24),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
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

        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: const Color(0xFFE5E5E5),
            ),
          ),
          child: Row(
            children: [
              Text(
                widget.category.toUpperCase(),
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF20242F),
                ),
              ),

              const SizedBox(width: 5),

              const Icon(
                Icons.arrow_drop_down,
                color: Color(0xFFFF7622),
                size: 18,
              ),
            ],
          ),
        ),

        const Spacer(),

        _buildCircleButton(
          Icons.search,
          false,
        ),

        const SizedBox(width: 9),

        _buildCircleButton(
          Icons.tune,
          true,
        ),
      ],
    );
  }

  Widget _buildCircleButton(
      IconData icon,
      bool light,
      ) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: light
            ? const Color(0xFFF1F3F5)
            : const Color(0xFF171A25),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 19,
        color: light
            ? const Color(0xFF555555)
            : Colors.white,
      ),
    );
  }

  Widget _buildFoods(
      BuildContext context,
      HomeLoaded state,
      ) {
    if (state.foods.isEmpty) {
      return const SizedBox(
        height: 160,
        child: Center(
          child: Text(
            'No food found',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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

        return _buildFoodCard(
          context,
          food,
        );
      },
    );
  }

  Widget _buildFoodCard(
      BuildContext context,
      Food food,
      ) {
    return GestureDetector(
      onTap: () {
        _openFoodDetails(
          context,
          food,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
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
                    fontSize: 12,
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

  Widget _buildRestaurantTitle() {
    return const Text(
      'Open Restaurants',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xFF20242F),
      ),
    );
  }

  Widget _buildRestaurant() {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(9),
          child: Image.asset(
            'assets/images/rose_garden.png',
            width: double.infinity,
            height: 105,
            fit: BoxFit.cover,
          ),
        ),

        const SizedBox(height: 9),

        const Text(
          'Tasty Treat Gallery',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF20242F),
          ),
        ),

        const SizedBox(height: 5),

        const Row(
          children: [
            Icon(
              Icons.star,
              color: Color(0xFFFF7622),
              size: 17,
            ),

            SizedBox(width: 4),

            Text(
              '4.7',
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFF737B8C),
              ),
            ),

            SizedBox(width: 16),

            Icon(
              Icons.delivery_dining,
              color: Color(0xFFFF7622),
              size: 17,
            ),

            SizedBox(width: 4),

            Text(
              'Free',
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFF737B8C),
              ),
            ),

            SizedBox(width: 16),

            Icon(
              Icons.access_time,
              color: Color(0xFFFF7622),
              size: 17,
            ),

            SizedBox(width: 4),

            Text(
              '20 min',
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFF737B8C),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _openFoodDetails(
      BuildContext context,
      Food food,
      ) {
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