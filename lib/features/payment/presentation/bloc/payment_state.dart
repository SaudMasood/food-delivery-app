import '../../domain/entities/payment_card.dart';

abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoaded extends PaymentState {
  final String selectedMethod;
  final List<PaymentCard> cards;
  final double total;

  PaymentLoaded({
    required this.selectedMethod,
    required this.cards,
    required this.total,
  });
}