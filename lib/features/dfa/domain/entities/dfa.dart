import 'package:foundational_learning_platform/core/utils/index.dart';

abstract class Dfa extends AutomatonAbstract {

  final List<DfaTransitionFunction> transitions;

  Dfa({
    required super.states,
    required super.alphabet,
    required this.transitions,
    required super.initialState,
    required super.finalStates,
  });

}
