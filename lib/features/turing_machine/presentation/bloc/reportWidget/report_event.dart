part of 'report_bloc.dart';

@immutable
sealed class ReportEvent {}

final class InitializeReport extends ReportEvent {}

final class RemoveTransition extends ReportEvent {}

final class AddTransition extends ReportEvent {
  final TMTransitionFunction transition;

  AddTransition(this.transition);
}

final class ScrollToStep extends ReportEvent {
  final int step;

  ScrollToStep(this.step);
}

final class ResetReport extends ReportEvent {}

final class UpdateCurrentStep extends ReportEvent {
  final int currentStep;
  UpdateCurrentStep({required this.currentStep});

}
