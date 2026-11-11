import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyPortfolio', // Mengubah judul aplikasi
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo, // Mengubah warna dasar menjadi indigo
          secondary: Colors.amber[700], // Menambahkan warna sekunder amber
        ),
        useMaterial3: true,
      ),
      // Menghapus parameter title dan const, sesuai catatan tutorial
      home: MyHomePage(),
    );
  }
}
