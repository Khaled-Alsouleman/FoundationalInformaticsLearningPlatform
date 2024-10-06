import 'package:foundational_learning_platform/core/utils/index.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {

  static TextTheme getTextThemeLight() {
    return TextTheme(
      displayLarge: GoogleFonts.lato(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: AppColorsTheme.light.primaryColor,
      ),
      displayMedium: GoogleFonts.lato(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: AppColorsTheme.light.primaryColor,
      ),
      displaySmall: GoogleFonts.lato(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColorsTheme.light.primaryColor,
      ),
      headlineLarge: GoogleFonts.lato(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColorsTheme.light.primaryColor,
      ),
      headlineMedium: GoogleFonts.lato(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColorsTheme.light.primaryColor,
      ),
      headlineSmall: GoogleFonts.lato(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: AppColorsTheme.light.primaryColor,
      ),
      titleLarge: GoogleFonts.lato(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColorsTheme.light.primaryColor,
      ),
      titleMedium: GoogleFonts.lato(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColorsTheme.light.primaryColor,
      ),
      titleSmall: GoogleFonts.lato(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColorsTheme.light.primaryColor,
      ),
      bodyLarge: GoogleFonts.lato(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: AppColorsTheme.light.primaryColor,
      ),
      bodyMedium: GoogleFonts.lato(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColorsTheme.light.primaryColor,
      ),
      bodySmall: GoogleFonts.lato(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColorsTheme.light.primaryColor,
      ),
      labelLarge: GoogleFonts.lato(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColorsTheme.light.primaryColor,
      ),
      labelMedium: GoogleFonts.lato(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: AppColorsTheme.light.primaryColor,
      ),
      labelSmall: GoogleFonts.lato(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: AppColorsTheme.light.primaryColor,
      ),
    );
  }

///TODO
/*
  static TextTheme getTextThemeDark() {
    return TextTheme(
      displayLarge: GoogleFonts.lato(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: AppColorsTheme.dark.primaryColor,
      ),
      // Füge hier die weiteren TextStyles für das Dark Theme hinzu
    );
  }
 */
}
