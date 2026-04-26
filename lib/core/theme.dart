import 'package:flutter/material.dart';

/// Paleta de colores del SGP.
/// Azul médico institucional como color primario.
class SgpColors {
  SgpColors._();

  static const primary = Color(0xFF1565C0);
  static const primaryLight = Color(0xFF1E88E5);
  static const primaryDark = Color(0xFF0D47A1);

  static const secondary = Color(0xFF00897B);
  static const secondaryLight = Color(0xFF26A69A);

  static const error = Color(0xFFD32F2F);
  static const warning = Color(0xFFF57C00);
  static const success = Color(0xFF388E3C);

  static const background = Color(0xFFF5F7FA);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceVariant = Color(0xFFECF0F4);

  static const textPrimary = Color(0xFF1A1A2E);
  static const textSecondary = Color(0xFF5A6270);
  static const textHint = Color(0xFF9EA8B3);
}

class SgpTheme {
  SgpTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: SgpColors.primary,
        brightness: Brightness.light,
        primary: SgpColors.primary,
        secondary: SgpColors.secondary,
        error: SgpColors.error,
        surface: SgpColors.surface,
      ),
      scaffoldBackgroundColor: SgpColors.background,
      fontFamily: 'Inter',

      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: SgpColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),

      // ElevatedButton — botón principal de la app
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: SgpColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          elevation: 0,
        ),
      ),

      // OutlinedButton — botón secundario
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: SgpColors.primary,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: const BorderSide(color: SgpColors.primary),
          textStyle: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // InputDecoration — campos de formulario
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: SgpColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFDDE3EC)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFDDE3EC)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: SgpColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: SgpColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: SgpColors.error, width: 2),
        ),
        labelStyle: const TextStyle(
          color: SgpColors.textSecondary,
          fontFamily: 'Inter',
        ),
        hintStyle: const TextStyle(
          color: SgpColors.textHint,
          fontFamily: 'Inter',
        ),
      ),

      // Card
      cardTheme: CardThemeData(
        color: SgpColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFFE8EDF3)),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: SgpColors.primary,
        brightness: Brightness.dark,
      ),
      fontFamily: 'Inter',
    );
  }
}
