
import 'package:foundational_learning_platform/core/utils/index.dart';
import '../../domain/usescases/generateTuringMachinePDF.dart';

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

              final colorTheme = Theme.of(context).extension<AppColorsTheme>();
              final input = tmCurrentState.turingMachine.alphabet;
              if(input.last != AppContents.blanketSymbol){
                input.add(AppContents.blanketSymbol);
              }
              return Dialog(
                insetPadding: const EdgeInsets.all(AppDimensions.paddingLarge),
                child: Container(
                  decoration: BoxDecoration(
                    color: colorsTheme!.backgroundColor,
                    borderRadius: AppDimensions.borderRadiusAll
                  ),
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.8,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppDimensions.paddingXLarge),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              isAccepted
                                  ? 'Ergebnis: Die Turing-Maschine hat die Zeichenkette "${dbState.originalInput}" akzeptiert.'
                                  : 'Ergebnis: Die Turing-Maschine hat die Zeichenkette "${dbState.originalInput}" nicht akzeptiert.',
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: isAccepted ? colorsTheme.green : colorsTheme.errorHeight,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: AppDimensions.paddingLarge),

                        Text(
                          'Turing-Maschinen Details:',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(color: colorTheme!.primaryColor),
                        const SizedBox(height: 10),
                        Text('Name: \n ${tmCurrentState.turingMachine.name ?? "N/A"}'),
                        Text('Beschreibung:\n ${tmCurrentState.turingMachine.description ?? "N/A"}'),
                        Text('Startzustand:\n ${tmCurrentState.turingMachine.initialState}'),
                        Text('Endzustände:\n {${tmCurrentState.turingMachine.finalStates.join(', ')}}'),
                        Text('Zustände:\n {${tmCurrentState.turingMachine.states.join(', ')}}'),
                        Text('Bandalphabet:\n {${tmCurrentState.turingMachine.alphabet.join(', ')}}'),
                        const SizedBox(height: 20),

                        Text(
                          'Transitionen:',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(color: colorTheme.primaryColor),
                        const SizedBox(height: 10),
                        DynamicTuringMachineTable(
                          states: tmCurrentState.turingMachine.states,
                          input: input,
                          transitions: tmCurrentState.turingMachine.transitions,
                        ),
                        const SizedBox(height: 20),

                        Text(
                          'Ausgeführte Schritte:',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(color: colorTheme.primaryColor),
                        const SizedBox(height: 10),

                         Padding(
                          padding: const EdgeInsets.all(AppDimensions.paddingSmall),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildDataCell(context,'Schritt', true ),
                              _buildDataCell(context,'Zustand', true ),
                              _buildDataCell(context,'Lesen', true ),
                              _buildDataCell(context,'Schreiben', true ),
                              _buildDataCell(context,'Nächster Zustand', true ),
                              _buildDataCell(context,'Bewegung', true ),
                            ],
                          ),
                        ),


                        _buildExecutedStepsList(context, isAccepted),
                        const SizedBox(height: 20),

                        // Download PDF Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomButton(
                              isActive: true,
                              onPressed: () {
                                _generatePDF(context, isAccepted);
                              },
                              child: const Text("Herunterladen"),
                            ),
                            const SizedBox(width: AppDimensions.paddingLarge,),
                            CustomButton(
                              
                              onPressed: () {
                                Navigator.of(context).pop();
                            },
                              child: const Text("Zurück"),
                            ),
                          ],
                        ),
                      ],
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




Future<void> _generatePDF(BuildContext context, bool isAccepted) async {
  final PdfService pdfService = PdfServiceFactory.createPdfService();
  final generator = GenerateTuringMachinePDF(pdfService);

  final bandState = context.read<DynamicBandBloc>().state as DynamicBandLoaded;
  final tmState = context.read<TuringMachineBloc>().state as TuringMachineLoaded;

  final Map<String, dynamic> machineDetails = {
    'Name': tmState.turingMachine.name ?? "Keine Name vorhanden",
    'Beschreibung': tmState.turingMachine.description ?? "Keine Beschreibung vorhanden",
    'Startzustand': tmState.turingMachine.initialState,
    'Endzustände': '{${tmState.turingMachine.finalStates.join(', ')}}',
    'Zustände': '{${tmState.turingMachine.states.join(', ')}}',
    'Bandalphabet': '{${tmState.turingMachine.alphabet.join(', ')}}',
    'Blanket symbol': AppContents.blanketSymbol,
  };


  final List<Map<String, String>> transitions = tmState.turingMachine.transitions.map((t) => {
    'currentState': t.currentState,
    'readSymbol': t.readSymbol,
    'nextState': t.nextState,
    'writtenSymbol': t.writtenSymbol,
    'movement': t.movementDirection.name,
  }).toList();


  final steps = (context.read<ReportBloc>().state as ReportLoaded)
      .transitions
      .asMap()
      .entries
      .map((entry) {
    final index = entry.key;
    final step = entry.value;


    return {
      'stepNumber': index + 1,
      'currentState': step.currentState,
      'readSymbol': step.readSymbol,
      'writtenSymbol': step.writtenSymbol,
      'nextState': step.nextState,
      'movementDirection': step.movementDirection.name,
    };
  }).toList();



  final List<String> bandAlphabet = tmState.turingMachine.alphabet;
  final List<String> states = tmState.turingMachine.states;
  final List<TMTransitionFunction> tmTransitions = tmState.turingMachine.transitions;

  final Uint8List pdfData = await generator.call(
    isAccepted: isAccepted,
    inputString: bandState.originalInput,
    machineDetails: machineDetails,
    transitions: transitions,
    steps: steps,
    bandSymbol: bandAlphabet,
    states: states,
    tmTransitions: tmTransitions
  );


  if (kIsWeb) {
    await pdfService.printPDF(pdfData);
  } else {
    await pdfService.savePDF(pdfData, "Ergebnis.pdf");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('PDF wurde heruntergeladen')),
    );
  }
}


Widget _buildExecutedStepsList(BuildContext context, bool isAccepted) {
  final colorTheme = Theme.of(context).extension<AppColorsTheme>();
  return BlocBuilder<ReportBloc, ReportState>(
    builder: (context, state) {
      final transList = (state as ReportLoaded).transitions;
      return ListView.builder(
        controller: ScrollController(),
        shrinkWrap: true,
        itemCount: transList.length,
        itemBuilder: (context, index) {
          final step = transList[index];
          return Card(
            color: isAccepted ? colorTheme!.green : colorTheme!.errorLow,
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingMedium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDataCell(context, '${index + 1}', false),
                  _buildDataCell(context, step.currentState, false),
                  _buildDataCell(context, step.readSymbol, false),
                  _buildDataCell(context, step.writtenSymbol, false),
                  _buildDataCell(context, step.nextState, false),
                  _buildDataCell(context, step.movementDirection.name, false),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

Widget _buildDataCell(BuildContext context, String value, bool isTitle) {
  final textTheme = Theme.of(context).textTheme;
  final colorTheme = Theme.of(context).extension<AppColorsTheme>();
  return Expanded(
    child: Text(
      value,
      textAlign: TextAlign.center,
      style: isTitle
          ? textTheme.labelLarge
          : textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold, color: colorTheme!.white),
    ),
  );
}
