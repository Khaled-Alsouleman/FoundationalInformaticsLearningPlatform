import 'package:foundational_learning_platform/core/utils/index.dart';

class TMResultPage extends StatelessWidget {
  final TuringMachine turingMachine;

  const TMResultPage({Key? key, required this.turingMachine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Description: ${turingMachine.description}'),
          Text('States: ${turingMachine.states.join(', ')}'),
          Text('Alphabet: ${turingMachine.alphabet.join(', ')}'),
          Text('Initial State: ${turingMachine.initialState}'),
          Text('Accepted State: ${turingMachine.finalStates.join(',')}'),
        ],
      ),
    );
  }
}
