import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../food_details/presentation/pages/food_details_page.dart';
import '../../../restaurant/presentation/pages/restaurant_detail_page.dart';
import '../../domain/entities/food.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widgets/category_card.dart';
import '../widgets/food_card.dart';
import '../widgets/offer_dialog.dart';
import '../widgets/search_bar.dart';
import 'search_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(LoadHome()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool offerShown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is! HomeLoaded) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!offerShown) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted && !offerShown) {
                  offerShown = true;
                  _showOffer();
                }
              });
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                24,
                18,
                24,
                30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),

                  const SizedBox(height: 20),

                  _buildGreeting(),

                  const SizedBox(height: 18),

                  _buildSearch(context),

                  const SizedBox(height: 22),

                  _buildCategoryTitle(),

                  const SizedBox(height: 12),

                  _buildCategories(
                    context,
                    state,
                  ),

                  const SizedBox(height: 22),

                  _buildFoodTitle(state),

                  const SizedBox(height: 12),

                  _buildFoods(
                    context,
                    state,
                  ),

                  const SizedBox(height: 24),

                  _buildRestaurantTitle(),

                  const SizedBox(height: 12),

                  _buildRestaurant(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showOffer() {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) {
        return Center(
          child: OfferCard(
            onClose: () {
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: const BoxDecoration(
            color: Color(0xFFF1F3F5),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.menu,
            size: 17,
          ),
        ),

        const SizedBox(width: 15),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'DELIVER TO',
              style: TextStyle(
                fontSize: 8,
                color: Color(0xFFFF7622),
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 3),

            const Row(
              children: [
                Text(
                  'Halal Lab office',
                  style: TextStyle(
                    fontSize: 9,
                    color: Color(0xFF555555),
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 12,
                ),
              ],
            ),
          ],
        ),

        const Spacer(),

        Container(
          width: 34,
          height: 34,
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
                  size: 18,
                ),
              ),

              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 16,
                  height: 16,
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

  Widget _buildGreeting() {
    return const Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Hey Halal, ',
            style: TextStyle(
              fontSize: 11,
            ),
          ),
          TextSpan(
            text: 'Good Afternoon!',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearch(BuildContext context) {
    final homeBloc = context.read<HomeBloc>();

    return SearchBarWidget(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return BlocProvider.value(
                value: homeBloc,
                child: const SearchPage(),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildCategoryTitle() {
    return Row(
      children: [
        const Text(
          'All Categories',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),

        const Spacer(),

        const Text(
          'See All',
          style: TextStyle(
            fontSize: 9,
          ),
        ),

        const Icon(
          Icons.chevron_right,
          size: 15,
        ),
      ],
    );
  }

  Widget _buildCategories(
      BuildContext context,
      HomeLoaded state,
      ) {
    const categories = [
      {
        'name': 'All',
        'image': 'assets/images/pizza.png',
      },
      {
        'name': 'Hot Dog',
        'image': 'assets/images/hotdog.png',
      },
      {
        'name': 'Burger',
        'image': 'assets/images/burger.png',
      },
      {
        'name': 'Pizza',
        'image': 'assets/images/pizza.png',
      },
    ];

    return SizedBox(
      height: 62,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) {
          return const SizedBox(width: 10);
        },
        itemBuilder: (context, index) {
          final category = categories[index];

          final name = category['name']!;
          final image = category['image']!;

          return CategoryCard(
            name: name,
            image: image,
            selected: state.selectedCategory == name,
            onTap: () {
              context.read<HomeBloc>().add(
                SelectCategory(name),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildFoodTitle(HomeLoaded state) {
    String title = 'Popular Items';

    if (state.selectedCategory != 'All') {
      title = 'Popular ${state.selectedCategory}';
    }

    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),

        const Spacer(),

        const Text(
          'See All',
          style: TextStyle(
            fontSize: 9,
          ),
        ),

        const Icon(
          Icons.chevron_right,
          size: 15,
        ),
      ],
    );
  }

  Widget _buildFoods(
      BuildContext context,
      HomeLoaded state,
      ) {
    if (state.foods.isEmpty) {
      return const SizedBox(
        height: 100,
        child: Center(
          child: Text(
            'No food found',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: 143,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: state.foods.length,
        separatorBuilder: (context, index) {
          return const SizedBox(width: 12);
        },
        itemBuilder: (context, index) {
          final food = state.foods[index];

          return FoodCard(
            food: food,
            onTap: () {
              _openFoodDetails(
                context,
                food,
              );
            },
          );
        },
      ),
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

  Widget _buildRestaurantTitle() {
    return Row(
      children: [
        const Text(
          'Open Restaurants',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),

        const Spacer(),

        const Text(
          'See All',
          style: TextStyle(
            fontSize: 9,
          ),
        ),

        const Icon(
          Icons.chevron_right,
          size: 15,
        ),
      ],
    );
  }

  Widget _buildRestaurant() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const RestaurantDetailPage(
                restaurantName: 'Tasty Treat Gallery',
                rating: '4.7',
              );
            },
          ),
        );
      },
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
            BorderRadius.circular(7),
            child: Image.asset(
              'assets/images/rose_garden.png',
              width: double.infinity,
              height: 92,
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

          const Text(
            'Burger - Chicken - Riche - Wings',
            style: TextStyle(
              fontSize: 9,
              color: Color(0xFF9BA5BC),
            ),
          ),

          const SizedBox(height: 7),

          const Row(
            children: [
              Icon(
                Icons.star_border,
                color: Color(0xFFFF7622),
                size: 17,
              ),

              SizedBox(width: 3),

              Text(
                '4.7',
                style: TextStyle(
                  fontSize: 9,
                ),
              ),

              SizedBox(width: 15),

              Icon(
                Icons.delivery_dining,
                color: Color(0xFFFF7622),
                size: 17,
              ),

              SizedBox(width: 3),

              Text(
                'Free',
                style: TextStyle(
                  fontSize: 9,
                ),
              ),

              SizedBox(width: 15),

              Icon(
                Icons.access_time,
                color: Color(0xFFFF7622),
                size: 17,
              ),

              SizedBox(width: 3),

              Text(
                '20 min',
                style: TextStyle(
                  fontSize: 9,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}