import 'package:flutter_test/flutter_test.dart';
import 'package:laborator4/cubit/fitness_cubit.dart';
import 'package:laborator4/domain/entities/fitness_entities.dart';
import 'package:laborator4/domain/repositories/fitness_repository.dart';

class FakeFitnessRepository implements FitnessRepository {
  @override
  Future<FitnessData> getFitnessData() async {
    return const FitnessData(
      date: 'Friday, 20 May',
      greeting: 'Good Morning',
      notificationUnread: true,
      challengeTitle: 'Today',
      challengeActivity: 'Running',
      completed: 15,
      total: 20,
      progress: 0.75,
      plans: [],
      filters: ['All Type'],
      workouts: [
        Workout(
          id: '1',
          title: 'Yoga',
          category: 'Yoga',
          calories: 210,
          durationMinutes: 120,
          isPro: false,
          imageUrl: '',
        ),
      ],
      gym: Gym(
        name: 'Mid City Gym',
        location: 'California',
        heroImageUrl: '',
        rating: 4.5,
        reviewCount: 1232,
        description: 'Gym description',
        amenities: [],
        price: 69,
        period: 'week',
      ),
    );
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('loads fitness data and exposes the success state', () async {
    final cubit = FitnessCubit(FakeFitnessRepository());
    await cubit.load();
    expect(cubit.state.status, FitnessStatus.success);
    expect(cubit.state.data?.workouts, isNotEmpty);
    await cubit.close();
  });
}
