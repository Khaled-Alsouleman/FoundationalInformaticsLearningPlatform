import 'package:foundational_learning_platform/core/utils/index.dart';

abstract class TuringMachineRepository {
  Future<LocalTMList> getTuringMachine(String id);
  Future<List<LocalTMList>> getAllTuringMachines(BuildContext context);
  Future<void> saveTuringMachine(LocalTMList turingMachine);
  Future<void> deleteTuringMachine(String id);
}

