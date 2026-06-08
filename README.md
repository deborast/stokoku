# StokoKu - MVVM Implementation Assignment

**Nama:** Debora Setiawan  
**NIM:** 0706012414006  

## Overview of MVVM Pattern & Architecture
Aplikasi StokoKu ini dibangun menggunakan pola arsitektur **MVVM (Model-View-ViewModel)**. Tujuan utama implementasi ini adalah untuk menciptakan pemisahan kode (*separation of concerns*) yang bersih antara antarmuka pengguna (UI) dan logika bisnis:
* **Model (`models/`)**: Representasi entitas data barang yang mencakup atribut ID, nama, deskripsi, kategori, stok, dan harga jual.
* **Repository (`repositories/`)**: Menangani seluruh operasi manipulasi data (CRUD) di belakang layar secara terpusat.
* **ViewModel (`viewmodels/`)**: Pengelola *state* yang mewarisi `ChangeNotifier`. Kelas ini bertindak sebagai jembatan yang memproses logika dari antarmuka dan memberikan sinyal `notifyListeners()` ke View jika terjadi perubahan data.
* **View (`views/pages/`)**: Kumpulan antarmuka pengguna (UI) yang dirender berdasarkan state dari ViewModel.

**Tambahan (sesuai pembelajaran sesi 8)**
Selain MVVM dasar, aplikasi ini telah merancang struktur folder tingkat lanjut (*Advanced Routing & Folder Structure*). Beberapa direktori di bawah ini sengaja disiapkan sebagai kerangka (*placeholder*) untuk kebutuhan proyek selanjutnya:
1. **Efisiensi Memori (Library Part):** Menerapkan sistem `part` dan `part of` terpusat pada file `pages.dart` di dalam folder `pages`. File ini bertindak sebagai *Gatekeeper* yang menangani seluruh *import package*, sehingga memori lebih hemat karena sistem hanya perlu memuat *library* satu kali.
2. **Modular Widgets (`views/widgets/`):** Folder ini disiapkan khusus untuk memecah UI menjadi komponen kecil yang dapat dipakai ulang (*reusable*, misal: `CardView`). Saat ini folder masih **belum terisi**, karena fokus pengembangan baru pada kerangka utama halaman (Pages).
3. **Data Layer (`data/`) - *Optional*:** Folder ini disiapkan untuk mengatur sirkulasi data, *networking*, respons *server*, dan API. Saat ini statusnya **belum terisi** karena aplikasi masih menggunakan data lokal (*dummy*).
4. **Shared Directory (`shared/`) - *Optional*:** Disiapkan untuk menyimpan fungsi, *widget*, atau variabel yang bersifat universal/masal (contoh: *API Key*, konfigurasi tema, dll). Saat ini statusnya **belum terisi**, namun kerangkanya sudah dibuat untuk memastikan aplikasi siap di-skala (*scalable*) pada tahap integrasi *backend* nanti.
5. folder"  yang status nya masih kosong saya beri .gitkeep agar tetap terdeteksi di github (dapat dinilai)

## How to Run This Application
1. Pastikan Flutter SDK telah terinstal dengan baik di sistem Anda.
2. Buka terminal pada direktori *root* proyek ini.
3. Jalankan perintah `flutter pub get` untuk mengunduh seluruh dependensi.
4. Jalankan aplikasi menggunakan perintah `flutter run` atau melalui fitur *debugging* (F5) pada IDE Anda.

## Project Status & Limitations (vs AFL 1 Proposal)
Versi rilis aplikasi saat ini difokuskan secara eksklusif untuk **memenuhi kriteria tugas implementasi arsitektur MVVM pada modul CRUD**. Terdapat beberapa batasan fitur jika dibandingkan dengan rancangan asli pada *Final Project Application Proposal* (AFL 1):
1. **Autentikasi & Pembuatan Toko:** Halaman awal masih menggunakan pendekatan statis (*hardcode*) untuk mendemonstrasikan UI dan navigasi, melewati proses login dan *setup* toko baru.
2. **Data Bersifat *Dummy* (In-Memory):** Seluruh data yang diinput hanya disimpan sementara di memori (`BarangRepository`) dan akan ter-reset apabila aplikasi ditutup.
3. **Logika Transaksi:** Fitur pengurangan stok saat penjualan belum berjalan. Laporan di *Dashboard* masih berupa *mock-up* visual.
4. **Modul Supplier:** Menu pengelolaan pemasok sengaja ditunda untuk *sprint* proyek berikutnya.
5. **CRUD** sudah bisa digunakan di fitur tambah barang yang akan tersimpan dalam menu daftar barang pada dashboard.

## Reflection
Mengerjakan assignment ini memberikan saya pemahaman yang mendalam mengenai pemisahan *business logic* dan antarmuka pengguna. Tantangan terbesar yang saya hadapi adalah merombak alur berpikir dari penggunaan `setState` konvensional menjadi pendekatan reaktif berbasis `Provider` dan `Consumer`. Selain itu, mengimplementasikan konsep `part` dan `part of` untuk efisiensi memori juga membutuhkan ketelitian ekstra dalam menjaga sinkronisasi penamaan file. Saya belajar bahwa arsitektur MVVM yang dikombinasikan dengan struktur folder yang disiapkan untuk *networking* (seperti `data/` dan `shared/`) membuat kode tidak hanya bersih (*clean code*), tetapi juga sangat *scalable* untuk proyek mendatang.