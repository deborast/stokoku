// lib/views/pages/pages.dart
library pages; // Nama library-nya huruf kecil

// Import dari luar
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

// Import model dan viewmodel (sesuai nama foldermu)
import '../../models/barangmodel.dart';
import '../../viewmodels/barangviewmodel.dart';

// Daftarkan semua file di dalam folder pages
part 'dashboard.dart';
part 'daftarbarang.dart';
part 'formbarang.dart';
part 'formeditbarang.dart';