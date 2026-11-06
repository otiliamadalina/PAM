class Workout {
  const Workout({
    required this.id,
    required this.title,
    required this.category,
    required this.calories,
    required this.durationMinutes,
    required this.isPro,
    required this.imagePath,
  });

  final String id;
  final String title;
  final String category;
  final int calories;
  final int durationMinutes;
  final bool isPro;
  final String imagePath;

  factory Workout.fromJson(Map<String, dynamic> json) => Workout(
        id: json['id'] as String,
        title: json['title'] as String,
        category: json['category'] as String,
        calories: json['calories'] as int,
        durationMinutes: json['durationMinutes'] as int,
        isPro: json['isPro'] as bool,
        imagePath: json['imageUrl'] as String,
      );
}

class FeaturedPlan {
  const FeaturedPlan({required this.title, required this.duration, required this.frequency, required this.imagePath});
  final String title;
  final String duration;
  final String frequency;
  final String imagePath;

  factory FeaturedPlan.fromJson(Map<String, dynamic> json) => FeaturedPlan(
        title: json['title'] as String,
        duration: json['duration'] as String,
        frequency: json['frequency'] as String,
        imagePath: json['imageUrl'] as String,
      );
}

class Gym {
  const Gym({required this.name, required this.location, required this.heroImagePath, required this.rating, required this.reviewCount, required this.description, required this.amenities, required this.price});
  final String name;
  final String location;
  final String heroImagePath;
  final double rating;
  final int reviewCount;
  final String description;
  final List<String> amenities;
  final double price;

  factory Gym.fromJson(Map<String, dynamic> json) => Gym(
        name: json['name'] as String,
        location: json['location'] as String,
        heroImagePath: json['heroImageUrl'] as String,
        rating: (json['rating'] as num).toDouble(),
        reviewCount: json['reviewCount'] as int,
        description: json['description'] as String,
        amenities: (json['amenities'] as List).map((item) => (item as Map<String, dynamic>)['name'] as String).toList(),
        price: (json['pricing']['amount'] as num).toDouble(),
      );
}

class FitnessData {
  const FitnessData({required this.date, required this.greeting, required this.challengeTitle, required this.challengeActivity, required this.completed, required this.total, required this.plans, required this.filters, required this.workouts, required this.gym});
  final String date;
  final String greeting;
  final String challengeTitle;
  final String challengeActivity;
  final int completed;
  final int total;
  final List<FeaturedPlan> plans;
  final List<String> filters;
  final List<Workout> workouts;
  final Gym gym;

  factory FitnessData.fromJson(Map<String, dynamic> json) {
    final home = json['fitnessHomePage'] as Map<String, dynamic>;
    final header = home['header'] as Map<String, dynamic>;
    final challenge = home['todaysChallenge'] as Map<String, dynamic>;
    final programs = home['workoutPrograms'] as Map<String, dynamic>;
    return FitnessData(
      date: header['date'] as String,
      greeting: header['greeting'] as String,
      challengeTitle: challenge['title'] as String,
      challengeActivity: challenge['activity'] as String,
      completed: challenge['completed'] as int,
      total: challenge['total'] as int,
      plans: (home['featuredPlans'] as List).map((item) => FeaturedPlan.fromJson(item as Map<String, dynamic>)).toList(),
      filters: (programs['filters'] as List).map((item) => (item as Map<String, dynamic>)['name'] as String).toList(),
      workouts: (programs['items'] as List).map((item) => Workout.fromJson(item as Map<String, dynamic>)).toList(),
      gym: Gym.fromJson((json['fitnessGymDetailsPage'] as Map<String, dynamic>)['gym'] as Map<String, dynamic>),
    );
  }
}
