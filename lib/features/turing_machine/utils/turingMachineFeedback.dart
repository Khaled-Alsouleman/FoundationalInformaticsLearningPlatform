import 'package:foundational_learning_platform/core/utils/index.dart';

class TuringMachineFeedback extends StatelessWidget {
  final String currentState;
  final String readSymbol;
  final String nextState;
  final String writtenSymbol;
  final String direction;

  const TuringMachineFeedback({super.key,
    required this.currentState,
    required this.readSymbol,
    required this.nextState,
    required this.writtenSymbol,
    required this.direction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        "Zustand: $currentState | Symbol: '$readSymbol' | Aktion: Schreibe '$writtenSymbol', bewege nach $direction | Nächster Zustand: $nextState",
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}
