import 'package:flutter/material.dart';

class OrderTab extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const OrderTab({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected
                  ? const Color(0xFFFF7622)
                  : const Color(0xFFE8ECEF),
              width: selected ? 2 : 1,
            ),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              color: selected
                  ? const Color(0xFFFF7622)
                  : const Color(0xFF9BA5BC),
              fontWeight: selected
                  ? FontWeight.w600
                  : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}