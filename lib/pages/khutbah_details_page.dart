import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../models/khutbah.dart';

class KhutbahDetailsPage extends StatefulWidget {
  final Khutbah khutbah;

  const KhutbahDetailsPage({super.key, required this.khutbah});

  @override
  State<KhutbahDetailsPage> createState() => _KhutbahDetailsPageState();
}

class _KhutbahDetailsPageState extends State<KhutbahDetailsPage> {
  late YoutubePlayerController _youtubeController;
  late String _selectedLanguage;
  bool _hasVideo = false;

  // For AI Summary
  String? _aiSummaryMessage;
  bool _isLoadingSummary = false;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = widget.khutbah.transcripts.keys.first;
    _initYoutubePlayer();
  }

  void _initYoutubePlayer() {
    final youtubeUrl = widget.khutbah.youtubeUrls[_selectedLanguage] ?? '';
    final videoId = YoutubePlayerController.convertUrlToId(youtubeUrl);

    if (videoId != null && videoId.isNotEmpty) {
      _hasVideo = true;
      _youtubeController = YoutubePlayerController.fromVideoId(
        videoId: videoId,
        autoPlay: false,
        params: const YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
          mute: false,
        ),
      );
    } else {
      _hasVideo = false;
    }
  }

  void _onLanguageChanged(String? lang) {
    if (lang == null || lang == _selectedLanguage) return;

    setState(() {
      _selectedLanguage = lang;
      if (_hasVideo) {
        _youtubeController.close();
      }
      _initYoutubePlayer();
    });
  }

  void _generateSummaryPlaceholder() {
    setState(() {
      _isLoadingSummary = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoadingSummary = false;
        _aiSummaryMessage = 'This feature is not available yet.';
      });
    });
  }

  @override
  void dispose() {
    if (_hasVideo) {
      _youtubeController.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final khutbah = widget.khutbah;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1E4D2B)),
        title: const Text(
          'Khutbah Details',
          style: TextStyle(
            color: Color(0xFF1E4D2B),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              khutbah.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E4D2B),
              ),
            ),
            const SizedBox(height: 12),
            _metaRow(Icons.person, khutbah.speaker),
            _metaRow(Icons.calendar_today, khutbah.date),
            _metaRow(Icons.location_on, khutbah.mosque),

            const SizedBox(height: 16),
            _sectionCard(
              title: 'Select Language',
              child: SizedBox(
                width: double.infinity,
                child: DropdownButton<String>(
                  value: _selectedLanguage,
                  isExpanded: true,
                  onChanged: _onLanguageChanged,
                  items: khutbah.transcripts.keys.map((lang) {
                    return DropdownMenuItem(
                      value: lang,
                      child: Text(lang),
                    );
                  }).toList(),
                ),
              ),
            ),

            const SizedBox(height: 8),
            _sectionCard(
              title: 'Transcript',
              child: Text(
                khutbah.transcripts[_selectedLanguage] ?? 'No transcript available.',
                style: const TextStyle(height: 1.5, color: Color(0xFF2E2E2E)),
              ),
            ),

            const SizedBox(height: 16),
            if (_hasVideo)
              _sectionCard(
                title: 'Listen to Khutbah',
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: YoutubePlayer(controller: _youtubeController),
                ),
              ),

            const SizedBox(height: 16),
            _sectionCard(
              title: 'AI Summary',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_aiSummaryMessage != null)
                    Text(
                      _aiSummaryMessage!,
                      style: const TextStyle(height: 1.5, color: Color(0xFF2E2E2E)),
                    )
                  else if (_isLoadingSummary)
                    const Center(child: CircularProgressIndicator())
                  else
                    const Text('No summary available.'),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.auto_awesome),
                      label: const Text('Generate Summary'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E4D2B),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: _isLoadingSummary ? null : _generateSummaryPlaceholder,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _metaRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFF6E6E6E)),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(color: Color(0xFF6E6E6E)))),
        ],
      ),
    );
  }

  Widget _sectionCard({required String title, required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(blurRadius: 4, color: Color(0x1A000000), offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E4D2B),
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
