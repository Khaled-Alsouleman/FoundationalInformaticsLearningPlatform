import 'package:foundational_learning_platform/core/utils/index.dart';

class TransitionFunctionStep extends StatelessWidget {
  const TransitionFunctionStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return BlocBuilder<TuringMachineBloc, TuringMachineState>(
      builder: (context, state) {
        if (state is TuringMachineLoaded) {
          final dropdownItems = [...state.turingMachine.alphabet];
          bool canAddNewRule = CanAddNewRuleUseCase().call(state);
          return SizedBox(
            height: screenSize.height * 0.5,
            width: screenSize.width / 1.1,
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingLarge),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.turingMachine.transitions.length + 1,
                itemBuilder: (context, index) {
                  if (index < state.turingMachine.transitions.length) {
                    return TransitionRuleWidget(
                      index: index,
                      rule: state.turingMachine.transitions[index],
                      states: state.turingMachine.states,
                      dropdownItems: dropdownItems,
                    );
                  } else {
                    return SizedBox(
                      width: 300,
                      child: CustomButton(
                        onPressed: canAddNewRule
                            ? () {
                          context.read<TuringMachineBloc>().add(AddTransitionRuleEvent());
                        }
                            : (){},
                        child: const Text('ADD RULE'),
                      ),
                    );
                  }
                },
              ),
            ),
          );
        }
        return const NoDataPage();
      },
    );
  }
}


