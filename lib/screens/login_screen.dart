
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _whatsappController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _whatsappController.dispose();
    super.dispose();
  }

  // EVENT: dipanggil saat tombol Masuk ditekan
  void _masuk() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            namaPengguna: _namaController.text.trim(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.storefront,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 12),

                  const Text(
                    'Katalog Sofia Bouquet',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Input nama
                  TextFormField(
                    controller: _namaController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Anda',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Nama wajib diisi';
                      }
                      if (value.trim().length < 3) {
                        return 'Nama minimal 3 karakter';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Input nomor WhatsApp
                  TextFormField(
                    controller: _whatsappController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(13),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Nomor WhatsApp',
                      hintText: 'Contoh: 081234567890',
                      prefixIcon: Icon(Icons.phone_android),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Nomor WhatsApp wajib diisi';
                      }

                      if (!RegExp(r'^\d+$').hasMatch(value)) {
                        return 'Nomor WhatsApp hanya boleh berisi angka';
                      }

                      if (value.length < 10 || value.length > 13) {
                        return 'Nomor WhatsApp harus 10–13 digit';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 24),

                  FilledButton.icon(
                    onPressed: _masuk,
                    icon: const Icon(Icons.login),
                    label: const Text('Masuk'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
