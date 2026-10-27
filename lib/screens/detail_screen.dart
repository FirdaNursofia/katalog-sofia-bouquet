
import 'package:flutter/material.dart';
import '../models/produk.dart';

class DetailScreen extends StatefulWidget {
  final Produk produk;

  const DetailScreen({super.key, required this.produk});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _jumlah = 1;

  // EVENT handler tombol + dan -
  void _tambah() => setState(() => _jumlah++);

  void _kurang() {
    if (_jumlah > 1) setState(() => _jumlah--);
  }

  @override
  Widget build(BuildContext context) {
    final produk = widget.produk;
    final teks = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(produk.nama)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              
ClipRRect(
  borderRadius: BorderRadius.circular(16),
  child: Image.asset(
    produk.gambar,
    height: 240,
    width: double.infinity,
    fit: BoxFit.contain,
    errorBuilder: (context, error, stackTrace) {
      return SizedBox(
        height: 240,
        width: double.infinity,
        child: Icon(
          produk.ikon,
          size: 110,
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    },
  ),
),
const SizedBox(height: 16),

              Text(produk.nama, style: teks.headlineSmall),
              const SizedBox(height: 4),

              // Kategori produk
              Text(
                'Kategori: ${produk.kategori}',
                style: teks.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),

              Text(formatRupiah(produk.harga), style: teks.titleMedium),
              const SizedBox(height: 12),

              Text(produk.deskripsi, style: teks.bodyLarge),

              const Spacer(),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton.outlined(
                    onPressed: _kurang,
                    icon: const Icon(Icons.remove),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text('$_jumlah', style: teks.headlineMedium),
                  ),
                  IconButton.outlined(
                    onPressed: _tambah,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Text(
                'Subtotal: ${formatRupiah(produk.harga * _jumlah)}',
                textAlign: TextAlign.center,
                style: teks.titleMedium,
              ),

              const SizedBox(height: 16),

              FilledButton.icon(
                // Kirim nilai jumlah kembali ke layar sebelumnya
                onPressed: () => Navigator.pop(context, _jumlah),
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('Tambah ke Keranjang'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
