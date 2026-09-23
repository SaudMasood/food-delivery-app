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
    final deliveryFee = 0.0;
    final subtotal = widget.total - deliveryFee;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        16,
        17,
        16,
        19,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAddress(),

          const SizedBox(height: 20),

          _buildTotal(),

          const SizedBox(height: 18),

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
                fontSize: 8,
              ),
            ),

            const Spacer(),

            GestureDetector(
              onTap: _showAddressDialog,
              child: const Text(
                'EDIT',
                style: TextStyle(
                  color: Color(0xFFFF7622),
                  fontSize: 8,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 9),

        Container(
          width: double.infinity,
          height: 40,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: const Color(0xFFF0F4F8),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            address,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF9BA5BC),
              fontSize: 9,
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
            fontSize: 8,
          ),
        ),

        const SizedBox(width: 10),

        Text(
          '\$${widget.total.toStringAsFixed(0)}',
          style: const TextStyle(
            color: Color(0xFF20242F),
            fontSize: 18,
            fontWeight: FontWeight.w400,
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
                  fontSize: 8,
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Color(0xFF20242F),
                size: 15,
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
      height: 41,
      child: ElevatedButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const PaymentMethodPage();
              },
            ),
          );

        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF7622),
          foregroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
        child: const Text(
          'PLACE ORDER',
          style: TextStyle(
            color: Colors.white,
            fontSize: 9,
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
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Delivery Address',
                      style: TextStyle(
                        color: Color(0xFF20242F),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const Spacer(),

                    GestureDetector(
                      onTap: () {
                        Navigator.pop(dialogContext);
                      },
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF1F3F5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 14,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                const Text(
                  'ADDRESS',
                  style: TextStyle(
                    color: Color(0xFF9BA5BC),
                    fontSize: 8,
                  ),
                ),

                const SizedBox(height: 7),

                TextField(
                  controller: controller,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF20242F),
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF0F4F8),
                    contentPadding:
                    const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(7),
                      borderSide: BorderSide.none,
                    ),
                    hintText:
                    'Enter delivery address',
                    hintStyle: const TextStyle(
                      fontSize: 9,
                      color: Color(0xFF9BA5BC),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                SizedBox(
                  width: double.infinity,
                  height: 41,
                  child: ElevatedButton(
                    onPressed: () {
                      if (controller.text
                          .trim()
                          .isNotEmpty) {
                        setState(() {
                          address =
                              controller.text.trim();
                        });
                      }

                      Navigator.pop(dialogContext);
                    },
                    style: ElevatedButton.styleFrom(
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
                      'SAVE ADDRESS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
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
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Price Breakdown',
                      style: TextStyle(
                        color: Color(0xFF20242F),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const Spacer(),

                    GestureDetector(
                      onTap: () {
                        Navigator.pop(dialogContext);
                      },
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF1F3F5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 14,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                _breakdownRow(
                  'Subtotal',
                  subtotal,
                ),

                const SizedBox(height: 12),

                _breakdownRow(
                  'Delivery Fee',
                  deliveryFee,
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 14,
                  ),
                  child: Divider(
                    height: 1,
                    color: Color(0xFFE5E5E5),
                  ),
                ),

                Row(
                  children: [
                    const Text(
                      'TOTAL',
                      style: TextStyle(
                        color: Color(0xFF9BA5BC),
                        fontSize: 9,
                      ),
                    ),

                    const Spacer(),

                    Text(
                      '\$${widget.total.toStringAsFixed(0)}',
                      style: const TextStyle(
                        color: Color(0xFF20242F),
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                    },
                    style: ElevatedButton.styleFrom(
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
                      'DONE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
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
            fontSize: 9,
          ),
        ),

        const Spacer(),

        Text(
          '\$${amount.toStringAsFixed(0)}',
          style: const TextStyle(
            color: Color(0xFF20242F),
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  void _placeOrder() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFF1E9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Color(0xFFFF7622),
                    size: 25,
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  'Order Placed',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  'Your order has been placed successfully.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF9BA5BC),
                    fontSize: 9,
                  ),
                ),

                const SizedBox(height: 18),

                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                    },
                    style: ElevatedButton.styleFrom(
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
                      'DONE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
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
}