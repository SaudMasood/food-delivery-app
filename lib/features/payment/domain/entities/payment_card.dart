class PaymentCard {
  final String holderName;
  final String cardNumber;
  final String expiryDate;
  final String cvv;

  const PaymentCard({
    required this.holderName,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
  });
}