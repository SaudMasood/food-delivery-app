import '../../domain/entities/payment_card.dart';

class PaymentCardModel extends PaymentCard {
  const PaymentCardModel({
    required super.holderName,
    required super.cardNumber,
    required super.expiryDate, required super.cvv,
  });

  factory PaymentCardModel.fromMap(
      Map<String, dynamic> map,
      ) {
    return PaymentCardModel(
      holderName: map['holderName'],
      cardNumber: map['cardNumber'],
      expiryDate: map['expiryDate'], cvv: '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'holderName': holderName,
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
    };
  }
}