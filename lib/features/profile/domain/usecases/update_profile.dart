import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class UpdateProfile {
  final ProfileRepository repository;

  UpdateProfile({
    required this.repository,
  });

  void call(Profile profile) {
    repository.updateProfile(profile);
  }
}