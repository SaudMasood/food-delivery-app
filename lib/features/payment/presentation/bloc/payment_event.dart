import '../../domain/entities/payment_card.dart';

abstract class PaymentEvent {}

class LoadPayment extends PaymentEvent {}

class SelectPaymentMethod extends PaymentEvent {
  final String method;

  SelectPaymentMethod(this.method);
}

class AddPaymentCard extends PaymentEvent {
  final PaymentCard card;

  AddPaymentCard(this.card);
}

class PayAndConfirm extends PaymentEvent {}