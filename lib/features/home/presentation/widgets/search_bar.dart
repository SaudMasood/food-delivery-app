import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;

  const SearchBarWidget({
    super.key,
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        absorbing: onTap != null,
        child: Container(
          height: 43,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            onChanged: onChanged,
            decoration: const InputDecoration(
              hintText: 'Search dishes, restaurants',
              hintStyle: TextStyle(
                fontSize: 10,
                color: Color(0xFF9BA5BC),
              ),
              prefixIcon: Icon(
                Icons.search,
                size: 17,
                color: Color(0xFF9BA5BC),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}