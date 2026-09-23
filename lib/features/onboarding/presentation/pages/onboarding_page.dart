import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController pageController = PageController();

  int currentPage = 0;

  final List<String> images = [
    'assets/images/onboarding_1.png',
    'assets/images/onboarding_2.png',
    'assets/images/onboarding_3.png',
    'assets/images/onboarding_4.png',
  ];

  final List<String> titles = [
    'All your favorites',
    'All your favorites',
    'Order from choosen chef',
    'Free delivery offers',
  ];

  final List<String> descriptions = [
    'Get all your loved foods in one once place,\nyou just place the order we do the rest',
    'Get all your loved foods in one once place,\nyou just place the order we do the rest',
    'Get all your loved foods in one once place,\nyou just place the order we do the rest',
    'Get all your loved foods in one once place,\nyou just place the order we do the rest',
  ];

  void nextPage() {
    if (currentPage < 3) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void skip() {
    pageController.jumpToPage(3);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: PageView.builder(
          controller: pageController,
          itemCount: 4,
          onPageChanged: (index) {
            setState(() {
              currentPage = index;
            });
          },
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Positioned(
                  top: 114,
                  left: 67,
                  width: 240,
                  height: 292,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      images[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Positioned(
                  top: 469,
                  left: 0,
                  right: 0,
                  child: Text(
                    titles[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF30313D),
                    ),
                  ),
                ),

                Positioned(
                  top: 516,
                  left: 20,
                  right: 20,
                  child: Text(
                    descriptions[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 10,
                      height: 1.5,
                      color: Color(0xFF6B6E80),
                    ),
                  ),
                ),

                Positioned(
                  top: 596,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      4,
                          (dotIndex) {
                        return Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: currentPage == dotIndex
                                ? const Color(0xFFFF7622)
                                : const Color(0xFFFFD9C7),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                Positioned(
                  top: 675,
                  left: 24,
                  right: 24,
                  height: 62,
                  child: ElevatedButton(
                    onPressed: nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF7622),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      currentPage == 3 ? 'GET STARTED' : 'NEXT',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: 750,
                  left: 0,
                  right: 0,
                  child: TextButton(
                    onPressed: skip,
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: Color(0xFF6B6E80),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}