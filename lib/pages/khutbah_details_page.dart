import 'package:flutter/material.dart';
import '../models/khutbah.dart';

class KhutbahDetailsPage extends StatefulWidget {
  final Khutbah khutbah;

  const KhutbahDetailsPage({super.key, required this.khutbah});

  @override
  State<KhutbahDetailsPage> createState() => _KhutbahDetailsPageState();
}

class _KhutbahDetailsPageState extends State<KhutbahDetailsPage> {
  String? selectedLanguage;

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
            /// Title + Icons
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    khutbah.title,
                    style: const TextStyle(
                      color: Color(0xFF1E4D2B),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    _circleIcon(Icons.bookmark_border),
                    const SizedBox(width: 12),
                    _circleIcon(Icons.share),
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),

            /// Metadata
            _metaRow(Icons.person, khutbah.speaker),
            _metaRow(Icons.calendar_today, khutbah.date),
            _metaRow(Icons.location_on, khutbah.mosque),
            const SizedBox(height: 16),

            /// Arabic Transcript
            _sectionCard(
              title: 'Arabic Transcript',
              child: Text(
                khutbah.transcript,
                style: const TextStyle(
                  color: Color(0xFF2E2E2E),
                  height: 1.5,
                ),
              ),
            ),

            /// Translation with Dropdown
            _sectionCard(
              title: 'Translation',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<String>(
                    value: selectedLanguage,
                    items: ['English', 'French', 'Spanish', 'Urdu']
                        .map((lang) => DropdownMenuItem(
                              value: lang,
                              child: Text(lang),
                            ))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedLanguage = val;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Select Language',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Color(0xFFE0E0E0)),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 14),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (selectedLanguage != null)
                    const Text(
                      '“In the name of Allah, the Most Gracious, the Most Merciful... Patience is one of the greatest virtues...”',
                      style: TextStyle(
                        color: Color(0xFF2E2E2E),
                        height: 1.5,
                      ),
                    ),
                ],
              ),
            ),

            /// Audio Player UI (Mock)
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF1E4D2B),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  _circleIcon(Icons.play_arrow, bgColor: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3FB984),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text('12:45', style: TextStyle(color: Colors.white)),
                  const SizedBox(width: 12),
                  _circleIcon(Icons.download_rounded, bgColor: Colors.white),
                ],
              ),
            ),

            /// Generate Summary Button
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E4D2B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const Text(
                  'Generate Summary',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),

            /// AI Summary
            _sectionCard(
              title: 'AI Summary',
              child: const Text(
                'This khutbah discusses the importance of patience (sabr) in Islam. The speaker explains the three types of patience...',
                style: TextStyle(
                  color: Color(0xFF2E2E2E),
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _metaRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFF6E6E6E)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Color(0xFF6E6E6E)),
            ),
          ),
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
          BoxShadow(
            blurRadius: 4,
            color: Color(0x1A000000),
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF1E4D2B),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _circleIcon(IconData icon, {Color bgColor = const Color(0xFFFFD580)}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: const Color(0xFF1E4D2B), size: 22),
    );
  }
}
