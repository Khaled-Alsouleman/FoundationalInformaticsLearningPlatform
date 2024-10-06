import 'package:foundational_learning_platform/core/utils/index.dart';

class AppGradientsTheme extends ThemeExtension<AppGradientsTheme> {
  final Gradient greenGradient;
  final Gradient orangeGradient;
  final Gradient primaryColorGradient;

  const AppGradientsTheme({
    required this.greenGradient,
    required this.orangeGradient,
    required this.primaryColorGradient,
  });

  @override
  AppGradientsTheme copyWith({
    Gradient? greenGradient,
    Gradient? orangeGradient,
    Gradient? blueGradient,
    Gradient? purpleGradient,
    Gradient? primaryColorGradient,
  }) {
    return AppGradientsTheme(
      greenGradient: greenGradient ?? this.greenGradient,
      orangeGradient: orangeGradient ?? this.orangeGradient,
      primaryColorGradient: primaryColorGradient ?? this.primaryColorGradient,
    );
  }

  @override
  AppGradientsTheme lerp(ThemeExtension<AppGradientsTheme>? other, double t) {
    if (other is! AppGradientsTheme) {
      return this;
    }

    return AppGradientsTheme(
      greenGradient: Gradient.lerp(greenGradient, other.greenGradient, t)!,
      orangeGradient: Gradient.lerp(orangeGradient, other.orangeGradient, t)!,
      primaryColorGradient: Gradient.lerp(primaryColorGradient, other.primaryColorGradient, t)!,
    );
  }

  static  AppGradientsTheme light = AppGradientsTheme(
    greenGradient: LinearGradient(
      colors: [
        const Color.fromARGB(255, 29, 221, 163),
        const Color.fromARGB(255, 42, 184, 60),
        const Color.fromARGB(255, 25, 171, 43),
        AppColorsTheme.light.green,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    orangeGradient: const LinearGradient(
      colors: [
        Color(0XFFF99E43),
        Color(0XFFDA2323),

      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    primaryColorGradient: RadialGradient(
      colors: [
        Colors.white10,
        Colors.white12,
        Colors.white12,
        AppColorsTheme.light.primaryColor,
        AppColorsTheme.light.accentColor,
      ],
      //begin: Alignment.topLeft,
      //end: Alignment.bottomRight,
    ),
  );

  /*

  static const AppGradientsTheme dark = AppGradientsTheme(
    greenGradient: LinearGradient(
      colors: [
        AppColorsTheme.dark.green,
        AppColorsTheme.dark.primaryColor,
        AppColorsTheme.dark.accentColor,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    orangeGradient: LinearGradient(
      colors: [
        AppColorsTheme.dark.errorLow,
        AppColorsTheme.dark.errorHeight,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    blueGradient: LinearGradient(
      colors: [
        AppColorsTheme.dark.secondaryColor,
        AppColorsTheme.dark.primaryColor,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    purpleGradient: LinearGradient(
      colors: [
        const Color.fromRGBO(82, 0, 163, 1.0),
        const Color.fromRGBO(104, 35, 200, 1.0),
        const Color.fromRGBO(82, 0, 163, 1.0),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    primaryColorGradient: LinearGradient(
      colors: [
        AppColorsTheme.dark.primaryColor,
        AppColorsTheme.dark.accentColor,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

   */
}
