
class TuringMachineLoadException implements Exception {
  final String message;

  TuringMachineLoadException(this.message);

  @override
  String toString() => "TuringMachineLoadException: $message";
}
