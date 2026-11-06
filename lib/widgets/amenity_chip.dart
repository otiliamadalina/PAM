import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AmenityChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const AmenityChip({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: const Color (0xFFF0F3F5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFDFE1E7),
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
            color: const Color(0xFF6B7280),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }
}