import '../models/address_model.dart';
import '../models/profile_model.dart';

class ProfileLocalDataSource {
  ProfileModel _profile = const ProfileModel(
    name: 'Saud Masood',
    email: 'saudmasood@gmail.com',
    phone: '408-841-0926',
    bio: 'I love fast food',
  );

  final List<AddressModel> _addresses = [
    const AddressModel(
      id: 1,
      label: 'HOME',
      address: '2464 Royal Ln. Mesa, New Jersey',
      street: 'Hason Nagar',
      postCode: '34567',
      apartment: '345',
    ),
    const AddressModel(
      id: 2,
      label: 'WORK',
      address: '3891 Ranchview Dr. Richardson',
      street: 'California',
      postCode: '62639',
      apartment: '',
    ),
  ];

  ProfileModel getProfile() {
    return _profile;
  }

  void updateProfile(ProfileModel profile) {
    _profile = profile;
  }

  List<AddressModel> getAddresses() {
    return List.unmodifiable(_addresses);
  }

  void addAddress(AddressModel address) {
    _addresses.add(address);
  }
}