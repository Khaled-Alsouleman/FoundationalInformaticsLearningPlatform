class TuringMachineNotFoundException implements Exception {
  final String id;

  TuringMachineNotFoundException(this.id);

  @override
  String toString() => "TuringMachineNotFoundException: No Turing Machine found with id $id";
}