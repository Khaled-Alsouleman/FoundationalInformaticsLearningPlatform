import 'package:foundational_learning_platform/core/utils/index.dart';

class GenerateTuringMachinePDF {
  final PdfService pdfService;

  GenerateTuringMachinePDF(this.pdfService);

  Future<Uint8List> call({
    required bool isAccepted,
    required String inputString,
    required Map<String, dynamic> machineDetails,
    required List<Map<String, String>> transitions,
    required List<Map<String, dynamic>> steps,
    required List<String> bandSymbol,
    required List<String> states,
    required List<TMTransitionFunction> tmTransitions
  }) {
    return pdfService.generateTmPdf(
      isAccepted: isAccepted,
      inputString: inputString,
      machineDetails: machineDetails,
      transitions: transitions,
      steps: steps,
      bandSymbol: bandSymbol,
      states: states,
      tmTransitions: tmTransitions
    );
  }
}
