import 'package:flutter/material.dart';

enum InfographicCategory { flowchart, anatomy, summary }

class Infographic {
  final String id;
  final String title;
  final String description;
  final String assetPath;
  final InfographicCategory category;
  final String moduleId;
  final IconData icon;

  const Infographic({
    required this.id,
    required this.title,
    required this.description,
    required this.assetPath,
    required this.category,
    required this.moduleId,
    required this.icon,
  });
}
