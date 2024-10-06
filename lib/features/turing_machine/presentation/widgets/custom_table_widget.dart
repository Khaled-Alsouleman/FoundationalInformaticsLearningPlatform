import 'package:foundational_learning_platform/core/utils/index.dart';

class DynamicTuringMachineTable extends StatelessWidget {
  final List<String> states;
  final List<String> input;
  final List<TMTransitionFunction> transitions;

  const DynamicTuringMachineTable({
    Key? key,
    required this.states,
    required this.input,
    required this.transitions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      columnWidths: const {0: FixedColumnWidth(50.0)},
      children: [
        _buildHeaderRow(),
        ...input.map(_buildDataRow).toList(),
      ],
    );
  }

  TableRow _buildHeaderRow() => TableRow(
    children: [
      _buildTableCell('δ', isHeader: true),
      ...states.map((state) => _buildTableCell(state, isHeader: true)),
    ],
  );


  TableRow _buildDataRow(String symbol) => TableRow(
    children: [
      _buildTableCell(symbol),
      ...states.map((state) {
        final transition = transitions.firstWhere(
              (t) => t.currentState == state && t.readSymbol == symbol,
          orElse: () => TMTransitionFunction(
            currentState: state,
            readSymbol: symbol,
            nextState: '-',
            writtenSymbol: '-',
            movementDirection: MovementDirection.bleiben,
          ),
        );
        return _buildTableCell(
          "(${transition.nextState}, ${transition.writtenSymbol}, ${transition.movementDirection.name[0].toUpperCase()})",
        );
      }).toList(),
    ],
  );


  Widget _buildTableCell(String text, {bool isHeader = false}) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        fontSize: 16.0,
      ),
    ),
  );
}
