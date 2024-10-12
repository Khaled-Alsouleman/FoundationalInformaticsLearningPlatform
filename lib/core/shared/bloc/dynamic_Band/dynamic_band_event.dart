part of 'dynamic_band_bloc.dart';

@immutable
sealed class DynamicBandEvent {}

class InitializeBand extends DynamicBandEvent {
  final int headLocation;
  final int numberOfBlankSymbol;
  final String currentState;

  InitializeBand({
    required this.headLocation,
    required this.numberOfBlankSymbol,
    required this.currentState,
  });
}

class UpdateInput extends DynamicBandEvent {
  final String newInput;
  final int numberOfBlankSymbol;
  final String startState;

  UpdateInput({
    required this.newInput,
    required this.startState,
    required this.numberOfBlankSymbol,
  });
}

class ResetBand extends DynamicBandEvent {
  final String initialState;

  ResetBand({required this.initialState});
}

class UpdateSpeed extends DynamicBandEvent {
  final ControlAction  timerState;
  final int newSpeed;

  UpdateSpeed(this.newSpeed, this.timerState);
}

class ControlEvent extends DynamicBandEvent {
  final ControlAction action;
  final TMTransitionFunction? transitionFunction;

  ControlEvent({required this.action, this.transitionFunction});
}

class UpdateTransitionState extends DynamicBandEvent {
  final MovementDirection movementDirection;
  final String newTapeSymbol;
  final String newState;

  UpdateTransitionState({
    required this.movementDirection,
    required this.newTapeSymbol,
    required this.newState,
  });
}

class UpdateAutoPlay extends DynamicBandEvent{
  final bool isAutoPlay;
  UpdateAutoPlay({required this.isAutoPlay});
}


