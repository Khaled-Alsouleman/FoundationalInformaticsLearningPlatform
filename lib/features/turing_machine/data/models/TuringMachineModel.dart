import 'package:foundational_learning_platform/features/turing_machine/data/models/TransitionFunctionModel.dart';

class TuringMachineModel {
  final List<String> states;
  final List<String> alphabet;
  final String turingSymbol;
  final List<TransitionFunctionModel> transitions;
  final String initialState;
  final List<String> finalStates;

  TuringMachineModel({
    required this.states,
    required this.alphabet,
    required this.turingSymbol,
    required this.transitions,
    required this.initialState,
    required this.finalStates,
  });

  factory TuringMachineModel.fromJson(Map<String, dynamic> json) {
    return TuringMachineModel(
      states: List<String>.from(json['states']),
      alphabet: List<String>.from(json['alphabet']),
      turingSymbol: json['turingSymbol'],
      transitions: (json['transitions'] as List)
          .map((e) => TransitionFunctionModel.fromJson(e))
          .toList(),
      initialState: json['initialState'],
      finalStates: List<String>.from(json['finalStates']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'states': states,
      'alphabet': alphabet,
      'turingSymbol': turingSymbol,
      'transitions': transitions.map((e) => e.toJson()).toList(),
      'initialState': initialState,
      'finalStates': finalStates,
    };
  }
}
