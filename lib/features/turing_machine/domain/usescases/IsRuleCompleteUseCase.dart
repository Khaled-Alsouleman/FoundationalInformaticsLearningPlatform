import 'package:foundational_learning_platform/core/utils/index.dart';
class IsRuleCompleteUseCase {
  bool call(TMTransitionFunction rule) {
    return rule.currentState.isNotEmpty &&
        rule.readSymbol.isNotEmpty &&
        rule.writtenSymbol.isNotEmpty &&
        rule.nextState.isNotEmpty;
  }
}
