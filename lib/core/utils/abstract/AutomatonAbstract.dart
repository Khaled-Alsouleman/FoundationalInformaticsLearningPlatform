abstract class AutomatonAbstract {
  final List<String> states;
  final List<String> alphabet;
  final String initialState;
  final List<String> finalStates;

  AutomatonAbstract({
    required this.states,
    required this.alphabet,
    required this.initialState,
    required this.finalStates,
  });


  bool isValidState(String state) {
    return states.contains(state);
  }


  bool isValidSymbol(String symbol) {
    return alphabet.contains(symbol);
  }


  bool isFinalState(String state) {
    return finalStates.contains(state);
  }


  String? getNextState(String currentState, String symbol);
}
