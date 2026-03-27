import 'package:flutter/material.dart';

// --- Generic Block Types ---

sealed class ContentBlock {}

class HeaderBlock extends ContentBlock {
  final String title;
  HeaderBlock(this.title);
}

class TextBlock extends ContentBlock {
  final String text;
  final bool isIntro;
  TextBlock(this.text, {this.isIntro = false});
}

class PearlBlock extends ContentBlock {
  final String title;
  final String text;
  PearlBlock(this.title, this.text);
}

class BulletCardBlock extends ContentBlock {
  final String title;
  final Color themeColor;
  final Color backgroundColor;
  final List<String> points;
  BulletCardBlock({
    required this.title,
    required this.themeColor,
    required this.backgroundColor,
    required this.points,
  });
}

class NumberedListBlock extends ContentBlock {
  final List<MapEntry<String, String>> items;
  NumberedListBlock(this.items);
}

class TableBlock extends ContentBlock {
  final String title;
  final List<String> columns;
  final List<List<String>> rows;
  final Color? headerColor;
  TableBlock({
    required this.title,
    required this.columns,
    required this.rows,
    this.headerColor,
  });
}

class ComparisonCardBlock extends ContentBlock {
  final String title;
  final Color themeColor;
  final Color backgroundColor;
  final IconData icon;
  final String description;
  final List<String> keyPoints;

  ComparisonCardBlock({
    required this.title,
    required this.themeColor,
    required this.backgroundColor,
    required this.icon,
    required this.description,
    required this.keyPoints,
  });
}

class MnemonicBlock extends ContentBlock {
  final String mnemonic;
  final String explanation;
  MnemonicBlock(this.mnemonic, this.explanation);
}

class ScaleBlock extends ContentBlock {
  final String scaleName;
  final String description;
  final List<String> columns;
  final List<List<String>> rows;
  final String? boardPearl;
  ScaleBlock({
    required this.scaleName,
    required this.description,
    required this.columns,
    required this.rows,
    this.boardPearl,
  });
}

class MedicationCardBlock extends ContentBlock {
  final String name;
  final String drugClass;
  final String mechanism;
  final String indication;
  final String dosing;
  final String sideEffects;
  final String boardPearl;
  final bool isAvoid;

  MedicationCardBlock({
    required this.name,
    required this.drugClass,
    required this.mechanism,
    required this.indication,
    this.dosing = '',
    this.sideEffects = '',
    this.boardPearl = '',
    this.isAvoid = false,
  });
}

// --- Visual Content Blocks ---

class AnnotationPoint {
  final double x; // 0.0-1.0 relative to image width
  final double y; // 0.0-1.0 relative to image height
  final String label;
  final String description;
  final Color? color;
  const AnnotationPoint({
    required this.x,
    required this.y,
    required this.label,
    required this.description,
    this.color,
  });
}

class AnnotatedImageBlock extends ContentBlock {
  final String assetPath;
  final String caption;
  final List<AnnotationPoint> annotations;
  final String? description;
  AnnotatedImageBlock({
    required this.assetPath,
    required this.caption,
    this.annotations = const [],
    this.description,
  });
}

enum FlowchartNodeType { start, decision, action, outcome }

class FlowchartNode {
  final String id;
  final String text;
  final FlowchartNodeType type;
  final Color? color;
  const FlowchartNode({
    required this.id,
    required this.text,
    required this.type,
    this.color,
  });
}

class FlowchartEdge {
  final String fromId;
  final String toId;
  final String? label;
  const FlowchartEdge({
    required this.fromId,
    required this.toId,
    this.label,
  });
}

class FlowchartBlock extends ContentBlock {
  final String title;
  final List<FlowchartNode> nodes;
  final List<FlowchartEdge> edges;
  final String? description;
  FlowchartBlock({
    required this.title,
    required this.nodes,
    required this.edges,
    this.description,
  });
}

class ComparisonSide {
  final String title;
  final String? imagePath;
  final List<String> features;
  final Color themeColor;
  const ComparisonSide({
    required this.title,
    this.imagePath,
    required this.features,
    required this.themeColor,
  });
}

class ComparisonDiagramBlock extends ContentBlock {
  final String title;
  final ComparisonSide left;
  final ComparisonSide right;
  final String? description;
  ComparisonDiagramBlock({
    required this.title,
    required this.left,
    required this.right,
    this.description,
  });
}

// Enum for bespoke custom widgets
enum CustomWidgetType {
  asiaExamTool,
  dermatomalMap,
  myotomalMap,
  classificationTrainer,
  isncsciWorksheet,
  aisPractice,
  bladderManagementAlgorithm,
  bowelProgramAlgorithm,
  adManagementFlowchart,
  spasticityLadder,
  pressureInjuryStaging,
  functionalOutcomesChart,
  anatomyGallery,
}

class CustomWidgetBlock extends ContentBlock {
  final CustomWidgetType type;
  CustomWidgetBlock(this.type);
}

// --- Tab and Topic Containers ---

class TopicTab {
  final String title;
  final List<ContentBlock> blocks;

  TopicTab({required this.title, required this.blocks});
}

class TopicData {
  final String id;
  final String title;
  final List<TopicTab> tabs;

  TopicData({required this.id, required this.title, required this.tabs});
}
