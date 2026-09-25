import 'package:flutter/material.dart';

import '../../features/home/presentation/pages/home_page.dart';
import '../../features/my_orders/presentation/pages/my_orders_page.dart';
import '../../features/cart/presentation/pages/cart_page.dart';
import '../../features/profile/presentation/pages/menu_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  final List<Widget> screens = [
    const HomePage(),
    const MyOrdersPage(),
    const MyCartPage(),
    const MenuPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: navigatorKey,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (_) => screens[currentIndex],
          );
        },
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBottomBar() {
    return SafeArea(
      child: Container(
        height: 65,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildItem(
              icon: Icons.home_outlined,
              index: 0,
            ),
            _buildItem(
              icon: Icons.receipt_long_outlined,
              index: 1,
            ),
            _buildItem(
              icon: Icons.shopping_cart_outlined,
              index: 2,
            ),
            _buildItem(
              icon: Icons.person_outline,
              index: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem({
    required IconData icon,
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });

        navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => screens[index],
          ),
              (route) => false,
        );
      },
      child: SizedBox(
        width: 55,
        height: 55,
        child: Center(
          child: Icon(
            icon,
            size: 23,
            color: currentIndex == index
                ? const Color(0xFFFF7622)
                : const Color(0xFFB5BBC5),
          ),
        ),
      ),
    );
  }
}