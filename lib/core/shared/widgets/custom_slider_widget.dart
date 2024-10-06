import 'package:foundational_learning_platform/core/utils/index.dart';


class MySlider extends StatelessWidget {
  final int value;
  final ValueChanged<double> onChange;

  const MySlider({super.key, required this.value, required this.onChange});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<AppColorsTheme>();

    return Material(
      color: colorTheme!.transparent,
      child: Row(
        children: [
          const Text('0.5 s'),
          Expanded(
            child: Slider(
              activeColor: colorTheme.primaryColor,
              inactiveColor: colorTheme.inactiveColor,
              value: value / 1000,
              min: 0.5,
              max: 2.0,
              divisions: 3,
              label: "${(value / 1000).toStringAsFixed(1)} s",
              onChanged: onChange,
            ),
          ),
          const Text('2 s'),
        ],
      ),
    );
  }
}
