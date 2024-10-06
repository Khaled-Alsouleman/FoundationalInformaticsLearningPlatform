import 'package:foundational_learning_platform/core/utils/index.dart';

class CanAddNewRuleUseCase {
  bool call(TuringMachineLoaded state) {
    bool allRulesComplete = state.turingMachine.transitions.every((rule) => IsRuleCompleteUseCase().call(rule));
    bool hasNoDuplicates = CheckForDuplicatesUseCase().call(state.turingMachine.transitions);
    return allRulesComplete && hasNoDuplicates;
  }
}
