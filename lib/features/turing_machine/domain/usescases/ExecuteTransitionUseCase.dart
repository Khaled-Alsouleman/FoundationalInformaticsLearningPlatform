import 'package:foundational_learning_platform/core/utils/index.dart';

class ExecuteTransitionUseCase {
  final TuringMachineBloc turingMachineBloc;
  final DynamicBandBloc dynamicBandBloc;

  ExecuteTransitionUseCase({required this.turingMachineBloc, required this.dynamicBandBloc});

  void call(TMTransitionFunction transition, {bool back = false}) {
    final tmState = turingMachineBloc.state;
    final bandState = dynamicBandBloc.state;

    if (tmState is TuringMachineLoaded && bandState is DynamicBandLoaded) {

      if (bandState.tape[bandState.headLocation] == AppContents.blanketSymbol) {
        if (tmState.turingMachine.finalStates.contains(transition.currentState)) {
          turingMachineBloc.add(UpdateTMState(executionState: ApprovalState.accepted));
        } else {
          turingMachineBloc.add(UpdateTMState(executionState: ApprovalState.rejected));
        }
      } else {
        turingMachineBloc.add(UpdateTMState(executionState: ApprovalState.indexed));
      }


      if (tmState.executionState == ApprovalState.indexed) {
        if (kDebugMode) {
          print('Back? : $back');
        }
        dynamicBandBloc.add(ControlEvent(
          action: back ? ControlAction.back : ControlAction.next,
          transitionFunction: transition,
        ));

      }
    }
  }
}
