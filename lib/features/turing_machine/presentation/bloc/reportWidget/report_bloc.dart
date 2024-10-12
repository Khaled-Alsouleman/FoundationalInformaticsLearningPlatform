import 'package:foundational_learning_platform/core/utils/index.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc() : super(ReportInitial()) {

    on<InitializeReport>((event,emit){
      emit(ReportLoaded(transitions:  [], currentStep: 0));
    });
   on<RemoveTransition> ((event, emit){
      if (state is ReportLoaded) {
        final currentState = state as ReportLoaded;
        final newTransitions = List.of(currentState.transitions);
        newTransitions.removeLast();
        final newValue = currentState.currentStep - 1;
        emit(currentState.copyWith(transitions: newTransitions, currentStep: newValue > 0 ? newValue : 0));

      }
   });
    on<AddTransition>((event, emit) {
      if (state is ReportLoaded) {
        final currentState = state as ReportLoaded;
        final newTransitions = List.of(currentState.transitions);
        newTransitions.add(event.transition);
        final newValue = currentState.currentStep + 1;
        emit(currentState.copyWith(transitions: newTransitions, currentStep: newValue));
      }
    });


    on<ScrollToStep>((event, emit) {
        final currentState = state as ReportLoaded;
        emit(ReportLoaded(transitions: currentState.transitions, currentStep: event.step));

    });

    on<ResetReport>((event, emit) {
      if (state is ReportLoaded) {
        final currentState = state as ReportLoaded;
        emit(currentState.copyWith(transitions: const [] , currentStep: 0));
      }
    });

  }
}
