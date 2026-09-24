import '../entities/address.dart';
import '../repositories/profile_repository.dart';

class AddAddress {
  final ProfileRepository repository;

  AddAddress({
    required this.repository,
  });

  void call(Address address) {
    repository.addAddress(address);
  }
}