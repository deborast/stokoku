part of 'pages.dart';

// Lanjut langsung ke class kamu, contoh:
// class DashboardPage extends StatelessWidget { ... }

class FormTambahBarangPage extends StatefulWidget {
  const FormTambahBarangPage({super.key});

  @override
  State<FormTambahBarangPage> createState() => _FormTambahBarangPageState();
}

class _FormTambahBarangPageState extends State<FormTambahBarangPage> {
  final _formKey = GlobalKey<FormState>(); 
  
  final _namaController = TextEditingController();
  final _kategoriController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _stokController = TextEditingController();
  final _hargaController = TextEditingController();
  
  bool _isFotoUploaded = false; 
  bool _isHovering = false; 

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
        title: const Text('Input Produk Baru', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFFFC1CC), 
        foregroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey, 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Isi Detail Formulir Barang', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(height: 25),
              
              // AREA FOTO
              const Text('Foto Produk (Opsional)', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
              const SizedBox(height: 8),
              Center(
                child: GestureDetector(
                  onTap: () { 
                    setState(() {
                      _isFotoUploaded = !_isFotoUploaded; 
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: 140,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: const Color(0xFFFFC1CC), width: 2),
                    ),
                    child: _isFotoUploaded
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(13),
                            child: Container(
                              color: const Color(0xFFE8F5E9),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.check_circle, color: Color(0xFF4CAF50), size: 32),
                                  SizedBox(width: 10),
                                  Text(
                                    'Foto Berhasil Dipasang!', 
                                    style: TextStyle(color: Color(0xFF4CAF50), fontWeight: FontWeight.bold, fontSize: 15)
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_a_photo, size: 42, color: Colors.grey),
                              SizedBox(height: 8),
                              Text('Ketuk untuk simulasi upload foto', style: TextStyle(color: Colors.grey, fontSize: 13)),
                            ],
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

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
                        backgroundColor: const Color(0xFF4CAF50), 
                        foregroundColor: Colors.white,
                        elevation: _isHovering ? 8 : 2, 
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final viewModel = Provider.of<BarangViewModel>(context, listen: false);
                          
                          viewModel.tambahBarang(
                            nama: _namaController.text,
                            deskripsi: _deskripsiController.text,
                            kategori: _kategoriController.text,
                            stok: int.parse(_stokController.text),
                            hargaJual: double.parse(_hargaController.text),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  const Icon(Icons.check_circle, color: Colors.white),
                                  const SizedBox(width: 10),
                                  Expanded(child: Text('Produk "${_namaController.text}" Berhasil Disimpan!')),
                                ],
                              ),
                              backgroundColor: const Color(0xFF2E7D32), 
                            ),
                          );
                          Navigator.pop(context); 
                        }
                      },
                      icon: const Icon(Icons.save_rounded, size: 24),
                      label: const Text('Simpan Ke Gudang', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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