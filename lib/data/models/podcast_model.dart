class PodcastEpisode {
  final String id;
  final String title;
  final String description;
  final String moduleId;
  final String assetPath;

  const PodcastEpisode({
    required this.id,
    required this.title,
    required this.description,
    required this.moduleId,
    required this.assetPath,
  });
}

class PodcastData {
  static const List<PodcastEpisode> episodes = [
    // Placeholder — audio files to be added via NotebookLM handoff
  ];
}
