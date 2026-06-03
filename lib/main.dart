import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'views/dashboard.dart';
import 'repositories/barangrepository.dart';
import 'viewmodels/barangviewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BarangViewModel(BarangRepository()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HalamanPilihTokoNetflix(), 
    ),
    GoRoute(
      path: '/dashboard/:namaToko',
      builder: (context, state) {
        final namaToko = state.pathParameters['namaToko']!;
        return DashboardTokoMenarik(namaToko: namaToko); 
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'StokoKu Pastel Pro',
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
      ),
    );
  }
}