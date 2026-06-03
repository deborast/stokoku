import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/barangmodel.dart';
import '../viewmodels/barangviewmodel.dart';

class FormEditBarangPage extends StatefulWidget {
  final Barang barangLama;
  
  const FormEditBarangPage({super.key, required this.barangLama});

  @override
  State<FormEditBarangPage> createState() => _FormEditBarangPageState();
}

class _FormEditBarangPageState extends State<FormEditBarangPage> {
  final _formKey = GlobalKey<FormState>(); 
  
  late TextEditingController _namaController;
  late TextEditingController _kategoriController;
  late TextEditingController _deskripsiController;
  late TextEditingController _stokController;
  late TextEditingController _hargaController;
  
  bool _isHovering = false; 

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.barangLama.nama);
    _kategoriController = TextEditingController(text: widget.barangLama.kategori);
    _deskripsiController = TextEditingController(text: widget.barangLama.deskripsi);
    _stokController = TextEditingController(text: widget.barangLama.stok.toString());
    _hargaController = TextEditingController(text: widget.barangLama.hargaJual.toString());
  }

  @override
  void dispose() {
    _namaController.dispose();
    _kategoriController.dispose();
    _deskripsiController.dispose();
    _stokController.dispose();
    _hargaController.dispose();
    super.dispose();
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? prefixText,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            prefixText: prefixText,
            filled: true,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 2)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.red, width: 1.5)),
            focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.red, width: 2)),
          ),
          validator: validator,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Data Produk', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFFFD54F), // Tema Kuning Pastel untuk Edit
        foregroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey, 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Ubah Detail Formulir Barang', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(height: 25),
              
              _buildTextField(
                controller: _namaController, label: 'Nama Barang', hint: 'Contoh: Baut Baja',
                validator: (value) => value == null || value.trim().isEmpty ? 'Wajib diisi!' : null,
              ),
              _buildTextField(
                controller: _kategoriController, label: 'Kategori', hint: 'Contoh: Sparepart',
                validator: (value) => value == null || value.trim().isEmpty ? 'Wajib diisi!' : null,
              ),
              _buildTextField(
                controller: _deskripsiController, label: 'Deskripsi Produk', hint: 'Detail produk...', maxLines: 3,
                validator: (value) => value == null || value.trim().isEmpty ? 'Wajib diisi!' : null,
              ),
              _buildTextField(
                controller: _stokController, label: 'Stok Tersedia', hint: 'Contoh: 10', keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return 'Wajib diisi!';
                  if (int.tryParse(value) == null) return 'Harus angka!';
                  return null;
                },
              ),
              _buildTextField(
                controller: _hargaController, label: 'Harga Jual (Rp)', hint: 'Contoh: 50000', prefixText: 'Rp ', keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return 'Wajib diisi!';
                  if (double.tryParse(value) == null) return 'Harus angka yang valid!';
                  return null;
                },
              ),
              
              const SizedBox(height: 20),
              
              MouseRegion(
                onEnter: (event) => setState(() => _isHovering = true), 
                onExit: (event) => setState(() => _isHovering = false), 
                child: AnimatedScale(
                  scale: _isHovering ? 1.05 : 1.0, 
                  duration: const Duration(milliseconds: 200), 
                  child: SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF57F17), // Warna oranye tua untuk tombol update
                        foregroundColor: Colors.white,
                        elevation: _isHovering ? 8 : 2, 
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final barangUpdate = Barang(
                            id: widget.barangLama.id, // ID tidak boleh berubah
                            nama: _namaController.text,
                            deskripsi: _deskripsiController.text,
                            kategori: _kategoriController.text,
                            stok: int.parse(_stokController.text),
                            hargaJual: double.parse(_hargaController.text),
                          );

                          Provider.of<BarangViewModel>(context, listen: false).updateBarang(barangUpdate);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Data berhasil diperbarui!'),
                              backgroundColor: Color(0xFFF57F17), 
                            ),
                          );
                          Navigator.pop(context); 
                        }
                      },
                      icon: const Icon(Icons.update, size: 24),
                      label: const Text('Update Data Gudang', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}