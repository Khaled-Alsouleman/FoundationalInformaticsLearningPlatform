import 'package:foundational_learning_platform/core/utils/index.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColorsTheme.light.primaryColor,
      scaffoldBackgroundColor: AppColorsTheme.light.backgroundColor,

      extensions: [
        AppColorsTheme.light,
        AppGradientsTheme.light,
      ],

      textTheme: AppTextStyles.getTextThemeLight(),
    );
  }
/*
  ///TODO darkTheme
  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: AppColorsTheme.dark.primaryColor,
      scaffoldBackgroundColor: AppColorsTheme.dark.backgroundColor,
      extensions: [],
      textTheme: AppTextStyles.getTextThemeDark(),
    );
  }

 */
}
