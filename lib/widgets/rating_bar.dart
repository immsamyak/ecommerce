import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget {
  final double rating;
  final double size;
  final Color color;

  const RatingBar({
    super.key, // Updated to use super.key
    required this.rating,
    this.size = 16,
    this.color = Colors.amber,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          // Full star
          return Icon(
            Icons.star,
            color: color,
            size: size,
          );
        } else if (index == rating.floor() && rating % 1 > 0) {
          // Half star
          return Icon(
            Icons.star_half,
            color: color,
            size: size,
          );
        } else {
          // Empty star
          return Icon(
            Icons.star_border,
            color: color,
            size: size,
          );
        }
      }),
    );
  }
}
