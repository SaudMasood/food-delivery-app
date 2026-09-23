import 'package:flutter/material.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({
    super.key,
  });

  @override
  State<FilterDialog> createState() =>
      _FilterDialogState();
}

class _FilterDialogState
    extends State<FilterDialog> {
  String selectedOffer = 'Delivery';
  String selectedTime = '10-15 min';
  String selectedPrice = '\$';
  int selectedRating = 1;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 20,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(
          16,
          15,
          16,
          15,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            _buildHeader(),

            const SizedBox(height: 14),

            const Text(
              'Filter your search',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 15),

            _buildTitle('OFFERS'),

            const SizedBox(height: 8),

            _buildOptions(
              [
                'Delivery',
                'Pick Up',
                'Offer',
              ],
              selectedOffer,
                  (value) {
                setState(() {
                  selectedOffer = value;
                });
              },
            ),

            const SizedBox(height: 15),

            _buildTitle('DELIVERY TIME'),

            const SizedBox(height: 8),

            _buildOptions(
              [
                '10-15 min',
                '20 min',
                '30 min',
              ],
              selectedTime,
                  (value) {
                setState(() {
                  selectedTime = value;
                });
              },
            ),

            const SizedBox(height: 15),

            _buildTitle('PRICING'),

            const SizedBox(height: 8),

            _buildOptions(
              [
                '\$',
                '\$\$',
                '\$\$\$',
              ],
              selectedPrice,
                  (value) {
                setState(() {
                  selectedPrice = value;
                });
              },
            ),

            const SizedBox(height: 15),

            _buildTitle('RATINGS'),

            const SizedBox(height: 8),

            Row(
              children: List.generate(
                5,
                    (index) {
                  final selected =
                      index < selectedRating;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedRating =
                            index + 1;
                      });
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      margin:
                      const EdgeInsets.only(
                        right: 7,
                      ),
                      decoration:
                      BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(
                            0xFFE5E5E5,
                          ),
                        ),
                      ),
                      child: Icon(
                        selected
                            ? Icons.star
                            : Icons.star_border,
                        color: const Color(
                          0xFFFF7622,
                        ),
                        size: 14,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 18),

            SizedBox(
              width: double.infinity,
              height: 42,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    FilterResult(
                      offer: selectedOffer,
                      deliveryTime:
                      selectedTime,
                      price: selectedPrice,
                      rating: selectedRating,
                    ),
                  );
                },
                style:
                ElevatedButton.styleFrom(
                  backgroundColor:
                  const Color(0xFFFF7622),
                  elevation: 0,
                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(7),
                  ),
                ),
                child: const Text(
                  'FILTER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
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
        const Text(
          'Filter',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),

        const Spacer(),

        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              color: Color(0xFFF1F3F5),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.close,
              size: 15,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 8,
        color: Color(0xFF9BA5BC),
      ),
    );
  }

  Widget _buildOptions(
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

class FilterResult {
  final String offer;
  final String deliveryTime;
  final String price;
  final int rating;

  FilterResult({
    required this.offer,
    required this.deliveryTime,
    required this.price,
    required this.rating,
  });
}