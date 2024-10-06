import 'package:foundational_learning_platform/core/utils/index.dart';
import 'package:collection/collection.dart';

class TuringMachineUtils  extends Utils {

  static TMTransitionFunction getCurrentTransition(
      List<TMTransitionFunction> transitions, String currentState, String? currentSymbol) {
    final resTransition = transitions.firstWhere(
          (element) => element.readSymbol == currentSymbol && element.currentState == currentState,
      orElse: () => throw Exception('Keine gültige Transition gefunden'),
    );
    return resTransition;
  }

  static String? validateInput(String? value, List<String> alphabet) {
    return Utils.validateInput(value, alphabet);
  }

  static Map<int, String> getBandItems(int left, int right, String input) {
    return Utils.getBandItems(left, right, input);
  }

  static List<int> getNumberOfBlankSymbols(String input) {
    return Utils.getNumberOfBlankSymbols(input);
  }
  static TMTransitionFunction? getNextTransition(DynamicBandLoaded bandState, List<TMTransitionFunction> transitions) {
    return transitions.firstWhereOrNull(
          (e) => e.currentState == bandState.currentState && e.readSymbol == bandState.tape[bandState.headLocation],
    );
  }
}
