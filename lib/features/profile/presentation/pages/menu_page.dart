import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/profile_local_data_source.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../domain/usecases/add_address.dart';
import '../../domain/usecases/get_addresses.dart';
import '../../domain/usecases/get_profile.dart';
import '../../domain/usecases/update_profile.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import 'address_page.dart';
import 'personal_info_page.dart';
import '../../../cart/presentation/pages/cart_page.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dataSource = ProfileLocalDataSource();

    final repository = ProfileRepositoryImpl(
      dataSource: dataSource,
    );

    final getProfile = GetProfile(
      repository: repository,
    );

    final updateProfile = UpdateProfile(
      repository: repository,
    );

    final getAddresses = GetAddresses(
      repository: repository,
    );

    final addAddress = AddAddress(
      repository: repository,
    );

    return BlocProvider(
      create: (_) => ProfileBloc(
        getProfile: getProfile,
        updateProfile: updateProfile,
        getAddresses: getAddresses,
        addAddress: addAddress,
      )..add(LoadProfile()),
      child: const MenuView(),
    );
  }
}

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      body: SafeArea(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading ||
                state is ProfileInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is ProfileError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.red,
                  ),
                ),
              );
            }

            if (state is! ProfileLoaded) {
              return const SizedBox();
            }

            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  _buildHeader(),

                  const SizedBox(height: 22),

                  _buildProfile(state),

                  const SizedBox(height: 24),

                  _buildSectionOne(context),

                  const SizedBox(height: 14),

                  _buildSectionTwo(context),

                  const SizedBox(height: 14),

                  _buildLogout(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const SizedBox(width: 2),

        const Text(
          'Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF20242F),
          ),
        ),

        const Spacer(),

        Container(
          width: 38,
          height: 38,
          decoration: const BoxDecoration(
            color: Color(0xFFF0F3F6),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.more_horiz,
            size: 20,
            color: Color(0xFF20242F),
          ),
        ),
      ],
    );
  }

  Widget _buildProfile(ProfileLoaded state) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 36,
          backgroundColor: Color(0xFFFFC6B0),
          child: Icon(
            Icons.person,
            size: 38,
            color: Colors.white,
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                state.profile.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF20242F),
                ),
              ),

              const SizedBox(height: 6),

              Text(
                state.profile.bio,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF9BA5BC),
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionOne(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _menuItem(
            Icons.person_outline,
            'Personal Info',
                () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const PersonalInfoPage(),
                ),
              );
            },
          ),

          _menuItem(
            Icons.location_on_outlined,
            'Addresses',
                () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const AddressPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTwo(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _menuItem(
            Icons.shopping_bag_outlined,
            'Cart',
                () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const MyCartPage(),
                ),
              );
            },
          ),

          _menuItem(
            Icons.favorite_border,
            'Favourite',
                () {},
          ),

          _menuItem(
            Icons.notifications_none,
            'Notifications',
                () {},
          ),

          _menuItem(
            Icons.credit_card_outlined,
            'Payment Method',
                () {},
          ),
        ],
      ),
    );
  }

  Widget _buildLogout() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: _menuItem(
        Icons.logout,
        'Log Out',
            () {},
      ),
    );
  }

  Widget _menuItem(
      IconData icon,
      String title,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 58,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
          ),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 19,
                  color: const Color(0xFFFF7622),
                ),
              ),

              const SizedBox(width: 14),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF3D414D),
                ),
              ),

              const Spacer(),

              const Icon(
                Icons.chevron_right,
                size: 21,
                color: Color(0xFF7F8794),
              ),
            ],
          ),
        ),
      ),
    );
  }
}