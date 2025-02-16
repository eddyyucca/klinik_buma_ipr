import 'package:flutter/material.dart';

// Kelas untuk menyimpan warna aplikasi
class AppColors {
  // Warna utama
  static const primary = Color(0xFF22C55E); // Hijau
  static const secondary = Color(0xFFFF9800); // Orange
  static const accent = Color(0xFF3B82F6); // Biru

  // Warna background
  static const background = Color(0xFFF9FAFB);
  static const cardBg = Colors.white;
  static const searchBg = Color(0xFFF3F4F6);

  // Warna teks
  static const textPrimary = Color(0xFF1F2937);
  static const textSecondary = Color(0xFF6B7280);
  static const textLight = Color(0xFF9CA3AF);

  // Warna status
  static const success = Color(0xFF22C55E);
  static const warning = Color(0xFFF59E0B);
  static const error = Color(0xFFEF4444);
  static const info = Color(0xFF3B82F6);

  // Warna gradient
  static final gradientPrimary = [
    primary,
    primary.withOpacity(0.8),
  ];

  static final gradientSecondary = [
    secondary,
    secondary.withOpacity(0.8),
  ];
}

// Kelas untuk menyimpan ukuran dan padding
class AppSizes {
  // Padding
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;

  // Radius
  static const double radiusS = 4.0;
  static const double radiusM = 8.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;

  // Icon sizes
  static const double iconS = 16.0;
  static const double iconM = 24.0;
  static const double iconL = 32.0;
  static const double iconXL = 40.0;
}

// Kelas untuk menyimpan tema aplikasi
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,

    // AppBar theme
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),

    // Card theme
    cardTheme: CardTheme(
      color: AppColors.cardBg,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusL),
      ),
    ),

    // Button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingL,
          vertical: AppSizes.paddingM,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
        ),
      ),
    ),

    // Text theme
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: AppColors.textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: AppColors.textSecondary,
      ),
    ),

    // Input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.searchBg,
      contentPadding: const EdgeInsets.all(AppSizes.paddingM),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
    ),
  );
}

// String constants
class AppStrings {
  static const appName = 'Klinik Sehat';
  static const welcome = 'Selamat datang';
  static const searchHint = 'Cari dokter atau layanan...';

  // Button texts
  static const create = 'Buat';
  static const update = 'Perbarui';
  static const delete = 'Hapus';
  static const cancel = 'Batal';
  static const save = 'Simpan';
  static const next = 'Selanjutnya';
  static const back = 'Kembali';

  // Error messages
  static const errorGeneral = 'Terjadi kesalahan';
  static const errorConnection = 'Koneksi terputus';
  static const errorInvalidInput = 'Input tidak valid';
}
