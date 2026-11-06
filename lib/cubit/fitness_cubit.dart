import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/fitness_repository.dart';
import '../models/fitness_models.dart';

enum FitnessStatus { initial, loading, success, empty, error }

class FitnessState {
  const FitnessState({this.status = FitnessStatus.initial, this.data, this.query = '', this.category = 'All Type', this.sortAscending = true, this.favorites = const {}, this.errorMessage});
  final FitnessStatus status;
  final FitnessData? data;
  final String query;
  final String category;
  final bool sortAscending;
  final Set<String> favorites;
  final String? errorMessage;

  FitnessState copyWith({FitnessStatus? status, FitnessData? data, String? query, String? category, bool? sortAscending, Set<String>? favorites, String? errorMessage}) => FitnessState(
        status: status ?? this.status, data: data ?? this.data, query: query ?? this.query, category: category ?? this.category,
        sortAscending: sortAscending ?? this.sortAscending, favorites: favorites ?? this.favorites, errorMessage: errorMessage ?? this.errorMessage);

  List<Workout> get visibleWorkouts {
    final items = data?.workouts.where((workout) {
      final matchesQuery = workout.title.toLowerCase().contains(query.toLowerCase());
      final matchesCategory = category == 'All Type' || workout.category == category;
      return matchesQuery && matchesCategory;
    }).toList() ?? <Workout>[];
    return items;
  }
}

class FitnessCubit extends Cubit<FitnessState> {
  FitnessCubit(this._repository) : super(const FitnessState());
  final FitnessRepository _repository;

  Future<void> load() async {
    emit(state.copyWith(status: FitnessStatus.loading));
    try {
      final data = await _repository.loadFitnessData();
      emit(state.copyWith(status: data.workouts.isEmpty ? FitnessStatus.empty : FitnessStatus.success, data: data));
    } catch (error) {
      emit(state.copyWith(status: FitnessStatus.error, errorMessage: error.toString()));
    }
  }

  void searchChanged(String value) => emit(state.copyWith(query: value));
  void categoryChanged(String value) => emit(state.copyWith(category: value));
  void toggleSort() => emit(state.copyWith(sortAscending: !state.sortAscending));
  void toggleFavorite(String id) {
    final favorites = {...state.favorites};
    favorites.contains(id) ? favorites.remove(id) : favorites.add(id);
    emit(state.copyWith(favorites: favorites));
  }
}
