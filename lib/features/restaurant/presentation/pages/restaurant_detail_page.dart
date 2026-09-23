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
            10,
            8,
            10,
            25,
          ),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              _buildHeader(),

              const SizedBox(height: 10),

              _buildRestaurantImage(),

              const SizedBox(height: 10),

              _buildRestaurantName(),

              const SizedBox(height: 5),

              _buildDescription(),

              const SizedBox(height: 10),

              _buildInfo(),

              const SizedBox(height: 13),

              _buildCategories(),

              const SizedBox(height: 14),

              Text(
                '$selectedCategory (${products.length})',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 10),

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
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 14,
            ),
          ),
        ),

        const SizedBox(width: 12),

        const Text(
          'Restaurant View',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),

        const Spacer(),

        GestureDetector(
          onTap: _showFilter,
          child: Container(
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.more_horiz,
              size: 17,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRestaurantImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
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
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildDescription() {
    return const Text(
      'Moccasas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.',
      style: TextStyle(
        fontSize: 8,
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
          size: 14,
        ),

        const SizedBox(width: 3),

        Text(
          widget.rating,
          style: const TextStyle(
            fontSize: 9,
          ),
        ),

        const SizedBox(width: 15),

        const Icon(
          Icons.delivery_dining,
          color: Color(0xFFFF7622),
          size: 14,
        ),

        const SizedBox(width: 3),

        const Text(
          'Free',
          style: TextStyle(
            fontSize: 9,
          ),
        ),

        const SizedBox(width: 15),

        const Icon(
          Icons.access_time,
          color: Color(0xFFFF7622),
          size: 14,
        ),

        const SizedBox(width: 3),

        const Text(
          '20 min',
          style: TextStyle(
            fontSize: 9,
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
      height: 32,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: categories.map(
              (category) {
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
                margin: const EdgeInsets.only(
                  right: 8,
                ),
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFFFF7622)
                      : Colors.white,
                  borderRadius:
                  BorderRadius.circular(18),
                  border: Border.all(
                    color: selected
                        ? const Color(0xFFFF7622)
                        : const Color(0xFFE5E5E5),
                  ),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 8,
                    color: selected
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            );
          },
        ).toList(),
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
              fontSize: 11,
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
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemBuilder: (context, index) {
        final food = products[index];

        return GestureDetector(
          onTap: () {
            _openFoodDetails(food);
          },
          child: Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color:
                  Colors.black.withOpacity(0.04),
                  blurRadius: 8,
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
                    height: 58,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 5),

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
                    fontSize: 7,
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
              backgroundColor: Colors.transparent,
              insetPadding:
              const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Container(
                padding:
                const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(12),
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
                            fontSize: 12,
                            fontWeight:
                            FontWeight.w500,
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
                            width: 30,
                            height: 30,
                            decoration:
                            const BoxDecoration(
                              color:
                              Color(0xFFF1F3F5),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 15,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    _filterTitle('OFFERS'),

                    const SizedBox(height: 8),

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

                    const SizedBox(height: 16),

                    _filterTitle(
                      'DELIVERY TIME',
                    ),

                    const SizedBox(height: 8),

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

                    const SizedBox(height: 16),

                    _filterTitle('PRICING'),

                    const SizedBox(height: 8),

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

                    const SizedBox(height: 16),

                    _filterTitle('RATINGS'),

                    const SizedBox(height: 8),

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
                              width: 32,
                              height: 32,
                              margin:
                              const EdgeInsets
                                  .only(
                                right: 7,
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
                                size: 14,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 42,
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
                              7,
                            ),
                          ),
                        ),
                        child: const Text(
                          'FILTER',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
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
        fontSize: 8,
        color: Color(0xFF9BA5BC),
      ),
    );
  }

  Widget _filterOptions(
      List<String> options,
      String selected,
      Function(String) onTap,
      ) {
    return Wrap(
      spacing: 7,
      runSpacing: 7,
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
                horizontal: 10,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFFFF7622)
                    : Colors.white,
                borderRadius:
                BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFFF7622)
                      : const Color(0xFFE5E5E5),
                ),
              ),
              child: Text(
                option,
                style: TextStyle(
                  fontSize: 8,
                  color: isSelected
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}