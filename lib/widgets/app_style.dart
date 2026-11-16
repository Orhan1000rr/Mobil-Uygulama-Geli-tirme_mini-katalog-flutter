import 'package:flutter/material.dart';

class AppStyle {
  static const navy = Color(0xFF19333D);
  static const green = Color(0xFF118A7B);
  static const bg = Color(0xFFF5F7F6);
  static const muted = Color(0xFF6D8087);

  static ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: green),
      scaffoldBackgroundColor: bg,
      appBarTheme: const AppBarTheme(
        backgroundColor: bg,
        foregroundColor: navy,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: navy,
          fontWeight: FontWeight.w800,
          fontSize: 29,
        ),
        titleLarge: TextStyle(
          color: navy,
          fontWeight: FontWeight.w800,
          fontSize: 21,
        ),
        titleMedium: TextStyle(
          color: navy,
          fontWeight: FontWeight.w700,
        ),
        bodyMedium: TextStyle(color: navy),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: green,
          foregroundColor: Colors.white,
          minimumSize: const Size(0, 52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }
}

String formatPrice(double value) {
  final parts = value.toStringAsFixed(2).split('.');
  final whole = parts[0]
      .replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.');
  return '₺$whole,${parts[1]}';
}
