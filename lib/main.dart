import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/learning/home_screen.dart';

void main() {
  runApp(const SCITrainingApp());
}

class SCITrainingApp extends StatelessWidget {
  const SCITrainingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SCI Training',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
