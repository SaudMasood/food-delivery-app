import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/tracking_bloc.dart';
import '../bloc/tracking_event.dart';
import '../bloc/tracking_state.dart';
import 'delivery_man_call_page.dart';
import 'delivery_man_message_page.dart';

class TrackingOrderPage extends StatelessWidget {
  const TrackingOrderPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      TrackingBloc()..add(LoadTracking()),
      child: const TrackingOrderView(),
    );
  }
}

class TrackingOrderView
    extends StatelessWidget {
  const TrackingOrderView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xFFF5F5F5),
      body: SafeArea(
        child: BlocBuilder<
            TrackingBloc,
            TrackingState>(
          builder: (context, state) {
            if (state is! TrackingLoaded) {
              return const Center(
                child:
                CircularProgressIndicator(),
              );
            }

            return Padding(
              padding:
              const EdgeInsets.all(8),
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        _buildMap(
                          context,
                        ),

                        Positioned(
                          top: 18,
                          left: 18,
                          child: _backButton(
                            context,
                          ),
                        ),

                        Positioned(
                          top: 30,
                          right: 55,
                          child:
                          _buildLocation(),
                        ),

                        if (state.showDetails)
                          _buildDetails(
                            context,
                            state,
                          )
                        else
                          _buildSmallOrder(
                            context,
                            state,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMap(
      BuildContext context,
      ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFD3DEE7),
        borderRadius:
        BorderRadius.circular(12),
      ),
      child: CustomPaint(
        painter: RoutePainter(),
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

  Widget _buildLocation() {
    return Container(
      width: 22,
      height: 22,
      decoration:
      const BoxDecoration(
        color: Color(0xFFFFB31A),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.location_on,
        color: Colors.white,
        size: 13,
      ),
    );
  }

  Widget _buildSmallOrder(
      BuildContext context,
      TrackingLoaded state,
      ) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: GestureDetector(
        onTap: () {
          context
              .read<TrackingBloc>()
              .add(
            ShowTrackingDetails(),
          );
        },
        child: Container(
          height: 78,
          padding:
          const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius:
            BorderRadius.only(
              topLeft:
              Radius.circular(12),
              topRight:
              Radius.circular(12),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration:
                BoxDecoration(
                  color:
                  const Color(0xFF9BAFC0),
                  borderRadius:
                  BorderRadius.circular(
                    5,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    state.order.restaurant,
                    style:
                    const TextStyle(
                      fontSize: 9,
                      fontWeight:
                      FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    state.order.orderTime,
                    style:
                    const TextStyle(
                      fontSize: 6,
                      color: Color(
                        0xFF9BA5BC,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    state.order.items,
                    style:
                    const TextStyle(
                      fontSize: 6,
                      color: Color(
                        0xFF555555,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetails(
      BuildContext context,
      TrackingLoaded state,
      ) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 280,
        padding:
        const EdgeInsets.fromLTRB(
          14,
          12,
          14,
          10,
        ),
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
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 32,
                height: 3,
                decoration:
                BoxDecoration(
                  color:
                  const Color(
                    0xFFD9E0E6,
                  ),
                  borderRadius:
                  BorderRadius.circular(
                    3,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration:
                  BoxDecoration(
                    color:
                    const Color(
                      0xFF9BAFC0,
                    ),
                    borderRadius:
                    BorderRadius
                        .circular(5),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
                  children: [
                    Text(
                      state.order
                          .restaurant,
                      style:
                      const TextStyle(
                        fontSize: 9,
                        fontWeight:
                        FontWeight.w500,
                      ),
                    ),
                    Text(
                      state.order
                          .orderTime,
                      style:
                      const TextStyle(
                        fontSize: 6,
                        color: Color(
                          0xFF9BA5BC,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            const Center(
              child: Text(
                '20 min',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),

            const Center(
              child: Text(
                'ESTIMATED DELIVERY TIME',
                style: TextStyle(
                  fontSize: 6,
                  color: Color(
                    0xFF9BA5BC,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            _step(
              'Your order has been received',
              true,
            ),

            _step(
              'The restaurant is preparing your food',
              true,
            ),

            _step(
              'Your order has been picked up for delivery',
              false,
            ),

            _step(
              'Order arriving soon!',
              false,
            ),

            const Spacer(),

            Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration:
                  const BoxDecoration(
                    color:
                    Color(0xFF9BAFC0),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                const Column(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
                  children: [
                    Text(
                      'Robert F.',
                      style:
                      TextStyle(
                        fontSize: 9,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Courier',
                      style:
                      TextStyle(
                        fontSize: 6,
                        color: Color(
                          0xFF9BA5BC,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                _actionButton(
                  Icons.phone,
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                        const DeliveryManCallPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 8),
                _actionButton(
                  Icons.chat,
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                        const DeliveryManMessagePage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _step(
      String text,
      bool active,
      ) {
    return Padding(
      padding:
      const EdgeInsets.only(
        bottom: 8,
      ),
      child: Row(
        children: [
          Icon(
            Icons.radio_button_checked,
            color: active
                ? const Color(
              0xFFFF7622,
            )
                : const Color(
              0xFFBFC4C9,
            ),
            size: 10,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 6,
              color: active
                  ? const Color(
                0xFFFF7622,
              )
                  : const Color(
                0xFFB0B5BA,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(
      IconData icon,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration:
        const BoxDecoration(
          color: Color(0xFFFF7622),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 14,
        ),
      ),
    );
  }
}

class RoutePainter extends CustomPainter {
  @override
  void paint(
      Canvas canvas,
      Size size,
      ) {
    final paint = Paint()
      ..color = const Color(
        0xFFFF7622,
      )
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();

    path.moveTo(
      size.width * .20,
      size.height * .70,
    );

    path.lineTo(
      size.width * .30,
      size.height * .58,
    );

    path.lineTo(
      size.width * .25,
      size.height * .48,
    );

    path.lineTo(
      size.width * .34,
      size.height * .38,
    );

    path.lineTo(
      size.width * .72,
      size.height * .25,
    );

    canvas.drawPath(
      path,
      paint,
    );

    canvas.drawCircle(
      Offset(
        size.width * .20,
        size.height * .70,
      ),
      13,
      Paint()
        ..color =
        const Color(0xFFFF493D),
    );

    canvas.drawCircle(
      Offset(
        size.width * .72,
        size.height * .25,
      ),
      4,
      Paint()
        ..color =
        const Color(0xFFFFB31A),
    );
  }

  @override
  bool shouldRepaint(
      covariant CustomPainter oldDelegate,
      ) {
    return false;
  }
}