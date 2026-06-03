import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/barangviewmodel.dart';
import 'formeditbarang.dart'; 

class DaftarBarangPage extends StatelessWidget {
  const DaftarBarangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Stok Barang', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFE3F2FD), 
        foregroundColor: Colors.black87,
      ),
      body: Consumer<BarangViewModel>(
        builder: (context, viewModel, child) {
          final listBarang = viewModel.daftarBarang;

          if (listBarang.isEmpty) {
            return const Center(
              child: Text('Gudang masih kosong Bu, silakan tambah barang.', style: TextStyle(color: Colors.black54)),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: listBarang.length,
            itemBuilder: (context, index) {
              final barang = listBarang[index];
              return Card(
                color: const Color(0xFFFDFDFD),
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(15),
                  leading: Container(
                    width: 50, height: 50,
                    decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.inventory, color: Color(0xFF2E7D32)),
                  ),
                  title: Text(barang.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(barang.deskripsi, maxLines: 2, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Chip(
                              label: Text(barang.kategori, style: const TextStyle(fontSize: 10)),
                              backgroundColor: const Color(0xFFFFF3E0),
                              padding: EdgeInsets.zero,
                            ),
                            const SizedBox(width: 8),
                            Text('Stok: ${barang.stok}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text('Rp ${barang.hargaJual.toStringAsFixed(0)}', style: const TextStyle(color: Color(0xFFC2185B), fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.orange), 
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FormEditBarangPage(barangLama: barang)),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.redAccent), // Tombol Hapus
                        onPressed: () {
                          viewModel.hapusBarang(barang.id); 
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Barang dihapus!')));
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}