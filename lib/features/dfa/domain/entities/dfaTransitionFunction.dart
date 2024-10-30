import 'package:foundational_learning_platform/core/utils/index.dart';

abstract class DfaTransitionFunction extends TransitionFunctionAbstract {
  DfaTransitionFunction(
      {required super.currentState,
      required super.readSymbol,
      required super.nextState});
}
