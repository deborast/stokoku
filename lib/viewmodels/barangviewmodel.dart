import 'package:flutter/material.dart';
import '../models/barangmodel.dart';
import '../repositories/barangrepository.dart';

class BarangViewModel extends ChangeNotifier {
  final BarangRepository repository;

  BarangViewModel(this.repository);

  List<Barang> get daftarBarang =>
      repository.getAllBarang();

  void tambahBarang({
    required String nama,
    required String deskripsi,
    required String kategori,
    required int stok,
    required double hargaJual,
  }) {
    final barang = Barang(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      nama: nama,
      deskripsi: deskripsi,
      kategori: kategori,
      stok: stok,
      hargaJual: hargaJual,
    );

    repository.tambahBarang(barang);

    notifyListeners();
  }

  void hapusBarang(String id) {
    repository.hapusBarang(id);

    notifyListeners();
  }

  void updateBarang(Barang barang) {
    repository.updateBarang(barang);

    notifyListeners();
  }

  int get totalBarang {
    return daftarBarang.length;
  }
}