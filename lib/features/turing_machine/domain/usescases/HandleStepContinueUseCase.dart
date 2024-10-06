import 'package:foundational_learning_platform/core/utils/index.dart';

class HandleStepContinueUseCase {
  final StepProgressBloc stepProgressBloc;
  final TuringMachineBloc configBloc;

  HandleStepContinueUseCase({
    required this.stepProgressBloc,
    required this.configBloc,
  });

  void call(int currentStep, GlobalKey<FormState> statesKey,
      GlobalKey<FormState> alphabetKey) {
    final isStatesValid = statesKey.currentState?.validate() ?? false;
    final isAlphabetValid = alphabetKey.currentState?.validate() ?? false;

    if (kDebugMode) {
      print('currentStep');
      print(configBloc.state);
      print(configBloc.state);
    }

    final currentState = configBloc.state;

    if (currentStep == 0 && isStatesValid && isAlphabetValid) {
      stepProgressBloc
          .add(UpdateStepperState(stepperState: StepperState.indexed));
      stepProgressBloc.add(NextStep());
    }
    if (currentStep == 1) {
      if (currentState is TuringMachineLoaded &&
          currentState.turingMachine.initialState.isNotEmpty &&
          currentState.turingMachine.finalStates.isNotEmpty) {
        stepProgressBloc.add(NextStep());
      }
    }

    if (currentStep == 2) {
      if (currentState is TuringMachineLoaded &&
          currentState.turingMachine.transitions.isNotEmpty) {
        configBloc.add(FinalizeConfigurationEvent());
        stepProgressBloc.add(NextStep());
      }
    }

    if (currentStep == 3 && currentState is TuringMachineCreated) {
      stepProgressBloc.add(UpdateStepperState(stepperState: StepperState.complete));
      stepProgressBloc.add(NextStep());
    }
  }
}
