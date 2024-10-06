import 'package:foundational_learning_platform/core/utils/index.dart';
abstract class TransitionFunctionAbstract {
  final String currentState;
  final String readSymbol;
  final String nextState;
  final MovementDirection movementDirection;
  TransitionFunctionAbstract(

      {
    required this.currentState,
    required this.readSymbol,
    required this.nextState,
    required this.movementDirection,
  });


  Map<String, dynamic> toMap();

  String toJson() => json.encode(toMap());


}