part of 'report_bloc.dart';

@immutable
sealed class ReportState {}

final class ReportInitial extends ReportState {}

final class ReportLoaded extends ReportState {
  final List<TMTransitionFunction> transitions;
  final int currentStep;

  ReportLoaded({required this.transitions, required this.currentStep});


  ReportLoaded copyWith({
    List<TMTransitionFunction>? transitions,
    int? currentStep,
  }) {
    return ReportLoaded(
      transitions: transitions ?? this.transitions,
      currentStep: currentStep ?? this.currentStep,
    );
  }
}

