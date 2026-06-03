import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'formbarang.dart'; 
import 'daftarbarang.dart'; 

class HalamanPilihTokoNetflix extends StatelessWidget {
  const HalamanPilihTokoNetflix({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE8F5E9), Color(0xFFFCE4EC)], 
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Pilih Toko Ibu',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 40),
              Wrap(
                spacing: 25,
                runSpacing: 25,
                alignment: WrapAlignment.center,
                children: [
                  _itemTokoProfil(context, 'Toko Sparepart', const Color(0xFFA5D6A7), 'S'), 
                  _itemTokoProfil(context, 'Toko Chainsaw', const Color(0xFFFFC1CC), 'C'), 
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemTokoProfil(BuildContext context, String nama, Color warna, String inisial) {
    return InkWell(
      onTap: () => context.go('/dashboard/$nama'), 
      child: Column(
        children: [
          Container(
            width: 115,
            height: 115,
            decoration: BoxDecoration(
              color: warna,
              borderRadius: BorderRadius.circular(22),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              inisial, 
              style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: Colors.white)
            ),
          ),
          const SizedBox(height: 12),
          Text(
            nama, 
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black54)
          ),
        ],
      ),
    );
  }
}


class DashboardTokoMenarik extends StatelessWidget {
  final String namaToko;
  const DashboardTokoMenarik({super.key, required this.namaToko});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard $namaToko'),
        backgroundColor: const Color(0xFFA5D6A7), 
        foregroundColor: Colors.black87,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => context.go('/'), 
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: const Color(0xFFFFC1CC), 
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE91E63), width: 1.5), 
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('LAPORAN KEUNTUNGAN HARI INI', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 11)),
                      SizedBox(height: 5),
                      Text('Rp 1.450.000', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFC2185B))), 
                    ],
                  ),
                  Icon(Icons.payments, size: 45, color: Color(0xFFE91E63)),
                ],
              ),
            ),
            const SizedBox(height: 30),
            
            const Text('Peringatan Sistem:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE0B2), 
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: const Color(0xFFFF9800), width: 1.5), 
              ),
              child: const Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: Color(0xFFE65100)),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ada 3 Stok Barang Menipis!', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFE65100))),
                        Text('Baut Baja 12mm sisa 2 pcs lagi.', style: TextStyle(fontSize: 13, color: Colors.black54)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            
            const Text('Menu Utama Toko:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54)),
            const SizedBox(height: 15),
            
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), 
              crossAxisCount: 2, 
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              children: [
                _buildMenuCard(context, 'Stok Gudang', Icons.storage, const Color(0xFFE8F5E9), const Color(0xFF2E7D32)), 
                _buildMenuCard(context, 'Rekap Finansial', Icons.analytics, const Color(0xFFFCE4EC), const Color(0xFFAD1457)), 
                
                // TOMBOL DAFTAR BARANG YANG BISA DIKLIK
                _buildMenuCard(context, 'Daftar Barang', Icons.inventory_2_outlined, const Color(0xFFE3F2FD), const Color(0xFF1565C0), onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DaftarBarangPage()));
                }), 
                _buildMenuCard(context, 'Daftar Supplier', Icons.local_shipping_outlined, const Color(0xFFFFF3E0), const Color(0xFFE65100)), 
              ],
            ),
            const SizedBox(height: 70), 
          ],
        ),
      ),
      
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF4CAF50), 
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_box),
        label: const Text('Tambah Barang'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FormTambahBarangPage()),
          );
        },
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, String judul, IconData ikon, Color bg, Color warnaAksen, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: bg, 
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(ikon, size: 42, color: warnaAksen),
            const SizedBox(height: 12),
            Text(judul, style: TextStyle(color: warnaAksen, fontWeight: FontWeight.bold, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}