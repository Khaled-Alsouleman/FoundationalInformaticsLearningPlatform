import 'package:foundational_learning_platform/core/utils/index.dart';
import 'package:pdf/widgets.dart' as pw;



/// Mobile-spezifische Implementierung des PDF-Services
class TMPdfServiceMobile implements PdfService {
  final pw.Document pdf = pw.Document();

  @override
  Future<Uint8List> generateTmPdf({
    required bool isAccepted,
    required String inputString,
    required Map<String, dynamic> machineDetails,
    required List<Map<String, dynamic>> transitions,
    required List<Map<String, dynamic>> steps,
    required List<String> bandSymbol,
    required List<String> states,
    required List<TMTransitionFunction> tmTransitions
  }) async {
    final fontData = await rootBundle.load("fonts/NotoSans-Regular.ttf");
    final ttf = pw.Font.ttf(fontData);

    final textColor = isAccepted ? PdfColor.fromHex('#00b300') : PdfColor.fromHex('#b30000');

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Ergebnis Abschnitt
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
              pw.SizedBox(height: 20),

              // Turing-Maschinen-Details
              pw.Text(
                'Turing-Maschinen Details:',
                style: pw.TextStyle(font: ttf, fontSize: 16, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 10),
              ...machineDetails.entries.map((entry) {
                return pw.Text(
                  '${entry.key}: ${entry.value}',
                  style: pw.TextStyle(font: ttf, fontSize: 14),
                );
              }).toList(),
              pw.SizedBox(height: 20),

              // Übergangstabelle
              pw.Text(
                'Übergangstabelle:',
                style: pw.TextStyle(font: ttf, fontSize: 16, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 10),
              _buildTransitionTable(ttf, transitions),

              pw.SizedBox(height: 20),

              // Ausgeführte Schritte
              pw.Text(
                'Ausgeführte Schritte:',
                style: pw.TextStyle(font: ttf, fontSize: 16, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 10),
              _buildStepsTable(ttf, steps, isAccepted),
            ],
          );
        },
      ),
    );
    return pdf.save();
  }

  pw.Widget _buildTransitionTable(pw.Font ttf, List<Map<String, dynamic>> transitions) {
    return pw.TableHelper.fromTextArray(
      border: pw.TableBorder.all(),
      headers: ['Zustand', 'Lesen', 'Schreiben', 'Nächster Zustand', 'Bewegung'],
      data: transitions.map((transition) {
        return [
          transition['currentState'],
          transition['readSymbol'],
          transition['writtenSymbol'],
          transition['nextState'],
          transition['movementDirection'],
        ];
      }).toList(),
      headerStyle: pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold),
      cellStyle: pw.TextStyle(font: ttf),
      cellAlignments: {
        0: pw.Alignment.center,
        1: pw.Alignment.center,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
        4: pw.Alignment.center,
      },
    );
  }

  pw.Widget _buildStepsTable(pw.Font ttf, List<Map<String, dynamic>> steps, bool isAccepted) {
    final stepColor = isAccepted ? PdfColor.fromHex('#00b300') : PdfColor.fromHex('#b30000');
    return pw.TableHelper.fromTextArray(
    border: pw.TableBorder.all(),
      headers: ['Schritt', 'Zustand', 'Lesen', 'Schreiben', 'Nächster Zustand', 'Bewegung'],
      data: steps.map((step) {
        return [
          step['stepNumber'],
          step['currentState'],
          step['readSymbol'],
          step['writtenSymbol'],
          step['nextState'],
          step['movementDirection'],
        ];
      }).toList(),
      headerStyle: pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold),
      cellStyle: pw.TextStyle(font: ttf, color: stepColor),
      cellAlignments: {
        0: pw.Alignment.center,
        1: pw.Alignment.center,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
        4: pw.Alignment.center,
        5: pw.Alignment.center,
      },
    );
  }

  @override
  Future<void> savePDF(Uint8List pdfData, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    final file = File(filePath);
    await file.writeAsBytes(pdfData);
    print("PDF gespeichert unter: $filePath");
  }

  @override
  Future<void> printPDF(Uint8List pdfData) {
    throw UnsupportedError("Drucken ist auf mobilen Geräten nicht verfügbar.");
  }
}
