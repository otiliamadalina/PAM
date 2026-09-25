import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ChallengeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final int current;
  final int total;

  const ChallengeCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.current,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final progress = current / total;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      decoration: BoxDecoration(
        color: AppColors.dark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: const TextStyle(color: AppColors.grey, fontSize: 14)),
              const SizedBox(height: 6),
              Text(subtitle,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(
            width: 56,
            height: 56,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 5,
                  backgroundColor: Colors.white24,
                  valueColor: const AlwaysStoppedAnimation(AppColors.green), //creează o animație falsă, fixă — o valoare care nu se mai schimbă niciodată
                ),
                Text('$current/$total',
                    style: const TextStyle(
                        color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}