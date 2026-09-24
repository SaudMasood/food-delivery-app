import 'package:flutter/material.dart';

import '../widgets/menu_item.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            17,
            0,
            17,
            10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Menue',
                style: TextStyle(
                  color: Color(0xFFB6B6B6),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),

              const SizedBox(height: 9),

              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(
                    12,
                    14,
                    12,
                    14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildHeader(context),

                        const SizedBox(height: 13),

                        _buildProfile(),

                        const SizedBox(height: 12),

                        _buildFirstSection(context),

                        const SizedBox(height: 10),

                        _buildSecondSection(context),

                        const SizedBox(height: 10),

                        _buildThirdSection(context),

                        const SizedBox(height: 10),

                        _buildLogout(context),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: 25,
            height: 25,
            decoration: const BoxDecoration(
              color: Color(0xFFF0F3F6),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 9,
              color: Color(0xFF20242F),
            ),
          ),
        ),

        const SizedBox(width: 8),

        const Text(
          'Profile',
          style: TextStyle(
            color: Color(0xFF20242F),
            fontSize: 8,
            fontWeight: FontWeight.w500,
          ),
        ),

        const Spacer(),

        GestureDetector(
          onTap: () {
            _showMore(context);
          },
          child: Container(
            width: 25,
            height: 25,
            decoration: const BoxDecoration(
              color: Color(0xFFF0F3F6),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.more_horiz,
              size: 14,
              color: Color(0xFF20242F),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfile() {
    return Row(
      children: [
        Container(
          width: 47,
          height: 47,
          decoration: const BoxDecoration(
            color: Color(0xFFFFC6B0),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.person,
            size: 28,
            color: Colors.white,
          ),
        ),

        const SizedBox(width: 12),

        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vishal Khadok',
              style: TextStyle(
                color: Color(0xFF20242F),
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 3),

            Text(
              'I love fast food',
              style: TextStyle(
                color: Color(0xFF9BA5BC),
                fontSize: 7,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFirstSection(BuildContext context) {
    return _section(
      children: [
        MenuItemWidget(
          icon: Icons.person_outline,
          title: 'Personal Info',
          onTap: () {
            _showMessage(context, 'Personal Info');
          },
        ),

        MenuItemWidget(
          icon: Icons.location_on_outlined,
          title: 'Addresses',
          onTap: () {
            _showMessage(context, 'Addresses');
          },
        ),
      ],
    );
  }

  Widget _buildSecondSection(BuildContext context) {
    return _section(
      children: [
        MenuItemWidget(
          icon: Icons.shopping_bag_outlined,
          title: 'Cart',
          onTap: () {
            _showMessage(context, 'Cart');
          },
        ),

        MenuItemWidget(
          icon: Icons.favorite_border,
          title: 'Favourite',
          onTap: () {
            _showMessage(context, 'Favourite');
          },
        ),

        MenuItemWidget(
          icon: Icons.notifications_none,
          title: 'Notifications',
          onTap: () {
            _showMessage(context, 'Notifications');
          },
        ),

        MenuItemWidget(
          icon: Icons.credit_card_outlined,
          title: 'Payment Method',
          onTap: () {
            _showMessage(context, 'Payment Method');
          },
        ),
      ],
    );
  }

  Widget _buildThirdSection(BuildContext context) {
    return _section(
      children: [
        MenuItemWidget(
          icon: Icons.help_outline,
          title: 'FAQs',
          onTap: () {
            _showMessage(context, 'FAQs');
          },
        ),

        MenuItemWidget(
          icon: Icons.grid_3x3,
          title: 'User Reviews',
          onTap: () {
            _showMessage(context, 'User Reviews');
          },
        ),

        MenuItemWidget(
          icon: Icons.settings_outlined,
          title: 'Settings',
          onTap: () {
            _showMessage(context, 'Settings');
          },
        ),
      ],
    );
  }

  Widget _buildLogout(BuildContext context) {
    return _section(
      children: [
        MenuItemWidget(
          icon: Icons.logout,
          title: 'Log Out',
          onTap: () {
            _showLogoutDialog(context);
          },
        ),
      ],
    );
  }

  Widget _section({
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8FA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  void _showMessage(
      BuildContext context,
      String title,
      ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title clicked'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _showMore(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return const SizedBox(
          height: 150,
          child: Center(
            child: Text(
              'Profile Options',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Log Out',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          content: const Text(
            'Are you sure you want to log out?',
            style: TextStyle(
              fontSize: 11,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Logged out'),
                  ),
                );
              },
              child: const Text(
                'LOG OUT',
                style: TextStyle(
                  color: Color(0xFFFF7622),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}