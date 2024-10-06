import 'package:foundational_learning_platform/core/utils/index.dart';

class UpdateAlphabetUseCase {
  final TuringMachineBloc turingMachineBloc;

  UpdateAlphabetUseCase({required this.turingMachineBloc});

  void call(List<String> alphabet) {
    turingMachineBloc.add(UpdateAlphabetEvent(alphabet));
  }
}
