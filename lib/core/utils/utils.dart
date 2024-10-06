import 'package:foundational_learning_platform/core/utils/index.dart';
abstract class Utils {
  static int _getMillisecondsValue(double sliderValue) {
    if (sliderValue == 1) return 10;
    if (sliderValue == 0) return 1000;

    final milliseconds = 2 * (1 - sliderValue) * 500;
    return milliseconds.round();
  }

  static bool isValidateAndSubmit(String alphabet ,String input) {
    bool isValid = input.split('').every((char) => alphabet.contains(char));
    return isValid;
  }

  static  List<String> getStringAsList(String input){
    return input.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
  }

  static List<int> getNumberOfBlankSymbols(String input) {
    final List<int> res = [];
    var rightSide = 5;
    var leftSide = 5;
    if (input.length < 15) {
      leftSide = 25 - (rightSide + input.length);
      res.add(leftSide);
      res.add(5);
    } else if (input.length > 15 && input.length < 26) {
      rightSide = 2;
      leftSide = 2;
      res.add(2);
      res.add(2);
    }
    return res;
  }

  static Map<int, String> getBandItems(int left, int right, String input) {
    final List<String> updatedBand = List<String>.filled(right, AppContents.blanketSymbol) +
        input.split('') +
        List<String>.filled(left, AppContents.blanketSymbol);
    return Map<int, String>.from(updatedBand.asMap());
  }

  static String? validateInput(String? value, List<String> alphabet) {
    if (value == null || value.isEmpty) {
      return '';//'Eingabe darf nicht leer sein';
    }
    bool isValid = value.split('').every((char) => alphabet.contains(char));
    if (!isValid) {
      final filteredAlphabet = List.of(alphabet)
        ..remove(AppContents.blanketSymbol)
        ..remove(AppContents.turingAlphabetSymbol);
      return 'Prüfen Sie Ihre Eingabe. Alphabet: $filteredAlphabet';
    }
    return null;
  }

}
