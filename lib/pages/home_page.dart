import 'package:flutter/material.dart';
import 'package:khutbah_finder_app/models/khutbah.dart';
import 'khutbah_details_page.dart';

// Mock data
final List<Khutbah> allKhutbahs = [
  Khutbah(
    title: 'The Virtue of Silence',
    mosque: 'Al-Masjid Al-Haram',
    speaker: 'Sheikh Dr. Abdul Rahman Al-Sudais',
    date: 'May 9, 2025',
    topic: 'Silence',
    transcript: 'Sheikh Al-Sudais emphasized the value of silence as a sign of wisdom. He reminded the congregation of the Hadith: "Whoever believes in Allah and the Last Day should speak good or remain silent." The khutbah encouraged reflection and control over one’s speech to avoid harm and promote peace.',
  ),
  Khutbah(
    title: 'The Virtues of Patience and Trust in Allah',
    mosque: 'Al-Masjid An-Nabawi',
    speaker: 'Sheikh Dr. Abdul Bari bin Awwad Ath-Thubaity',
    date: 'May 9, 2025',
    topic: 'Patience',
    transcript: 'In this khutbah, Sheikh Ath-Thubaity spoke about the rewards of patience and placing trust in Allah. He explained that these qualities lead to peace and strength in hardship, referencing stories from the lives of the Prophets as examples.',
  ),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String? selectedMosque;
  String? selectedTopic;
  String? selectedSpeaker;
  String? selectedDate;

  List<String> get mosques =>
      allKhutbahs.map((k) => k.mosque).toSet().toList();
  List<String> get topics =>
      allKhutbahs.map((k) => k.topic).toSet().toList();
  List<String> get speakers =>
      allKhutbahs.map((k) => k.speaker).toSet().toList();
  List<String> get dates =>
      allKhutbahs.map((k) => k.date).toSet().toList();

  @override
  Widget build(BuildContext context) {
    List<Khutbah> filtered = allKhutbahs.where((k) {
      final matchesSearch = _searchController.text.isEmpty ||
          k.title.toLowerCase().contains(_searchController.text.toLowerCase());
      final matchesMosque = selectedMosque == null || k.mosque == selectedMosque;
      final matchesSpeaker = selectedSpeaker == null || k.speaker == selectedSpeaker;
      final matchesTopic = selectedTopic == null || k.topic == selectedTopic;
      final matchesDate = selectedDate == null || k.date == selectedDate;
      return matchesSearch &&
          matchesMosque &&
          matchesSpeaker &&
          matchesTopic &&
          matchesDate;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'AI-Powered Khutbah Finder App',
          style: TextStyle(
            color: Color(0xFF1E4D2B),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Search khutbahs...',
                prefixIcon: const Icon(Icons.search, color: Color(0xFF6E6E6E)),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFF1E4D2B)),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _dropdownBox('Mosque', mosques, selectedMosque, (val) {
                    setState(() => selectedMosque = val);
                  }),
                  _dropdownBox('Speaker', speakers, selectedSpeaker, (val) {
                    setState(() => selectedSpeaker = val);
                  }),
                  _dropdownBox('Topic', topics, selectedTopic, (val) {
                    setState(() => selectedTopic = val);
                  }),
                  _dropdownBox('Date', dates, selectedDate, (val) {
                    setState(() => selectedDate = val);
                  }),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Results',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color(0xFF2E2E2E),
              ),
            ),
            const SizedBox(height: 12),
            ...filtered.map(_buildKhutbahCard).toList(),
          ],
        ),
      ),
    );
  }

  Widget _dropdownBox(
    String label,
    List<String> items,
    String? value,
    ValueChanged<String?> onChanged,
  ) {
    return Container(
      width: 160,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        value: value,
        hint: Text(label, overflow: TextOverflow.ellipsis),
        items: [
          DropdownMenuItem(value: null, child: Text('All $label')),
          ...items.map((item) => DropdownMenuItem(value: item, child: Text(item))),
        ],
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF1E4D2B)),
          ),
        ),
        icon: const Icon(Icons.arrow_drop_down),
      ),
    );
  }

  Widget _buildKhutbahCard(Khutbah khutbah) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x15000000),
            offset: Offset(0, 2),
          )
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            khutbah.title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color(0xFF2E2E2E),
            ),
          ),
          const SizedBox(height: 8),
          Text('🕌  ${khutbah.mosque}',
              style: const TextStyle(color: Color(0xFF6E6E6E))),
          Text('🎙️  ${khutbah.speaker}',
              style: const TextStyle(color: Color(0xFF6E6E6E))),
          Text('📅  ${khutbah.date}',
              style: const TextStyle(color: Color(0xFF6E6E6E))),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KhutbahDetailsPage(khutbah: khutbah),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E4D2B),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              ),
              child: const Text('View'),
            ),
          )
        ],
      ),
    );
  }
}
