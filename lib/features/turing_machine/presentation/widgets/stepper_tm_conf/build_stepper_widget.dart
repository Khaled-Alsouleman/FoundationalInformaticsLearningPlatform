import 'package:foundational_learning_platform/core/utils/index.dart';

class BuildStepperWidget extends StatefulWidget {

  final TextEditingController statesController;
  final TextEditingController alphabetController;
  final TextEditingController turingSymbolController;
  final GlobalKey<FormState> statesKey;
  final GlobalKey<FormState> alphabetKey;
  const BuildStepperWidget(
      {super.key, required this.statesController, required this.alphabetController, required this.turingSymbolController, required this.statesKey, required this.alphabetKey});

  @override
  State<BuildStepperWidget> createState() => _BuildStepperWidgetState();
}

class _BuildStepperWidgetState extends State<BuildStepperWidget> {
  late final HandleStepContinueUseCase handleStepContinueUseCase;

  @override
  void initState() {
    super.initState();

    handleStepContinueUseCase = HandleStepContinueUseCase(
      stepProgressBloc: context.read<StepProgressBloc>(),
      configBloc: context.read<TuringMachineBloc>(),
    );
  }
   late int currentStep;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TuringMachineBloc, TuringMachineState>(
      builder: (context, state) {
        if (state is TuringMachineLoaded || state is TuringMachineCreated) {
          return BlocListener<StepProgressBloc, StepProgressState>(
            listener: (context, spState) {
             if(spState is StepperLoaded) {
               setState(() {
                 currentStep = spState.currentStep;
               });

             }
            },
            child: CustomStepper(
              numberOfSteps: 4,
              steps: [
                StatesAndInputAlphabetStep(
                  statesKey: widget.statesKey,
                  statesController: widget.statesController,
                  alphabetKey: widget.alphabetKey,
                  alphabetController: widget.alphabetController,
                  blankStateController: widget.turingSymbolController,
                ),
                const StartAndEndStateStep(),
                TransitionFunctionStep(),
                const CompletionStep(),
              ],
              onStepContinue: () {
                handleStepContinueUseCase.call(
                    currentStep, widget.statesKey, widget.alphabetKey);
              },
            ),
          );
        }
        return const NoDataPage();
      },
    );
  }
}
