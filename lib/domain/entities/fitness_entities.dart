class Workout {
  const Workout({
    required this.id,
    required this.title,
    required this.category,
    required this.calories,
    required this.durationMinutes,
    required this.isPro,
    required this.imageUrl,
  });

  final String id;
  final String title;
  final String category;
  final int calories;
  final int durationMinutes;
  final bool isPro;
  final String imageUrl;
}

class FeaturedPlan {
  const FeaturedPlan({
    required this.id,
    required this.title,
    required this.duration,
    required this.frequency,
    required this.actionLabel,
    required this.imageUrl,
  });

  final String id;
  final String title;
  final String duration;
  final String frequency;
  final String actionLabel;
  final String imageUrl;
}

class GymAmenity {
  const GymAmenity({required this.name, required this.iconUrl});
  final String name;
  final String iconUrl;
}

class Gym {
  const Gym({
    required this.name,
    required this.location,
    required this.heroImageUrl,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.amenities,
    required this.price,
    required this.period,
  });

  final String name;
  final String location;
  final String heroImageUrl;
  final double rating;
  final int reviewCount;
  final String description;
  final List<GymAmenity> amenities;
  final double price;
  final String period;
}

class FitnessData {
  const FitnessData({
    required this.date,
    required this.greeting,
    required this.notificationUnread,
    required this.challengeTitle,
    required this.challengeActivity,
    required this.completed,
    required this.total,
    required this.progress,
    required this.plans,
    required this.filters,
    required this.workouts,
    required this.gym,
  });

  final String date;
  final String greeting;
  final bool notificationUnread;
  final String challengeTitle;
  final String challengeActivity;
  final int completed;
  final int total;
  final double progress;
  final List<FeaturedPlan> plans;
  final List<String> filters;
  final List<Workout> workouts;
  final Gym gym;
}
