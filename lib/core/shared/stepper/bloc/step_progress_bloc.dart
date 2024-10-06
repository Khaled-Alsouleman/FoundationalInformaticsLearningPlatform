import 'package:foundational_learning_platform/core/utils/index.dart';

part 'step_progress_event.dart';
part 'step_progress_state.dart';

class StepProgressBloc extends Bloc<StepProgressEvent, StepProgressState> {
  StepProgressBloc() : super(StepProgressInitial()) {
    int newCurrentState = 0;
  on<InitializeStepper>((event , emit){
    emit(StepperLoaded(
      numberOfSteps: event.numberOfSteps,
      currentStep: 0,
      stepperState: StepperState.indexed
    ));
  });

    on<NextStep>((event, emit) {
      final currentState = state as StepperLoaded;
      final isCompleted = currentState.numberOfSteps - 1 == currentState.currentStep;
      newCurrentState = isCompleted ? currentState.currentStep : currentState.currentStep + 1;

      isCompleted
          ? emit(currentState.copyWith(stepperState: StepperState.complete))
          : emit(currentState.copyWith(currentStep: newCurrentState));

    });

    on<LastStep>((event, emit) {
      final currentState = state as StepperLoaded;
      newCurrentState = currentState.currentStep > 0 ? currentState.currentStep - 1 : currentState.currentStep;
      emit(currentState.copyWith(currentStep: newCurrentState));
    });

    on<UpdateStepperState>((event, emit) {
      final currentState = state as StepperLoaded;
      emit(currentState.copyWith(stepperState: event.stepperState));
    });
  }


}
