part of 'report_bloc.dart';

@immutable
sealed class ReportState {}

final class ReportInitial extends ReportState {}

final class ReportLoaded extends ReportState {
  final List<TMTransitionFunction> transitions;
  final int currentStep;

  ReportLoaded({required this.transitions, required this.currentStep});
}
