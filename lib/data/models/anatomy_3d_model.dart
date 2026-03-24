/// Data model for 3D anatomy models hosted on Sketchfab.
class Anatomy3DModel {
  final String id;
  final String title;
  final String description;
  final String sketchfabId;
  final String attribution;
  final String moduleId;
  final List<String> relevantTopics;

  const Anatomy3DModel({
    required this.id,
    required this.title,
    required this.description,
    required this.sketchfabId,
    required this.attribution,
    required this.moduleId,
    required this.relevantTopics,
  });

  /// Sketchfab embed URL with dark theme and minimal UI.
  String get embedUrl =>
      'https://sketchfab.com/models/$sketchfabId/embed'
      '?autostart=1&ui_theme=dark&ui_infos=0&ui_controls=0'
      '&ui_stop=0&ui_watermark=0&ui_watermark_link=0';

  /// URL to open the model on the Sketchfab website.
  String get webUrl => 'https://sketchfab.com/3d-models/$sketchfabId';
}
