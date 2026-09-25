import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/challenge_card.dart';
import '../widgets/plan_card.dart';
import '../widgets/workout_card.dart';
import 'fitness_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedFilter = 0;
  final filters = ['All Type', 'Pilates', 'Cardio', 'Boxing', 'Yoga'];

  final workouts = const [
    {'title': 'Yoga', 'category': 'Yoga', 'kcal': 210, 'minutes': 120, 'color': Color(0xFF000000), 'isPro': false, 'image': 'assets/images/woman-working-out-gym (3).jpg'},
    {'title': 'Arm Strengthening', 'category': 'Pilates', 'kcal': 210, 'minutes': 120, 'color': Color(0xFFF5F5F5), 'isPro': true, 'image': 'assets/images/woman-working-out-gym (5).jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    final filteredWorkouts = selectedFilter == 0
        ? workouts
        : workouts.where((w) => w['category'] == filters[selectedFilter]).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            const ChallengeCard(
              title: "Today's Challenge",
              subtitle: 'Running',
              current: 15,
              total: 20,
            ),
            const SizedBox(height: 28),
            _buildSectionHeader('Featured Plan'),
            const SizedBox(height: 14),
            SizedBox(
              height: 144,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  PlanCard(
                    title: 'Massive Upper Body',
                    duration: '5 week',
                    frequency: '4x/week',
                    imagePath: 'assets/images/young-fitness-man-studio.jpg',
                    color: const Color(0xFF4A4A4C),
                    width: 300,
                    imageAlignment: const Alignment(2, -1),
                    onStart: () {},
                  ),
                  const SizedBox(width: 16),
                  PlanCard(
                    title: 'Massive Lower Body',
                    duration: '6 week',
                    frequency: '3x/week',
                    imagePath: 'assets/images/young-fitness-man-studio.jpg',
                    color: const Color(0xFF3C4A5C),
                    width: 300,
                    imageAlignment: const Alignment(1, -1),
                    onStart: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            _buildSectionHeader('Workout Programs'),
            const SizedBox(height: 14),
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, i) {
                  final selected = i == selectedFilter;
                  return ChoiceChip(
                    label: Text(filters[i]),
                    selected: selected,
                    showCheckmark: false,
                    onSelected: (_) => setState(() => selectedFilter = i),
                    selectedColor: AppColors.green,
                    labelStyle: TextStyle(
                      color: selected ? Colors.white : Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: selected ? AppColors.green : Colors.grey.shade300),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredWorkouts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, i) {
                final w = filteredWorkouts[i];
                return WorkoutCard(
                  title: w['title'] as String,
                  kcal: w['kcal'] as int,
                  minutes: w['minutes'] as int,
                  imagePath: w['image'] as String?,
                  color: w['color'] as Color,
                  isPro: w['isPro'] as bool,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const FitnessDetailScreen()),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Friday, 20 May', style: TextStyle(color: AppColors.grey, fontSize: 13)),
            SizedBox(height: 4),
            Text('Good Morning', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
        Container(
          width: 44,
          height: 44,
          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: const Icon(Icons.notifications_none, color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const Text('See All', style: TextStyle(color: AppColors.green, fontWeight: FontWeight.w600)),
      ],
    );
  }
}