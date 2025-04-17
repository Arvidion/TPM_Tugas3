import 'package:flutter/material.dart';

class MembersPage extends StatelessWidget {
  const MembersPage({super.key});

  @override
  Widget build(BuildContext context) {
    // List of team members with their details
    final List<Map<String, dynamic>> members = [
      {
        'name': 'Arjikusna Maharjanta',
        'nim': '123220072',
        'role': 'Jungler',
        'avatar': 'A',
        'color': Colors.blue[700],
      },
      {
        'name': 'Arvidion Havas Oktavian',
        'nim': '123220067',
        'role': 'Explaner',
        'avatar': 'A',
        'color': Colors.green[700],
      },
      {
        'name': 'Muhammad Oscar Fileas Jakaria',
        'nim': '123220096',
        'role': 'Midlaner',
        'avatar': 'M',
        'color': Colors.orange[700],
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Header section with style similar to homepage
              Text(
                'Anggota Kelompok',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Daftar anggota kelompok kami',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 40),
              
              // Members list
              Expanded(
                child: ListView.builder(
                  itemCount: members.length,
                  itemBuilder: (context, index) {
                    final member = members[index];
                    return _buildMemberCard(member);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Selected tab is Anggota
        selectedItemColor: Colors.blue[700],
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Utama'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Anggota'),
          BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Bantuan'),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home'); 
              break;
            case 1:
              // Already on members page
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/help');
              break;
          }
        },
      ),
    );
  }

  Widget _buildMemberCard(Map<String, dynamic> member) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Avatar circle
            CircleAvatar(
              radius: 30,
              backgroundColor: member['color'],
              child: Text(
                member['avatar'],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Member details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member['name'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'NIM: ${member['nim']}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    member['role'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            // More actions icon
            Icon(
              Icons.more_vert,
              color: Colors.grey[600],
            ),
          ],
        ),
      ),
    );
  }
}import 'package:flutter/material.dart';

class MembersPage extends StatelessWidget {
  const MembersPage({super.key});

  @override
  Widget build(BuildContext context) {
    // List of team members with their details
    final List<Map<String, dynamic>> members = [
      {
        'name': 'Arjikusna Maharjanta',
        'nim': '123220072',
        'role': 'Jungler',
        'avatar': 'A',
        'color': Colors.blue[700],
      },
      {
        'name': 'Arvidion Havas Oktavian',
        'nim': '123220067',
        'role': 'Explaner',
        'avatar': 'A',
        'color': Colors.green[700],
      },
      {
        'name': 'Muhammad Oscar Fileas Jakaria',
        'nim': '123220096',
        'role': 'Midlaner',
        'avatar': 'M',
        'color': Colors.orange[700],
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Header section with style similar to homepage
              Text(
                'Anggota Kelompok',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Daftar anggota kelompok kami',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 40),
              
              // Members list
              Expanded(
                child: ListView.builder(
                  itemCount: members.length,
                  itemBuilder: (context, index) {
                    final member = members[index];
                    return _buildMemberCard(member);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Selected tab is Anggota
        selectedItemColor: Colors.blue[700],
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Utama'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Anggota'),
          BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Bantuan'),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home'); 
              break;
            case 1:
              // Already on members page
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/help');
              break;
          }
        },
      ),
    );
  }

  Widget _buildMemberCard(Map<String, dynamic> member) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Avatar circle
            CircleAvatar(
              radius: 30,
              backgroundColor: member['color'],
              child: Text(
                member['avatar'],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Member details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member['name'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'NIM: ${member['nim']}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    member['role'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            // More actions icon
            Icon(
              Icons.more_vert,
              color: Colors.grey[600],
            ),
          ],
        ),
      ),
    );
  }
}
