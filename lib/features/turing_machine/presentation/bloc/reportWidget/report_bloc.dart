import 'package:foundational_learning_platform/core/utils/index.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc() : super(ReportInitial()) {
    on<AddTransitionEvent>((event, emit) {
      if (state is ReportLoaded) {
        final currentState = state as ReportLoaded;
        final newTransitions = List<TMTransitionFunction>.from(currentState.transitions)
          ..add(event.transition);
        emit(ReportLoaded(transitions: newTransitions, currentStep: currentState.currentStep));
      } else {
        emit(ReportLoaded(transitions: [event.transition], currentStep: 0));
      }
    });

    on<ScrollToStepEvent>((event, emit) {
      if (state is ReportLoaded) {
        final currentState = state as ReportLoaded;
        emit(ReportLoaded(transitions: currentState.transitions, currentStep: event.step));
      }
    });


    on<ResetReportEvent>((event, emit) {
      emit(ReportLoaded(transitions: const [], currentStep: 0));
    });

  }
}
