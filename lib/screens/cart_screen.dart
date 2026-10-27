
import 'package:flutter/material.dart';
import '../models/produk.dart';

class CartScreen extends StatefulWidget {
  final Map<Produk, int> keranjang;
  final VoidCallback onClear;

  const CartScreen({
    super.key,
    required this.keranjang,
    required this.onClear,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int get _totalHarga {
    return widget.keranjang.entries.fold<int>(
      0,
      (total, item) => total + (item.key.harga * item.value),
    );
  }

  Future<void> _konfirmasiKosongkan() async {
    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kosongkan Keranjang?'),
        content: const Text(
          'Semua produk dalam keranjang akan dihapus. '
          'Apakah kamu yakin ingin melanjutkan?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Ya, Kosongkan'),
          ),
        ],
      ),
    );

    if (konfirmasi == true && mounted) {
      widget.onClear();

      setState(() {});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Keranjang berhasil dikosongkan'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final daftarKeranjang = widget.keranjang.entries.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
      ),
      body: daftarKeranjang.isEmpty
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 72,
                  ),
                  SizedBox(height: 16),
                  Text('Keranjang masih kosong'),
                  SizedBox(height: 8),
                  Text('Pilih produk dari katalog terlebih dahulu.'),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: daftarKeranjang.length,
                    itemBuilder: (context, index) {
                      final item = daftarKeranjang[index];
                      final produk = item.key;
                      final jumlah = item.value;
                      final subtotal = produk.harga * jumlah;

                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Icon(produk.ikon),
                          ),
                          title: Text(produk.nama),
                          subtitle: Text(
                            '${formatRupiah(produk.harga)}'
                            '\nJumlah: $jumlah'
                            '\nSubtotal: ${formatRupiah(subtotal)}',
                          ),
                          isThreeLine: true,
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .surfaceContainerHighest,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Total Harga',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        formatRupiah(_totalHarga),
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton.icon(
                        onPressed: _konfirmasiKosongkan,
                        icon: const Icon(Icons.delete_outline),
                        label: const Text('Kosongkan Keranjang'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
