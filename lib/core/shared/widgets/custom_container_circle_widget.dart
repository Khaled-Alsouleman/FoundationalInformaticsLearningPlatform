import 'package:foundational_learning_platform/core/utils/index.dart';

class CircleContainer extends StatelessWidget {
      final int index;
      final int currentStep;
      final bool hasError;
      const CircleContainer(
          {super.key,
          required this.index,
          required this.currentStep,
          required this.hasError});

      @override
      Widget build(BuildContext context) {
        final colorTheme = Theme.of(context).extension<AppColorsTheme>()!;
        IconData? icon;
        Color? color;
        if (hasError && index == currentStep) {
          // Step has error
          icon = Icons.error;
          color = colorTheme.errorHeight;
        } else if (index < currentStep) {
          // Step is complete and error-free
          icon = Icons.check;
          color = colorTheme.green;
        } else if (index == currentStep) {
          // Step is in process
          icon = null;
          color = colorTheme.primaryColor;
        } else {
          // Step is not yet reached
          icon = null;
          color = colorTheme.white;
        }
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: AppDimensions.borderRadiusAll,
            border: Border.all(
              color: color,
              width: 2,
            ),
            color: color,
          ),
          child: Center(
            child: icon != null
                ? Icon(icon, color: Colors.white)
                : Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: index == currentStep ? Colors.white : Colors.black,
                    ),
                  ),
          ),
        );
      }
}
