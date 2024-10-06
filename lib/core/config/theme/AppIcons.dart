import 'package:foundational_learning_platform/core/utils/index.dart';

class AppIcons {
  static Icon searchIcon(BuildContext context) {
    final colorsTheme = Theme.of(context).extension<AppColorsTheme>()!;
    return Icon(
      Icons.search,
      color: colorsTheme.white,
    );
  }
}
