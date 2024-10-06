import 'package:foundational_learning_platform/core/utils/index.dart';

class ControlExecutionUseCase {
  Timer? _timer;

  void startTimer(
      BuildContext context, int delay, TuringMachineBloc turingMachineBloc, TuringMachine tm) {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: delay), (timer) {
      final currentTransition = TuringMachineUtils.getNextTransition(
        context.read<DynamicBandBloc>().state as DynamicBandLoaded, tm.transitions,
      );
      if (currentTransition != null) {
        // Verwende hier den ExecuteTransitionUseCase
        ExecuteTransitionUseCase(
          turingMachineBloc: turingMachineBloc,
          dynamicBandBloc: context.read<DynamicBandBloc>(),
        ).call(currentTransition);
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }
}
