import 'package:foundational_learning_platform/core/utils/index.dart';

part 'dynamic_band_event.dart';
part 'dynamic_band_state.dart';

class DynamicBandBloc extends Bloc<DynamicBandEvent, DynamicBandState> {
  DynamicBandBloc() : super(DynamicBandInitial()) {
    on<InitializeBand>(_onInitializeBand);
    on<UpdateSpeed>(_onUpdateSpeed);
    on<UpdateInput>(_onUpdateInput);
    on<ControlEvent>(_onControlEvent);
    on<UpdateTransitionState>(_onUpdateTransitionState);
    on<ResetBand>(_onResetBand);
  }


  void _onControlEvent(ControlEvent event, Emitter<DynamicBandState> emit) {
    final currentState = state as DynamicBandLoaded;

    switch (event.action) {
      case ControlAction.play:
        if (!currentState.autoPlay) {
          if (event.transitionFunction != null) {

            if (kDebugMode) {
              print('Play action triggered with transition: ${event.transitionFunction}');
            }


            add(UpdateTransitionState(
              movementDirection: event.transitionFunction!.movementDirection,
              newTapeSymbol: event.transitionFunction!.writtenSymbol,
              newState: event.transitionFunction!.nextState,
            ));


            if (kDebugMode) {
              print('Transition State Update requested for Play action.');
            }


            emit(currentState.copyWith(
              executionState: ExecutionState.running,
              autoPlay: true,
            ));


            if (kDebugMode) {
              print('State set to running, autoPlay enabled.');
            }
          }
        }
        break;

      case ControlAction.stop:
        emit(currentState.copyWith(
          executionState: ExecutionState.paused,
          autoPlay: false,
        ));
        break;

      case ControlAction.next:
        if (event.transitionFunction != null) {
          var lastTransition = currentState.lastTransition?.clone() ?? MyStack();
          lastTransition.push(event.transitionFunction!);

          add(UpdateTransitionState(
              movementDirection: event.transitionFunction!.movementDirection,
              newTapeSymbol: event.transitionFunction!.writtenSymbol,
              newState: event.transitionFunction!.nextState
          ));
          emit(currentState.copyWith(
            executionState: currentState.autoPlay ? ExecutionState.running : ExecutionState.paused,
            lastTransition: lastTransition,
          ));
        }
        break;


      case ControlAction.back:
        if (currentState.lastTransition != null && !currentState.lastTransition!.isEmpty) {
          final lastTransitions = currentState.lastTransition!;
          final lastTransition = lastTransitions.pop();

          if (kDebugMode) {
            print('Back action last transition: $lastTransition');
          }


          final reverseDirection = lastTransition.movementDirection == MovementDirection.right
              ? MovementDirection.left
              : lastTransition.movementDirection == MovementDirection.left
              ? MovementDirection.right
              : MovementDirection.stay;

          final int maxIndex = currentState.tape.length - 1;
          const int minIndex = 0;


          final newPosition = reverseDirection == MovementDirection.right ? 1
              : reverseDirection == MovementDirection.left ? -1
              : 0;

          int newHeadLocation = currentState.headLocation + newPosition;


          if (newHeadLocation < minIndex || newHeadLocation > maxIndex) {
            newHeadLocation = currentState.headLocation;
          }


          final updatedTape = Map<int, String>.from(currentState.tape);
          updatedTape[newHeadLocation] = lastTransition.readSymbol; // Setze das alte Symbol


          emit(currentState.copyWith(
            headLocation: newHeadLocation,
            tape: updatedTape,
            currentState: lastTransition.currentState,
            executionState: ExecutionState.paused,
            autoPlay: false,
            lastTransition: lastTransitions,
          ));
        }
        break;

    }
  }


  void _onInitializeBand(InitializeBand event, Emitter<DynamicBandState> emit) {
    final List<String> band = List<String>.filled(event.numberOfBlankSymbol, AppContents.blanketSymbol);
    final Map<int, String> tape = Map<int, String>.from(band.asMap());

    emit(DynamicBandLoaded(
      isInitBand: true,
      autoPlay: false,
      tape: tape,
      headLocation: event.headLocation,
      currentState: event.currentState,
      executionState: ExecutionState.paused,
      originalInput: '',
      autoSpeed: 1000,
      lastTransition: null,
    ));
  }


  void _onUpdateSpeed(UpdateSpeed event, Emitter<DynamicBandState> emit) {
    final currentState = state as DynamicBandLoaded;
    emit(currentState.copyWith(
      autoPlay: false,
      autoSpeed: event.newSpeed,
    ));
  }


  void _onUpdateInput(UpdateInput event, Emitter<DynamicBandState> emit) {
    var numberOfBlankSymbols = TuringMachineUtils.getNumberOfBlankSymbols(event.newInput);
    final currentState = state as DynamicBandLoaded;

    emit(currentState.copyWith(
      isInitBand: false,
      autoPlay: false,
      tape: TuringMachineUtils.getBandItems(
        numberOfBlankSymbols.first,
        numberOfBlankSymbols.last,
        event.newInput,
      ),
      headLocation: 5,
      currentState: event.startState,
      executionState: ExecutionState.paused,
      originalInput: event.newInput,
      lastTransition: null,
    ));
  }


  void _onUpdateTransitionState(UpdateTransitionState event, Emitter<DynamicBandState> emit) {
    final currentState = state as DynamicBandLoaded;
    final int maxIndex = currentState.tape.length - 1;
    const int minIndex = 0;


    final updatedTape = Map<int, String>.from(currentState.tape);
    updatedTape[currentState.headLocation] = event.newTapeSymbol;


    final newPosition = event.movementDirection == MovementDirection.rechts ? 1 : event.movementDirection == MovementDirection.links ? -1 : 0;
    int newHeadLocation = currentState.headLocation + newPosition;

    if (newHeadLocation < minIndex || newHeadLocation > maxIndex) {
      newHeadLocation = currentState.headLocation;
    }


    emit(currentState.copyWith(
      headLocation: newHeadLocation,
      tape: updatedTape,
      currentState: event.newState,
      executionState: currentState.autoPlay ? ExecutionState.running : ExecutionState.paused,
    ));
  }

  void _onResetBand(ResetBand event, Emitter<DynamicBandState> emit) {
    final currentState = state as DynamicBandLoaded;
    var numberOfBlankSymbols = TuringMachineUtils.getNumberOfBlankSymbols(currentState.originalInput);

    currentState.lastTransition?.clear();
    emit(currentState.copyWith(
      currentState: event.initialState,
      originalInput: currentState.originalInput,
      tape: TuringMachineUtils.getBandItems(
        numberOfBlankSymbols.first,
        numberOfBlankSymbols.last,
        currentState.originalInput,
      ),
      headLocation: numberOfBlankSymbols.last ,
      executionState: ExecutionState.paused,
      autoPlay: false,
      lastTransition: null,
    ));
  }
}
