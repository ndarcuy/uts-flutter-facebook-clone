import 'package:flutter/material.dart';
import '../screens/profile_page.dart';

class StorySection extends StatelessWidget {
  const StorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 195,
      margin: const EdgeInsets.only(top: 8),
      color: Colors.white,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        children: const [
          _CreateStoryCard(),
          _StoryCard(name: 'Eka Afif', timeAgo: 'Baru saja'),
          _StoryCard(name: 'Arka Raffinendra', timeAgo: '1 jam'),
          _StoryCard(name: 'Firliana Aulia', timeAgo: '3 jam'),
          _StoryCard(name: 'Farid Hisyam', timeAgo: '4 jam'),
        ],
      ),
    );
  }
}

class _CreateStoryCard extends StatelessWidget {
  const _CreateStoryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 105,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Stack(
        children: [
          Container(
            height: 110,
            decoration: const BoxDecoration(
              color: Color(0xFFD8DADF),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: const Center(
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
          ),
          Positioned(
            top: 92,
            left: 32,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const CircleAvatar(
                radius: 16,
                backgroundColor: Color(0xFF1877F2),
                child: Icon(Icons.add, color: Colors.white, size: 20),
              ),
            ),
          ),
          const Positioned(
            bottom: 8,
            left: 8,
            right: 8,
            child: Text(
              'Buat Cerita',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  final String name;
  final String timeAgo;

  const _StoryCard({required this.name, required this.timeAgo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(
              name: name,
              initials: name.substring(0, 1).toUpperCase(),
              bio: 'Cerita dibagikan $timeAgo',
              school: 'Politeknik',
              location: 'Surabaya, Indonesia',
            ),
          ),
        );
      },
      child: Container(
        width: 105,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF89C4FF), Color(0xFF1877F2)],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.white,
                  child: Text(
                    name.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      color: Color(0xFF1877F2),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Text(
                name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  shadows: [Shadow(color: Colors.black45, blurRadius: 4)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}