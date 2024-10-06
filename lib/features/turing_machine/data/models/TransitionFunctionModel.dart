import 'package:foundational_learning_platform/features/turing_machine/domain/entities/movement_direction.dart';

class TransitionFunctionModel {
  final String currentState;
  final String readSymbol;
  final String nextState;
  final String writtenSymbol;
  final MovementDirection movementDirection;

  TransitionFunctionModel({
    required this.currentState,
    required this.readSymbol,
    required this.nextState,
    required this.writtenSymbol,
    required this.movementDirection,
  });

  factory TransitionFunctionModel.fromJson(Map<String, dynamic> json) {
    return TransitionFunctionModel(
      currentState: json['currentState'],
      readSymbol: json['readSymbol'],
      nextState: json['nextState'],
      writtenSymbol: json['writtenSymbol'],
      movementDirection: MovementDirection.values
          .firstWhere((e) => e.toString() == json['movementDirection']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentState': currentState,
      'readSymbol': readSymbol,
      'nextState': nextState,
      'writtenSymbol': writtenSymbol,
      'movementDirection': movementDirection.toString(),
    };
  }
}
