import 'package:flutter/material.dart';

import '../../domain/entities/cart_item.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;
  final bool showDelete;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
    required this.showDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildName(),

                const SizedBox(height: 7),

                _buildPrice(),

                const Spacer(),

                _buildBottom(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      width: 94,
      height: 88,
      decoration: BoxDecoration(
        color: const Color(0xFF29293B),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          item.image,
          width: 94,
          height: 88,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) {
            return Container(
              color: const Color(0xFF29293B),
            );
          },
        ),
      ),
    );
  }

  Widget _buildName() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            item.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),
        ),

        if (showDelete) ...[
          const SizedBox(width: 8),

          GestureDetector(
            onTap: onRemove,
            child: Container(
              width: 22,
              height: 22,
              decoration: const BoxDecoration(
                color: Color(0xFFE94B4B),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 14,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPrice() {
    return Text(
      '\$${item.price.toStringAsFixed(0)}',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildBottom() {
    return Row(
      children: [
        Text(
          item.size,
          style: const TextStyle(
            color: Color(0xFF8E8EA3),
            fontSize: 11,
          ),
        ),

        const Spacer(),

        _quantityButton(
          Icons.remove,
          onDecrease,
        ),

        const SizedBox(width: 12),

        Text(
          item.quantity.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(width: 12),

        _quantityButton(
          Icons.add,
          onIncrease,
        ),
      ],
    );
  }

  Widget _quantityButton(
      IconData icon,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 21,
        height: 21,
        decoration: const BoxDecoration(
          color: Color(0xFF3E3E50),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 13,
        ),
      ),
    );
  }
}