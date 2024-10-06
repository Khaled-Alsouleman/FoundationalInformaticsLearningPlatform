import 'package:foundational_learning_platform/core/utils/index.dart';
class CheckForDuplicatesUseCase {
  bool call(List<TMTransitionFunction> transitions) {
    final seen = <String>{};
    for (var transition in transitions) {
      String transitionKey = '${transition.currentState}_${transition.readSymbol}_${transition.nextState}';
      if (seen.contains(transitionKey)) {
        return false;
      }
      seen.add(transitionKey);
    }
    return true;
  }
}
