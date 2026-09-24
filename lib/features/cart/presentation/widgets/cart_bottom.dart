import 'package:flutter/material.dart';

import '../../../payment/presentation/pages/payment_method_page.dart';

class CartBottom extends StatefulWidget {
  final double total;

  const CartBottom({
    super.key,
    required this.total,
  });

  @override
  State<CartBottom> createState() => _CartBottomState();
}

class _CartBottomState extends State<CartBottom> {
  String address = '2118 Thornridge Cir. Syracuse';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        18,
        19,
        18,
        22,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAddress(),

          const SizedBox(height: 21),

          _buildTotal(),

          const SizedBox(height: 19),

          _buildPlaceOrder(),
        ],
      ),
    );
  }

  Widget _buildAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'DELIVERY ADDRESS',
              style: TextStyle(
                color: Color(0xFF9BA5BC),
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),

            const Spacer(),

            GestureDetector(
              onTap: _showAddressDialog,
              child: const Text(
                'EDIT',
                style: TextStyle(
                  color: Color(0xFFFF7622),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        Container(
          width: double.infinity,
          height: 47,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: const Color(0xFFF0F4F8),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            address,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF7F8795),
              fontSize: 11,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTotal() {
    return Row(
      children: [
        const Text(
          'TOTAL:',
          style: TextStyle(
            color: Color(0xFF9BA5BC),
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(width: 11),

        Text(
          '\$${widget.total.toStringAsFixed(0)}',
          style: const TextStyle(
            color: Color(0xFF20242F),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),

        const Spacer(),

        GestureDetector(
          onTap: _showBreakdown,
          child: const Row(
            children: [
              Text(
                'Breakdown',
                style: TextStyle(
                  color: Color(0xFFFF7622),
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Color(0xFF20242F),
                size: 18,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceOrder() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const PaymentMethodPage(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF7622),
          foregroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'PLACE ORDER',
          style: TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _showAddressDialog() {
    final controller = TextEditingController(
      text: address,
    );

    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Delivery Address',
                      style: TextStyle(
                        color: Color(0xFF20242F),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const Spacer(),

                    GestureDetector(
                      onTap: () {
                        Navigator.pop(dialogContext);
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF1F3F5),
                          shape: BoxShape.circle,
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

                const Text(
                  'ADDRESS',
                  style: TextStyle(
                    color: Color(0xFF9BA5BC),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                TextField(
                  controller: controller,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF20242F),
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF0F4F8),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 13,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Enter delivery address',
                    hintStyle: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF9BA5BC),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {
                      if (controller.text.trim().isNotEmpty) {
                        setState(() {
                          address = controller.text.trim();
                        });
                      }

                      Navigator.pop(dialogContext);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF7622),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'SAVE ADDRESS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
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
  }

  void _showBreakdown() {
    final deliveryFee = 0.0;
    final subtotal = widget.total - deliveryFee;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Text(
                      'Price Breakdown',
                      style: TextStyle(
                        color: Color(0xFF20242F),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const Spacer(),

                    GestureDetector(
                      onTap: () {
                        Navigator.pop(dialogContext);
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF1F3F5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                _breakdownRow(
                  'Subtotal',
                  subtotal,
                ),

                const SizedBox(height: 13),

                _breakdownRow(
                  'Delivery Fee',
                  deliveryFee,
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  child: Divider(
                    color: Color(0xFFE5E5E5),
                  ),
                ),

                Row(
                  children: [
                    const Text(
                      'TOTAL',
                      style: TextStyle(
                        color: Color(0xFF9BA5BC),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const Spacer(),

                    Text(
                      '\$${widget.total.toStringAsFixed(0)}',
                      style: const TextStyle(
                        color: Color(0xFF20242F),
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF7622),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'DONE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
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
  }

  Widget _breakdownRow(
      String title,
      double amount,
      ) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF9BA5BC),
            fontSize: 11,
          ),
        ),

        const Spacer(),

        Text(
          '\$${amount.toStringAsFixed(0)}',
          style: const TextStyle(
            color: Color(0xFF20242F),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}