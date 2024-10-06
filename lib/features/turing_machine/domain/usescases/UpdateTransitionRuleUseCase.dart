import 'package:foundational_learning_platform/core/utils/index.dart';
class UpdateTransitionRuleUseCase {
  void call({
    required BuildContext context,
    required TMTransitionFunction updatedRule,
    required int index,
  }) {
    bool hasError = updatedRule.currentState.isEmpty ||
        updatedRule.readSymbol.isEmpty ||
        updatedRule.writtenSymbol.isEmpty ||
        updatedRule.nextState.isEmpty;

    EditingState newStatus = hasError ? EditingState.error : EditingState.complete;

    // Aktualisiere die Übergangsregel im Bloc
    context.read<TuringMachineBloc>().add(UpdateTransitionRuleEvent(index: index, updatedRule: updatedRule));

    // Aktualisiere den Status der spezifischen Regel
    final currentState = context.read<TuringMachineBloc>().state;
    if (currentState is TuringMachineLoaded) {
      List<EditingState> updatedStatuses = List.from(currentState.transitionStatuses);
      if (index < updatedStatuses.length) {
        updatedStatuses[index] = newStatus;
      } else {
        updatedStatuses.add(newStatus);
      }
      context.read<TuringMachineBloc>().add(UpdateTransitionRuleStatusEvent(statuses: updatedStatuses));
    }
  }
}
