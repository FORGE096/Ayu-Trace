// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

/// A stateless widget that renders a blurred, glowing circular orb.
///
/// Typically used in Stack layouts to create a modern, glassmorphic
/// ambient background effect.
class GlowingOrb extends StatelessWidget {
  /// The base color of the glowing orb.
  final Color color;

  /// The diameter of the orb.
  final double size;
  const GlowingOrb({super.key, required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.3),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 100,
            spreadRadius: 50,
          ),
        ],
      ),
    );
  }
}
