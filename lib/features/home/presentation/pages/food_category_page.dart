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

class _FoodCategoryPageState
    extends State<FoodCategoryPage> {

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

            const Padding(
              padding: EdgeInsets.fromLTRB(
                18,
                6,
                18,
                8,
              ),
              child: Text(
                'Food - Burgers',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFB8B8B8),
                ),
              ),
            ),

            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(
                  9,
                  0,
                  9,
                  0,
                ),

                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                  ),
                ),

                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    15,
                    14,
                    15,
                    0,
                  ),

                  child: BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {

                      if (state is! HomeLoaded) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [

                            _buildHeader(),

                            const SizedBox(height: 17),

                            Text(
                              'Popular ${widget.category}s',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            const SizedBox(height: 12),

                            _buildFoods(
                              context,
                              state,
                            ),

                            const SizedBox(height: 18),

                            _buildRestaurantTitle(),

                            const SizedBox(height: 10),

                            _buildRestaurant(),

                            const SizedBox(height: 20),
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
            width: 34,
            height: 34,

            decoration: const BoxDecoration(
              color: Color(0xFFF1F3F5),
              shape: BoxShape.circle,
            ),

            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 14,
            ),
          ),
        ),

        const SizedBox(width: 12),

        Container(
          height: 34,

          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFE8E8E8),
            ),
          ),

          child: Row(
            children: [

              Text(
                widget.category.toUpperCase(),
                style: const TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(width: 4),

              const Icon(
                Icons.arrow_drop_down,
                color: Color(0xFFFF7622),
                size: 14,
              ),
            ],
          ),
        ),

        const Spacer(),

        _buildCircleButton(
          Icons.search,
          false,
        ),

        const SizedBox(width: 8),

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
      width: 34,
      height: 34,

      decoration: BoxDecoration(
        color: light
            ? const Color(0xFFF1F3F5)
            : const Color(0xFF171A25),
        shape: BoxShape.circle,
      ),

      child: Icon(
        icon,
        size: 16,
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
        height: 150,
        child: Center(
          child: Text(
            'No food found',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 11,
            ),
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,

      physics:
      const NeverScrollableScrollPhysics(),

      itemCount: state.foods.length,

      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.88,
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
        padding: const EdgeInsets.all(7),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),

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
              borderRadius:
              BorderRadius.circular(8),

              child: Image.asset(
                food.image,

                width: double.infinity,

                height: 52,

                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              food.name,

              maxLines: 1,

              overflow:
              TextOverflow.ellipsis,

              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 2),

            Text(
              food.restaurant,

              maxLines: 1,

              overflow:
              TextOverflow.ellipsis,

              style: const TextStyle(
                fontSize: 8,
                color: Color(0xFF9BA5BC),
              ),
            ),

            const Spacer(),

            Row(
              children: [

                Text(
                  '\$${food.price.toStringAsFixed(0)}',

                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Spacer(),

                Container(
                  width: 19,
                  height: 19,

                  decoration:
                  const BoxDecoration(
                    color: Color(0xFFFF8A3D),
                    shape: BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 13,
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
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildRestaurant() {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [

        ClipRRect(
          borderRadius:
          BorderRadius.circular(7),

          child: Image.asset(
            'assets/images/rose_garden.png',

            width: double.infinity,

            height: 86,

            fit: BoxFit.cover,
          ),
        ),

        const SizedBox(height: 7),

        const Text(
          'Tasty Treat Gallery',

          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 3),

        const Row(
          children: [

            Icon(
              Icons.star,
              color: Color(0xFFFF7622),
              size: 14,
            ),

            SizedBox(width: 3),

            Text(
              '4.7',
              style: TextStyle(
                fontSize: 8,
              ),
            ),

            SizedBox(width: 14),

            Icon(
              Icons.delivery_dining,
              color: Color(0xFFFF7622),
              size: 14,
            ),

            SizedBox(width: 3),

            Text(
              'Free',
              style: TextStyle(
                fontSize: 8,
              ),
            ),

            SizedBox(width: 14),

            Icon(
              Icons.access_time,
              color: Color(0xFFFF7622),
              size: 14,
            ),

            SizedBox(width: 3),

            Text(
              '20 min',
              style: TextStyle(
                fontSize: 8,
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