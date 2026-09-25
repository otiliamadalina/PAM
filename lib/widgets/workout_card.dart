import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class WorkoutCard extends StatelessWidget {
  final String title;
  final int kcal;
  final int minutes;
  final String? imagePath;
  final Color color;
  final bool isPro;
  final VoidCallback? onTap;

  const WorkoutCard({
    super.key,
    required this.title,
    required this.kcal,
    required this.minutes,
    this.imagePath,
    this.color = const Color(0xFF6B6B6B),
    this.isPro = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: color,
              child: imagePath != null
                  ? Image.asset(imagePath!, fit: BoxFit.cover)
                  : null,
            ),

            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.05),
                    Colors.black.withValues(alpha: 0.85),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(14),
              child: Stack(
                children: [
                  if (isPro)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 48,
                        height: 22,
                        padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE9F9EF),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.workspace_premium,
                                color: AppColors.green, size: 13),
                            const SizedBox(width: 3),
                            Text(
                              'Pro',
                              style: GoogleFonts.plusJakartaSans(
                                color: AppColors.green,
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          height: 1.3,
                          letterSpacing: -0.32,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.local_fire_department,
                                  color: Colors.white70, size: 14),
                              const SizedBox(width: 3),
                              Text(
                                '$kcal kcal',
                                style: GoogleFonts.plusJakartaSans(
                                  color: Colors.white, // ← alb pur, nu gri
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  height: 1.55,
                                  letterSpacing: -0.22,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.timer,
                                  color: Colors.white70, size: 14),
                              const SizedBox(width: 3),
                              Text(
                                '$minutes min',
                                style: GoogleFonts.plusJakartaSans(
                                  color: Colors.white, // ← alb pur
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  height: 1.55,
                                  letterSpacing: -0.22,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}