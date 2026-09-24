import 'package:flutter/material.dart';

import '../../../../core/constants/mainscreen.dart';

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
    } else {
      _goToMainScreen();
    }
  }

  void skip() {
    _goToMainScreen();
  }

  void _goToMainScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const MainScreen(),
      ),
    );
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
          itemCount: images.length,
          onPageChanged: (index) {
            setState(() {
              currentPage = index;
            });
          },
          itemBuilder: (context, index) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final screenWidth = constraints.maxWidth;
                final screenHeight = constraints.maxHeight;

                return Column(
                  children: [
                    SizedBox(height: screenHeight * 0.12),

                    SizedBox(
                      width: screenWidth * 0.64,
                      height: screenHeight * 0.36,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          images[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.075),

                    Text(
                      titles[index],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF30313D),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.03),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
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

                    SizedBox(height: screenHeight * 0.045),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        images.length,
                            (dotIndex) {
                          return Container(
                            width: 6,
                            height: 6,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 4,
                            ),
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

                    const Spacer(),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: SizedBox(
                        width: double.infinity,
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
                            currentPage == 3
                                ? 'GET STARTED'
                                : 'NEXT',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),

                    SizedBox(
                      height: 55,
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
            );
          },
        ),
      ),
    );
  }
}