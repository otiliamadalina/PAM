import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/cubit/fitness_cubit.dart';
import 'data/fitness_repository.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness API App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F5F7),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => FitnessCubit(FitnessRepositoryImpl())..load(),
        child: const HomeScreen(),
      ),
    );
  }
}
