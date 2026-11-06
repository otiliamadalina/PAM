import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/fitness_cubit.dart';
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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FitnessCubit, FitnessState>(
      builder: (context, state) {
        if (state.status == FitnessStatus.loading || state.status == FitnessStatus.initial) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (state.status == FitnessStatus.error) {
          return Scaffold(body: Center(child: Text('Nu s-au putut încărca datele: ${state.errorMessage}')));
        }
        final data = state.data!;
        final workouts = state.visibleWorkouts;
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildHeader(data.date, data.greeting),
                const SizedBox(height: 20),
                ChallengeCard(title: data.challengeTitle, subtitle: data.challengeActivity, current: data.completed, total: data.total),
                const SizedBox(height: 28),
                _buildSectionHeader('Featured Plan'),
                const SizedBox(height: 14),
                SizedBox(
                  height: 144,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      if (data.plans.isNotEmpty)
                        PlanCard(
                          title: data.plans[0].title,
                          duration: data.plans[0].duration,
                          frequency: data.plans[0].frequency,
                          imagePath: data.plans[0].imagePath,
                          color: const Color(0xFF4A4A4C),
                          width: 300,
                          imageAlignment: const Alignment(2, -1),
                          onStart: () {},
                        ),
                      if (data.plans.length > 1) ...[
                        const SizedBox(width: 16),
                        PlanCard(
                          title: data.plans[1].title,
                          duration: data.plans[1].duration,
                          frequency: data.plans[1].frequency,
                          imagePath: data.plans[1].imagePath,
                          color: const Color(0xFF3C4A5C),
                          width: 300,
                          imageAlignment: const Alignment(1, -1),
                          onStart: () {},
                        ),
                      ],
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
                    itemCount: data.filters.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 8),
                    itemBuilder: (context, i) {
                      final selected = data.filters[i] == state.category;
                      return ChoiceChip(
                        label: Text(data.filters[i]),
                        selected: selected,
                        showCheckmark: false,
                        onSelected: (_) => context.read<FitnessCubit>().categoryChanged(data.filters[i]),
                        selectedColor: AppColors.green,
                        labelStyle: TextStyle(color: selected ? Colors.white : Colors.grey.shade600, fontWeight: FontWeight.w600),
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
                  itemCount: workouts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 14, crossAxisSpacing: 14, childAspectRatio: 0.9),
                  itemBuilder: (context, i) {
                    final workout = workouts[i];
                    return WorkoutCard(
                      title: workout.title,
                      kcal: workout.calories,
                      minutes: workout.durationMinutes,
                      imagePath: workout.imagePath,
                      color: const Color(0xFF000000),
                      isPro: workout.isPro,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FitnessDetailScreen(gym: data.gym))),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(String date, String greeting) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(date, style: const TextStyle(color: AppColors.grey, fontSize: 13)),
          const SizedBox(height: 4),
          Text(greeting, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ]),
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
