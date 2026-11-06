import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/fitness_models.dart';

class FitnessRepository {

  Future<FitnessData> loadFitnessData() async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    final raw = await rootBundle.loadString('assets/data/fitness_data.json');
    return FitnessData.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }
}
