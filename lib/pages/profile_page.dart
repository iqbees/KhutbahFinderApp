import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String selectedLanguage = 'Arabic';
  String profileImageUrl = ''; // Replace with real image URL if available

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        toolbarHeight: 100,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Your Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),

            /// Profile Avatar
            GestureDetector(
              onTap: () {
                // Implement image picker if needed
              },
              child: CircleAvatar(
                radius: 50,
                backgroundColor: const Color(0xFFE0E0E0),
                backgroundImage:
                    profileImageUrl.isNotEmpty ? NetworkImage(profileImageUrl) : null,
                child: profileImageUrl.isEmpty
                    ? const Icon(Icons.person, size: 48, color: Color(0xFF1E4D2B))
                    : null,
              ),
            ),
            const SizedBox(height: 24),

            /// Language Dropdown
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DropdownButtonFormField<String>(
                value: selectedLanguage,
                items: ['Arabic', 'English', 'Urdu']
                    .map((lang) => DropdownMenuItem(
                          value: lang,
                          child: Text(lang),
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedLanguage = val!;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Choose a language...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ),

            const SizedBox(height: 24),

            /// Bookmarks Row
            GestureDetector(
              onTap: () {
                // Navigate to bookmarks page
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x22000000),
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    const Text(
                      'Show bookmarks',
                      style: TextStyle(fontSize: 16),
                    ),
                    const Spacer(),
                    Icon(Icons.arrow_forward_ios, color: Colors.grey.shade600, size: 16),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            /// Log Out Button
            ElevatedButton(
              onPressed: () {
                // Implement your logout logic here
                Navigator.pushReplacementNamed(context, '/authentication');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF1F4F8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(38),
                ),
                side: const BorderSide(color: Color(0xFFE0E3E7), width: 1),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text(
                'Log Out',
                style: TextStyle(color: Color(0xFF14181B)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
