import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/add_address.dart';
import '../../domain/usecases/get_addresses.dart';
import '../../domain/usecases/get_profile.dart';
import '../../domain/usecases/update_profile.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfile getProfile;
  final UpdateProfile updateProfile;
  final GetAddresses getAddresses;
  final AddAddress addAddress;

  ProfileBloc({
    required this.getProfile,
    required this.updateProfile,
    required this.getAddresses,
    required this.addAddress,
  }) : super(ProfileInitial()) {
    on<LoadProfile>(_loadProfile);
    on<UpdateProfileEvent>(_updateProfile);
    on<AddAddressEvent>(_addAddress);
  }

  void _loadProfile(
      LoadProfile event,
      Emitter<ProfileState> emit,
      ) {
    emit(ProfileLoading());

    try {
      emit(
        ProfileLoaded(
          profile: getProfile(),
          addresses: getAddresses(),
        ),
      );
    } catch (e) {
      emit(
        ProfileError(e.toString()),
      );
    }
  }

  void _updateProfile(
      UpdateProfileEvent event,
      Emitter<ProfileState> emit,
      ) {
    try {
      updateProfile(event.profile);

      emit(
        ProfileLoaded(
          profile: getProfile(),
          addresses: getAddresses(),
        ),
      );
    } catch (e) {
      emit(
        ProfileError(e.toString()),
      );
    }
  }

  void _addAddress(
      AddAddressEvent event,
      Emitter<ProfileState> emit,
      ) {
    try {
      addAddress(event.address);

      emit(
        ProfileLoaded(
          profile: getProfile(),
          addresses: getAddresses(),
        ),
      );
    } catch (e) {
      emit(
        ProfileError(e.toString()),
      );
    }
  }
}