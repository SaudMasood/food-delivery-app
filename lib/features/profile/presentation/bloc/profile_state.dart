import '../../domain/entities/address.dart';
import '../../domain/entities/profile.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Profile profile;
  final List<Address> addresses;

  ProfileLoaded({
    required this.profile,
    required this.addresses,
  });
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}