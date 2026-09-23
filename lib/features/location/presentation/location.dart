import 'package:flutter/material.dart';

import '../../home/presentation/pages/home_page.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 2),

              const Text(
                'Location Access',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFB5B5B5),
                  fontWeight: FontWeight.w400,
                ),
              ),

              const SizedBox(height: 12),

              Expanded(
                child: Center(
                  child: Container(
                    width: double.infinity,
                    height: 545,
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      118,
                      16,
                      0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/location.png',
                          width: 140,
                          height: 168,
                          fit: BoxFit.contain,
                        ),

                        const SizedBox(height: 62),

                        SizedBox(
                          width: double.infinity,
                          height: 41,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                  const HomePage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              const Color(0xFFFF7622),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(7),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'ACCESS LOCATION',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(width: 12),

                                Container(
                                  width: 22,
                                  height: 22,
                                  decoration:
                                  const BoxDecoration(
                                    color: Color(0xFFFF914D),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.location_on_outlined,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 25),

                        const Text(
                          'DFOOD WILL ACCESS YOUR LOCATION',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF737A98),
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.3,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          'ONLY WHILE USING THE APP',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF737A98),
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.3,
                          ),
                        ),
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
}