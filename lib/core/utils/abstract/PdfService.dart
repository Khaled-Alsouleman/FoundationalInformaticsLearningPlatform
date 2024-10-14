import 'dart:typed_data';

import 'package:foundational_learning_platform/core/utils/index.dart';

/// Basis-Interface für PDF-Service, das für die gesamte Plattform verwendet wird.
abstract class PdfService {

  Future<Uint8List> generateTmPdf({
    required bool isAccepted,
    required String inputString,
    required Map<String, dynamic> machineDetails,
    required List<Map<String, String>> transitions,
    required List<Map<String, dynamic>> steps,
    required List<String> bandSymbol,
    required List<String> states,
    required List<TMTransitionFunction> tmTransitions
});


  Future<void> savePDF(Uint8List pdfData, String fileName);


  Future<void> printPDF(Uint8List pdfData);
}
