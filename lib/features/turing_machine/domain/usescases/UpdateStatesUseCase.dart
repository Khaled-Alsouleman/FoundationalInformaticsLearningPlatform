import 'package:foundational_learning_platform/core/utils/index.dart';
class UpdateStatesUseCase {
  final TuringMachineBloc turingMachineBloc;
  final TMListSelectableBloc tmListSelectableBloc;

  UpdateStatesUseCase({
    required this.turingMachineBloc,
    required this.tmListSelectableBloc,
  });

  void call(List<String> states) {
    turingMachineBloc.add(UpdateStatesEvent(states));
    tmListSelectableBloc.add(TMUpdateSelectableItems(items: states));
  }
}
