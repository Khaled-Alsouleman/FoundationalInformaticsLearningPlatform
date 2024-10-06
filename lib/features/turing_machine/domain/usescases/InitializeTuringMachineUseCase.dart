import 'package:foundational_learning_platform/core/utils/index.dart';

class InitializeTuringMachineUseCase {
  final TuringMachineBloc turingMachineBloc;

  InitializeTuringMachineUseCase({required this.turingMachineBloc});

  void call(String input, TuringMachine turingMachine) {
    turingMachineBloc.add(InitTuringMachineEvent(input: input, turingMachine: turingMachine));
  }
}
