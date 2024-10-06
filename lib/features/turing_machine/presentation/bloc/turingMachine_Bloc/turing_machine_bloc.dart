import 'package:foundational_learning_platform/core/utils/index.dart';
part 'turing_machine_event.dart';
part 'turing_machine_state.dart';

class TuringMachineBloc extends Bloc<TuringMachineEvent, TuringMachineState> {
  final TuringMachineRepository repository;
  TuringMachineBloc( {required this.repository}) : super(TuringMachineInitial()) {

    on<InitTuringMachineEvent>(_onInitTuringMachine);
    on<ChangeSpeedEvent>(_onChangeSpeed);
    on<LoadLocalTMs>(_onLoadLocalTMs);
    on<UpdateStatesEvent>(_handleUpdateStatesEvent);
    on<UpdateAlphabetEvent>(_handleUpdateAlphabetEvent);
    on<UpdateStartStateEvent>(_handleUpdateStartStateEvent);
    on<UpdateEndStateEvent>(_handleUpdateEndStatesEvent);
    on<UpdateTMSymbolEvent>(_handleUpdateTMSymbolEvent);
    on<AddTransitionRuleEvent>(_handleAddTransitionRuleEvent);
    on<RemoveTransitionRuleEvent>(_handleRemoveTransitionRuleEvent);
    on<UpdateTransitionRuleEvent>(_handleUpdateTransitionRuleEvent);
    on<UpdateTransitionRuleStatusEvent>(_handleUpdateTransitionRuleStatusEvent);
    on<FinalizeConfigurationEvent>(_handleFinalizeConfigurationEvent);
    on<EditCurrentTMEvent>(_handleEditCurrentTMEvent);
    on<UpdateTMState>(_handleUpdateTMStateEvent);
    on<ResetEvent>(_handleResetEvent);
  }


  void _handleUpdateTransitionRuleStatusEvent(UpdateTransitionRuleStatusEvent event, Emitter<TuringMachineState> emit) {
    final currentState = state;
    if (currentState is TuringMachineLoaded) {
      emit(currentState.copyWith(transitionStatuses: event.statuses));
    }
  }

  void _onInitTuringMachine(InitTuringMachineEvent event, Emitter<TuringMachineState> emit) {
    emit(TuringMachineLoaded(
      input: event.input,
      turingMachine: event.turingMachine,
      executionMessage: '',
      sliderValue: 0.5,
    ));
  }

  void _onChangeSpeed(ChangeSpeedEvent event, Emitter<TuringMachineState> emit) {
    final currentState = state;
    if (currentState is TuringMachineLoaded) {
      emit(currentState.copyWith(sliderValue: event.value));
    }
  }

  void _onLoadLocalTMs(LoadLocalTMs event, Emitter<TuringMachineState> emit) async {
    if (kDebugMode) {
      print('Loading local TMs...');
    }
    try {
      final List<LocalTMList> loadedTMs = await repository.getAllTuringMachines(event.context);
      emit(TuringMachineLoaded(
        localTMs: loadedTMs,
        input: '',
        turingMachine: TuringMachine.getDemo(),
        executionMessage: '',
        sliderValue: 0.5,
      ));
    } catch (error) {
      if (kDebugMode) {
        print(TuringMachineLoadException(error.toString()));
      }
    }
  }

  void _handleUpdateStatesEvent(UpdateStatesEvent event, Emitter<TuringMachineState> emit) {
    final currentState = state as TuringMachineLoaded;
    final updatedTM = currentState.turingMachine.copyWith(states: event.states);
    emit(currentState.copyWith(turingMachine: updatedTM));
  }

  void _handleUpdateAlphabetEvent(UpdateAlphabetEvent event, Emitter<TuringMachineState> emit) {
    final currentState = state as TuringMachineLoaded;
    var updatedAlphabet = List<String>.from(event.alphabet)..removeWhere((item) => item.isEmpty);
    updatedAlphabet.add(AppContents.blanketSymbol);
    final updatedTM = currentState.turingMachine.copyWith(alphabet: updatedAlphabet);
    emit(currentState.copyWith(turingMachine: updatedTM));
  }

  void _handleUpdateStartStateEvent(UpdateStartStateEvent event, Emitter<TuringMachineState> emit) {
    final currentState = state as TuringMachineLoaded;
    final updatedTM = currentState.turingMachine.copyWith(initialState: event.startState);
    emit(currentState.copyWith(turingMachine : updatedTM));
  }

  void _handleUpdateEndStatesEvent(UpdateEndStateEvent event, Emitter<TuringMachineState> emit) {
    final currentState = state as TuringMachineLoaded;
    final updatedTM = currentState.turingMachine.copyWith(finalStates: event.endStates);
    if (kDebugMode) {
      print('Updating final states to: ${event.endStates}');
      print('Updated TuringMachine: $updatedTM');
    }

    emit(currentState.copyWith(turingMachine: updatedTM));
  }

  void _handleUpdateTMStateEvent(UpdateTMState event, Emitter<TuringMachineState> emit) {
    final currentState = state as TuringMachineLoaded;
    emit(currentState.copyWith(executionState : event.executionState));
  }

  void _handleUpdateTMSymbolEvent(UpdateTMSymbolEvent event, Emitter<TuringMachineState> emit) {
    final currentState = state as TuringMachineLoaded;
    final updatedTM = currentState.turingMachine.copyWith(turingSymbol: event.tmSymbol);
    emit(currentState.copyWith(turingMachine: updatedTM));
  }

  void _handleAddTransitionRuleEvent(AddTransitionRuleEvent event, Emitter<TuringMachineState> emit) {
    final currentState = state as TuringMachineLoaded;
    final newTransition = TMTransitionFunction(
      currentState: '',
      readSymbol: '',
      nextState: '',
      writtenSymbol: '',
      movementDirection: MovementDirection.rechts,
    );

    final updatedTM = currentState.turingMachine
                                  .copyWith(
                                     transitions: [...currentState.turingMachine.transitions, newTransition]);
    emit(currentState.copyWith(turingMachine: updatedTM));
  }

  void _handleRemoveTransitionRuleEvent(RemoveTransitionRuleEvent event, Emitter<TuringMachineState> emit) {
    final currentState = state as TuringMachineLoaded;
    final updatedTransitions = List<TMTransitionFunction>.from(currentState.turingMachine.transitions)
      ..removeAt(event.index);
    final updatedTM = currentState.turingMachine.copyWith(transitions: updatedTransitions);
    emit(currentState.copyWith(turingMachine: updatedTM));
  }

  void _handleUpdateTransitionRuleEvent(UpdateTransitionRuleEvent event, Emitter<TuringMachineState> emit) {
    final currentState = state as TuringMachineLoaded;
    final updatedTransitions = List<TMTransitionFunction>.from(currentState.turingMachine.transitions)
      ..[event.index] = event.updatedRule;

    final updatedTM = currentState.turingMachine.copyWith(transitions: updatedTransitions);

    emit(currentState.copyWith(turingMachine: updatedTM));
  }

  void _handleFinalizeConfigurationEvent(FinalizeConfigurationEvent event, Emitter<TuringMachineState> emit) {
    final currentState = state as TuringMachineLoaded;

    emit(TuringMachineCreated(currentState.turingMachine));
    print('TM has been successful created..');
    print('Current state: $state');
  }

  void _handleEditCurrentTMEvent(EditCurrentTMEvent event, Emitter<TuringMachineState> emit) {
    emit(TuringMachineLoaded(
      input: "",
      turingMachine: event.tm,
      executionMessage: '',
      sliderValue: 0.5,
    ));
  }

  void _handleResetEvent(ResetEvent event, Emitter<TuringMachineState> emit) {
    emit(TuringMachineInitial());
  }
}
