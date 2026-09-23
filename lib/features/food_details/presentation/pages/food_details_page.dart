import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cart/presentation/pages/cart_page.dart';
import '../../../home/domain/entities/food.dart';
import '../bloc/bloc_bloc.dart';
import '../bloc/bloc_event.dart';
import '../bloc/bloc_state.dart';

class FoodDetailPage extends StatelessWidget {
  final Food food;

  const FoodDetailPage({
    super.key,
    required this.food,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FoodDetailBloc()
        ..add(LoadFoodDetail()),
      child: FoodDetailView(food: food),
    );
  }
}

class FoodDetailView extends StatefulWidget {
  final Food food;

  const FoodDetailView({
    super.key,
    required this.food,
  });

  @override
  State<FoodDetailView> createState() =>
      _FoodDetailViewState();
}

class _FoodDetailViewState
    extends State<FoodDetailView> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FA),
      body: SafeArea(
        child: BlocBuilder<FoodDetailBloc, FoodDetailState>(
          builder: (context, state) {
            if (state is! FoodDetailLoaded) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: _buildContent(
                    context,
                    state,
                  ),
                ),
                _buildBottomCart(
                  context,
                  state,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(
      BuildContext context,
      FoodDetailLoaded state,
      ) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: _buildFoodImage(),
        ),
        SliverToBoxAdapter(
          child: _buildFoodInformation(
            context,
            state,
          ),
        ),
      ],
    );
  }

  Widget _buildFoodImage() {
    return AspectRatio(
      aspectRatio: 1.35,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius:
              const BorderRadius.only(
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
              child: Image.asset(
                widget.food.image,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Positioned(
            top: 18,
            left: 18,
            child: _roundButton(
              icon: Icons.arrow_back_ios_new,
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),

          Positioned(
            top: 18,
            right: 18,
            child: _roundButton(
              icon: isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border,
              iconColor:
              const Color(0xFFFF7622),
              onTap: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _roundButton({
    required IconData icon,
    required VoidCallback onTap,
    Color iconColor = Colors.black,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration:
        const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            icon,
            size: 14,
            color: iconColor,
          ),
        ),
      ),
    );
  }

  Widget _buildFoodInformation(
      BuildContext context,
      FoodDetailLoaded state,
      ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        18,
        14,
        18,
        20,
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(
            widget.food.name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF20242F),
            ),
          ),

          const SizedBox(height: 5),

          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.red,
                size: 11,
              ),
              const SizedBox(width: 3),
              Text(
                widget.food.restaurant,
                style: const TextStyle(
                  fontSize: 9,
                  color: Color(0xFF555555),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          _buildFoodStats(),

          const SizedBox(height: 13),

          const Text(
            'Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.',
            style: TextStyle(
              fontSize: 8,
              height: 1.6,
              color: Color(0xFF9BA5BC),
            ),
          ),

          const SizedBox(height: 17),

          const Text(
            'SIZE:',
            style: TextStyle(
              fontSize: 7,
              color: Color(0xFF9BA5BC),
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 8),

          _buildSizes(
            context,
            state,
          ),

          const SizedBox(height: 17),

          const Text(
            'INGREDIENTS',
            style: TextStyle(
              fontSize: 7,
              color: Color(0xFF9BA5BC),
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 8),

          _buildIngredients(),
        ],
      ),
    );
  }

  Widget _buildFoodStats() {
    return Row(
      children: [
        const Icon(
          Icons.star_border,
          color: Color(0xFFFF7622),
          size: 16,
        ),

        const SizedBox(width: 3),

        Text(
          widget.food.rating.toString(),
          style: const TextStyle(
            fontSize: 8,
          ),
        ),

        const SizedBox(width: 16),

        const Icon(
          Icons.delivery_dining,
          color: Color(0xFFFF7622),
          size: 15,
        ),

        const SizedBox(width: 3),

        const Text(
          'Free',
          style: TextStyle(
            fontSize: 8,
          ),
        ),

        const SizedBox(width: 16),

        const Icon(
          Icons.access_time,
          color: Color(0xFFFF7622),
          size: 15,
        ),

        const SizedBox(width: 3),

        const Text(
          '20 min',
          style: TextStyle(
            fontSize: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildSizes(
      BuildContext context,
      FoodDetailLoaded state,
      ) {
    const sizes = [
      '10"',
      '14"',
      '16"',
    ];

    return Row(
      children: sizes.map(
            (size) {
          final selected =
              state.size == size;

          return GestureDetector(
            onTap: () {
              context
                  .read<FoodDetailBloc>()
                  .add(
                SelectFoodSize(size),
              );
            },
            child: Container(
              width: 34,
              height: 34,
              margin:
              const EdgeInsets.only(
                right: 8,
              ),
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFFFF8A3D)
                    : const Color(0xFFF0F3F7),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  size,
                  style: TextStyle(
                    fontSize: 7,
                    fontWeight:
                    FontWeight.w500,
                    color: selected
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }

  Widget _buildIngredients() {
    const icons = [
      Icons.local_pizza,
      Icons.set_meal,
      Icons.local_fire_department,
      Icons.eco,
      Icons.lunch_dining,
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: icons.map(
              (icon) {
            return Container(
              width: 36,
              height: 36,
              margin:
              const EdgeInsets.only(
                right: 9,
              ),
              decoration:
              const BoxDecoration(
                color: Color(0xFFFFF1E9),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color:
                const Color(0xFFFF7622),
                size: 15,
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  Widget _buildBottomCart(
      BuildContext context,
      FoodDetailLoaded state,
      ) {
    final total =
        widget.food.price * state.quantity;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        18,
        10,
        18,
        12,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFF1F5F9),
        borderRadius:
        BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '\$${total.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF20242F),
                ),
              ),

              const Spacer(),

              _buildQuantity(
                context,
                state,
              ),
            ],
          ),

          const SizedBox(height: 10),

          SizedBox(
            width: double.infinity,
            height: 43,
            child: ElevatedButton(
              onPressed: () {
                context.read<FoodDetailBloc>().add(
                  AddFoodToCart(),
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const MyCartPage();
                    },
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF7622),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              child: Text(
                state.addedToCart
                    ? 'ADDED TO CART'
                    : 'ADD TO CART',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),        ],
      ),
    );
  }

  Widget _buildQuantity(
      BuildContext context,
      FoodDetailLoaded state,
      ) {
    return Container(
      height: 34,
      padding:
      const EdgeInsets.symmetric(
        horizontal: 7,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF20242F),
        borderRadius:
        BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              context
                  .read<FoodDetailBloc>()
                  .add(
                DecreaseQuantity(),
              );
            },
            child: const Icon(
              Icons.remove,
              color: Colors.white,
              size: 13,
            ),
          ),

          const SizedBox(width: 12),

          Text(
            state.quantity.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 9,
            ),
          ),

          const SizedBox(width: 12),

          GestureDetector(
            onTap: () {
              context
                  .read<FoodDetailBloc>()
                  .add(
                IncreaseQuantity(),
              );
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 13,
            ),
          ),
        ],
      ),
    );
  }
}