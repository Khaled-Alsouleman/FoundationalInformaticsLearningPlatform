part of 'turing_machine_bloc.dart';

@immutable
sealed class TuringMachineState {}

final class TuringMachineInitial extends TuringMachineState {}

final class TuringMachineLoaded extends TuringMachineState {
  final String input;
  final TuringMachine turingMachine;
  final String executionMessage;
  final ApprovalState executionState;
  final double sliderValue;
  final List<LocalTMList> localTMs;

  // Neue Eigenschaft hinzugefügt
  final List<EditingState> transitionStatuses;

  TuringMachineLoaded({
    required this.input,
    required this.turingMachine,
    required this.executionMessage,
    this.executionState = ApprovalState.indexed,
    required this.sliderValue,
    this.localTMs = const [],
    this.transitionStatuses = const [],  // Initialisieren der transitionStatuses-Liste
  });

  TuringMachineLoaded copyWith({
    String? input,
    TuringMachine? turingMachine,
    String? executionMessage,
    ApprovalState? executionState,
    double? sliderValue,
    List<LocalTMList>? localTMs,
    List<EditingState>? transitionStatuses,
  }) {
    return TuringMachineLoaded(
      input: input ?? this.input,
      turingMachine: turingMachine ?? this.turingMachine,
      executionMessage: executionMessage ?? this.executionMessage,
      executionState: executionState ?? this.executionState,
      sliderValue: sliderValue ?? this.sliderValue,
      localTMs: localTMs ?? this.localTMs,
      transitionStatuses: transitionStatuses ?? this.transitionStatuses,
    );
  }
}


final class TuringMachineCreated extends TuringMachineState {
  final TuringMachine turingMachine;
  TuringMachineCreated(this.turingMachine);
}
