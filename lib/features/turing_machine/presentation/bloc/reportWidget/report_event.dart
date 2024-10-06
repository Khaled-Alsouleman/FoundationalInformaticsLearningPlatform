part of 'report_bloc.dart';

@immutable
sealed class ReportEvent {}

final class AddTransitionEvent extends ReportEvent {
  final TMTransitionFunction transition;

  AddTransitionEvent(this.transition);
}

final class ScrollToStepEvent extends ReportEvent {
  final int step;

  ScrollToStepEvent(this.step);
}

final class ResetReportEvent extends ReportEvent {}
