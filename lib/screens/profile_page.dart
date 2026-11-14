import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String name;
  final String bio;
  final String initials;
  final String location;
  final String school;

  const ProfilePage({
    super.key,
    this.name = 'Eka Maulana',
    this.bio = 'Mahasiswa Teknik Komputer & Jaringan',
    this.initials = 'EM',
    this.location = 'Tinggal di Surabaya, Indonesia',
    this.school = 'Kuliah di Politeknik',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0.5,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: ListView(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: 180,
                    width: double.infinity,
                    color: Colors.blueGrey.shade200,
                    child: Image.network(
                      'https://picsum.photos/800/300',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(color: Colors.blueGrey),
                    ),
                  ),
                  Positioned(
                    bottom: -45,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: const Color(0xFF1877F2),
                        child: Text(
                          initials,
                          style: const TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 55),
              Center(
                child: Text(name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 4),
              Center(
                child: Text(bio, style: const TextStyle(color: Colors.black54)),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.person_add, size: 18),
                        label: const Text('Tambah Teman'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1877F2),
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.chat_bubble, size: 18),
                      label: const Text('Kirim Pesan'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE4E6EB),
                        foregroundColor: Colors.black87,
                        elevation: 0,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 32),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('Tentang', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              ListTile(
                leading: const Icon(Icons.school, color: Colors.grey),
                title: Text(school),
              ),
              ListTile(
                leading: const Icon(Icons.location_on, color: Colors.grey),
                title: Text(location),
              ),
            ],
          ),
        ),
      ),
    );
  }
}