import '../../domain/entities/fitness_entities.dart';
import '../../domain/repositories/fitness_repository.dart';
import '../datasources/fitness_remote_data_source.dart';

class FitnessRepositoryImpl implements FitnessRepository {
  FitnessRepositoryImpl({FitnessRemoteDataSource? remoteDataSource})
      : _remoteDataSource = remoteDataSource ?? FitnessRemoteDataSource();

  final FitnessRemoteDataSource _remoteDataSource;

  @override
  Future<FitnessData> getFitnessData() async {
    final results = await Future.wait([
      _remoteDataSource.fetchFeed(),
      _remoteDataSource.fetchDetails(),
    ]);
    return _mapToEntity(results[0], results[1]);
  }

  FitnessData _mapToEntity(
    Map<String, dynamic> feed,
    Map<String, dynamic> details,
  ) {
    final header = _map(feed['header']);
    final challenge = _map(feed['todaysChallenge']);
    final programs = _map(feed['workoutPrograms']);
    final gymData = _map(details['gym']);
    final pricing = _map(gymData['pricing']);

    final planItems = _list(feed['featuredPlans']);
    final filterItems = _list(programs['filters']);
    final workoutItems = _list(programs['items']);
    final amenityItems = _list(gymData['amenities']);

    return FitnessData(
      date: _string(header['date']),
      greeting: _string(header['greeting']),
      notificationUnread:
          _map(header['notification'])['hasUnread'] == true,
      challengeTitle: _string(challenge['title']),
      challengeActivity: _string(challenge['activity']),
      completed: _int(challenge['completed']),
      total: _int(challenge['total']),
      progress: _double(challenge['progress']),
      plans: planItems.asMap().entries.map((entry) {
        final item = entry.value;
        final index = entry.key;
        final json = _map(item);
        return FeaturedPlan(
          id: _string(json['id']),
          title: _string(json['title']),
          duration: _string(json['duration']),
          frequency: _string(json['frequency']),
          actionLabel: _string(json['actionLabel']),
          imageUrl: index == 0
              ? 'assets/images/young-fitness-man-studio.jpg'
              : 'assets/images/2.jpg',
        );
      }).toList(),
      filters: filterItems.map((item) => _string(_map(item)['name'])).toList(),
      workouts: workoutItems.take(2).toList().asMap().entries.map((entry) {
        final item = entry.value;
        final index = entry.key;
        final json = _map(item);
        final title = _string(json['title']);
        final category = title.toLowerCase().contains('yoga')
            ? 'Yoga'
            : title.toLowerCase().contains('cardio')
                ? 'Cardio'
                : title.toLowerCase().contains('box')
                    ? 'Boxing'
                : title.toLowerCase().contains('pilates')
                        ? 'Pilates'
                        : 'All Type';
        return Workout(
          id: _string(json['id']),
          title: title,
          category: category,
          calories: _int(json['calories']),
          durationMinutes: _int(json['durationMinutes']),
          isPro: json['isPro'] == true,
          imageUrl: index == 0
              ? 'assets/images/woman-working-out-gym (3).jpg'
              : index == 1
                  ? 'assets/images/woman-working-out-gym (5).jpg'
                  : 'assets/images/woman-working-out-gym (3).jpg',
        );
      }).toList(),
      gym: Gym(
        name: _string(gymData['name']),
        location: _string(gymData['location']),
        heroImageUrl: 'assets/images/2.jpg',
        rating: _double(gymData['rating']),
        reviewCount: _int(gymData['reviewCount']),
        description: _string(gymData['description']),
        amenities: amenityItems.map((item) {
          final json = _map(item);
          return GymAmenity(
            name: _string(json['name']),
            iconUrl: _string(json['iconUrl']),
          );
        }).toList(),
        price: _double(pricing['amount']),
        period: _string(pricing['period']),
      ),
    );
  }

  Map<String, dynamic> _map(dynamic value) =>
      value is Map<String, dynamic> ? value : <String, dynamic>{};

  List<dynamic> _list(dynamic value) =>
      value is List ? value : <dynamic>[];

  String _string(dynamic value) => value?.toString() ?? '';

  int _int(dynamic value) => value is num ? value.toInt() : 0;

  double _double(dynamic value) => value is num ? value.toDouble() : 0;
}
