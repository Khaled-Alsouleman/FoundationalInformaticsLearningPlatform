import 'package:foundational_learning_platform/core/utils/index.dart';
import 'package:foundational_learning_platform/features/turing_machine/data/datasources/turing_machine_loader.dart'; // Importiere den Loader

class TuringMachineRepositoryImpl implements TuringMachineRepository {
  final TuringMachineLocalDataSource localDataSource;

  TuringMachineRepositoryImpl({required this.localDataSource});

  @override
  Future<LocalTMList> getTuringMachine(String id) async {
    try {
      return await localDataSource.getTuringMachine(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<LocalTMList>> getAllTuringMachines(BuildContext context) async {
    List<LocalTMList> cachedMachines = await localDataSource.getAllTuringMachines();

    if (cachedMachines.isEmpty) {
      if (kDebugMode) {
        print("Lokaler Cache ist leer, lade aus den Assets...");
      }
      try {

        cachedMachines = await TuringMachineLoader.loadTuringMachines(context);
        await localDataSource.saveTuringMachinesToCache(cachedMachines);
      } catch (e) {
        if (kDebugMode) {
          print("Fehler beim Laden der Turing-Maschinen aus den Assets: $e");
        }
      }
    }
    return cachedMachines;
  }

  @override
  Future<void> saveTuringMachine(LocalTMList turingMachine) async {
    await localDataSource.saveTuringMachine(turingMachine);
  }

  @override
  Future<void> deleteTuringMachine(String id) async {
    await localDataSource.deleteTuringMachine(id);
  }
}

