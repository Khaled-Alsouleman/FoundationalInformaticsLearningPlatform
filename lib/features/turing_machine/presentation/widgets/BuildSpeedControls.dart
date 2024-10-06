import 'package:foundational_learning_platform/core/utils/index.dart';

class BuildSpeedControls extends StatelessWidget {
  const BuildSpeedControls({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DynamicBandBloc, DynamicBandState>(
      builder: (context, state) {
        return Container(
          width: 500,
          height: 100,
          color: Colors.transparent,
          child: MySlider(
            value: (state as DynamicBandLoaded).autoSpeed,
            onChange: (value) {
              int speedInMillis = (value * 1000).toInt();
              context.read<DynamicBandBloc>().add(UpdateSpeed(
                speedInMillis,
                ControlAction.stop,
              ));
            },
          ),
        );
      },
    );
  }
}
