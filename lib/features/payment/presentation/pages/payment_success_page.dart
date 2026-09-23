import 'package:flutter/material.dart';
import 'package:food_delevery_app/features/tracking/presentation/pages/tracking_order_page.dart';

class PaymentSuccessPage
    extends StatelessWidget {
  const PaymentSuccessPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding:
          const EdgeInsets.all(8),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                Container(
                  width: 94,
                  height: 94,
                  decoration: BoxDecoration(
                    color:
                    const Color(0xFF9BAFC0),
                    borderRadius:
                    BorderRadius.circular(14),
                  ),
                child: Image.asset(
                  'assets/images/payment_success.png',
                  width: 104,
                  height: 104,
                  fit: BoxFit.cover,
                ),
                ),

                const SizedBox(height: 18),

                const Text(
                  'Congratulations!',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'You successfully maked a payment,\nenjoy our service!',
                  textAlign:
                  TextAlign.center,
                  style: TextStyle(
                    fontSize: 7,
                    color:
                    Color(0xFF9BA5BC),
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 35),

                Padding(
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const TrackingOrderPage();
                            },
                          ),
                        );

                      },
                      style:
                      ElevatedButton.styleFrom(
                        backgroundColor:
                        const Color(
                          0xFFFF7622,
                        ),
                        elevation: 0,
                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(
                            6,
                          ),
                        ),
                      ),
                      child: const Text(
                        'TRACK ORDER',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}