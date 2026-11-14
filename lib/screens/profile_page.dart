import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String name;
  final String bio;
  final String initials;
  final String location;
  final String school;

  const ProfilePage({
    super.key,
    this.name = 'Cahyo Ndaru',
    this.bio = 'Mahasiswa Teknik Komputer & Jaringan',
    this.initials = 'CN',
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
                    child: Image.asset(
                      'assets/images/image1.png', // <-- Wajib diisi nama file gambarnya di sini
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: double.infinity,
                        height: 180,
                        color: Colors.grey.shade200,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
                            SizedBox(height: 8),
                            Text('Gambar tidak ditemukan', style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
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