import 'package:foundational_learning_platform/features/dfa/domain/entities/dfa.dart';
import 'package:foundational_learning_platform/features/dfa/data/models/dfaTransitionFunctionModel.dart';
import 'package:foundational_learning_platform/core/utils/index.dart';
class DfaModel extends Dfa {
  DfaModel({
    required List<String> states,
    required List<String> alphabet,
    required List<DfaTransitionFunctionModel> transitions,
    required String initialState,
    required List<String> finalStates,
  }) : super(
    states: states,
    alphabet: alphabet,
    transitions: transitions,
    initialState: initialState,
    finalStates: finalStates,
  );

  
  Map<String, dynamic> toMap() {
    return {
      'states': states,
      'alphabet': alphabet,
      'transitions': transitions.map((e) => e.toMap()).toList(),
      'initialState': initialState,
      'finalStates': finalStates,
    };
  }

  
  factory DfaModel.fromJson(Map<String, dynamic> json) {
    return DfaModel(
      states: List<String>.from(json['states']),
      alphabet: List<String>.from(json['alphabet']),
      transitions: (json['transitions'] as List)
          .map((e) => DfaTransitionFunctionModel.fromJson(e))
          .toList(),
      initialState: json['initialState'],
      finalStates: List<String>.from(json['finalStates']),
    );
  }

  @override
  String? getNextState(String currentState, String symbol) {
    final DfaTransitionFunction transition = transitions.firstWhere(
          (transition) =>
      transition.currentState == currentState && transition.readSymbol == symbol
    );

    return transition.nextState;
  }


}
