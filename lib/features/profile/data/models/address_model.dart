import '../../domain/entities/address.dart';

class AddressModel extends Address {
  const AddressModel({
    required super.id,
    required super.label,
    required super.address,
    required super.street,
    required super.postCode,
    required super.apartment,
  });

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] ?? 0,
      label: map['label'] ?? '',
      address: map['address'] ?? '',
      street: map['street'] ?? '',
      postCode: map['postCode'] ?? '',
      apartment: map['apartment'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'label': label,
      'address': address,
      'street': street,
      'postCode': postCode,
      'apartment': apartment,
    };
  }
}