import 'package:foundational_learning_platform/core/utils/index.dart';
import 'package:pdf/widgets.dart' as pw;

class TMPdfServiceWeb implements PdfService {
  final pw.Document pdf = pw.Document();

  @override
  Future<Uint8List> generateTmPdf(
      {required bool isAccepted,
      required String inputString,
      required Map<String, dynamic> machineDetails,
      required List<Map<String, String>> transitions,
      required List<Map<String, dynamic>> steps,
      required List<String> bandSymbol,
      required List<String> states,
      required List<TMTransitionFunction> tmTransitions}) async {
    final fontData = await rootBundle.load("fonts/Inter-Regular.ttf");
    final ttf = pw.Font.ttf(fontData);

    final logoData = await rootBundle.load('images/thws_logo.png');
    final logo = logoData.buffer.asUint8List();

    final textColor =
        isAccepted ? PdfColor.fromHex('#00b300') : PdfColor.fromHex('#b30000');

    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) => [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'Grundlagen der Informatik',
                style: pw.TextStyle(
                  font: ttf,
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColor.fromHex('#141e30'),
                ),
              ),
              pw.SizedBox(width: 50),
              pw.Image(
                pw.MemoryImage(logo),
                width: 100,
                height: 50,
              ),
            ],
          ),
          pw.Divider(),
          pw.SizedBox(height: 20),

          // Ergebnis Text (Grün oder Rot)
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text(
                  isAccepted
                      ? 'Ergebnis: Die Zeichenkette "$inputString" wurde akzeptiert.'
                      : 'Ergebnis: Die Zeichenkette "$inputString" wurde nicht akzeptiert.',
                  style: pw.TextStyle(
                    font: ttf,
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ]),
          pw.SizedBox(height: 20),

          // Turing-Maschinen Details
          _buildTitle('Turing-Maschinen Details:', ttf),
          pw.SizedBox(height: 10),
          ...machineDetails.entries.map((entry) {
            return pw.Text(
              '${entry.key}:\n${entry.value} \n \n',
              style: pw.TextStyle(
                  font: ttf, fontSize: 14, fontWeight: pw.FontWeight.bold),
            );
          }).toList(),
          pw.SizedBox(height: 20),

          // Übergangstabelle
          _buildTitle('Übergangstabelle:', ttf),
          pw.SizedBox(height: 10),
          _buildTransitionTable(ttf, bandSymbol, states, tmTransitions),
          pw.SizedBox(height: 20),

          // Ausgeführte Schritte
          _buildTitle('Ausgeführte Schritte:', ttf),
          pw.SizedBox(height: 10),
          _buildStepsTable(ttf, steps, isAccepted),
        ],
      ),
    );

    return pdf.save();
  }

  pw.Widget _buildTransitionTable(pw.Font ttf, List<String> bandAlphabet,
      List<String> states, List<TMTransitionFunction> transitions) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColor.fromHex('#CCCCCC')),
      columnWidths: {
        0: const pw.FixedColumnWidth(50),
        for (var i = 0; i < states.length; i++)
          i + 1: const pw.FlexColumnWidth(),
      },
      children: [
        pw.TableRow(
          children: [
            pw.Container(
                color: PdfColor.fromHex('#141e30'),
                alignment: pw.Alignment.center,
                child: pw.Padding(
                  padding: const pw.EdgeInsets.all(5),
                  child: pw.Text('δ',
                      style: pw.TextStyle(
                          font: ttf,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColor.fromHex('#FFFFFF'))),
                )),
            ...states
                .map((state) => pw.Container(
                    color: PdfColor.fromHex('#141e30'),
                    alignment: pw.Alignment.center,
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text(state,
                          style: pw.TextStyle(
                              font: ttf,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColor.fromHex('#FFFFFF'))),
                    )))
                .toList(),
          ],
        ),
        for (var symbol in bandAlphabet)
          pw.TableRow(
            children: [
              pw.Container(
                color: PdfColor.fromHex('#141e30'),
                alignment: pw.Alignment.center,
                child: pw.Padding(
                    padding: const pw.EdgeInsets.all(5),
                    child: pw.Text(symbol,
                        style: pw.TextStyle(
                            font: ttf, color: PdfColor.fromHex('#FFFFFF')))),
              ),
              ...states.map((state) {
                final transition = transitions.firstWhere(
                  (t) => t.currentState == state && t.readSymbol == symbol,
                  orElse: () => TMTransitionFunction(
                      currentState: '-',
                      readSymbol: '-',
                      nextState: '-',
                      movementDirection: MovementDirection.bleiben,
                      writtenSymbol: '-'),
                );
                final movement = transition.movementDirection.name == 'rechts'
                    ? 'R'
                    : transition.movementDirection.name == 'links'
                        ? 'L'
                        : 'B';
                return pw.Container(
                  alignment: pw.Alignment.center,
                  child: pw.Padding(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text(
                        "( ${transition.nextState}, ${transition.readSymbol}, $movement )",
                        style: pw.TextStyle(font: ttf),
                      )),
                );
              }).toList(),
            ],
          ),
      ],
    );
  }

  pw.Widget _buildStepsTable(
      pw.Font ttf, List<Map<String, dynamic>> steps, bool isAccepted) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColor.fromHex('#CCCCCC')),
      columnWidths: {
        0: const pw.FlexColumnWidth(), // Schritt Spalte
        1: const pw.FlexColumnWidth(), // Zustand Spalte
        2: const pw.FlexColumnWidth(), // Lesen Spalte
        3: const pw.FlexColumnWidth(), // Schreiben Spalte
        4: const pw.FlexColumnWidth(), // Nächster Zustand Spalte
        5: const pw.FlexColumnWidth(), // Bewegung Spalte
      },
      children: [
        // Header Row
        pw.TableRow(
          children: [
            _buildStepsHeader('Schritt', ttf),
            _buildStepsHeader('Von', ttf),
            _buildStepsHeader('Lesen', ttf),
            _buildStepsHeader('Schreiben', ttf),
            _buildStepsHeader('Nach', ttf),
            _buildStepsHeader('Bewegung', ttf),
          ],
        ),
        // Steps Rows
        ...steps.asMap().entries.map((entry) {
          final step = entry.value;
          final isLastStep = entry.key == steps.length - 1;

          return pw.TableRow(
            children: [
              _buildStepRow(
                  step['stepNumber'].toString(), isLastStep, isAccepted, ttf),
              _buildStepRow(
                  step['currentState'].toString(), isLastStep, isAccepted, ttf),
              _buildStepRow(
                  step['readSymbol'].toString(), isLastStep, isAccepted, ttf),
              _buildStepRow(step['writtenSymbol'].toString(), isLastStep,
                  isAccepted, ttf),
              _buildStepRow(
                  step['nextState'].toString(), isLastStep, isAccepted, ttf),
              _buildStepRow(step['movementDirection'].toString(), isLastStep,
                  isAccepted, ttf),
            ],
          );
        }).toList(),
      ],
    );
  }

  pw.Container _buildStepRow(
      String step, bool isLastStep, bool isAccepted, pw.Font ttf) {
    var currentColor = PdfColor.fromHex('#FFFFFF');
    var fontColor =
        isLastStep ? PdfColor.fromHex('#FFFFFF') : PdfColor.fromHex('#141E30');
    if (isLastStep) {
      currentColor = isAccepted
          ? PdfColor.fromHex('#008000')
          : PdfColor.fromHex('#FF0000');
    }
    return pw.Container(
      color: currentColor,
      alignment: pw.Alignment.center,
      padding: const pw.EdgeInsets.all(5),
      child: pw.Text(step, style: pw.TextStyle(font: ttf, color: fontColor)),
    );
  }

  pw.Container _buildStepsHeader(String header, pw.Font ttf) {
    return pw.Container(
      color: PdfColor.fromHex('#141F30'),
      alignment: pw.Alignment.center,
      padding: const pw.EdgeInsets.all(5),
      child: pw.Text(header,
          style: pw.TextStyle(
              font: ttf,
              fontWeight: pw.FontWeight.bold,
              color: PdfColor.fromHex('#FFFFFF'))),
    );
  }

  pw.Container _buildTitle(String title, pw.Font ttf) {
    return pw.Container(
      width: double.maxFinite,
      color: PdfColor.fromHex('#141e30'),
      child: pw.Padding(
        padding: const pw.EdgeInsets.all(5),
        child: pw.Text(
          title,
          style: pw.TextStyle(
              font: ttf,
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
              color: PdfColor.fromHex('#FFFFFF')),
        ),
      ),
    );
  }

  @override
  Future<void> printPDF(Uint8List pdfData) async {
    await Printing.layoutPdf(onLayout: (format) async => pdfData);
  }

  @override
  Future<void> savePDF(Uint8List pdfData, String fileName) {
    throw UnsupportedError(
        "Speichern ist auf Web-Plattformen nicht verfügbar.");
  }
}
