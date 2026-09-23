import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/payment_card.dart';
import '../bloc/payment_bloc.dart';
import '../bloc/payment_event.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({
    super.key,
  });

  @override
  State<AddCardPage> createState() =>
      _AddCardPageState();
}

class _AddCardPageState
    extends State<AddCardPage> {
  final holderController =
  TextEditingController();

  final cardController =
  TextEditingController();

  final expiryController =
  TextEditingController();

  final cvvController =
  TextEditingController();

  @override
  void dispose() {
    holderController.dispose();
    cardController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(
              12,
              18,
              12,
              14,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                _buildHeader(context),

                const SizedBox(height: 20),

                _buildField(
                  title: 'CARD HOLDER NAME',
                  controller:
                  holderController,
                  hint: 'Vishal Khachak',
                ),

                const SizedBox(height: 15),

                _buildField(
                  title: 'CARD NUMBER',
                  controller:
                  cardController,
                  hint: '2134  ----  ----  ----',
                ),

                const SizedBox(height: 15),

                Row(
                  children: [
                    Expanded(
                      child: _buildField(
                        title: 'EXPIRE DATE',
                        controller:
                        expiryController,
                        hint: 'mm/yyyy',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildField(
                        title: 'CVC',
                        controller:
                        cvvController,
                        hint: '•••',
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: _addCard,
                    style:
                    ElevatedButton.styleFrom(
                      backgroundColor:
                      const Color(
                        0xFFFF7622,
                      ),
                      elevation: 0,
                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                          6,
                        ),
                      ),
                    ),
                    child: const Text(
                      'ADD & MAKE PAYMENT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addCard() {
    if (holderController.text.isEmpty ||
        cardController.text.isEmpty ||
        expiryController.text.isEmpty ||
        cvvController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
          Text('Please fill all fields'),
        ),
      );
      return;
    }

    final card = PaymentCard(
      holderName:
      holderController.text.trim(),
      cardNumber:
      cardController.text.trim(),
      expiryDate:
      expiryController.text.trim(),
      cvv: cvvController.text.trim(),
    );

    context.read<PaymentBloc>().add(
      AddPaymentCard(card),
    );

    Navigator.pop(context);
  }

  Widget _buildHeader(
      BuildContext context,
      ) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: 30,
            height: 30,
            decoration:
            const BoxDecoration(
              color: Color(0xFFF0F3F6),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.close,
              size: 13,
            ),
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          'Add Card',
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildField({
    required String title,
    required TextEditingController
    controller,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 7,
            color: Color(0xFF9BA5BC),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFF0F4F8),
            borderRadius:
            BorderRadius.circular(5),
          ),
          child: TextField(
            controller: controller,
            style: const TextStyle(
              fontSize: 8,
            ),
            decoration:
            InputDecoration(
              hintText: hint,
              hintStyle:
              const TextStyle(
                color:
                Color(0xFF9BA5BC),
                fontSize: 8,
              ),
              border:
              InputBorder.none,
              contentPadding:
              const EdgeInsets.symmetric(
                horizontal: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}