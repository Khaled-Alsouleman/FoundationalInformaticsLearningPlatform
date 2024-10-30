import 'package:foundational_learning_platform/features/dfa/domain/entities/dfaTransitionFunction.dart';

class DfaTransitionFunctionModel extends DfaTransitionFunction {
  DfaTransitionFunctionModel({
    required String currentState,
    required String readSymbol,
    required String nextState,
  }) : super(
    currentState: currentState,
    readSymbol: readSymbol,
    nextState: nextState,
  );

  factory DfaTransitionFunctionModel.fromJson(Map<String, dynamic> json) {
    return DfaTransitionFunctionModel(
      currentState: json['currentState'],
      readSymbol: json['readSymbol'],
      nextState: json['nextState'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'currentState': currentState,
      'readSymbol': readSymbol,
      'nextState': nextState,
    };
  }
}
