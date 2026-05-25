import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Paleta de colores institucional del SGP.
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

  static const background = Color(0xFFF4F6FA);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceVariant = Color(0xFFEDF1F7);

  static const textPrimary = Color(0xFF0F1B2D);
  static const textSecondary = Color(0xFF546E7A);
  static const textHint = Color(0xFFB0BEC5);

  static const cardBorder = Color(0xFFE3E9F2);
  static const divider = Color(0xFFECF0F6);
}

class SgpTheme {
  SgpTheme._();

  static ThemeData get lightTheme {
    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: SgpColors.primary,
      onPrimary: Colors.white,
      primaryContainer: Color(0xFFD6E4FF),
      onPrimaryContainer: Color(0xFF001A41),
      secondary: SgpColors.secondary,
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFB2DFDB),
      onSecondaryContainer: Color(0xFF00251F),
      error: SgpColors.error,
      onError: Colors.white,
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFF410002),
      surface: SgpColors.surface,
      onSurface: SgpColors.textPrimary,
      surfaceContainerHighest: SgpColors.surfaceVariant,
      onSurfaceVariant: SgpColors.textSecondary,
      outline: Color(0xFFBDC7D6),
      outlineVariant: SgpColors.cardBorder,
      tertiary: Color(0xFF7B5EA7),
      onTertiary: Colors.white,
      tertiaryContainer: Color(0xFFEADDFF),
      onTertiaryContainer: Color(0xFF21005D),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: SgpColors.background,

      // ── AppBar ─────────────────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: SgpColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 2,
        centerTitle: false,
        shadowColor: SgpColors.primary.withValues(alpha: 0.3),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          letterSpacing: 0.2,
        ),
        iconTheme: const IconThemeData(color: Colors.white, size: 22),
        actionsIconTheme: const IconThemeData(color: Colors.white, size: 22),
      ),

      // ── ElevatedButton ─────────────────────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: SgpColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
      ),

      // ── FilledButton ───────────────────────────────────────────────────────
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ── OutlinedButton ─────────────────────────────────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: SgpColors.primary,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: const BorderSide(color: SgpColors.primary, width: 1.5),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ── TextButton ─────────────────────────────────────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: SgpColors.primary,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ── InputDecoration ────────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: SgpColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: SgpColors.cardBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: SgpColors.cardBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: SgpColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: SgpColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: SgpColors.error, width: 2),
        ),
        labelStyle: const TextStyle(
          color: SgpColors.textSecondary,
          fontSize: 14,
        ),
        hintStyle: const TextStyle(
          color: SgpColors.textHint,
          fontSize: 14,
        ),
        errorStyle: const TextStyle(
          color: SgpColors.error,
          fontSize: 12,
        ),
        prefixIconColor: WidgetStateColor.resolveWith((states) =>
            states.contains(WidgetState.focused)
                ? SgpColors.primary
                : SgpColors.textSecondary),
      ),

      // ── Card ───────────────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: SgpColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: SgpColors.cardBorder),
        ),
        margin: EdgeInsets.zero,
      ),

      // ── ListTile ───────────────────────────────────────────────────────────
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),

      // ── Chip ───────────────────────────────────────────────────────────────
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: const BorderSide(color: SgpColors.cardBorder),
        backgroundColor: SgpColors.surfaceVariant,
        selectedColor: SgpColors.primaryLight.withValues(alpha: 0.18),
        labelStyle: const TextStyle(fontSize: 13),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      ),

      // ── Divider ────────────────────────────────────────────────────────────
      dividerTheme: const DividerThemeData(
        color: SgpColors.divider,
        thickness: 1,
        space: 1,
      ),

      // ── SnackBar ───────────────────────────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: SgpColors.textPrimary,
        contentTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
      ),

      // ── Dialog ─────────────────────────────────────────────────────────────
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: SgpColors.surface,
        titleTextStyle: const TextStyle(
          color: SgpColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),

      // ── ExpansionTile ──────────────────────────────────────────────────────
      expansionTileTheme: const ExpansionTileThemeData(
        shape: Border(),
        collapsedShape: Border(),
        tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),

      // ── FloatingActionButton ───────────────────────────────────────────────
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: SgpColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
      ),

      // ── Typography ─────────────────────────────────────────────────────────
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            color: SgpColors.textPrimary, fontWeight: FontWeight.w800),
        displayMedium: TextStyle(
            color: SgpColors.textPrimary, fontWeight: FontWeight.w700),
        headlineLarge: TextStyle(
            color: SgpColors.textPrimary, fontWeight: FontWeight.w700),
        headlineMedium: TextStyle(
            color: SgpColors.textPrimary, fontWeight: FontWeight.w700),
        headlineSmall: TextStyle(
            color: SgpColors.textPrimary, fontWeight: FontWeight.w600),
        titleLarge: TextStyle(
            color: SgpColors.textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 20),
        titleMedium: TextStyle(
            color: SgpColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 16),
        titleSmall: TextStyle(
            color: SgpColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 14),
        bodyLarge: TextStyle(color: SgpColors.textPrimary, fontSize: 16),
        bodyMedium: TextStyle(color: SgpColors.textSecondary, fontSize: 14),
        bodySmall: TextStyle(color: SgpColors.textSecondary, fontSize: 12),
        labelLarge: TextStyle(
            color: SgpColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 14),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: SgpColors.primary,
        brightness: Brightness.dark,
        primary: const Color(0xFF90CAF9),
        secondary: const Color(0xFF80CBC4),
      ),
      scaffoldBackgroundColor: const Color(0xFF0F1B2D),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: Color(0xFF1E2D42)),
        ),
        color: const Color(0xFF162032),
      ),
    );
  }
}
