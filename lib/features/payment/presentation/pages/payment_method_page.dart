import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/payment_bloc.dart';
import '../bloc/payment_event.dart';
import '../bloc/payment_state.dart';
import 'add_card_page.dart';
import 'payment_success_page.dart';

class PaymentMethodPage extends StatelessWidget {
  const PaymentMethodPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PaymentBloc()
        ..add(LoadPayment()),
      child: const PaymentMethodView(),
    );
  }
}

class PaymentMethodView extends StatelessWidget {
  const PaymentMethodView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: BlocBuilder<PaymentBloc, PaymentState>(
          builder: (context, state) {
            if (state is! PaymentLoaded) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.fromLTRB(
                  11,
                  18,
                  11,
                  14,
                ),
                child: Column(
                  children: [
                    _buildHeader(context),

                    const SizedBox(height: 20),

                    _buildPaymentMethods(
                      context,
                      state,
                    ),

                    const SizedBox(height: 15),

                    Expanded(
                      child: _buildCardSection(
                        context,
                        state,
                      ),
                    ),

                    _buildTotal(state),

                    const SizedBox(height: 14),

                    _buildPayButton(context),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              color: Color(0xFFF0F3F6),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 12,
            ),
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          'Payment',
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethods(
      BuildContext context,
      PaymentLoaded state,
      ) {
    return SizedBox(
      height: 63,
      child: Row(
        children: [
          _buildPaymentMethod(
            context: context,
            state: state,
            name: 'Cash',
            icon: 'assets/icons/cash.svg',
          ),
          _buildPaymentMethod(
            context: context,
            state: state,
            name: 'Visa',
            icon: 'assets/icons/visa.svg',
          ),
          _buildPaymentMethod(
            context: context,
            state: state,
            name: 'Mastercard',
            icon: 'assets/icons/master.svg',
          ),
          _buildPaymentMethod(
            context: context,
            state: state,
            name: 'Paypal',
            icon: 'assets/icons/paypal.svg',
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod({
    required BuildContext context,
    required PaymentLoaded state,
    required String name,
    required String icon,
  }) {
    final selected =
        state.selectedMethod == name;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          context.read<PaymentBloc>().add(
            SelectPaymentMethod(name),
          );
        },
        child: Container(
          height: 63,
          margin: const EdgeInsets.only(
            right: 6,
          ),
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFFFFF8F3)
                : const Color(0xFFF1F5F8),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: selected
                  ? const Color(0xFFFF7622)
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 27,
                      height: 22,
                      child: SvgPicture.asset(
                        icon,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 7,
                        color: Color(0xFF555555),
                      ),
                    ),
                  ],
                ),
              ),

              if (selected)
                Positioned(
                  top: -1,
                  right: -1,
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF7622),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 10,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardSection(
      BuildContext context,
      PaymentLoaded state,
      ) {
    if (state.cards.isEmpty) {
      return _buildNoCard(context);
    }

    return _buildSavedCard(
      context,
      state,
    );
  }

  Widget _buildNoCard(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFF7F8FA),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              Container(
                width: 76,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF7622),
                  borderRadius:
                  BorderRadius.circular(7),
                ),
                child: const Icon(
                  Icons.credit_card,
                  color: Colors.white,
                  size: 25,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'No master card added',
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 4),

              const Text(
                'You can add a mastercard and\nsave it for later',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 7,
                  color: Color(0xFF9BA5BC),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        _buildAddButton(context),
      ],
    );
  }

  Widget _buildSavedCard(
      BuildContext context,
      PaymentLoaded state,
      ) {
    final card = state.cards.first;

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F5F8),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(4),
                ),
                child: Padding(
                  padding:
                  const EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    'assets/icons/master.svg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Master Card',
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      _hideCardNumber(
                        card.cardNumber,
                      ),
                      style: const TextStyle(
                        fontSize: 7,
                        color:
                        Color(0xFF9BA5BC),
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.keyboard_arrow_down,
                size: 15,
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        _buildAddButton(context),
      ],
    );
  }

  String _hideCardNumber(String number) {
    final clean =
    number.replaceAll(' ', '');

    if (clean.length <= 4) {
      return number;
    }

    return '••••  ••••  ••••  ${clean.substring(clean.length - 4)}';
  }

  Widget _buildAddButton(
      BuildContext context,
      ) {
    return GestureDetector(
      onTap: () {
        final bloc =
        context.read<PaymentBloc>();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return BlocProvider.value(
                value: bloc,
                child: const AddCardPage(),
              );
            },
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(5),
          border: Border.all(
            color: const Color(0xFFE5EAF0),
          ),
        ),
        child: const Center(
          child: Text(
            '+  ADD NEW',
            style: TextStyle(
              color: Color(0xFFFF7622),
              fontSize: 7,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTotal(
      PaymentLoaded state,
      ) {
    return Row(
      children: [
        const Text(
          'TOTAL:',
          style: TextStyle(
            fontSize: 8,
            color: Color(0xFF9BA5BC),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '\$${state.total.toStringAsFixed(0)}',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildPayButton(
      BuildContext context,
      ) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
        onPressed: () {
          context.read<PaymentBloc>().add(
            PayAndConfirm(),
          );

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
              const PaymentSuccessPage(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
          const Color(0xFFFF7622),
          elevation: 0,
          shape:
          RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(6),
          ),
        ),
        child: const Text(
          'PAY & CONFIRM',
          style: TextStyle(
            color: Colors.white,
            fontSize: 8,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}