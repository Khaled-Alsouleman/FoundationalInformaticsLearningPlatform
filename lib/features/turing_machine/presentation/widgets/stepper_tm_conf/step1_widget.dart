import 'package:foundational_learning_platform/core/utils/index.dart';

class StatesAndInputAlphabetStep extends StatelessWidget {
  final GlobalKey<FormState> statesKey;
  final TextEditingController statesController;
  final GlobalKey<FormState> alphabetKey;
  final TextEditingController alphabetController;
  final TextEditingController blankStateController;

  const StatesAndInputAlphabetStep({
    required this.statesKey,
    required this.statesController,
    required this.alphabetKey,
    required this.alphabetController,
    required this.blankStateController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final updateStatesUseCase = UpdateStatesUseCase(
      turingMachineBloc: context.read<TuringMachineBloc>(),
      tmListSelectableBloc: context.read<TMListSelectableBloc>(),
    );

    final updateAlphabetUseCase = UpdateAlphabetUseCase(
      turingMachineBloc: context.read<TuringMachineBloc>(),
    );

    return BlocBuilder<TuringMachineBloc, TuringMachineState>(
      builder: (context, tmConfigState) {
        return BlocBuilder<TMListSelectableBloc, TMListSelectableState>(
          builder: (context, tmListState) {
            return Center(
              child: Column(
                children: [
                  ///TODO CURRENT HEIGHT IS FOR DESKTOP ONLY
                  const SizedBox(height: AppDimensions.paddingXLarge * 1.5),
                  Padding(
                    padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                    child: SizedBox(
                      height: 70,
                      child: MyTextField(
                        globalKey: statesKey,
                        label: const Text('Zustandsmenge'),
                        controller: statesController,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            final states = Utils.getStringAsList(value);
                            print('States from Step 1:');
                            print(states);
                            updateStatesUseCase.call(states);
                          }
                        },
                        onSubmitted: (value) {
                          if (value.isNotEmpty) {
                            final states = Utils.getStringAsList(value);
                            updateStatesUseCase.call(states);
                          }
                        },
                        validator: (value) {

                          if (value == null || value.isEmpty) {
                           return "Bitte geben Sie mindestens einen Zustand ein.";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                    child: SizedBox(
                      height: 70,
                      child: MyTextField(
                        globalKey: alphabetKey,
                        controller: alphabetController,
                        label: const Text('Eingabealphabet'),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            final alphabet = Utils.getStringAsList(value);
                            updateAlphabetUseCase.call(alphabet);
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Bitte geben Sie mindestens ein Alphabet ein.";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

