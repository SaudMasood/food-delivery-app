import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class GetProfile {
  final ProfileRepository repository;

  GetProfile({
    required this.repository,
  });

  Profile call() {
    return repository.getProfile();
  }
}