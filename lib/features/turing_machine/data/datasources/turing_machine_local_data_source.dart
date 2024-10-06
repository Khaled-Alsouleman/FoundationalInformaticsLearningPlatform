import 'package:foundational_learning_platform/core/utils/index.dart';
class TuringMachineLocalDataSource {
  static const _cachedTuringMachinesKey = 'CACHED_TURING_MACHINES';

  final SharedPreferences sharedPreferences;

  TuringMachineLocalDataSource({required this.sharedPreferences});

  Future<LocalTMList> getTuringMachine(String id) async {
    final List<LocalTMList> allMachines = await getAllTuringMachines();
    try {
      return allMachines.firstWhere((machine) => machine.id == id);
    } catch (e) {
      throw TuringMachineLoadException("No Turing Machine found with id $id");
    }

  }

  Future<List<LocalTMList>> getAllTuringMachines() async {

    final jsonString = sharedPreferences.getString(_cachedTuringMachinesKey);

    if (jsonString != null) {
      try {
        final List<dynamic> decodedMachines = jsonDecode(jsonString);

        if (decodedMachines is List) {
          return decodedMachines
              .map((machineData) => LocalTMList.fromMap(Map<String, dynamic>.from(machineData)))
              .toList();
        } else {
         if (kDebugMode) {
           print(TuringMachineLoadException("Fehler: Der Inhalt von jsonString ist keine Liste"));
         }

          return [];
        }
      } catch (e) {
        if (kDebugMode) {
          print(TuringMachineLoadException("Fehler beim Dekodieren von JSON: $e"));
        }
        return [];
      }
    } else {
      return [];
    }
  }


  Future<void> saveTuringMachine(LocalTMList turingMachine) async {
    final List<LocalTMList> allMachines = await getAllTuringMachines();

    allMachines.removeWhere((machine) => machine.id == turingMachine.id);

    allMachines.add(turingMachine);
    final jsonString = jsonEncode(allMachines.map((e) => e.toMap()).toList());
    await sharedPreferences.setString(_cachedTuringMachinesKey, jsonString);
  }

  Future<void> deleteTuringMachine(String id) async {
    final List<LocalTMList> allMachines = await getAllTuringMachines();
    allMachines.removeWhere((machine) => machine.id == id);

    final jsonString = jsonEncode(allMachines.map((e) => e.toMap()).toList());
    await sharedPreferences.setString(_cachedTuringMachinesKey, jsonString);
  }


  Future<void> saveTuringMachinesToCache(List<LocalTMList> turingMachines) async {
    final jsonString = jsonEncode(turingMachines.map((e) => e.toMap()).toList());
    await sharedPreferences.setString(_cachedTuringMachinesKey, jsonString);
  }
}
