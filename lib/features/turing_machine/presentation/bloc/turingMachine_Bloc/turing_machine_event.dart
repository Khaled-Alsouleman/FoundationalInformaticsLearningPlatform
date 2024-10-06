part of 'turing_machine_bloc.dart';

@immutable
sealed class TuringMachineEvent {}

final class InitTuringMachineEvent extends TuringMachineEvent {
  final String input;
  final TuringMachine turingMachine;

  InitTuringMachineEvent({
    required this.input,
    required this.turingMachine,
  });
}

final class ChangeSpeedEvent extends TuringMachineEvent {
  final double value;

  ChangeSpeedEvent(this.value);
}

final class LoadLocalTMs extends TuringMachineEvent {
  final BuildContext context;
  LoadLocalTMs({required this.context});
}

final class AddTransitionRuleEvent extends TuringMachineEvent {}

final class RemoveTransitionRuleEvent extends TuringMachineEvent {
  final int index;

  RemoveTransitionRuleEvent({required this.index});
}

final class UpdateTransitionRuleEvent extends TuringMachineEvent {
  final int index;
  final TMTransitionFunction updatedRule;

  UpdateTransitionRuleEvent({required this.index, required this.updatedRule});
}

final class UpdateStatesEvent extends TuringMachineEvent {
  final List<String> states;

  UpdateStatesEvent(this.states);
}

final class UpdateAlphabetEvent extends TuringMachineEvent {
  final List<String> alphabet;

  UpdateAlphabetEvent(this.alphabet);
}

final class UpdateStartStateEvent extends TuringMachineEvent {
  final String startState;

  UpdateStartStateEvent(this.startState);
}

final class UpdateEndStateEvent extends TuringMachineEvent {
  final List<String> endStates;

  UpdateEndStateEvent(this.endStates);
}

final class UpdateTMSymbolEvent extends TuringMachineEvent {
  final String tmSymbol;

  UpdateTMSymbolEvent(this.tmSymbol);
}

final class FinalizeConfigurationEvent extends TuringMachineEvent {}

final class UpdateTMState extends TuringMachineEvent {
  final ApprovalState executionState;
  UpdateTMState({required this.executionState});
}

final class EditCurrentTMEvent extends TuringMachineEvent {
  final TuringMachine tm;

  EditCurrentTMEvent({required this.tm});
}

final class ResetEvent extends TuringMachineEvent {}

class UpdateTransitionRuleStatusEvent extends TuringMachineEvent {
  final List<EditingState> statuses;

  UpdateTransitionRuleStatusEvent({required this.statuses});
}
