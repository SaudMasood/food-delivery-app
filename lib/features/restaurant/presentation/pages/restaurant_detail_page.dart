import 'package:flutter/material.dart';

import '../../../food_details/presentation/pages/food_details_page.dart';
import '../../../home/data/models/food_model.dart';
import '../../../home/domain/entities/food.dart';

class RestaurantDetailPage extends StatefulWidget {
  final String restaurantName;
  final String rating;

  const RestaurantDetailPage({
    super.key,
    required this.restaurantName,
    required this.rating,
  });

  @override
  State<RestaurantDetailPage> createState() =>
      _RestaurantDetailPageState();
}

class _RestaurantDetailPageState
    extends State<RestaurantDetailPage> {
  String selectedCategory = 'Burger';

  String selectedOffer = 'Delivery';
  String selectedTime = '10-15 min';
  String selectedPrice = '\$';
  int selectedRating = 1;

  bool filterApplied = false;

  final List<Food> foods = [
    const FoodModel(
      id: 1,
      name: 'Burger Ferguson',
      image: 'assets/images/burger.png',
      price: 40,
      category: 'Burger',
      restaurant: 'Spicy Restaurant',
      rating: 4.7,
    ),
    const FoodModel(
      id: 2,
      name: "Rockin' Burgers",
      image: 'assets/images/burger.png',
      price: 40,
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
      name: 'Pepperoni Pizza',
      image: 'assets/images/pizza.png',
      price: 90,
      category: 'Pizza',
      restaurant: 'Spicy Restaurant',
      rating: 4.8,
    ),
    const FoodModel(
      id: 8,
      name: 'Chicken Sandwich',
      image: 'assets/images/burger.png',
      price: 50,
      category: 'Sandwich',
      restaurant: 'Rose Garden',
      rating: 4.4,
    ),
    const FoodModel(
      id: 9,
      name: 'Club Sandwich',
      image: 'assets/images/burger.png',
      price: 65,
      category: 'Sandwich',
      restaurant: 'Cafenio',
      rating: 4.6,
    ),
    const FoodModel(
      id: 10,
      name: 'Salmon Sushi',
      image: 'assets/images/pizza.png',
      price: 100,
      category: 'Sushi',
      restaurant: 'Sushi House',
      rating: 4.8,
    ),
    const FoodModel(
      id: 11,
      name: 'California Sushi',
      image: 'assets/images/pizza.png',
      price: 85,
      category: 'Sushi',
      restaurant: 'Sushi House',
      rating: 4.5,
    ),
  ];

  List<Food> get filteredFoods {
    List<Food> result = foods;

    result = result
        .where(
          (food) => food.category == selectedCategory,
    )
        .toList();

    if (filterApplied) {
      if (selectedPrice == '\$') {
        result = result
            .where(
              (food) => food.price <= 50,
        )
            .toList();
      }

      if (selectedPrice == '\$\$') {
        result = result
            .where(
              (food) =>
          food.price > 50 &&
              food.price <= 80,
        )
            .toList();
      }

      if (selectedPrice == '\$\$\$') {
        result = result
            .where(
              (food) => food.price > 80,
        )
            .toList();
      }

      result = result
          .where(
            (food) => food.rating >= selectedRating,
      )
          .toList();
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final products = filteredFoods;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            18,
            12,
            18,
            25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),

              const SizedBox(height: 14),

              _buildRestaurantImage(),

              const SizedBox(height: 13),

              _buildRestaurantName(),

              const SizedBox(height: 6),

              _buildDescription(),

              const SizedBox(height: 12),

              _buildInfo(),

              const SizedBox(height: 17),

              _buildCategories(),

              const SizedBox(height: 18),

              Text(
                '$selectedCategory (${products.length})',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF20242F),
                ),
              ),

              const SizedBox(height: 12),

              _buildFoods(products),
            ],
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
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 16,
              color: Color(0xFF20242F),
            ),
          ),
        ),

        const SizedBox(width: 14),

        const Text(
          'Restaurant View',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF20242F),
          ),
        ),

        const Spacer(),

        GestureDetector(
          onTap: _showFilter,
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.more_horiz,
              size: 20,
              color: Color(0xFF20242F),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRestaurantImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Image.asset(
        'assets/images/rose_garden.png',
        width: double.infinity,
        height: 115,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildRestaurantName() {
    return Text(
      widget.restaurantName,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xFF20242F),
      ),
    );
  }

  Widget _buildDescription() {
    return const Text(
      'Moccasas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.',
      style: TextStyle(
        fontSize: 10,
        color: Color(0xFF9BA5BC),
        height: 1.5,
      ),
    );
  }

  Widget _buildInfo() {
    return Row(
      children: [
        const Icon(
          Icons.star,
          color: Color(0xFFFF7622),
          size: 18,
        ),

        const SizedBox(width: 4),

        Text(
          widget.rating,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF20242F),
          ),
        ),

        const SizedBox(width: 18),

        const Icon(
          Icons.delivery_dining,
          color: Color(0xFFFF7622),
          size: 18,
        ),

        const SizedBox(width: 4),

        const Text(
          'Free',
          style: TextStyle(
            fontSize: 11,
            color: Color(0xFF20242F),
          ),
        ),

        const SizedBox(width: 18),

        const Icon(
          Icons.access_time,
          color: Color(0xFFFF7622),
          size: 18,
        ),

        const SizedBox(width: 4),

        const Text(
          '20 min',
          style: TextStyle(
            fontSize: 11,
            color: Color(0xFF20242F),
          ),
        ),
      ],
    );
  }

  Widget _buildCategories() {
    const categories = [
      'Burger',
      'Sandwich',
      'Pizza',
      'Sushi',
    ];

    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) =>
        const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          final selected =
              selectedCategory == category;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = category;
                filterApplied = false;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFFFF7622)
                    : Colors.white,
                borderRadius:
                BorderRadius.circular(22),
                border: Border.all(
                  color: selected
                      ? const Color(0xFFFF7622)
                      : const Color(0xFFE5E5E5),
                ),
              ),
              child: Text(
                category,
                style: TextStyle(
                  fontSize: 11,
                  color: selected
                      ? Colors.white
                      : const Color(0xFF20242F),
                  fontWeight: selected
                      ? FontWeight.w600
                      : FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFoods(List<Food> products) {
    if (products.isEmpty) {
      return const SizedBox(
        height: 150,
        child: Center(
          child: Text(
            'No food found',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics:
      const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 0.82,
      ),
      itemBuilder: (context, index) {
        final food = products[index];

        return GestureDetector(
          onTap: () {
            _openFoodDetails(food);
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color:
                  Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                  BorderRadius.circular(9),
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
                  overflow:
                  TextOverflow.ellipsis,
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
                  overflow:
                  TextOverflow.ellipsis,
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
                      width: 23,
                      height: 23,
                      decoration:
                      const BoxDecoration(
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
      },
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

  void _showFilter() {
    String tempOffer = selectedOffer;
    String tempTime = selectedTime;
    String tempPrice = selectedPrice;
    int tempRating = selectedRating;

    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (
              context,
              setDialogState,
              ) {
            return Dialog(
              backgroundColor:
              Colors.transparent,
              insetPadding:
              const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Container(
                padding:
                const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize:
                  MainAxisSize.min,
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Filter your search',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight:
                            FontWeight.w600,
                            color:
                            Color(0xFF20242F),
                          ),
                        ),

                        const Spacer(),

                        GestureDetector(
                          onTap: () {
                            Navigator.pop(
                              dialogContext,
                            );
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration:
                            const BoxDecoration(
                              color:
                              Color(0xFFF1F3F5),
                              shape:
                              BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    _filterTitle('OFFERS'),

                    const SizedBox(height: 9),

                    _filterOptions(
                      [
                        'Delivery',
                        'Pick Up',
                        'Offer',
                      ],
                      tempOffer,
                          (value) {
                        setDialogState(() {
                          tempOffer = value;
                        });
                      },
                    ),

                    const SizedBox(height: 18),

                    _filterTitle(
                      'DELIVERY TIME',
                    ),

                    const SizedBox(height: 9),

                    _filterOptions(
                      [
                        '10-15 min',
                        '20 min',
                        '30 min',
                      ],
                      tempTime,
                          (value) {
                        setDialogState(() {
                          tempTime = value;
                        });
                      },
                    ),

                    const SizedBox(height: 18),

                    _filterTitle('PRICING'),

                    const SizedBox(height: 9),

                    _filterOptions(
                      [
                        '\$',
                        '\$\$',
                        '\$\$\$',
                      ],
                      tempPrice,
                          (value) {
                        setDialogState(() {
                          tempPrice = value;
                        });
                      },
                    ),

                    const SizedBox(height: 18),

                    _filterTitle('RATINGS'),

                    const SizedBox(height: 9),

                    Row(
                      children: List.generate(
                        5,
                            (index) {
                          final selected =
                              index < tempRating;

                          return GestureDetector(
                            onTap: () {
                              setDialogState(() {
                                tempRating =
                                    index + 1;
                              });
                            },
                            child: Container(
                              width: 36,
                              height: 36,
                              margin:
                              const EdgeInsets
                                  .only(
                                right: 8,
                              ),
                              decoration:
                              BoxDecoration(
                                shape:
                                BoxShape.circle,
                                border: Border.all(
                                  color:
                                  const Color(
                                    0xFFE5E5E5,
                                  ),
                                ),
                              ),
                              child: Icon(
                                selected
                                    ? Icons.star
                                    : Icons.star_border,
                                color:
                                const Color(
                                  0xFFFF7622,
                                ),
                                size: 16,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 22),

                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedOffer =
                                tempOffer;

                            selectedTime =
                                tempTime;

                            selectedPrice =
                                tempPrice;

                            selectedRating =
                                tempRating;

                            filterApplied = true;
                          });

                          Navigator.pop(
                            dialogContext,
                          );
                        },
                        style: ElevatedButton
                            .styleFrom(
                          backgroundColor:
                          const Color(
                            0xFFFF7622,
                          ),
                          elevation: 0,
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(
                              8,
                            ),
                          ),
                        ),
                        child: const Text(
                          'FILTER',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _filterTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 10,
        color: Color(0xFF9BA5BC),
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _filterOptions(
      List<String> options,
      String selected,
      Function(String) onTap,
      ) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map(
            (option) {
          final isSelected =
              option == selected;

          return GestureDetector(
            onTap: () {
              onTap(option);
            },
            child: Container(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFFFF7622)
                    : Colors.white,
                borderRadius:
                BorderRadius.circular(18),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFFF7622)
                      : const Color(0xFFE5E5E5),
                ),
              ),
              child: Text(
                option,
                style: TextStyle(
                  fontSize: 10,
                  color: isSelected
                      ? Colors.white
                      : const Color(0xFF20242F),
                  fontWeight: isSelected
                      ? FontWeight.w500
                      : FontWeight.w400,
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}