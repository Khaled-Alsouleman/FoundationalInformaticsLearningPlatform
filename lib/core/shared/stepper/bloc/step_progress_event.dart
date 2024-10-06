part of 'step_progress_bloc.dart';

@immutable
sealed class StepProgressEvent {}

class InitializeStepper extends StepProgressEvent {
  final int numberOfSteps;
  InitializeStepper({required this.numberOfSteps});
}

class NextStep extends StepProgressEvent {}

class LastStep extends StepProgressEvent {}

class UpdateStepperState extends StepProgressEvent {
  final StepperState      stepperState;
  UpdateStepperState({required this.stepperState});
}
