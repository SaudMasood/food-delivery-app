import 'package:flutter/material.dart';

class DeliveryManCallPage
    extends StatelessWidget {
  const DeliveryManCallPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration:
                BoxDecoration(
                  color:
                  const Color(
                    0xFF526A7E,
                  ),
                  borderRadius:
                  BorderRadius.circular(
                    12,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 22,
                      left: 18,
                      child:
                      _backButton(
                        context,
                      ),
                    ),

                    Center(
                      child: Container(
                        width: 52,
                        height: 52,
                        decoration:
                        const BoxDecoration(
                          color:
                          Color(
                            0xFF9BAFC0,
                          ),
                          shape:
                          BoxShape
                              .circle,
                        ),
                      ),
                    ),

                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child:
                      _buildCallPanel(
                        context,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _backButton(
      BuildContext context,
      ) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: 24,
        height: 24,
        decoration:
        const BoxDecoration(
          color: Color(0xFF111122),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
          size: 10,
        ),
      ),
    );
  }

  Widget _buildCallPanel(
      BuildContext context,
      ) {
    return Container(
      height: 185,
      padding:
      const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.only(
          topLeft:
          Radius.circular(14),
          topRight:
          Radius.circular(14),
        ),
      ),
      child: Column(
        children: [
          const Text(
            'Robert Fox',
            style: TextStyle(
              fontSize: 10,
              fontWeight:
              FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          const Text(
            'Connecting......',
            style: TextStyle(
              fontSize: 7,
              color:
              Color(0xFF9BA5BC),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [
              _roundButton(
                Icons.mic_off,
                Colors.grey,
              ),
              const SizedBox(width: 18),
              _roundButton(
                Icons.call,
                const Color(
                  0xFFFF493D,
                ),
                size: 58,
              ),
              const SizedBox(width: 18),
              _roundButton(
                Icons.volume_up,
                Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _roundButton(
      IconData icon,
      Color color, {
        double size = 34,
      }) {
    return Container(
      width: size,
      height: size,
      decoration:
      BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 15,
      ),
    );
  }
}