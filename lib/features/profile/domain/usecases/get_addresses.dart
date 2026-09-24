import '../entities/address.dart';
import '../repositories/profile_repository.dart';

class GetAddresses {
  final ProfileRepository repository;

  GetAddresses({
    required this.repository,
  });

  List<Address> call() {
    return repository.getAddresses();
  }
}