import 'package:flutter/material.dart';
import '../screens/profile_page.dart';

class CommentItem {
  final String user;
  final String text;
  CommentItem({required this.user, required this.text});
}

class PostCard extends StatefulWidget {
  final String name;
  final String time;
  final String text;
  final String initialLikes;
  final String imageUrl;
  final List<CommentItem> comments;

  const PostCard({
    super.key,
    required this.name,
    required this.time,
    required this.text,
    required this.initialLikes,
    required this.imageUrl,
    required this.comments,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool liked = false;
  late List<CommentItem> postComments;
  final commentInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    postComments = List.from(widget.comments);
  }

  // Solusi agar komentar langsung berubah saat diedit di home_page.dart
  @override
  void didUpdateWidget(covariant PostCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.comments != widget.comments) {
      setState(() {
        postComments = List.from(widget.comments);
      });
    }
  }

  @override
  void dispose() {
    commentInputController.dispose();
    super.dispose();
  }

  void openProfile(String userName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(
          name: userName,
          initials: userName.isNotEmpty ? userName.substring(0, 1).toUpperCase() : 'U',
          bio: 'Pengguna Aktif Facebook',
          school: 'Politeknik',
          location: 'Jawa Timur, Indonesia',
        ),
      ),
    );
  }

  void openCommentModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Komentar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const Divider(),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 250),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: postComments.length,
                      itemBuilder: (context, index) {
                        final c = postComments[index];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              openProfile(c.user);
                            },
                            child: CircleAvatar(
                              backgroundColor: const Color(0xFF1877F2).withOpacity(0.15),
                              child: Text(
                                c.user.isNotEmpty ? c.user.substring(0, 1).toUpperCase() : 'U',
                                style: const TextStyle(color: Color(0xFF1877F2), fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          title: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              openProfile(c.user);
                            },
                            child: Text(c.user, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          ),
                          subtitle: Container(
                            margin: const EdgeInsets.only(top: 4),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0F2F5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(c.text, style: const TextStyle(color: Colors.black87)),
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: commentInputController,
                          decoration: const InputDecoration(
                            hintText: 'Tulis komentar...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send, color: Color(0xFF1877F2)),
                        onPressed: () {
                          if (commentInputController.text.trim().isNotEmpty) {
                            setModalState(() {
                              postComments.add(
                                CommentItem(user: 'Anda', text: commentInputController.text.trim()),
                              );
                            });
                            setState(() {});
                            commentInputController.clear();
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void showPostOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.bookmark_border),
              title: const Text('Simpan postingan'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Postingan disimpan')));
              },
            ),
            ListTile(
              leading: const Icon(Icons.hide_source),
              title: const Text('Sembunyikan postingan'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Postingan disembunyikan')));
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: GestureDetector(
              onTap: () => openProfile(widget.name),
              child: CircleAvatar(
                backgroundColor: const Color(0xFF1877F2).withOpacity(0.15),
                child: Text(
                  widget.name.substring(0, 1).toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1877F2)),
                ),
              ),
            ),
            title: GestureDetector(
              onTap: () => openProfile(widget.name),
              child: Text(widget.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            subtitle: Row(
              children: [
                Text(widget.time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(width: 4),
                const Icon(Icons.public, size: 12, color: Colors.grey),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: showPostOptions,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            child: Text(widget.text, style: const TextStyle(fontSize: 14)),
          ),
          const SizedBox(height: 8),
          Image.network(
            widget.imageUrl,
            width: double.infinity,
            height: 240,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 200,
              color: Colors.grey.shade200,
              child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(color: Color(0xFF1877F2), shape: BoxShape.circle),
                  child: const Icon(Icons.thumb_up, size: 10, color: Colors.white),
                ),
                const SizedBox(width: 6),
                Text(
                  liked ? '${int.parse(widget.initialLikes) + 1}' : widget.initialLikes,
                  style: const TextStyle(color: Colors.black54, fontSize: 13),
                ),
                const Spacer(),
                Text('${postComments.length} komentar', style: const TextStyle(color: Colors.black54, fontSize: 13)),
              ],
            ),
          ),
          const Divider(height: 1),
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: () => setState(() => liked = !liked),
                  icon: Icon(
                    liked ? Icons.thumb_up : Icons.thumb_up_outlined,
                    color: liked ? const Color(0xFF1877F2) : Colors.black54,
                    size: 18,
                  ),
                  label: Text('Suka', style: TextStyle(color: liked ? const Color(0xFF1877F2) : Colors.black54)),
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  onPressed: openCommentModal,
                  icon: const Icon(Icons.mode_comment_outlined, color: Colors.black54, size: 18),
                  label: const Text('Komentar', style: TextStyle(color: Colors.black54)),
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tautan disalin ke clipboard!')));
                  },
                  icon: const Icon(Icons.share_outlined, color: Colors.black54, size: 18),
                  label: const Text('Bagikan', style: TextStyle(color: Colors.black54)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}