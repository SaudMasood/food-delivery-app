import '../entities/address.dart';
import '../entities/profile.dart';

abstract class ProfileRepository {
  Profile getProfile();

  void updateProfile(Profile profile);

  List<Address> getAddresses();

  void addAddress(Address address);
}