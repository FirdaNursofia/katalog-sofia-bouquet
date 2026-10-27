
import 'package:flutter/material.dart';

class Produk {
  final String nama;
  final int harga;
  final String deskripsi;
  final IconData ikon;
  final String kategori;
  final String gambar;

  const Produk({
    required this.nama,
    required this.harga,
    required this.deskripsi,
    required this.ikon,
    required this.kategori,
    required this.gambar,
  });
}

const List<Produk> daftarProduk = [
  Produk(
    nama: 'Sunflower Bouquet',
    harga: 255000,
    deskripsi: 'Buket bunga matahari berukuran Large dengan tampilan cerah dan menawan. Pilihan cantik untuk menyampaikan perhatian, apresiasi, dan kebahagiaan kepada orang tersayang.',
    ikon: Icons.local_florist,
    kategori: 'Buket Bunga Artificial',
    gambar: 'assets/images/sunflower_bouquet.jpeg',
  ),
  Produk(
    nama: 'Artificial Bouquet',
    harga: 300000,
    deskripsi: 'Buket bunga artificial berukuran Xtra Large yang tampil menonjol dan berkesan. Cocok untuk momen spesial ketika kamu ingin memberikan hadiah bunga dengan tampilan yang istimewa.',
    ikon: Icons.spa,
    kategori: 'Buket Bunga Artificial',
    gambar: 'assets/images/artificial_bouquet.jpeg',
  ),
  Produk(
    nama: 'Mariposa Bouquet',
    harga: 285000,
    deskripsi: 'Buket Mariposa berukuran Xtra Large dengan pilihan warna pink dan biru. Perpaduan warna yang menawan untuk hadiah spesial yang ingin tampil cantik dan berkesan.',
    ikon: Icons.filter_vintage,
    kategori: 'Buket Bunga Artificial',
    gambar: 'assets/images/mariposa_bouquet.jpeg',
  ),
  Produk(
    nama: 'Thumbelina Bouquet',
    harga: 190000,
    deskripsi: 'Buket Thumbelina berukuran Medium dengan tampilan manis dan anggun. Pilihan hadiah yang cantik untuk mengungkapkan rasa sayang, ucapan selamat, maupun apresiasi.',
    ikon: Icons.local_florist,
    kategori: 'Buket Bunga Artificial',
    gambar: 'assets/images/thumbelina_bouquet.jpeg',
  ),
  Produk(
    nama: 'Satin Bouquet 30 tangkai',
    harga: 325000,
    deskripsi: 'Buket satin dengan 30 tangkai dan pilihan warna pink, maroon, navy, serta hitam. Pilihan menarik bagi kamu yang menginginkan buket dengan tampilan elegan dan karakter warna sesuai selera.',
    ikon: Icons.celebration,
    kategori: 'Buket Satin',
    gambar: 'assets/images/satin_bouquet.jpeg',
  ),
  Produk(
    nama: 'Money Bouquet 40 Lembar',
    harga: 250000,
    deskripsi: 'Buket uang berisi 40 lembar dengan ukuran Human Size yang tampil besar dan mencuri perhatian. Pilihan hadiah unik untuk merayakan ulang tahun, kelulusan, dan berbagai momen istimewa.',
    ikon: Icons.redeem,
    kategori: 'Buket Uang',
    gambar: 'assets/images/money_bouquet.jpeg',
  ),
];

String formatRupiah(int angka) {
  final s = angka.toString();
  final buffer = StringBuffer();

  for (int i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) {
      buffer.write('.');
    }
    buffer.write(s[i]);
  }

  return 'Rp $buffer';
}
