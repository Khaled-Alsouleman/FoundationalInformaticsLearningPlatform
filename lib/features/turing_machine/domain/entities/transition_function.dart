import 'package:foundational_learning_platform/core/utils/index.dart';

class TMTransitionFunction extends TransitionFunctionAbstract {
  TMTransitionFunction({
    required String currentState,
    required String readSymbol,
    required String nextState,
    required MovementDirection movementDirection,
    required this.writtenSymbol,

  }) : super(
    currentState: currentState,
    readSymbol: readSymbol,
    nextState: nextState,
    movementDirection :movementDirection
  );

  final String writtenSymbol;

  TMTransitionFunction copyWith({
    String? currentState,
    String? readSymbol,
    String? nextState,
    String? writtenSymbol,
    MovementDirection? movementDirection,
  }) {
    return TMTransitionFunction(
      currentState: currentState ?? this.currentState,
      readSymbol: readSymbol ?? this.readSymbol,
      nextState: nextState ?? this.nextState,
      writtenSymbol: writtenSymbol ?? this.writtenSymbol,
      movementDirection: movementDirection ?? this.movementDirection,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'currentState': currentState,
      'readSymbol': readSymbol,
      'nextState': nextState,
      'writtenSymbol': writtenSymbol,
      'movementDirection': movementDirection.name,
    };
  }

  factory TMTransitionFunction.fromMap(Map<String, dynamic> map) {
    return TMTransitionFunction(
      currentState: map['currentState'] ?? '',
      readSymbol: map['readSymbol'] ?? '',
      nextState: map['nextState'] ?? '',
      writtenSymbol: map['writtenSymbol'] ?? '',
      movementDirection: MovementDirection.fromString(map['movementDirection']),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory TMTransitionFunction.fromJson(String source) => TMTransitionFunction.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TMTransitionFunction(currentState: $currentState, readSymbol: $readSymbol, nextState: $nextState, writtenSymbol: $writtenSymbol, movementDirection: $movementDirection)';
  }
}
