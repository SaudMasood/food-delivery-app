import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/payment_card.dart';
import 'payment_event.dart';
import 'payment_state.dart';

class PaymentBloc
    extends Bloc<PaymentEvent, PaymentState> {
  final List<PaymentCard> cards = [];

  String selectedMethod = 'Mastercard';

  final double total = 96;

  PaymentBloc() : super(PaymentInitial()) {
    on<LoadPayment>((event, emit) {
      emit(
        PaymentLoaded(
          selectedMethod: selectedMethod,
          cards: List.from(cards),
          total: total,
        ),
      );
    });

    on<SelectPaymentMethod>((event, emit) {
      selectedMethod = event.method;

      emit(
        PaymentLoaded(
          selectedMethod: selectedMethod,
          cards: List.from(cards),
          total: total,
        ),
      );
    });

    on<AddPaymentCard>((event, emit) {
      cards.add(event.card);

      selectedMethod = 'Mastercard';

      emit(
        PaymentLoaded(
          selectedMethod: selectedMethod,
          cards: List.from(cards),
          total: total,
        ),
      );
    });

    on<PayAndConfirm>((event, emit) {
      emit(
        PaymentLoaded(
          selectedMethod: selectedMethod,
          cards: List.from(cards),
          total: total,
        ),
      );
    });
  }
}