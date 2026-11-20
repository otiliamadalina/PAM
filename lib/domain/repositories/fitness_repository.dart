import '../entities/fitness_entities.dart';

abstract class FitnessRepository {
  Future<FitnessData> getFitnessData();
}
