import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final namaDepanController = TextEditingController();
  final namaBelakangController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String gender = 'Laki-laki';
  String selectedDay = '12';
  String selectedMonth = 'Nov';
  String selectedYear = '2004';

  // State indikator kekuatan password
  String passwordStrengthText = '';
  Color passwordStrengthColor = Colors.transparent;
  double passwordStrengthPercent = 0.0;

  @override
  void dispose() {
    namaDepanController.dispose();
    namaBelakangController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void checkPasswordStrength(String value) {
    if (value.isEmpty) {
      setState(() {
        passwordStrengthText = '';
        passwordStrengthPercent = 0.0;
        passwordStrengthColor = Colors.transparent;
      });
      return;
    }

    bool hasUpper = value.contains(RegExp(r'[A-Z]'));
    bool hasSpecial = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasDigits = value.contains(RegExp(r'[0-9]'));

    if (value.length < 6 || (!hasUpper && !hasSpecial)) {
      setState(() {
        passwordStrengthText = 'Lemah (Gunakan huruf besar & simbol spesial)';
        passwordStrengthColor = Colors.red;
        passwordStrengthPercent = 0.33;
      });
    } else if (value.length >= 6 && hasUpper && hasSpecial && !hasDigits) {
      setState(() {
        passwordStrengthText = 'Sedang (Tambahkan angka agar lebih aman)';
        passwordStrengthColor = Colors.orange;
        passwordStrengthPercent = 0.66;
      });
    } else if (value.length >= 8 && hasUpper && hasSpecial && hasDigits) {
      setState(() {
        passwordStrengthText = 'Sangat Kuat!';
        passwordStrengthColor = Colors.green;
        passwordStrengthPercent = 1.0;
      });
    } else {
      setState(() {
        passwordStrengthText = 'Cukup Kuat';
        passwordStrengthColor = Colors.green;
        passwordStrengthPercent = 0.8;
      });
    }
  }

  void submitRegister() {
    final namaDepan = namaDepanController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final hasUpper = password.contains(RegExp(r'[A-Z]'));
    final hasSpecial = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    if (namaDepan.isEmpty || email.isEmpty || password.isEmpty) {
      showError('Semua formulir yang berbintang harus diisi!');
      return;
    }

    if (!emailRegex.hasMatch(email)) {
      showError('Format email tidak valid! Wajib ada tanda @ dan domain lengkap (.com / dll)');
      return;
    }

    if (password.length < 6) {
      showError('Kata sandi harus minimal 6 karakter!');
      return;
    }

    if (!hasUpper) {
      showError('Kata sandi wajib memiliki minimal 1 huruf besar (kapital)!');
      return;
    }

    if (!hasSpecial) {
      showError('Kata sandi wajib memiliki minimal 1 karakter spesial (!@#\$%^&* dll)!');
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pendaftaran berhasil!'), backgroundColor: Colors.green),
    );
    Navigator.pushReplacementNamed(context, '/splash');
  }

  void showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.redAccent, behavior: SnackBarBehavior.floating),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar ke Facebook', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0.5,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Buat akun baru', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const Text('Cepat dan mudah.', style: TextStyle(color: Colors.grey, fontSize: 14)),
                const Divider(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: namaDepanController,
                        decoration: const InputDecoration(labelText: 'Nama depan', border: OutlineInputBorder()),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: namaBelakangController,
                        decoration: const InputDecoration(labelText: 'Nama belakang', border: OutlineInputBorder()),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Nomor ponsel atau email',
                    border: OutlineInputBorder(),
                    hintText: 'contoh: nama@mail.com',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  onChanged: checkPasswordStrength,
                  decoration: const InputDecoration(
                    labelText: 'Kata sandi baru',
                    border: OutlineInputBorder(),
                    hintText: 'Minimal 1 kapital & 1 simbol',
                  ),
                ),
                if (passwordStrengthText.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  LinearProgressIndicator(
                    value: passwordStrengthPercent,
                    color: passwordStrengthColor,
                    backgroundColor: Colors.grey.shade200,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Kekuatan: $passwordStrengthText',
                    style: TextStyle(color: passwordStrengthColor, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
                const SizedBox(height: 18),
                const Text('Tanggal Lahir', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedDay,
                        items: ['1', '5', '10', '12', '15', '20', '25', '30']
                            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (v) => setState(() => selectedDay = v!),
                        decoration: const InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.symmetric(horizontal: 10)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedMonth,
                        items: ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des']
                            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (v) => setState(() => selectedMonth = v!),
                        decoration: const InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.symmetric(horizontal: 10)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedYear,
                        items: ['2000', '2001', '2002', '2003', '2004', '2005']
                            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (v) => setState(() => selectedYear = v!),
                        decoration: const InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.symmetric(horizontal: 10)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                const Text('Jenis Kelamin', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Laki-laki', style: TextStyle(fontSize: 13)),
                        value: 'Laki-laki',
                        groupValue: gender,
                        onChanged: (v) => setState(() => gender = v!),
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Perempuan', style: TextStyle(fontSize: 13)),
                        value: 'Perempuan',
                        groupValue: gender,
                        onChanged: (v) => setState(() => gender = v!),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton(
                    onPressed: submitRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00A400),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                    child: const Text('Daftar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}