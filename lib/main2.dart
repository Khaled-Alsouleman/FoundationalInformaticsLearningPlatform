class TuringMachine {
  final List<Transition> transitions;

  TuringMachine({
    required this.transitions,
  });

  Transition? getTransition(String currentState, String inputSymbol) {
    // Finde die Transition, die zum aktuellen Zustand und Eingabesymbol passt
    try {
      return transitions.firstWhere(
            (transition) =>
        transition.currentState == currentState &&
            transition.readSymbol == inputSymbol,
      );
    } catch (e) {
      return null; // Keine passende Transition gefunden

    }
  }
}

class Transition {
  final String currentState;
  final String readSymbol;
  final String nextState;
  final String writtenSymbol;
  final String movementDirection;

  Transition({
    required this.currentState,
    required this.readSymbol,
    required this.nextState,
    required this.writtenSymbol,
    required this.movementDirection,
  });
}

void main() {
  List<Transition> transitions = [
    Transition(
      currentState: "Q0",
      readSymbol: "1",
      nextState: "Q0",
      writtenSymbol: "0",
      movementDirection: "RIGHT",
    ),
    Transition(
      currentState: "Q0",
      readSymbol: "0",
      nextState: "Q0",
      writtenSymbol: "0",
      movementDirection: "RIGHT",
    ),
    Transition(
      currentState: "Q0",
      readSymbol: "◇",
      nextState: "Q1",
      writtenSymbol: "◇",
      movementDirection: "RIGHT",
    ),
    Transition(
      currentState: "Q1",
      readSymbol: "◇",
      nextState: "Q1",
      writtenSymbol: "◇",
      movementDirection: "LEFT",
    ),
  ];

  TuringMachine turingMachine = TuringMachine(transitions: transitions);
  String currentState = "Q0";
  String inputSymbol = "1";

  Transition? transition = turingMachine.getTransition(currentState, inputSymbol);

  if (transition != null) {
    print("Gefundene Transition: "
        "(${transition.currentState}, ${transition.readSymbol}) -> "
        "(${transition.nextState}, ${transition.writtenSymbol}, ${transition.movementDirection})");
  } else {
    print("Keine passende Transition gefunden.");
  }
}
