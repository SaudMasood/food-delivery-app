import 'package:flutter/material.dart';

class DeliveryManCallPage extends StatefulWidget {
  const DeliveryManCallPage({super.key});

  @override
  State<DeliveryManCallPage> createState() =>
      _DeliveryManCallPageState();
}

class _DeliveryManCallPageState
    extends State<DeliveryManCallPage> {
  bool muted = false;
  bool speaker = false;
  bool calling = true;

  void _endCall() {
    setState(() {
      calling = false;
    });

    Future.delayed(
      const Duration(milliseconds: 500),
          () {
        if (mounted) {
          Navigator.pop(context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF526A7E),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              _buildBackButton(context),
              _buildProfile(),
              _buildCallPanel(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(
      BuildContext context,
      ) {
    return Positioned(
      top: 20,
      left: 18,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          width: 25,
          height: 25,
          decoration: const BoxDecoration(
            color: Color(0xFF1E1D27),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 10,
          ),
        ),
      ),
    );
  }

  Widget _buildProfile() {
    return const Center(
      child: CircleAvatar(
        radius: 31,
        backgroundColor: Color(0xFF9BAFC0),
      ),
    );
  }

  Widget _buildCallPanel() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 185,
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Column(
          children: [
            const Text(
              'Robert Fox',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 3),

            Text(
              calling ? 'Connecting......' : 'Call Ended',
              style: const TextStyle(
                fontSize: 7,
                color: Color(0xFF9BA5BC),
              ),
            ),

            const Spacer(),

            Row(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                _smallButton(
                  muted
                      ? Icons.mic_off
                      : Icons.mic,
                  muted
                      ? const Color(0xFFFF7622)
                      : const Color(0xFFE8EDF1),
                  muted
                      ? Colors.white
                      : Colors.black,
                      () {
                    setState(() {
                      muted = !muted;
                    });
                  },
                ),

                const SizedBox(width: 18),

                GestureDetector(
                  onTap: _endCall,
                  child: Container(
                    width: 64,
                    height: 64,
                    padding: const EdgeInsets.all(9),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFE8E3),
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF493D),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        calling
                            ? Icons.call
                            : Icons.call_end,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 18),

                _smallButton(
                  speaker
                      ? Icons.volume_up
                      : Icons.volume_off,
                  speaker
                      ? const Color(0xFFFF7622)
                      : const Color(0xFFE8EDF1),
                  speaker
                      ? Colors.white
                      : Colors.black,
                      () {
                    setState(() {
                      speaker = !speaker;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _smallButton(
      IconData icon,
      Color background,
      Color iconColor,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: background,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: 15,
        ),
      ),
    );
  }
}