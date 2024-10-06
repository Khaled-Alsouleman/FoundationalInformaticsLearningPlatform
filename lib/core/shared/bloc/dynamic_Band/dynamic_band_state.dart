
part of 'dynamic_band_bloc.dart';

@immutable
sealed class DynamicBandState {}

class DynamicBandInitial extends DynamicBandState {}

class DynamicBandLoaded extends DynamicBandState {
  final bool isInitBand;
  final Map<int, String> tape;
  final int headLocation;
  final String currentState;
  final ExecutionState executionState;
  final String originalInput;
  final bool autoPlay;
  final int autoSpeed;
  final MyStack? lastTransition;

  DynamicBandLoaded({
    required this.isInitBand,
    required this.tape,
    required this.headLocation,
    required this.currentState,
    required this.executionState,
    required this.autoPlay,
    required this.autoSpeed,
    required this.originalInput,
    required this.lastTransition,
  });


  DynamicBandLoaded copyWith({
    final bool? isInitBand,
    final Map<int, String>? tape,
    final int? headLocation,
    final String? currentState,
    final ExecutionState? executionState,
    final String? originalInput,
    final bool? autoPlay,
    final int? autoSpeed,
    final MyStack? lastTransition,
  }) {
    if (kDebugMode) {
      print('lastTransition from DynamicBandState has been updated:');
      print(lastTransition);
    }
    return DynamicBandLoaded(
      isInitBand: isInitBand ?? this.isInitBand,
      tape: tape ?? this.tape,
      headLocation: headLocation ?? this.headLocation,
      currentState: currentState ?? this.currentState,
      executionState: executionState ?? this.executionState,
      originalInput: originalInput ?? this.originalInput,
      autoPlay: autoPlay ?? this.autoPlay,
      autoSpeed: autoSpeed ?? this.autoSpeed,
      lastTransition: lastTransition ?? this.lastTransition,
    );
  }
}
