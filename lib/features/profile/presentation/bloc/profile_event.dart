import '../../domain/entities/address.dart';
import '../../domain/entities/profile.dart';

abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final Profile profile;

  UpdateProfileEvent(this.profile);
}

class AddAddressEvent extends ProfileEvent {
  final Address address;

  AddAddressEvent(this.address);
}