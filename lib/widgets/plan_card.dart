import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PlanCard extends StatelessWidget {
  final String title;
  final String duration;
  final String frequency;
  final String? imagePath;
  final Color color;
  final double width;
  final Alignment imageAlignment;
  final VoidCallback? onStart;

  const PlanCard({
    super.key,
    required this.title,
    required this.duration,
    required this.frequency,
    this.imagePath,
    this.color = const Color(0xFF3A3A3C),
    this.width = 296,
    this.imageAlignment = Alignment.center,
    this.onStart,
  });

  // Card orizontal cu poza de fundal, titlu si buton Start Now
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 144,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color,
        image: imagePath != null
            ? DecorationImage(
          image: AssetImage(imagePath!),
          fit: BoxFit.cover,
          alignment: imageAlignment,
        )
            : null,
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withValues(alpha: 0.05),
              Colors.black.withValues(alpha: 0.75),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: const TextStyle(
                    color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            Row(
              children: [
                const Icon(Icons.headphones, color: Colors.white70, size: 16),
                const SizedBox(width: 6),
                Text('$duration • $frequency',
                    style: const TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(6),
                onTap: onStart,
                child: Container(
                  height: 32,
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF0D0D12).withValues(alpha: 0.06),
                        offset: const Offset(0, 1),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: const Text(
                    'Start Now',
                    style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}