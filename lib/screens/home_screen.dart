
import 'package:flutter/material.dart';
import '../models/produk.dart';
import 'detail_screen.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  final String namaPengguna;

  const HomeScreen({super.key, required this.namaPengguna});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Map<Produk, int> _keranjang = {};
  String _kataKunci = '';

  int get _totalItem {
    return _keranjang.values.fold<int>(
      0,
      (total, jumlah) => total + jumlah,
    );
  }

  // Membuka detail produk dan menerima jumlah yang dipilih.
  Future<void> _bukaDetail(Produk produk) async {
    final jumlah = await Navigator.push<int>(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(produk: produk),
      ),
    );

    if (!mounted) return;

    if (jumlah != null && jumlah > 0) {
      setState(() {
        _keranjang[produk] = (_keranjang[produk] ?? 0) + jumlah;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$jumlah x ${produk.nama} masuk keranjang'),
        ),
      );
    }
  }

  // Membuka halaman keranjang.
  void _lihatKeranjang() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(
          keranjang: _keranjang,
          onClear: () {
            setState(() {
              _keranjang.clear();
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Filter produk berdasarkan nama, kategori, atau deskripsi.
    final produkTersaring = daftarProduk.where((produk) {
      final kataKunci = _kataKunci.toLowerCase().trim();

      return produk.nama.toLowerCase().contains(kataKunci) ||
          produk.kategori.toLowerCase().contains(kataKunci) ||
          produk.deskripsi.toLowerCase().contains(kataKunci);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Produk'),
        actions: [
          IconButton(
            tooltip: 'Keranjang',
            onPressed: _lihatKeranjang,
            icon: Badge(
              isLabelVisible: _totalItem > 0,
              label: Text('$_totalItem'),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
          IconButton(
            tooltip: 'Tentang',
            icon: const Icon(Icons.info_outline),
            onPressed: () => Navigator.pushNamed(context, '/about'),
          ),
          IconButton(
            tooltip: 'Keluar',
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacementNamed(context, '/'),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Halo, ${widget.namaPengguna}!',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),

          // Kolom pencarian produk.
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _kataKunci = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Cari nama atau kategori buket...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _kataKunci.isNotEmpty
                    ? IconButton(
                        tooltip: 'Hapus pencarian',
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _kataKunci = '';
                          });
                        },
                      )
                    : null,
                border: const OutlineInputBorder(),
              ),
            ),
          ),

          // Daftar produk hasil pencarian.
          Expanded(
            child: produkTersaring.isEmpty
                ? const Center(
                    child: Text('Produk tidak ditemukan'),
                  )
                : ListView.builder(
                    itemCount: produkTersaring.length,
                    itemBuilder: (context, index) {
                      final produk = produkTersaring[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        child: ListTile(
                          leading: ClipRRect(
  borderRadius: BorderRadius.circular(8),
  child: Image.asset(
    produk.gambar,
    width: 60,
    height: 60,
    fit: BoxFit.cover,
    errorBuilder: (context, error, stackTrace) {
      return SizedBox(
        width: 60,
        height: 60,
        child: Icon(produk.ikon),
      );
    },
  ),
),
                          title: Text(produk.nama),
                          subtitle: Text(
                            '${produk.kategori}\n'
                            '${formatRupiah(produk.harga)}',
                          ),
                          isThreeLine: true,
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _bukaDetail(produk),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
