import 'package:flutter/material.dart';
import '../widgets/post_card.dart';
import '../widgets/story_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeTab = 0;

  void openNewStatusDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Buat Postingan'),
        content: const TextField(
          maxLines: 3,
          decoration: InputDecoration(hintText: 'Apa yang Anda pikirkan?'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Status berhasil dibagikan!')));
            },
            child: const Text('Kirim'),
          ),
        ],
      ),
    );
  }

  void openSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cari di Facebook'),
        content: const TextField(
          autofocus: true,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: 'Ketik nama teman, grup, atau topik...',
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Tutup')),
        ],
      ),
    );
  }

  void openMessengerSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            ListTile(
              title: Text('Obrolan Messenger', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            Divider(height: 1),
            ListTile(
              leading: CircleAvatar(child: Text('F')),
              title: Text('Farid Hisyam'),
              subtitle: Text('Gimana progress tugas UTSnya bro?'),
              trailing: Text('10:20'),
            ),
            ListTile(
              leading: CircleAvatar(child: Text('A')),
              title: Text('Arka Raffinendra'),
              subtitle: Text('Oke siap, nanti ketemu di kampus'),
              trailing: Text('08:15'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Column(
              children: [
                // Top Header Facebook
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'facebook',
                        style: TextStyle(
                          color: Color(0xFF1877F2),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -1.2,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: CircleAvatar(
                              backgroundColor: Colors.grey.shade200,
                              child: const Icon(Icons.search, color: Colors.black87, size: 20),
                            ),
                            onPressed: openSearchDialog, // Search box
                          ),
                          IconButton(
                            icon: CircleAvatar(
                              backgroundColor: Colors.grey.shade200,
                              child: const Icon(Icons.chat_bubble, color: Colors.black87, size: 20),
                            ),
                            onPressed: openMessengerSheet, // Messenger list
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Top Tab Bar Navigation (5 Tab Lengkap)
                Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(5, (index) {
                      final icons = [
                        Icons.home,
                        Icons.group_outlined,
                        Icons.ondemand_video,
                        Icons.notifications_none,
                        Icons.menu,
                      ];
                      final isSelected = activeTab == index;
                      return InkWell(
                        onTap: () => setState(() => activeTab = index),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: isSelected ? const Color(0xFF1877F2) : Colors.transparent,
                                width: 2.5,
                              ),
                            ),
                          ),
                          child: Icon(icons[index], color: isSelected ? const Color(0xFF1877F2) : Colors.grey, size: 26),
                        ),
                      );
                    }),
                  ),
                ),

                // Content View Sesuai Tab yang Dipilih
                Expanded(
                  child: IndexedStack(
                    index: activeTab,
                    children: [
                      _buildFeedView(),          // Tab 0: Home / Beranda
                      _buildFriendsView(),       // Tab 1: Teman
                      _buildVideosView(),        // Tab 2: Watch
                      _buildNotificationsView(), // Tab 3: Notifikasi
                      _buildMenuView(),          // Tab 4: Menu / Pengaturan
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // TAB 0: BERANDA
  Widget _buildFeedView() {
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(12),
          color: Colors.white,
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/profile'),
                child: const Tooltip(
                  message: 'Lihat Profil',
                  child: CircleAvatar(
                    backgroundColor: Color(0xFF1877F2),
                    child: Text('CN', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: InkWell(
                  onTap: openNewStatusDialog,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F2F5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('Apa yang Anda pikirkan?', style: TextStyle(color: Colors.black54)),
                  ),
                ),
              ),
            ],
          ),
        ),
        const StorySection(),
        // Postingan 1 dengan Komentar dari Afif
        PostCard(
          name: 'Eka Afif',
          time: '2 jam',
          text: 'Tugas Mobile Programming membuat tiruan UI Facebook dengan Flutter selesai dirapikan! 🚀',
          initialLikes: '142',
          imageUrl: 'assets/images/image2.png',
          comments: [
            CommentItem(user: 'Eka Afif', text: 'Keren banget bro, tampilannya mirip aslinya!'),
            CommentItem(user: 'Firliana', text: 'gokil!'),
          ],
        ),
        // Postingan 2 dengan Komentar dari Arkha dan Firli
        PostCard(
          name: 'Komunitas Flutter Indonesia',
          time: '5 jam',
          text: 'Kunci nilai bagus di UTS adalah clean code, responsivitas, dan interaksi tombol yang nyata!',
          initialLikes: '280',
          imageUrl: 'assets/images/image3.png',
          comments: [
            CommentItem(user: 'Arka Raffinendra ', text: 'Betul, dosen penguji pasti suka pemisahan filenya.'),
            CommentItem(user: 'Farid Hisyam', text: 'Mantap, semangat buat yang lagi ngerjain tugas!'),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // TAB 1: PERMINTAAN PERTEMANAN
  Widget _buildFriendsView() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Permintaan Pertemanan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _friendRequestCard('Budi Santoso', '10 teman bersama'),
        _friendRequestCard('Siti Nurhaliza', '3 teman bersama'),
        _friendRequestCard('Rizky Pratama', '1 teman bersama'),
      ],
    );
  }

  Widget _friendRequestCard(String name, String mutual) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: const Color(0xFF1877F2).withOpacity(0.2),
            child: Text(name.substring(0, 1), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF1877F2))),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(mutual, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1877F2), foregroundColor: Colors.white),
                      child: const Text('Konfirmasi'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE4E6EB), foregroundColor: Colors.black87),
                      child: const Text('Hapus'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // TAB 2: VIDEO WATCH
  Widget _buildVideosView() {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: const Text('Facebook Watch', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        PostCard(
          name: 'Tech Creator ID',
          time: '1 jam',
          text: 'Tutorial membuat animasi jeda SplashScreen di Flutter 📱',
          initialLikes: '540',
          imageUrl: 'https://picsum.photos/600/340',
          comments: [
            CommentItem(user: 'Deni', text: 'Videonya informatif banget!'),
          ],
        ),
      ],
    );
  }

  // TAB 3: NOTIFIKASI
  Widget _buildNotificationsView() {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: const Text('Notifikasi', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        _notificationTile('Afif Ramadhan menyukai postingan Anda.', '2 jam yang lalu'),
        _notificationTile('Maulana Arkha mengomentari kiriman Anda.', '4 jam yang lalu'),
        _notificationTile('Ada 5 postingan baru di Komunitas Flutter Indonesia.', 'Kemarin'),
      ],
    );
  }

  Widget _notificationTile(String text, String time) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 2),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFF1877F2),
          child: Icon(Icons.notifications, color: Colors.white, size: 20),
        ),
        title: Text(text, style: const TextStyle(fontSize: 14)),
        subtitle: Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ),
    );
  }

  // TAB 4: MENU & KELUAR (LOGOUT)
  Widget _buildMenuView() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Menu', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ListTile(
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          leading: const CircleAvatar(
            backgroundColor: Color(0xFF1877F2),
            child: Text('EM', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          title: const Text('Eka Maulana', style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: const Text('Lihat profil Anda'),
          onTap: () => Navigator.pushNamed(context, '/profile'),
        ),
        const SizedBox(height: 16),
        ListTile(
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          leading: const Icon(Icons.bookmark, color: Colors.purple),
          title: const Text('Tersimpan'),
          onTap: () {},
        ),
        const SizedBox(height: 8),
        ListTile(
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          leading: const Icon(Icons.groups, color: Color(0xFF1877F2)),
          title: const Text('Grup'),
          onTap: () {},
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
          },
          icon: const Icon(Icons.logout, color: Colors.red),
          label: const Text('Keluar (Log Out)', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE4E6EB),
            padding: const EdgeInsets.symmetric(vertical: 14),
            elevation: 0,
          ),
        ),
      ],
    );
  }
}