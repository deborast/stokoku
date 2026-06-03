# StokoKu - MVVM Implementation Assignment

## Overview of MVVM Pattern
Aplikasi StokoKu ini dibangun menggunakan pola arsitektur **MVVM (Model-View-ViewModel)**. Tujuan utama implementasi ini adalah untuk menciptakan pemisahan kode (*separation of concerns*) yang bersih antara antarmuka pengguna (UI) dan logika bisnis:
* **Model (`models/barangmodel.dart`)**: Bertugas sebagai kerangka representasi entitas data barang yang mencakup atribut ID, nama, deskripsi, kategori, stok, dan harga jual.
* **Repository (`repositories/barangrepository.dart`)**: Menangani seluruh operasi manipulasi data (CRUD) di belakang layar secara terpusat.
* **ViewModel (`viewmodels/barangviewmodel.dart`)**: Kelas pengelola *state* yang mewarisi `ChangeNotifier`. Kelas ini bertindak sebagai jembatan yang memproses logika dari antarmuka dan memberikan sinyal `notifyListeners()` ke View jika terjadi perubahan data.
* **View (`views/`)**: Kumpulan antarmuka pengguna (Dashboard, Form Tambah, Form Edit, dan Daftar Barang) yang murni hanya bertugas merender UI dan mendengarkan perubahan data dari ViewModel menggunakan *package* `provider`.

## How to Run This Application
1. Pastikan Flutter SDK telah terinstal dengan baik di sistem Anda.
2. Buka terminal pada direktori *root* proyek ini.
3. Jalankan perintah `flutter pub get` untuk mengunduh dependensi (`provider` dan `go_router`).
4. Jalankan aplikasi menggunakan perintah `flutter run` atau melalui fitur *debugging* (F5) pada IDE Anda.

## Project Status & Limitations (vs AFL 1 Proposal)
Perlu dicatat bahwa versi rilis aplikasi saat ini difokuskan secara eksklusif untuk **memenuhi kriteria tugas implementasi arsitektur MVVM pada modul CRUD utama**. Oleh karena itu, terdapat beberapa batasan fitur jika dibandingkan dengan rancangan asli pada *Final Project Application Proposal* (AFL 1):
1. **Autentikasi & Pembuatan Toko Belum Tersedia:** Sesuai proposal awal, alur aplikasi seharusnya dimulai dengan halaman Login/Register akun, dilanjutkan dengan pembuatan entitas toko baru. Pada rilis ini, proses tersebut di-Bypass. Halaman awal (Pilih Toko ala profil Netflix) masih menggunakan data statis (*hardcode*) untuk mendemonstrasikan UI dan sistem *routing*.
2. **Data Masih Bersifat *Dummy* (In-Memory):** Seluruh data yang diinput pada rilis ini hanya disimpan sementara menggunakan `List` di dalam memori (`BarangRepository`). Data akan kembali kosong jika aplikasi ditutup atau di-*restart* karena belum terintegrasi dengan *database* sungguhan (lokal maupun *cloud*).
3. **Logika Transaksi & Mutasi Stok Belum Aktif:** Fitur operasional inti seperti pengurangan stok saat terjadi penjualan atau penambahan stok (*restock*) belum berjalan. Card "Laporan Keuntungan" dan "Peringatan Stok Menipis" di halaman Dashboard saat ini masih berupa *mock-up* visual statis.
4. **Modul Daftar Supplier Belum Dibangun:** Menu untuk mengelola data pemasok (*supplier*) belum memiliki halaman dan logika pendukung (*ViewModel*/*Repository*). 
Pengembangan seluruh fitur yang tertunda di atas akan dilanjutkan pada proyek berikutnya setelah fondasi MVVM ini divalidasi.

## Reflection
Mengerjakan assignment ini memberikan saya pemahaman yang jauh lebih terstruktur mengenai pemisahan antara UI dan *business logic*. Tantangan terbesar yang saya hadapi adalah merombak kebiasaan menggunakan fungsi `setState` secara langsung di dalam UI, dan beralih ke pendekatan reaktif berbasis `Provider` dan `Consumer`. Saya belajar bahwa ViewModel sangat krusial dan efektif untuk mencegah terjadinya tumpukan logika yang berantakan (*spaghetti code*) di dalam file antarmuka.

Pengetahuan mengenai arsitektur MVVM ini sangat esensial dan akan menjadi fondasi utama saya dalam melanjutkan pengembangan Final Project AFL 1. Mengingat aplikasi StokoKu nantinya akan mengelola alur data operasional toko yang saling terkait—seperti sinkronisasi data antar menu, manajemen stok dari *supplier*, hingga rekapitulasi finansial—penggunaan pola arsitektur MVVM akan membuat manajemen *state* aplikasi menjadi terukur, *scalable*, dan jauh lebih mudah dikembangkan (*maintainable*) untuk tahapan proyek selanjutnya.