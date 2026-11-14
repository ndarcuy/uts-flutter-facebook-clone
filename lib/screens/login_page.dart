import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool hidePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

void login() {
    final email = emailController.text.trim();
    final password = passwordController.text;

    // 1. Cek kekosongan input
    if (email.isEmpty) {
      showErrorSnackBar('Nomor ponsel atau email tidak boleh kosong!');
      return;
    }

    if (password.isEmpty) {
      showErrorSnackBar('Kata sandi tidak boleh kosong!');
      return;
    }

    // 2. Cek format email
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      showErrorSnackBar('Format email harus valid dan memiliki @ serta domain (contoh: asas@gmail.com)');
      return;
    }

    // 3. Cek panjang password
    if (password.length < 6) {
      showErrorSnackBar('Kata sandi harus minimal 6 karakter!');
      return;
    }

    // Hilangkan fokus keyboard sebelum navigasi
    FocusScope.of(context).unfocus();

    // Sukses, buka splash jeda animasi
    Navigator.pushReplacementNamed(context, '/splash');
  }

  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'facebook',
                    style: TextStyle(
                      color: Color(0xFF1877F2),
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -2.0,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Terhubung dengan teman dan dunia di sekitar Anda.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Nomor ponsel atau email',
                            filled: true,
                            fillColor: const Color(0xFFF5F6F7),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(color: Color(0xFFCCD0D5)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: passwordController,
                          obscureText: hidePassword,
                          decoration: InputDecoration(
                            hintText: 'Kata sandi',
                            filled: true,
                            fillColor: const Color(0xFFF5F6F7),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(color: Color(0xFFCCD0D5)),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
                              onPressed: () => setState(() => hidePassword = !hidePassword),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 46,
                          child: ElevatedButton(
                            onPressed: login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1877F2),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                            ),
                            child: const Text('Masuk', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Lupa Kata Sandi?', style: TextStyle(color: Color(0xFF1877F2))),
                        ),
                        const Divider(color: Color(0xFFDADDE1), height: 24),
                        ElevatedButton(
                          onPressed: () => Navigator.pushNamed(context, '/register'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF42B72A),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          ),
                          child: const Text('Buat akun baru', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text('Meta © 2026', style: TextStyle(color: Colors.black45, fontSize: 12)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}