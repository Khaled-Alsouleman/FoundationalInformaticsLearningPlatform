import 'dart:convert';

abstract class TransitionFunctionAbstract {
  final String currentState;
  final String readSymbol;
  final String nextState;
  TransitionFunctionAbstract(

      {
    required this.currentState,
    required this.readSymbol,
    required this.nextState,
  });


  Map<String, dynamic> toMap();

  String toJson() => json.encode(toMap());


}