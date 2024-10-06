part of 'step_progress_bloc.dart';

@immutable
sealed class StepProgressState {}

final class StepProgressInitial extends StepProgressState {}

final class StepperLoaded extends StepProgressState {
  final int currentStep;
  final int numberOfSteps;
  final StepperState  stepperState;
  StepperLoaded( { required this.numberOfSteps,required this.currentStep, required this.stepperState});

  StepperLoaded copyWith({
    int? numberOfSteps,
    int? currentStep,
    StepperState ? stepperState
  }) {
    return StepperLoaded(
        numberOfSteps: numberOfSteps?? this.numberOfSteps,
        currentStep: currentStep?? this.currentStep,
        stepperState: stepperState ?? this.stepperState
    );
  }
}
