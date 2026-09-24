import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/tracking_bloc.dart';
import '../bloc/tracking_event.dart';
import '../bloc/tracking_state.dart';
import 'delivery_man_call_page.dart';
import 'delivery_man_message_page.dart';

class TrackingOrderPage extends StatelessWidget {
  const TrackingOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TrackingBloc()..add(LoadTracking()),
      child: const TrackingView(),
    );
  }
}

class TrackingView extends StatelessWidget {
  const TrackingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD4E0E8),
      body: SafeArea(
        child: BlocBuilder<TrackingBloc, TrackingState>(
          builder: (context, state) {
            if (state is! TrackingLoaded) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Stack(
              children: [
                _buildMap(),
                _buildHeader(context),
                if (state.showDetails)
                  _buildDetails(context, state)
                else
                  _buildSmallOrder(context, state),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildMap() {
    return Positioned.fill(
      child: CustomPaint(
        painter: MapPainter(),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Positioned(
      top: 20,
      left: 18,
      right: 18,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Color(0xFF1E1D27),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 13,
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            'Track Order',
            style: TextStyle(
              fontSize: 8,
              color: Color(0xFF20242F),
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.my_location,
              size: 15,
              color: Color(0xFF20242F),
            ),
          ),
        ],
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
          context.read<TrackingBloc>().add(
            ShowTrackingDetails(),
          );
        },
        child: Container(
          height: 94,
          padding: const EdgeInsets.fromLTRB(
            14,
            8,
            14,
            10,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Column(
            children: [
              _buildHandle(),
              const SizedBox(height: 8),
              Row(
                children: [
                  _restaurantImage(),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Text(
                          state.order.restaurant,
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          state.order.orderTime,
                          style: const TextStyle(
                            fontSize: 6,
                            color: Color(0xFF9BA5BC),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          state.order.items,
                          style: const TextStyle(
                            fontSize: 6,
                            color: Color(0xFF555555),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_up,
                    size: 17,
                    color: Color(0xFF9BA5BC),
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
        padding: const EdgeInsets.fromLTRB(
          18,
          7,
          18,
          8,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            _buildHandle(),

            const SizedBox(height: 10),

            _buildRestaurantInfo(
              context,
              state,
            ),

            const SizedBox(height: 12),

            _buildDeliveryTime(),

            const SizedBox(height: 15),

            _buildTrackingSteps(),

            const SizedBox(height: 5),

            _buildCourierCard(context),

            const SizedBox(height: 3),
          ],
        ),
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      width: 38,
      height: 4,
      decoration: BoxDecoration(
        color: const Color(0xFFD5DDE3),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  Widget _buildRestaurantInfo(
      BuildContext context,
      TrackingLoaded state,
      ) {
    return Row(
      children: [
        _restaurantImage(
          width: 38,
          height: 38,
        ),
        const SizedBox(width: 9),
        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                state.order.restaurant,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                state.order.orderTime,
                style: const TextStyle(
                  fontSize: 6,
                  color: Color(0xFF9BA5BC),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                state.order.items,
                style: const TextStyle(
                  fontSize: 6,
                  color: Color(0xFF9BA5BC),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            context.read<TrackingBloc>().add(
              HideTrackingDetails(),
            );
          },
          child: const Icon(
            Icons.keyboard_arrow_down,
            size: 17,
            color: Color(0xFF9BA5BC),
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryTime() {
    return const Column(
      children: [
        Text(
          '20 min',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 19,
            height: 1,
            fontWeight: FontWeight.bold,
            color: Color(0xFF20242F),
          ),
        ),
        SizedBox(height: 5),
        Text(
          'ESTIMATED DELIVERY TIME',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 6,
            height: 1,
            color: Color(0xFF9BA5BC),
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }

  Widget _buildTrackingSteps() {
    return Column(
      children: [
        _trackingStep(
          'Your order has been received',
          true,
          true,
        ),
        _trackingStep(
          'The restaurant is preparing your food',
          true,
          true,
        ),
        _trackingStep(
          'Your order has been picked up for delivery',
          false,
          true,
        ),
        _trackingStep(
          'Order arriving soon!',
          false,
          false,
        ),
      ],
    );
  }

  Widget _trackingStep(
      String text,
      bool active,
      bool showLine,
      ) {
    return SizedBox(
      height: 28,
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 16,
            height: 28,
            child: Stack(
              children: [
                if (showLine)
                  Positioned(
                    left: 7,
                    top: 10,
                    bottom: 0,
                    child: Container(
                      width: 2,
                      color: const Color(0xFFD0D5D9),
                    ),
                  ),

                Positioned(
                  left: 2,
                  top: 5,
                  child: Container(
                    width: 11,
                    height: 11,
                    decoration: BoxDecoration(
                      color: active
                          ? const Color(0xFFFF7622)
                          : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: active
                            ? const Color(0xFFFF7622)
                            : const Color(0xFFC8CDD2),
                        width: 1,
                      ),
                    ),
                    child: active
                        ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 7,
                    )
                        : null,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 5,
              ),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 7,
                  height: 1.1,
                  color: active
                      ? const Color(0xFFFF7622)
                      : const Color(0xFF9BA5BC),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourierCard(
      BuildContext context,
      ) {
    return Container(
      width: double.infinity,
      height: 67,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(
          color: const Color(0xFFE9E9E9),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Color(0xFFDDE5EB),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              size: 18,
              color: Color(0xFF8999A7),
            ),
          ),

          const SizedBox(width: 8),

          const Column(
            mainAxisAlignment:
            MainAxisAlignment.center,
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                'Robert F.',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Courier',
                style: TextStyle(
                  fontSize: 7,
                  color: Color(0xFF9BA5BC),
                ),
              ),
            ],
          ),

          const Spacer(),

          _courierButton(
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

          _courierButton(
            Icons.chat_bubble,
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
    );
  }

  Widget _courierButton(
      IconData icon,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: const Color(0xFFFF7622),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF7622)
                  .withOpacity(0.18),
              blurRadius: 8,
            ),
          ],
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 15,
        ),
      ),
    );
  }

  Widget _restaurantImage({
    double width = 55,
    double height = 55,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFE7EDF0),
        borderRadius: BorderRadius.circular(7),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Image.asset(
          'assets/images/rose_garden.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class MapPainter extends CustomPainter {
  @override
  void paint(
      Canvas canvas,
      Size size,
      ) {
    final road = Paint()
      ..color = const Color(0xFFE8EEF1)
      ..strokeWidth = 35
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final road2 = Paint()
      ..color = const Color(0xFFE3EAEE)
      ..strokeWidth = 24
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final route = Paint()
      ..color = const Color(0xFFFF9418)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path1 = Path();

    path1.moveTo(
      0,
      size.height * 0.35,
    );

    path1.cubicTo(
      size.width * 0.25,
      size.height * 0.25,
      size.width * 0.40,
      size.height * 0.50,
      size.width * 0.70,
      size.height * 0.32,
    );

    path1.cubicTo(
      size.width * 0.85,
      size.height * 0.23,
      size.width * 0.92,
      size.height * 0.38,
      size.width,
      size.height * 0.30,
    );

    canvas.drawPath(
      path1,
      road,
    );

    final path2 = Path();

    path2.moveTo(
      0,
      size.height * 0.72,
    );

    path2.cubicTo(
      size.width * 0.20,
      size.height * 0.62,
      size.width * 0.40,
      size.height * 0.78,
      size.width * 0.65,
      size.height * 0.65,
    );

    path2.cubicTo(
      size.width * 0.82,
      size.height * 0.56,
      size.width * 0.90,
      size.height * 0.68,
      size.width,
      size.height * 0.60,
    );

    canvas.drawPath(
      path2,
      road2,
    );

    final routePath = Path();

    routePath.moveTo(
      size.width * 0.15,
      size.height * 0.68,
    );

    routePath.cubicTo(
      size.width * 0.20,
      size.height * 0.58,
      size.width * 0.12,
      size.height * 0.47,
      size.width * 0.27,
      size.height * 0.39,
    );

    routePath.cubicTo(
      size.width * 0.40,
      size.height * 0.32,
      size.width * 0.55,
      size.height * 0.33,
      size.width * 0.72,
      size.height * 0.20,
    );

    canvas.drawPath(
      routePath,
      route,
    );

    _drawMarker(
      canvas,
      Offset(
        size.width * 0.15,
        size.height * 0.68,
      ),
      const Color(0xFFFF493D),
    );

    _drawMarker(
      canvas,
      Offset(
        size.width * 0.72,
        size.height * 0.20,
      ),
      const Color(0xFFFFB31A),
    );
  }

  void _drawMarker(
      Canvas canvas,
      Offset position,
      Color color,
      ) {
    canvas.drawCircle(
      position,
      11,
      Paint()..color = color,
    );

    canvas.drawCircle(
      position,
      4,
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(
      covariant CustomPainter oldDelegate,
      ) {
    return false;
  }
}