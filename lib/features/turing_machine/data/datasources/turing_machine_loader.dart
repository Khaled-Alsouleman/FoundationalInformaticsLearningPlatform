import 'package:foundational_learning_platform/core/utils/index.dart';

class TuringMachineLoader {

  static Future<List<LocalTMList>> loadTuringMachines(BuildContext context) async {
    try {
      if (kDebugMode) {
        print("Attempting to load file: assets/jsons/turing_machines.json");
      }
      final result = await DefaultAssetBundle.of(context).loadString("jsons/turing_machines.json");
      if (kDebugMode) {
        print("Successfully loaded JSON file");
      }

      final List<dynamic> decodedMachines = jsonDecode(result);
      return decodedMachines.map((e) => LocalTMList.fromMap(e)).toList();
    } catch (e) {

      throw TuringMachineLoadException('Error loading Turing Machines: $e');
    }
  }


}