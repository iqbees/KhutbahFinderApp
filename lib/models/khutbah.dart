class Khutbah {
  final String title;
  final String mosque;
  final String speaker;
  final String date;
  final String topic;
  final Map<String, String> transcripts;
  final Map<String, String> youtubeUrls;
  final String? summary;

  Khutbah({
    required this.title,
    required this.mosque,
    required this.speaker,
    required this.date,
    required this.topic,
    required this.transcripts,
    required this.youtubeUrls,
    this.summary,
  });
}
