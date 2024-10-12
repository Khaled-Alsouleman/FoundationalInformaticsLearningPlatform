import 'package:foundational_learning_platform/core/utils/index.dart';

class ExecuteTransitionUseCase {
  final TuringMachineBloc turingMachineBloc;
  final DynamicBandBloc dynamicBandBloc;
  final ReportBloc reportBloc;

  ExecuteTransitionUseCase({
    required this.turingMachineBloc,
    required this.dynamicBandBloc,
    required this.reportBloc,
  });

  Timer? _timer;

  Future<void> call({bool back = false}) async {
    final tmState = turingMachineBloc.state as TuringMachineLoaded;
    final bandState = dynamicBandBloc.state as DynamicBandLoaded;

    final transition = TuringMachineUtils.getNextTransition(bandState, tmState.turingMachine.transitions);

    if (transition != null && !bandState.isInitBand) {
      final currentSymbol = bandState.tape[bandState.headLocation];

      if (tmState.turingMachine.finalStates.contains(transition.nextState)) {
        _handleAccepted();
        return;
      }
      if (currentSymbol == AppContents.blanketSymbol &&
          !tmState.turingMachine.finalStates.contains(transition.nextState)) {
        _handleRejected();
        return;
      }

      await _dispatchControlEvent(back, transition);

    } else {
      _updateExecutionState(ApprovalState.rejected);
    }
  }


  void _handleAccepted() {

    final tmState = turingMachineBloc.state as TuringMachineLoaded;
    final bandState = dynamicBandBloc.state as DynamicBandLoaded;
    final lastTransition = TuringMachineUtils.getNextTransition(bandState, tmState.turingMachine.transitions);

    if (lastTransition != null) {

      reportBloc.add(AddTransition(lastTransition));

      dynamicBandBloc.add(UpdateTransitionState(
        movementDirection: lastTransition.movementDirection,
        newTapeSymbol: lastTransition.writtenSymbol,
        newState: lastTransition.nextState,
      ));
    }

    _updateExecutionState(ApprovalState.accepted);
    dynamicBandBloc.add(UpdateAutoPlay(isAutoPlay: false));
    stopTimer();
  }


  void _handleRejected() {

    final tmState = turingMachineBloc.state as TuringMachineLoaded;
    final bandState = dynamicBandBloc.state as DynamicBandLoaded;
    final lastTransition = TuringMachineUtils.getNextTransition(bandState, tmState.turingMachine.transitions);

    if (lastTransition != null) {

      reportBloc.add(AddTransition(lastTransition));

      dynamicBandBloc.add(UpdateTransitionState(
        movementDirection: lastTransition.movementDirection,
        newTapeSymbol: lastTransition.writtenSymbol,
        newState: lastTransition.nextState,
      ));
    }

    _updateExecutionState(ApprovalState.rejected);
    dynamicBandBloc.add(UpdateAutoPlay(isAutoPlay: false));
    stopTimer();
  }



  Future<void> _dispatchControlEvent(bool back, TMTransitionFunction transition) async {
    final bandState = dynamicBandBloc.state;

    if (!back) {
      dynamicBandBloc.add(ControlEvent(
        action: ControlAction.next,
        transitionFunction: transition,
      ));
      reportBloc.add(AddTransition(transition));
    } else {

      if (bandState is DynamicBandLoaded) {
        final lastTrans = bandState.lastTransition?.peek();
        if (lastTrans != null) {

          reportBloc.add(RemoveTransition());


          dynamicBandBloc.add(ControlEvent(
            action: ControlAction.back,
            transitionFunction: lastTrans,
          ));
        }
      }
    }


    await Future.delayed(const Duration(milliseconds: 50));
  }






  void _updateExecutionState(ApprovalState state) {
    turingMachineBloc.add(UpdateTMState(executionState: state));
  }


  void startTimer() {
    final bandState = dynamicBandBloc.state as DynamicBandLoaded;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: bandState.autoSpeed), (timer) {
      final tmState = turingMachineBloc.state;
      if (tmState is TuringMachineLoaded && (tmState.executionState == ApprovalState.accepted || tmState.executionState == ApprovalState.rejected)) {
        stopTimer();
      } else {
        call();
      }
    });
  }


  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }
}

