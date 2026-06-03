import '../models/barangmodel.dart';

class BarangRepository {
  final List<Barang> _barangList = [];

  List<Barang> getAllBarang() {
    return _barangList;
  }

  void tambahBarang(Barang barang) {
    _barangList.add(barang);
  }

  void hapusBarang(String id) {
    _barangList.removeWhere(
      (barang) => barang.id == id,
    );
  }

  void updateBarang(Barang barangBaru) {
    final index = _barangList.indexWhere(
      (barang) => barang.id == barangBaru.id,
    );

    if (index != -1) {
      _barangList[index] = barangBaru;
    }
  }
}