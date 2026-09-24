import '../../domain/entities/address.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_data_source.dart';
import '../models/address_model.dart';
import '../models/profile_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDataSource dataSource;

  ProfileRepositoryImpl({
    required this.dataSource,
  });

  @override
  Profile getProfile() {
    return dataSource.getProfile();
  }

  @override
  void updateProfile(Profile profile) {
    dataSource.updateProfile(
      ProfileModel(
        name: profile.name,
        email: profile.email,
        phone: profile.phone,
        bio: profile.bio,
      ),
    );
  }

  @override
  List<Address> getAddresses() {
    return dataSource.getAddresses();
  }

  @override
  void addAddress(Address address) {
    dataSource.addAddress(
      AddressModel(
        id: address.id,
        label: address.label,
        address: address.address,
        street: address.street,
        postCode: address.postCode,
        apartment: address.apartment,
      ),
    );
  }
}