import 'package:foundational_learning_platform/core/utils/index.dart';

class InitializeStatesUseCase {
  final TMListSelectableBloc tmListSelectableBloc;

  InitializeStatesUseCase({
    required this.tmListSelectableBloc,
  });

  void call(TuringMachineLoaded state) {
    if (state.turingMachine.initialState.isNotEmpty) {
      final startStateIndex = state.turingMachine.states.indexOf(state.turingMachine.initialState);
      tmListSelectableBloc.add(TMUpdateSelectedIndex(
        selectedIndex: startStateIndex,
        isStartState: true,
        isMultiSelectable: false,
      ));
    }

    if (state.turingMachine.finalStates.isNotEmpty) {
      final endStateIndices = state.turingMachine.finalStates.map((endState) => state.turingMachine.states.indexOf(endState)).toList();
      for (var index in endStateIndices) {
        tmListSelectableBloc.add(TMUpdateSelectedIndex(
          selectedIndex: index,
          isStartState: false,
          isMultiSelectable: true,
        ));
      }
    }
  }
}
