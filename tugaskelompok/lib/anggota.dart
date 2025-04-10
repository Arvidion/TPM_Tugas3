import 'package:flutter/material.dart';

class MembersPage extends StatelessWidget {
  const MembersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Anggota"),
        backgroundColor: Colors.blue[900],
      ),
      body: ListView(
        children: const [
          ListTile(title: Text("1. Nama Anggota 1")),
          ListTile(title: Text("2. Nama Anggota 2")),
          ListTile(title: Text("3. Nama Anggota 3")),
          ListTile(title: Text("4. Nama Anggota 4")),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
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
              Navigator.pushReplacementNamed(context, '/members');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/help');
              break;
          }
        },
      ),
    );
  }
}
