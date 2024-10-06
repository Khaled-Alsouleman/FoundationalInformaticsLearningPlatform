import 'package:foundational_learning_platform/core/utils/index.dart';

class StartAndEndStateStep extends StatefulWidget {


  const StartAndEndStateStep({Key? key,}) : super(key: key);

  @override
  _StartAndEndStateStepState createState() => _StartAndEndStateStepState();
}

class _StartAndEndStateStepState extends State<StartAndEndStateStep> {
  late final InitializeStatesUseCase initializeStatesUseCase;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final tmListSelectableBloc = context.read<TMListSelectableBloc>();
      final tmState = context.read<TuringMachineBloc>().state;

      if (tmState is TuringMachineLoaded) {
        initializeStatesUseCase = InitializeStatesUseCase(tmListSelectableBloc: tmListSelectableBloc);
        initializeStatesUseCase.call(tmState);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final tmBloc = context.read<TuringMachineBloc>();
    final tmListSelectableBloc = context.read<TMListSelectableBloc>();

    return BlocBuilder<TuringMachineBloc, TuringMachineState>(
      builder: (context, state) {
        if (state is TuringMachineLoaded) {
          return Column(
            children: [
              // TODO CURRENT HEIGHT IS FOR DESKTOP ONLY
              const SizedBox(height: AppDimensions.paddingLarge),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BuildStateSelection(
                  title: 'Wählen Sie einen Anfangszustand aus:',
                  states: state.turingMachine.states,
                  isStartState: true,
                  initialSelectedIndex: state.turingMachine.initialState.isNotEmpty
                      ? state.turingMachine.states.indexOf(state.turingMachine.initialState)
                      : -1,
                  onItemSelected: (index) {
                    tmListSelectableBloc.add(TMUpdateSelectedIndex(
                      selectedIndex: index,
                      isStartState: true,
                      isMultiSelectable: false,
                    ));
                    tmBloc.add(UpdateStartStateEvent(state.turingMachine.states[index]));
                  },
                ),
              ),
              const SizedBox(height: 8),
              BuildStateSelection(
                title: 'Wählen Sie einen Endzustand aus:',
                states: state.turingMachine.states,
                isStartState: false,
                initialSelectedIndex: state.turingMachine.finalStates.isNotEmpty
                    ? state.turingMachine.states.indexOf(state.turingMachine.finalStates.first)
                    : -1,
                onItemSelected: (index) {
                  if (kDebugMode) {
                    print('Selected final state: ${state.turingMachine.states[index]}');
                  }
                  tmListSelectableBloc.add(TMUpdateSelectedIndex(
                    selectedIndex: index,
                    isStartState: false,
                    isMultiSelectable: false,
                  ));
                  tmBloc.add(UpdateEndStateEvent([state.turingMachine.states[index]]));
                },
              ),
            ],
          );
        }
        return const NoDataPage();
      },
    );
  }

}
