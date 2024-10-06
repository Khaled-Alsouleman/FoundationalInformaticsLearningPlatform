import 'package:foundational_learning_platform/core/utils/index.dart';
import 'package:foundational_learning_platform/features/turing_machine/presentation/widgets/custom_table_widget.dart';
void showResultDialog({
  required BuildContext context,
  required bool isAccepted,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      final colorsTheme = Theme.of(context).extension<AppColorsTheme>();
      return BlocBuilder<TuringMachineBloc, TuringMachineState>(
        builder: (context, tmState) {
          if (tmState is! TuringMachineLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          final tmCurrentState = tmState;
          return BlocBuilder<DynamicBandBloc, DynamicBandState>(
            builder: (context, dbState) {
              if (dbState is! DynamicBandLoaded) {
                return const Center(child: CircularProgressIndicator());
              }

              final dbCurrentState = dbState;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Dialog(
                  insetPadding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.8,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Ergebnisbericht
                          Text(
                            isAccepted
                                ? 'Ergebnis: Die Turing-Maschine hat die Zeichenkette "${dbState.originalInput}" akzeptiert.'
                                : 'Ergebnis: Die Turing-Maschine hat die Zeichenkette "${dbState.originalInput}" nicht akzeptiert.',
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isAccepted ? colorsTheme!.green : colorsTheme!.errorHeight,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Turing-Maschinen-Details
                          Text(
                            'Turing-Maschinen Details:',
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text('Name: ${tmCurrentState.turingMachine.name ?? "N/A"}'),
                          Text('Beschreibung: ${tmCurrentState.turingMachine.description ?? "N/A"}'),
                          Text('Startzustand: ${tmCurrentState.turingMachine.initialState}'),
                          Text('Endzustände: ${tmCurrentState.turingMachine.finalStates.join(', ')}'),
                          Text('Zustände: ${tmCurrentState.turingMachine.states.join(', ')}'),
                          Text('Bandalphabet: ${tmCurrentState.turingMachine.alphabet.join(', ')}'),
                          const SizedBox(height: 20),

                          // Transitionen - DynamicTuringMachineTable
                          Text(
                            'Transitionen:',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          DynamicTuringMachineTable(
                            states: tmCurrentState.turingMachine.states,
                            input: tmCurrentState.turingMachine.alphabet,
                            transitions: tmCurrentState.turingMachine.transitions,
                          ),
                          const SizedBox(height: 20),

                          // Bericht über ausgeführte Schritte
                          Text(
                            'Ausgeführte Schritte:',
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 Text('Schritt'),
                                 Text('Zustand'),
                                 Text('Lesen'),
                                 Text('Schreiben'),
                                 Text('Bewegung'),
                              ],
                            ),
                          ),
                          _buildExecutedStepsList(context, dbCurrentState.lastTransition ),
                          const SizedBox(height: 20),

                          // OK Button
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('OK'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
    },
  );
}

Widget _buildExecutedStepsList(BuildContext context, MyStack<dynamic>? steps) {

  if (steps == null || steps.isEmpty) {
    return const Text('Keine Schritte verfügbar.');
  }
  final lastSteps = steps.toList();
  return ListView.builder(
    controller: ScrollController(),
    shrinkWrap: true,
    itemCount: lastSteps.length,
    itemBuilder: (context, index) {
      final step = lastSteps[index];
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildDataCell(context,  '${index + 1}', true),
              _buildDataCell(context,  step.currentState, true),
              _buildDataCell(context, step.readSymbol, true),
              _buildDataCell(context, step.writtenSymbol, true),
              _buildDataCell(context, '${step.movementDirection}', true),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildDataCell(BuildContext context, String value, bool isTitle) {
  final textTheme = Theme.of(context).textTheme;
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        value,
        style: isTitle
            ? textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold)
            : textTheme.headlineSmall,
      ),
    ),
  );
}
