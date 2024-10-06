
import 'package:foundational_learning_platform/core/utils/index.dart';
class TuringMachine {
  final String? name;
  final String? description;
  final List<String> states;
  final List<String> alphabet;
  final String? turingSymbol;
  final List<TMTransitionFunction> transitions;
  final String initialState;
  final List<String> finalStates;

  TuringMachine({
    this.name,
    this.description,
    required this.states,
    required this.alphabet,
    this.turingSymbol,
    required this.transitions,
    required this.initialState,
    required this.finalStates,
  });

  TuringMachine copyWith({
    String? name,
    String? description,
    List<String>? states,
    List<String>? alphabet,
    String? turingSymbol,
    List<TMTransitionFunction>? transitions,
    String? initialState,
    List<String>? finalStates,
  }) {
    return TuringMachine(
      name: name ?? this.name,
      description: description ?? this.description,
      states: states ?? this.states,
      alphabet: alphabet ?? this.alphabet,
      turingSymbol: turingSymbol ?? this.turingSymbol,
      transitions: transitions ?? this.transitions,
      initialState: initialState ?? this.initialState,
      finalStates: finalStates ?? this.finalStates,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'states': states,
      'alphabet': alphabet,
      'turingSymbol': turingSymbol,
      'transitions': transitions.map((x) => x.toMap()).toList(),
      'initialState': initialState,
      'finalStates': finalStates,
    };
  }

  factory TuringMachine.fromMap(Map<String, dynamic> map) {
    return TuringMachine(
      name: map['name'],
      description: map['description'],
      states: List<String>.from(map['states']),
      alphabet: List<String>.from(map['alphabet']),
      turingSymbol: map['turingSymbol'],
      transitions: List<TMTransitionFunction>.from(map['transitions']?.map((x) => TMTransitionFunction.fromMap(x))),
      initialState: map['initialState'],
      finalStates: List<String>.from(map['finalStates']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TuringMachine.fromJson(String source) => TuringMachine.fromMap(json.decode(source));

  static TuringMachine getDemo(){
    return TuringMachine(
        states: [],
        alphabet: [],
        transitions: [],
        initialState: '',
        finalStates: []
    );
  }

  @override
  String toString() {
    return 'TuringMachine{name: $name, description: $description, states: $states, alphabet: $alphabet, turingSymbol: $turingSymbol, transitions: $transitions, initialState: $initialState, finalStates: $finalStates}';
  }
}

