import 'package:pdf/widgets.dart' as pw;
import 'package:foundational_learning_platform/core/utils/index.dart';

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
                              isActive: false,
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
  final pdf = pw.Document();

  final font = await rootBundle.load("fonts/NotoSans-Regular.ttf");
  final ttf = pw.Font.ttf(font);

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              isAccepted
                  ? 'Ergebnis: \n Die Turing-Maschine hat die Zeichenkette akzeptiert.'
                  : 'Ergebnis: \n Die Turing-Maschine hat die Zeichenkette nicht akzeptiert.',
              style: pw.TextStyle(font: ttf, fontSize: 14, fontWeight: pw.FontWeight.bold, color: isAccepted ? PdfColor.fromHex('#00b300')  : PdfColor.fromHex('#b30000') ),
            ),
            pw.SizedBox(height: 10),


            pw.Text('Turing-Maschinen Details:', style: pw.TextStyle(font: ttf, fontSize: 14)),
            pw.Text('Name: ${"Turing Machine Name"}', style: pw.TextStyle(font: ttf,fontSize: 12)),
            pw.Text('Beschreibung: ${"Turing Machine Description"}', style: pw.TextStyle(font: ttf,fontSize: 12)),
            pw.Text('Startzustand: ${"Q0"}', style: pw.TextStyle(font: ttf)),
            pw.Text('Endzustände: ${"Q4"}', style: pw.TextStyle(font: ttf)),
            pw.SizedBox(height: 10),

            pw.Text('Ausgeführte Schritte:', style: pw.TextStyle(font: ttf)),
            pw.Divider(),
            pw.SizedBox(height: 10),

            // Adding steps data
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Schritt', style: pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold)),
                pw.Text('Zustand', style: pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold)),
                pw.Text('Lesen', style: pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold)),
                pw.Text('Schreiben', style: pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold)),
                pw.Text('Bewegung', style: pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold)),
              ],
            ),

           pw.SizedBox(height: 12),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [

              ],
            ),
          ],
        );
      },
    ),
  );


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
