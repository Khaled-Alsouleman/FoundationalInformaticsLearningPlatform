import 'package:foundational_learning_platform/features/turing_machine/domain/entities/transition_function.dart';

class StepData {
  final int stepNumber; // Schrittzähler
  final TMTransitionFunction transition; // Transition (Zustand, Symbole, Bewegung)

  StepData({
    required this.stepNumber,
    required this.transition,
  });
}
