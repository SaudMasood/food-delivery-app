import 'package:flutter/material.dart';

import '../../domain/entities/order.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final bool history;
  final VoidCallback onTrack;
  final VoidCallback onCancel;
  final VoidCallback onRate;
  final VoidCallback onReorder;

  const OrderCard({
    super.key,
    required this.order,
    required this.history,
    required this.onTrack,
    required this.onCancel,
    required this.onRate,
    required this.onReorder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCategory(),

        const SizedBox(height: 13),

        Row(
          children: [
            _buildImage(),

            const SizedBox(width: 13),

            Expanded(
              child: _buildInfo(),
            ),

            const SizedBox(width: 8),

            Text(
              order.orderNumber,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF737B8C),
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),

        const SizedBox(height: 15),

        Row(
          children: [
            Expanded(
              child: _buildButton(
                title: history ? 'Rate' : 'Track Order',
                filled: false,
                onTap: history ? onRate : onTrack,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: _buildButton(
                title: history ? 'Re-Order' : 'Cancel',
                filled: history,
                onTap: history ? onReorder : onCancel,
              ),
            ),
          ],
        ),

        const SizedBox(height: 17),

        const Divider(
          color: Color(0xFFE9EDF0),
          height: 1,
        ),
      ],
    );
  }

  Widget _buildCategory() {
    return Row(
      children: [
        Text(
          order.category,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF20242F),
          ),
        ),

        const Spacer(),

        if (history)
          Text(
            order.status == OrderStatus.completed
                ? 'Completed'
                : 'Canceled',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: order.status == OrderStatus.completed
                  ? const Color(0xFF00B98D)
                  : const Color(0xFFFF493D),
            ),
          ),
      ],
    );
  }

  Widget _buildImage() {
    return Container(
      width: 68,
      height: 68,
      decoration: BoxDecoration(
        color: const Color(0xFF9BAFC0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          order.image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          order.restaurant,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF20242F),
          ),
        ),

        const SizedBox(height: 8),

        Row(
          children: [
            Text(
              '\$${order.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF20242F),
              ),
            ),

            const SizedBox(width: 10),

            Container(
              width: 1,
              height: 14,
              color: const Color(0xFFD5D9DD),
            ),

            const SizedBox(width: 10),

            Flexible(
              child: Text(
                order.date,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF737B8C),
                ),
              ),
            ),

            const SizedBox(width: 7),

            Text(
              '• ${order.itemCount} Items',
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF737B8C),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildButton({
    required String title,
    required bool filled,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 43,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor:
          filled ? const Color(0xFFFF7622) : Colors.white,
          side: const BorderSide(
            color: Color(0xFFFF7622),
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: filled
                ? Colors.white
                : const Color(0xFFFF7622),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}